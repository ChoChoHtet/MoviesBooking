import 'package:movies_booking/resources/dimen.dart';

class MovieSeatVO {
  final String title;
  final String type;

  const MovieSeatVO(this.title, this.type);

  bool isMovieSeatAvailable() => type == SEAT_TYPE_AVAILABLE;

  bool isMovieSeatTaken() => type == SEAT_TYPE_TAKEN;

  bool isMovieSeatRowTitle() => type == SEAT_TYPE_TEXT;
}
