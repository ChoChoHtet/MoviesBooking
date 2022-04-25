import 'package:flutter/material.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';

import '../data/vos/cinema_seat_vo.dart';
import '../data/vos/movie_seat_vo.dart';

class MovieSeatItemView extends StatelessWidget {
  final CinemaSeatVO? movieSeatVO;

  const MovieSeatItemView(this.movieSeatVO);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(movieSeatVO?.seatName ?? ""),
      margin: EdgeInsets.all(
        MARGIN_CARD_SMALL,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MARGIN_SMALL),
          topRight: Radius.circular(MARGIN_SMALL),
        ),
        color: _getColor(movieSeatVO),
      ),
      child: Center(
        child: Text(
          _setSeatText(movieSeatVO),
          style: TextStyle(
            color: movieSeatVO?.isSelected == true ? Colors.white : null,
          ),
        ),
      ),
    );
  }

  String _setSeatText(CinemaSeatVO? movieSeatVO) {
    if (movieSeatVO?.isSeatTypeText() == true) {
      return movieSeatVO?.symbol ?? "";
    } else if (movieSeatVO?.isSeatTypeAvailable() == true &&
        movieSeatVO?.isSelected == true) {
      List<String> name = movieSeatVO?.seatName?.split("-") ?? [];
      return name.isNotEmpty && name.length == 2
          ? name.last
          : movieSeatVO?.symbol ?? "";
    }
    return "";
  }

  Color _getColor(CinemaSeatVO? movieSeatVO) {
    if (movieSeatVO?.isSeatTypeAvailable() == true) {
      if (movieSeatVO?.isSelected == true) {
        return DATE_NONE_SELECT_COLOR;
      }
      return Colors.black26;
    } else if (movieSeatVO?.isSeatTypeTaken() == true) {
      return Colors.blueGrey;
    } else
      return Colors.white;
  }
}
