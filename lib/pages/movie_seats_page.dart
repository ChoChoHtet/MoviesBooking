import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_booking/bloc/movie_seat_bloc.dart';
import 'package:movies_booking/data/vos/cinema_seat_vo.dart';
import 'package:movies_booking/pages/item_order_page.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/viewItems/movie_seat_item_view.dart';
import 'package:movies_booking/widgets/back_button_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:provider/provider.dart';

class MovieSeatPage extends StatelessWidget {
  final int movieId;
  final String movieName;
  final String moviePath;
  final int timeSlotId;
  final String bookingDate;
  final String cinemaName;
  final String startTime;
  final int cinemaId;

  MovieSeatPage(
      {required this.movieId,
      required this.movieName,
      required this.moviePath,
      required this.timeSlotId,
      required this.bookingDate,
      required this.cinemaName,
      required this.startTime,
      required this.cinemaId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieSeatBloc(timeSlotId, bookingDate),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: BackButtonView(() => Navigator.pop(context)),
          ),
          body: SingleChildScrollView(
            key: Key(KEY_SEAT_PAGE_SCROLL),
            child: Column(
              children: [
                MovieNameTimeAndCinemaSection(
                  movieName: movieName,
                  cinemaName: cinemaName,
                  date: bookingDate,
                  startTime: startTime,
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                Selector<MovieSeatBloc, List<CinemaSeatVO>?>(
                  selector: (context, bloc) => bloc.cinemaSeatList,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (BuildContext context, cinemaSeats, Widget? child) {
                    return MovieSeatSection(
                      movieSeats: cinemaSeats,
                      onTapSeat: (seatVO, index) {
                        MovieSeatBloc bloc =
                            Provider.of(context, listen: false);
                        bloc.setSeatSelected(seatVO, index);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                MovieSeatGlossySection(),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
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
                Selector<MovieSeatBloc, int>(
                  selector: (context, bloc) => bloc.seatCount,
                  builder: (BuildContext context, seatCount, Widget? child) {
                    return Selector<MovieSeatBloc, String>(
                        selector: (context, bloc) => bloc.seatRows,
                        builder:
                            (BuildContext context, seatRows, Widget? child) {
                          return MovieSeatAndTicketSection(
                            seatCount: seatCount.toString(),
                            seatRow: seatRows,
                          );
                        });
                  },
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                  child: Selector<MovieSeatBloc, int>(
                    selector: (context, bloc) => bloc.totalPrice,
                    builder: (BuildContext context, totalPrice, Widget? child) {
                      MovieSeatBloc bloc = Provider.of(context, listen: false);
                      return ElevatedButtonView(
                        "Buy Ticket for \$$totalPrice",
                        () {
                          if(bloc.validateSeats()){
                            _navigateToItemOrderScreen(
                                context, totalPrice, bloc.seatRows);
                          }else {
                            _showAlertDialog(context);
                          }
                        },
                        keyName: KEY_SEAT_BUY_TICKET,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
              ],
            ),
          )),
    );
  }
  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text("Cinema Seats "),
        content: Text("Please choose seats. Thanks"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              key: Key(KEY_CINEMA_SEAT_DIALOG_OKAY),
            ),
          ),
        ],
      ),
    );
  }
  void _navigateToItemOrderScreen(
      BuildContext context, int totalPrice, String seatRows) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ItemOrderPage(
                  movieId: movieId,
                  cinemaId: cinemaId,
                  timeSlotId: timeSlotId,
                  bookingDate: bookingDate,
                  totalPrice: totalPrice,
                  seatNumbers: seatRows,
                  moviePath: moviePath,
                  cinemaName: cinemaName,
                )));
  }
}

class MovieSeatAndTicketSection extends StatelessWidget {
  final String seatCount;
  final String seatRow;

  MovieSeatAndTicketSection({required this.seatCount, required this.seatRow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM),
      child: Column(
        children: [
          SeatAndTicketView("Ticket", seatCount),
          SizedBox(
            height: MARGIN_SMALL_2,
          ),
          SeatAndTicketView("Seats", seatRow),
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
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        MovieSeatGlossaryView(SEAT_TYPE_AVAILABLE_TEXT, Colors.black26),
        MovieSeatGlossaryView(SEAT_TYPE_RESERVED, Colors.blueGrey),
        MovieSeatGlossaryView(SEAT_TYPE_SELECTION, Colors.deepPurpleAccent),
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
        mainAxisSize: MainAxisSize.min,
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
  const MovieSeatSection({required this.movieSeats, required this.onTapSeat});

  final List<CinemaSeatVO>? movieSeats;
  final Function(CinemaSeatVO? seat, int index) onTapSeat;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieSeats?.length ?? 0,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1, crossAxisCount: 14),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onTapSeat(movieSeats?[index], index);
          },
          child: MovieSeatItemView(
            movieSeats?[index],
          ),
        );
      },
    );
  }
}

class MovieNameTimeAndCinemaSection extends StatelessWidget {
  final String movieName;
  final String cinemaName;
  final String date;
  final String startTime;

  MovieNameTimeAndCinemaSection(
      {required this.movieName,
      required this.cinemaName,
      required this.date,
      required this.startTime});

  String _getMovieDate() {
    DateTime dateTime = new DateFormat("yyyy-MM-dd").parse(this.date);
    String date = DateFormat("EEEE, dd MMMM").format(dateTime);
    return "$date, $startTime";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          LargeTitleText(this.movieName),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          NormalTextView(
            this.cinemaName,
            textColor: Colors.black26,
          ),
          SizedBox(
            height: MARGIN_SMALL,
          ),
          NormalTextView(
            //"Wednesday, 10 May 7:00 PM",
            _getMovieDate(),
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
