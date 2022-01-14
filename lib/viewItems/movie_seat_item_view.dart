import 'package:flutter/material.dart';
import 'package:movies_booking/data.vos/movie_seat_vo.dart';
import 'package:movies_booking/resources/dimen.dart';

class MovieSeatItemView extends StatelessWidget {
  final MovieSeatVO movieSeatVO;

  const MovieSeatItemView(this.movieSeatVO);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MARGIN_CARD_SMALL,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MARGIN_SMALL),
          topRight: Radius.circular(MARGIN_SMALL),
        ),
        color: _getColor(movieSeatVO),
      ),
      child: Center(
        child: Text(movieSeatVO.title),
      ),
    );
  }

  Color _getColor(MovieSeatVO movieSeatVO) {
    if (movieSeatVO.isMovieSeatAvailable()) {
      return Colors.black26;
    } else if (movieSeatVO.isMovieSeatTaken()) {
      return Colors.blueGrey;
    } else {
      return Colors.white;
    }
  }
}
