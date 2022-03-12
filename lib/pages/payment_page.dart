import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_booking/data/request/check_out_request.dart';
import 'package:movies_booking/data/request/snack_request.dart';
import 'package:movies_booking/data/vos/checkout_vo.dart';
import 'package:movies_booking/pages/add_card_info_page.dart';
import 'package:movies_booking/pages/movie_ticket_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/back_button_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

import '../data/models/movie_booking_model.dart';
import '../data/models/movie_booking_model_impl.dart';
import '../data/vos/card_vo.dart';

class PaymentPage extends StatefulWidget {
  @override
  State<PaymentPage> createState() => _PaymentPageState();

  final int movieId;
  final int cinemaId;
  final int timeSlotId;
  final String bookingDate;
  final int totalPrice;
  final String seatNumbers;
  final String moviePath;
  final String cinemaName;
  final List<SnackRequest> snacks;
  PaymentPage(
      {required this.movieId,
      required this.cinemaId,
      required this.timeSlotId,
      required this.bookingDate,
      required this.totalPrice,
      required this.seatNumbers,
      required this.moviePath,
      required this.cinemaName,
      required this.snacks});
}

class _PaymentPageState extends State<PaymentPage> {
  MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  List<CardVO>? cardList;
  int selectCardId = 0;
  CheckoutVO? checkoutVO;

  void _getUserProfile() {
    _movieBookingModel.getUserInfoDB().listen((response) {
      debugPrint("Profile CARD: ${response?.cards?.length}");
      setState(() {
        this.cardList = response?.cards;
      });
    }).onError((error) {
      debugPrint("Profile Error: $error");
    });
  }

  @override
  void initState() {
    _getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButtonView(() => Navigator.pop(context)),
      ),
      body: Container(
        padding: EdgeInsets.all(MARGIN_MEDIUM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentAmoutSection(
              totalPrice: widget.totalPrice,
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Visibility(
              visible: this.cardList?.isNotEmpty ?? false,
              child: PaymentCardOptionSection(
                cardList: this.cardList,
                onSelectCard: (index) {
                  selectCardId = this.cardList?[index].id ?? 0;
                  print("Select Card -> index: $index, $selectCardId");
                },
              ),
            ),
            SizedBox(
              height: MARGIN_XLARGE,
            ),
            AddNewCardSection(
              onTapAddNew: () => _navigateToAddNewCardScreen(context),
            ),
            SizedBox(
              height: MARGIN_XXLARGE,
            ),
            ElevatedButtonView("Confirm", () => _checkoutTicket()),
          ],
        ),
      ),
    );
  }

  void _checkoutTicket() {
    CheckOutRequest checkOutRequest = CheckOutRequest(
        widget.timeSlotId,
        widget.seatNumbers,
        widget.bookingDate,
        widget.movieId,
        selectCardId,
        widget.cinemaId,
        widget.totalPrice,
        widget.snacks);

    print("CheckOutReq-> ${checkOutRequest.toString()}");
    _movieBookingModel.checkoutTicket(checkOutRequest).then((response) {
      _navigateToTicketScreen(context, response);
    }).catchError((error) {
      debugPrint("Checkout Error: $error");
    });
  }

  void _navigateToTicketScreen(BuildContext context, CheckoutVO? checkoutVO) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieTicketPage(
          checkoutVO: checkoutVO,
          cinemaName: widget.cinemaName,
          moviePoster: widget.moviePath,
        ),
      ),
    );
    print("payment confirm clicked");
  }

  void _navigateToAddNewCardScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddCardInfoPage(),
        ));

       /* .then((value) {
      if (value == true) {
        _getUserProfile();
      }
    });*/
  }
}

class PaymentAmoutSection extends StatelessWidget {
  final int totalPrice;
  PaymentAmoutSection({required this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalTextView(
          PAYMENT_AMOUNT,
          textColor: Colors.black26,
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        TitleText("\$ $totalPrice"),
      ],
    );
  }
}

class PaymentCardOptionSection extends StatelessWidget {
  const PaymentCardOptionSection(
      {required this.cardList, required this.onSelectCard});

  final List<CardVO>? cardList;
  final Function(int) onSelectCard;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: cardList?.length ?? 0,
      options: CarouselOptions(
          aspectRatio: 2,
          viewportFraction: 0.8,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          initialPage: 0,
          onPageChanged: (index, value) => onSelectCard(index)),
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return PaymentCardView(cardVO: cardList?[itemIndex]);
      },
    );
  }
}

class AddNewCardSection extends StatelessWidget {
  final VoidCallback onTapAddNew;

  const AddNewCardSection({required this.onTapAddNew});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapAddNew,
      child: Row(
        children: [
          Icon(
            Icons.add_circle_outline_outlined,
            color: Colors.green,
            size: 24,
          ),
          SizedBox(
            width: MARGIN_SMALL_2,
          ),
          NormalTextView(
            "Add New Card",
            textColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class PaymentCardView extends StatelessWidget {
  final CardVO? cardVO;
  PaymentCardView({required this.cardVO});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 330,
        padding: EdgeInsets.all(MARGIN_MEDIUM),
        decoration: BoxDecoration(
          color: PAYMENT_CARD_PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(MARGIN_SMALL_2),
        ),
        child: Column(
          children: [
            CardTypeView(),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            CardNumberView(
              cardNumber: cardVO?.cardNumber ?? "",
            ),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            CardHolderNameAndExpireView("CARD HOLDER", "EXPIRES"),
            SizedBox(
              height: MARGIN_CARD_SMALL,
            ),
            CardHolderNameAndExpireView(
                cardVO?.cardHolder ?? "", cardVO?.expirationDate ?? ""),
          ],
        ));
  }
}

class CardHolderNameAndExpireView extends StatelessWidget {
  final String holderText;
  final String expireText;

  const CardHolderNameAndExpireView(this.holderText, this.expireText);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleText(
          holderText,
          textColor: Colors.black26,
        ),
        TitleText(
          expireText,
          textColor: Colors.black26,
        ),
      ],
    );
  }
}

class CardTypeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Visa",
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        Spacer(),
        Icon(
          Icons.more_horiz_rounded,
          color: Colors.white,
          size: 24,
        )
      ],
    );
  }
}

class CardNumberView extends StatelessWidget {
  final String cardNumber;
  CardNumberView({required this.cardNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleText(
          "* * * *",
          textColor: Colors.white,
        ),
        // SizedBox(width: MARGIN_SMALL,),
        TitleText(
          "* * * *",
          textColor: Colors.white,
        ),
        // SizedBox(width: MARGIN_SMALL,),
        TitleText(
          "* * * *",
          textColor: Colors.white,
        ),
        //SizedBox(width: MARGIN_SMALL,),
        TitleText(
          cardNumber,
          textColor: Colors.white,
        ),
      ],
    );
  }
}
