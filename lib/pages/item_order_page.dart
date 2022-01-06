import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/back_button_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/input_field_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_and_description_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

class ItemOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButtonView(() {}),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ComboSetSection(),
                ComboSetSection(),
                ComboSetSection(),
                PromoCodeSection(),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                TitleText(
                  "Sub Total : 40\$",
                  textColor: Colors.green,
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                PaymentMethodSection(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                ElevatedButtonView("Pay \$40",(){} ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
              ],
            ),
          ),
        ));
  }
}

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LargeTitleText("Payment Method"),
        SizedBox(height: MARGIN_LARGE),
        PaymentOptionView(
          "Credit Card",
          "Visa, master and JCB",
          Image.asset(
            "assets/ic_credit_card.png",
            width: 28,
            height: 28,
          ),
        ),
        SizedBox(height: MARGIN_SMALL,),
        PaymentOptionView(
          "Internet banking (ATM Card)",
          "Visa, master and JCB",
          Image.asset(
            "assets/ic_atm_card.png",
            width: 28,
            height: 28,
          ),
        ),
        SizedBox(height: MARGIN_SMALL,),
        PaymentOptionView(
          "E-Wallet",
          "Paypal",
          Image.asset(
            "assets/ic_wallet.png",
            width: 28,
            height: 28,
          ),
        ),
      ],
    );
  }
}

class PaymentOptionView extends StatelessWidget {
  final String title;
  final String description;
  final Image paymentIcon;

  const PaymentOptionView(this.title, this.description, this.paymentIcon);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          TitleAndDescriptionView(title, description),
        ],
      ),
    );
  }
}

class PromoCodeSection extends StatelessWidget {
  const PromoCodeSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Enter Promo Code",
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
              "Don't have any promo Code?",
              textColor: Colors.black26,
            ),
            SizedBox(
              width: MARGIN_CARD_SMALL,
            ),
            NormalTextView(
              "Get it now",
              textColor: Colors.black,
            ),
          ],
        )
      ],
    );
  }
}

class ComboSetSection extends StatelessWidget {
  const ComboSetSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: TitleAndDescriptionView(
              "Combo Set M",
              "Combo size  220z Coke (X1) and medium popcorn(X1)",
            ),
          ),
          Spacer(),
          ComboPricerAndNumbersView(),
        ],
      ),
    );
  }
}

class ComboPricerAndNumbersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText("15\$"),
        SizedBox(
          height: 4,
        ),
        NumberPickerView()
      ],
    );
  }
}

class NumberPickerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: MARGIN_SMALL_2, right: MARGIN_CARD_SMALL),
            child: Icon(
              Icons.remove,
              size: 18,
            ),
          ),
          VerticalDivider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
            child: NormalTextView(
              "0",
              textColor: Colors.black26,
            ),
          ),
          VerticalDivider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: MARGIN_CARD_SMALL, right: MARGIN_SMALL_2),
            child: Icon(
              Icons.add,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
