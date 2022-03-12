import 'package:flutter/material.dart';
import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/models/movie_booking_model_impl.dart';
import 'package:movies_booking/data/request/snack_request.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/data/vos/snack_vo.dart';
import 'package:movies_booking/pages/payment_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/viewItems/combo_set_view.dart';
import 'package:movies_booking/widgets/back_button_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_and_description_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

class ItemOrderPage extends StatefulWidget {
  final int movieId;
  final String moviePath;
  final int cinemaId;
  final String cinemaName;
  final int timeSlotId;
  final String bookingDate;
  final int totalPrice;
  final String seatNumbers;

  ItemOrderPage({
    required this.movieId,
    required this.moviePath,
    required this.cinemaId,
    required this.cinemaName,
    required this.timeSlotId,
    required this.bookingDate,
    required this.totalPrice,
    required this.seatNumbers
});

  @override
  State<ItemOrderPage> createState() => _ItemOrderPageState();
}

class _ItemOrderPageState extends State<ItemOrderPage> {
  MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  // final List<String> snackList = ["1", "2", "3"];

  List<SnackVO>? snacksList;
  List<PaymentVO>? paymentList;
  List<SnackRequest> snackRequest= [];
  int totalPrice = 0;
  @override
  void initState() {
    _getSnacks();
    _getPaymentMethods();
    super.initState();
  }

  void _getPaymentMethods() {
    _movieBookingModel.getPaymentMethodFromDB().listen((paymentResponse) {
      setState(() {
        this.paymentList = paymentResponse;
      });
    }).onError((error) {
      debugPrint("Payment Error: $error");
    });
  }

  void _getSnacks() {
    _movieBookingModel.getSnackFromDB().listen((snackResponse) {
      setState(() {
        this.snacksList = snackResponse;
      });
    }).onError((error) {
      debugPrint("Snack Error: $error");
    });
  }
  void _setPaymentSelected(PaymentVO? payment){
    paymentList?.forEach((element) {
      if(element.id == payment?.id){
        element.isSelected = true ;
      }else{
        element.isSelected = false ;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButtonView(() => Navigator.pop(context)),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: this.snacksList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) =>
                        ComboSetView(
                      snackVO: this.snacksList?[index],
                      onTapCount: (quantity, action) {
                        print("quantity: $quantity,action: $action");
                        setState(() {
                          SnackVO? snack = this.snacksList?[index];
                          snack?.quantity = quantity;
                          if (ACTION_INCREASE == action) {
                            this.totalPrice += snack?.price ?? 0 * quantity;
                          } else {
                            this.totalPrice -= snack?.price ?? 0 * quantity;
                          }
                        });
                      },
                    ),
                  ),
                ),
                PromoCodeSection(),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                TitleText(
                  "Sub Total : $totalPrice\$",
                  textColor: Colors.green,
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                PaymentMethodSection(
                  paymentList: this.paymentList,
                  onTapPayment: (payment){
                    setState(() {
                      _setPaymentSelected(payment);
                    });
                  },
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                ElevatedButtonView(
                  "Pay \$${totalPrice + widget.totalPrice}",
                  () => _navigateToPaymentScreen(context),
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
              ],
            ),
          ),
        ));
  }

  void _navigateToPaymentScreen(BuildContext context) {
    snackRequest = [];
    this.snacksList?.forEach((element) {
      if(element.quantity !=null && element.quantity != 0){
        snackRequest.add(SnackRequest(element.id, element.quantity));
      }
    });
    print("snack List: ${snackRequest.toString()}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          movieId: widget.movieId,
          cinemaId: widget.cinemaId,
          timeSlotId: widget.timeSlotId,
          bookingDate: widget.bookingDate,
          totalPrice: totalPrice,
          seatNumbers: widget.seatNumbers,
          cinemaName: widget.cinemaName,
          moviePath: widget.moviePath,
          snacks: this.snackRequest,
        ),
      ),
    );
  }
}

class PaymentMethodSection extends StatelessWidget {
  final List<PaymentVO>? paymentList;
  final Function(PaymentVO?) onTapPayment;
  PaymentMethodSection({required this.paymentList, required this.onTapPayment});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        LargeTitleText("Payment Method"),
        SizedBox(height: MARGIN_LARGE),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: paymentList?.length ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => onTapPayment(paymentList?[index]),
              child: PaymentOptionView(
                title: paymentList?[index].name ?? "",
                description: paymentList?[index].name ?? "",
                isSelected: paymentList?[index].isSelected ?? false,
                paymentIcon: Image.asset(
                  "assets/ic_credit_card.png",
                  width: 28,
                  height: 28,
                ),
              ),
            );
          },
        ),

        // PaymentOptionView(
        //   title: paymentList?[0].name ?? "",
        //   description: paymentList?[0].description ?? "",
        //   paymentIcon: Image.asset(
        //     "assets/ic_credit_card.png",
        //     width: 28,
        //     height: 28,
        //   ),
        // ),
        // SizedBox(
        //   height: MARGIN_SMALL,
        // ),
        // PaymentOptionView(
        //   title: paymentList?[1].name ?? "",
        //   description: paymentList?[0].description ?? "",
        //   paymentIcon: Image.asset(
        //     "assets/ic_atm_card.png",
        //     width: 28,
        //     height: 28,
        //   ),
        // ),
        // SizedBox(
        //   height: MARGIN_SMALL,
        // ),
        // PaymentOptionView(
        //   title: paymentList?[2].name ?? "",
        //   description: paymentList?[2].description ?? "",
        //   paymentIcon: Image.asset(
        //     "assets/ic_wallet.png",
        //     width: 28,
        //     height: 28,
        //   ),
        // ),
      ],
    );
  }
}

class PaymentOptionView extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final Image paymentIcon;

  const PaymentOptionView(
      {required this.title,
      required this.description,
      required this.paymentIcon,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: paymentIcon,
              ),
              SizedBox(
                width: MARGIN_LARGE,
              ),
              TitleAndDescriptionView(
                title,
                description,
                textColor:
                    isSelected == true ? DATE_NONE_SELECT_COLOR : Colors.black26,
              ),
            ],
          ),
        ),
        SizedBox(height: MARGIN_SMALL,),
      ],
    );
  }
}

class PromoCodeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
              hintText: ENTER_PROMO_CODE,
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
              )),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Row(
          children: [
            NormalTextView(
              HAVE_ANY_PROMO_CODE,
              textColor: Colors.black26,
            ),
            SizedBox(
              width: MARGIN_CARD_SMALL,
            ),
            NormalTextView(
              GET_IT_NOW,
              textColor: Colors.black,
            ),
          ],
        )
      ],
    );
  }
}

