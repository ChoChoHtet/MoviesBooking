import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_booking/bloc/payment_bloc.dart';
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
import 'package:provider/provider.dart';
import '../data/vos/card_vo.dart';

class PaymentPage extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentBloc(),
      child: Scaffold(
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
                totalPrice: totalPrice,
              ),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Selector<PaymentBloc, List<CardVO>?>(
                selector: (context, bloc) => bloc.cardList,
                builder: (BuildContext context, cardList, Widget? child) {
                  return Visibility(
                    visible: cardList?.isNotEmpty ?? false,
                    child: PaymentCardOptionSection(
                      cardList: cardList,
                      onSelectCard: (index) {
                        PaymentBloc bloc = Provider.of(context, listen: false);
                        bloc.setSelectedCard(index);
                      },
                    ),
                  );
                },
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
              Builder(builder: (context) {
                return ElevatedButtonView("Confirm", () {
                  PaymentBloc bloc = Provider.of(context, listen: false);
                  bloc
                      .checkoutTicket(timeSlotId, seatNumbers, bookingDate,
                          movieId, cinemaId, totalPrice, snacks)
                      .then((response) {
                    _navigateToTicketScreen(context, response);
                  }).catchError((error) {
                    debugPrint("Checkout Error: $error");
                  });
                });
              }),
            ],
          ),
        ),
      ),
    );
  }


  void _navigateToTicketScreen(BuildContext context, CheckoutVO? checkoutVO) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieTicketPage(
          checkoutVO: checkoutVO,
          cinemaName: cinemaName,
          moviePoster: moviePath,
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

  //CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    debugPrint("Card List length: ${cardList?.length ?? 0}");
    return CarouselSlider.builder(
      itemCount: this.cardList?.length ?? 0,
      options: CarouselOptions(
          aspectRatio: 2,
          viewportFraction: 0.8,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          initialPage: 0,
          enableInfiniteScroll: false,
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
      child: Container(
        key: Key(KEY_ADD_NEW_CARD),
        child:  Row(
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
