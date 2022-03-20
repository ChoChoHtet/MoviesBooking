import 'package:flutter/material.dart';
import 'package:movies_booking/bloc/item_order_bloc.dart';
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
import 'package:provider/provider.dart';

class ItemOrderPage extends StatelessWidget {
  final int movieId;
  final String moviePath;
  final int cinemaId;
  final String cinemaName;
  final int timeSlotId;
  final String bookingDate;
  final int totalPrice;
  final String seatNumbers;

  ItemOrderPage(
      {required this.movieId,
      required this.moviePath,
      required this.cinemaId,
      required this.cinemaName,
      required this.timeSlotId,
      required this.bookingDate,
      required this.totalPrice,
      required this.seatNumbers});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemOrderBloc(),
      child: Scaffold(
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
                  Selector<ItemOrderBloc, List<SnackVO>?>(
                      selector: (context, bloc) => bloc.snacksList,
                      shouldRebuild: (previous,next)=> previous != next,
                      builder: (BuildContext context, snacksList, Widget? child){
                        ItemOrderBloc bloc =
                        Provider.of(context, listen: false);
                        return Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snacksList?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) =>
                                ComboSetView(
                                  snackVO: snacksList?[index],
                                  onTapIncrease: () => bloc.incrementQty(index),
                                  onTapDecrease: () => bloc.decreaseQty(index),
                                ),
                          ),
                        );
                      }
                  ),
                  PromoCodeSection(),
                  SizedBox(
                    height: MARGIN_MEDIUM,
                  ),
                  Selector<ItemOrderBloc, int>(
                    selector: (context, bloc) => bloc.totalPrice,
                    builder: (BuildContext context, totalPrice, Widget? child) {
                      return TitleText(
                        "Sub Total : $totalPrice\$",
                        textColor: Colors.green,
                      );
                    },
                  ),
                  SizedBox(
                    height: MARGIN_LARGE,
                  ),
                  Selector<ItemOrderBloc, List<PaymentVO>?>(
                    selector: (context, bloc) => bloc.paymentList,
                    shouldRebuild: (previous,next)=> previous != next,
                    builder: (BuildContext context, paymentList, Widget? child) {
                      return PaymentMethodSection(
                        paymentList: paymentList,
                        onTapPayment: (payment) {
                          ItemOrderBloc bloc =
                          Provider.of(context, listen: false);
                          bloc.setPaymentSelected(payment);
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: MARGIN_LARGE,
                  ),
                  Builder(
                      builder: (context) {
                        ItemOrderBloc bloc =
                        Provider.of(context, listen: false);
                        return ElevatedButtonView(
                          "Pay \$${bloc.totalPrice + totalPrice}",
                              () {
                            bloc.addSnackRequest();
                            _navigateToPaymentScreen(context,bloc);
                          },
                        );
                      }
                  ),
                  SizedBox(
                    height: MARGIN_LARGE,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _navigateToPaymentScreen(BuildContext context,ItemOrderBloc bloc) {
    bloc.addSnackRequest();
    print("snack List: ${bloc.snackRequest.toString()}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          movieId: movieId,
          cinemaId: cinemaId,
          timeSlotId: timeSlotId,
          bookingDate: bookingDate,
          totalPrice: bloc.totalPrice,
          seatNumbers: seatNumbers,
          cinemaName: cinemaName,
          moviePath: moviePath,
          snacks: bloc.snackRequest,
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
                textColor: isSelected == true
                    ? DATE_NONE_SELECT_COLOR
                    : Colors.black26,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
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
