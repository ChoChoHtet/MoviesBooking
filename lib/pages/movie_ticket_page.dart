import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:movies_booking/data/vos/checkout_vo.dart';
import 'package:movies_booking/network/api_constants.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/close_button_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

import 'home_page.dart';

class MovieTicketPage extends StatelessWidget {
  final CheckoutVO? checkoutVO;
  final String cinemaName;
  final String moviePoster;
  MovieTicketPage(
      {required this.checkoutVO,
      required this.cinemaName,
      required this.moviePoster});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CloseButtonView(
          () {
            //Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
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
            TicketSection(
              checkoutVO: checkoutVO,
              cinemaName: this.cinemaName,
              moviePoster: this.moviePoster,
            ),
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
  final CheckoutVO? checkoutVO;
  final String cinemaName;
  final String moviePoster;
  TicketSection(
      {required this.checkoutVO,
      required this.cinemaName,
      required this.moviePoster});
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
            MovieTicketPosterView(
              moviePoster: moviePoster,
            ),
            DashLineView(),
            TicketInfoSection(
              checkoutVO: checkoutVO,
              cinemaName: this.cinemaName,
            ),
            DashLineView(),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            GenerateBarCodeView(qrCode: checkoutVO?.qrCode ?? "",),
          ],
        ),
      ),
    );
  }
}

class GenerateBarCodeView extends StatelessWidget {
  final String qrCode;
  GenerateBarCodeView({required this.qrCode});
  @override
  Widget build(BuildContext context) {
    return BarcodeWidget(
      width: TICKET_BARCODE_HEIGHT,
      height: TICKET_BARCODE_WIDTH,
      data: qrCode,
      barcode: Barcode.code128(),
      drawText: false,
    );
  }
}

class TicketInfoSection extends StatelessWidget {
  final CheckoutVO? checkoutVO;
  final String cinemaName;
  TicketInfoSection({required this.checkoutVO, required this.cinemaName});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MARGIN_MEDIUM),
      child: Column(
        children: [
          TicketItemView(TICKET_BOOKING_NO, checkoutVO?.bookingNo ?? ""),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_SHOW_TIME_AND_DATE,
              "${checkoutVO?.timeSlot?.startTime ?? ""}-${checkoutVO?.bookingDate ?? ""}"),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_THEATER, cinemaName),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_SCREEN, "2"),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_ROW, checkoutVO?.row ?? ""),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_SEATS, checkoutVO?.seat ?? ""),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TicketItemView(TICKET_PRICE, "${checkoutVO?.total ?? 0}"),
        ],
      ),
    );
  }
}

class DashLineView extends StatelessWidget {
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
  final String moviePoster;
  MovieTicketPosterView({required this.moviePoster});
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
            "$MOVIE_IMAGE_URL$moviePoster",
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
