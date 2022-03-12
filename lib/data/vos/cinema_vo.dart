import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/data/vos/time_slot_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';
part 'cinema_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_CINEMA_TIME_SLOT,adapterName: "CinemaVOAdapter")
class CinemaVO{

  @JsonKey(name: "cinema_id")
  @HiveField(0)
  int? cinemaId;

  @JsonKey(name: "cinema")
  @HiveField(1)
  String? cinema;

  @JsonKey(name: "timeslots")
  @HiveField(2)
  List<TimeSlotVO>? timeSlots ;

  @HiveField(3)
  bool? isSelected = false ;



  CinemaVO(this.cinemaId, this.cinema, this.timeSlots);


  @override
  String toString() {
    return 'CinemaVO{cinemaId: $cinemaId, cinema: $cinema, timeSlots: $timeSlots}';
  }

  factory CinemaVO.fromJson(Map<String,dynamic>json) => _$CinemaVOFromJson(json);
  Map<String,dynamic> toJson() => _$CinemaVOToJson(this);
}