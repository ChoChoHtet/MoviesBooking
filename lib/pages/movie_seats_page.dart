import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:movies_booking/data.vos/movie_seat_vo.dart';
import 'package:movies_booking/dummy/dummy_data.dart';
import 'package:movies_booking/pages/item_order_page.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/viewItems/movie_seat_item_view.dart';
import 'package:movies_booking/widgets/back_button_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';

class MovieSeatPage extends StatelessWidget {
  final List<MovieSeatVO> _movieSeats = dummyMovieSeats;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButtonView(() => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieNameTimeAndCinemaSection(),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            MovieSeatSection(movieSeats: _movieSeats),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            MovieSeatGlossySection(),
            SizedBox(
              height: MARGIN_LARGE,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
              child: DottedLine(
                lineLength: double.infinity,
                dashColor: Colors.black26,
                dashLength: 8,
                direction: Axis.horizontal,
                lineThickness: 2,
                dashGapLength: MARGIN_SMALL,
                dashGapColor: Colors.transparent,
              ),
            ),
            MovieSeatAndTicketSection(),
            SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
              child: ElevatedButtonView("Buy Ticket for \$20.00", ()=> _navigateToItemOrderScreen(
                  context)),
            ),
            SizedBox(
              height: MARGIN_LARGE,
            ),
          ],
        ),
      )
    );
   
  }
  void _navigateToItemOrderScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemOrderPage()));
  }
}

class MovieSeatAndTicketSection extends StatelessWidget {
  const MovieSeatAndTicketSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM),
      child: Column(
        children: [
          SeatAndTicketView("Ticket","2"),
          SizedBox(height: MARGIN_SMALL_2,),
          SeatAndTicketView("Seats", "D Row/5,6"),
        ],
      ),
    );
  }
}

class SeatAndTicketView extends StatelessWidget {
  final String label;
  final String text;

  const SeatAndTicketView(this.label, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NormalTextView(
          label,
          textColor: Colors.black26,
        ),
        NormalTextView(
          text,
          textColor: Colors.black26,
        ),
      ],
    );
  }
}

class MovieSeatGlossySection extends StatelessWidget {
  const MovieSeatGlossySection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child:
              MovieSeatGlossaryView(SEAT_TYPE_AVAILABLE_TEXT, Colors.black26),
        ),
        Expanded(
          flex: 1,
          child: MovieSeatGlossaryView(SEAT_TYPE_RESERVED, Colors.blueGrey),
        ),
        Expanded(
          flex: 1,
          child: MovieSeatGlossaryView(
              SEAT_TYPE_SELECTION, Colors.deepPurpleAccent),
        ),
      ],
    );
  }
}

class MovieSeatGlossaryView extends StatelessWidget {
  final String type;
  final Color color;

  const MovieSeatGlossaryView(this.type, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(
            width: MARGIN_SMALL,
          ),
          NormalTextView(
            type,
            textColor: Colors.black26,
          ),
        ],
      ),
    );
  }
}

class MovieSeatSection extends StatelessWidget {
  const MovieSeatSection({
    Key key,
    @required List<MovieSeatVO> movieSeats,
  })  : _movieSeats = movieSeats,
        super(key: key);

  final List<MovieSeatVO> _movieSeats;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _movieSeats.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1, crossAxisCount: 10),
      itemBuilder: (context, index) {
        return MovieSeatItemView(
          _movieSeats[index],
        );
      },
    );
  }
}

class MovieNameTimeAndCinemaSection extends StatelessWidget {
  const MovieNameTimeAndCinemaSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          LargeTitleText("Detective PikaChu"),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          NormalTextView(
            "Galaxy Cinema-Golden City",
            textColor: Colors.black26,
          ),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          NormalTextView(
            "Wednesday, 10 May 7:00 PM",
            textColor: Colors.black87,
          ),
          SizedBox(
            height: MARGIN_LARGE,
          ),
        ],
      ),
    );
  }
}
