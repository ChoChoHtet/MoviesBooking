

import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/data/request/snack_request.dart';
part 'check_out_request.g.dart';

@JsonSerializable()
class CheckOutRequest{
/*  @JsonKey(name: "cinema_day_timeslot_id")
  int? timeSlotId;

  @JsonKey(name: "seat_number")
  String? seatNumber;

  @JsonKey(name: "booking_date")
  String? bookingDate;

  @JsonKey(name: "total_price")
  int? totalPrice;

  @JsonKey(name: "movie_id")
  int? movieId;

  @JsonKey(name: "card_id")
  int? cardId;

  @JsonKey(name: "cinema_id")
  int? cinemaId;

  @JsonKey(name: "snacks")
  List<SnackRequest>? snacks;*/

   @JsonKey(name: "cinema_day_timeslot_id")
   int cinemaDayTimeSlotId;

   @JsonKey(name: "seat_number")
   String seatNumber;

   @JsonKey(name: "booking_date")
   String bookingDate;

   @JsonKey(name: "movie_id")
   int movieId;

   @JsonKey(name: "card_id")
   int cardId;

   @JsonKey(name: "cinema_id")
   int cinemaId;

   @JsonKey(name: "total_price")
   int totalPrice;

   @JsonKey(name: "snacks")
   List<SnackRequest> snacks;


   CheckOutRequest(this.cinemaDayTimeSlotId, this.seatNumber, this.bookingDate,
      this.movieId, this.cardId, this.cinemaId, this.totalPrice, this.snacks);


   @override
  String toString() {
    return 'CheckOutRequest{cinemaDayTimeSlotId: $cinemaDayTimeSlotId, seatNumber: $seatNumber, bookingDate: $bookingDate, movieId: $movieId, cardId: $cardId, cinemaId: $cinemaId, totalPrice: $totalPrice, snacks: $snacks}';
  }

   factory CheckOutRequest.fromJson(Map<String,dynamic>json) => _$CheckOutRequestFromJson(json);
  Map<String,dynamic> toJson() => _$CheckOutRequestToJson(this);

}