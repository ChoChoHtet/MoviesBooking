import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/data/vos/time_slot_vo.dart';
part 'cinema_vo.g.dart';

@JsonSerializable()
class CinemaVO{

  @JsonKey(name: "cinema_id")
  int? cinemaId;

  @JsonKey(name: "cinema")
  String? cinema;

  @JsonKey(name: "timeslots")
  List<TimeSlotVO>? timeSlots ;



  CinemaVO(this.cinemaId, this.cinema, this.timeSlots);


  @override
  String toString() {
    return 'CinemaVO{cinemaId: $cinemaId, cinema: $cinema, timeSlots: $timeSlots}';
  }

  factory CinemaVO.fromJson(Map<String,dynamic>json) => _$CinemaVOFromJson(json);
  Map<String,dynamic> toJson() => _$CinemaVOToJson(this);
}