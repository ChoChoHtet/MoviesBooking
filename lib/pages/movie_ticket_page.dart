import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/close_button_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

class MovieTicketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CloseButtonView(
          () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LargeTitleText(TICKET_AWESOME),
            SizedBox(
              height: MARGIN_SMALL,
            ),
            NormalTextView(
              YOUR_TICKET,
              textColor: Colors.black26,
            ),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            TicketSection(),
            SizedBox(
              height: MARGIN_LARGE,
            ),
          ],
        ),
      ),
    );
  }
}

class TicketSection extends StatelessWidget {
  const TicketSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MARGIN_SMALL_2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: MARGIN_LARGE),
        child: Column(
          children: [
            MovieTicketPosterView(),
            DashLineView(),
            TicketInfoSection(),
            DashLineView(),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            GenerateBarCodeView(),
          ],
        ),
      ),
    );
  }
}

class GenerateBarCodeView extends StatelessWidget {
  const GenerateBarCodeView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarcodeWidget(
      width: TICKET_BARCODE_HEIGHT,
      height: TICKET_BARCODE_WIDTH,
      data: 'https://pub.dev/packages/barcode_widget',
      barcode: Barcode.code128(),
      drawText: false,
    );
  }
}

class TicketInfoSection extends StatelessWidget {
  const TicketInfoSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MARGIN_MEDIUM),
      child: Column(
        children: [
          TicketItemView(TICKET_BOOKING_NO, "GC1547219308"),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_SHOW_TIME_AND_DATE, "7:00 PM - 10 May"),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_THEATER, "Galaxy Cinema-Golden City"),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_SCREEN, "2"),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_ROW, "D"),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_SEATS, "5,6"),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_PRICE, "\$ 40.00"),
        ],
      ),
    );
  }
}

class DashLineView extends StatelessWidget {
  const DashLineView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(20, (index) {
        return Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            height: 2,
            width: 2,
            color: Colors.black26,
          ),
        ));
      }),
    );
  }
}

class TicketItemView extends StatelessWidget {
  final String infoLabel;
  final String infoText;

  const TicketItemView(this.infoLabel, this.infoText);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NormalTextView(
          infoLabel,
          textColor: Colors.black26,
        ),
        NormalTextView(
          infoText,
          textColor: Colors.black26,
        ),
      ],
    );
  }
}

class MovieTicketPosterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MARGIN_SMALL_2),
            topRight: Radius.circular(MARGIN_SMALL_2),
          ),
          child: Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGFrQd3ez_nmjQhnH7F3vyJUbDogMKNqoU6nCd-7rJ3ZzgprZo",
            fit: BoxFit.cover,
            width: double.maxFinite,
            height: 200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM,
            vertical: MARGIN_SMALL_2,
          ),
          child: TitleText("Detective Pikachu"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          child: NormalTextView(
            "105m-IMAX",
            textColor: Colors.black26,
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
      ],
    );
  }
}
