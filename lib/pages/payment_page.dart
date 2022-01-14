import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_booking/pages/add_card_info_page.dart';
import 'package:movies_booking/pages/item_order_page.dart';
import 'package:movies_booking/pages/movie_ticket_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/back_button_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

class PaymentPage extends StatelessWidget {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

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
            PaymentAmoutSection(),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            PaymentCardOptionSection(imgList: imgList),
            SizedBox(
              height: MARGIN_XLARGE,
            ),
            AddNewCardSection(() => _navigateToAddNewCardScreen(context)),
            SizedBox(
              height: MARGIN_XXLARGE,
            ),
            ElevatedButtonView("Confirm",() => _navigateToTicketScreen(context)
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToTicketScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieTicketPage(),
      ),
    );
  }

  void _navigateToAddNewCardScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCardInfoPage(),
      ),
    );
  }
}

class PaymentAmoutSection extends StatelessWidget {
  const PaymentAmoutSection({
    Key key,
  }) : super(key: key);

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
        TitleText("\$ 9426.21"),
      ],
    );
  }
}

class PaymentCardOptionSection extends StatelessWidget {
  const PaymentCardOptionSection({
    Key key,
    @required this.imgList,
  }) : super(key: key);

  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          aspectRatio: 2,
          viewportFraction: 0.8,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          initialPage: 3),
      items: imgList.map((card) {
        return Builder(builder: (BuildContext context) {
          return PaymentCardView();
        });
      }).toList(),
    );
  }
}

class AddNewCardSection extends StatelessWidget {
  final Function onTapAddNew;

  const AddNewCardSection(this.onTapAddNew);

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
  const PaymentCardView({
    Key key,
  }) : super(key: key);

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
            CardNumberView(),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            CardHolderNameAndExpireView("CARD HOLDER", "EXPIRES"),
            SizedBox(
              height: MARGIN_CARD_SMALL,
            ),
            CardHolderNameAndExpireView("Lily Johnson", "08/21"),
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
  const CardTypeView({
    Key key,
  }) : super(key: key);

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
  const CardNumberView({
    Key key,
  }) : super(key: key);

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
          "8014",
          textColor: Colors.white,
        ),
      ],
    );
  }
}
