import 'package:json_annotation/json_annotation.dart';
part 'time_slot_vo.g.dart';

@JsonSerializable()
class TimeSlotVO{

  @JsonKey(name: "cinema_day_timeslot_id")
  int? timeSlotId;

  @JsonKey(name: "start_time")
  String? startTime;

  TimeSlotVO(this.timeSlotId, this.startTime);


  @override
  String toString() {
    return 'TimeSlotVO{timeSlotId: $timeSlotId, startTime: $startTime}';
  }

  factory TimeSlotVO.fromJson(Map<String,dynamic>json) => _$TimeSlotVOFromJson(json);
  Map<String,dynamic> toJson() => _$TimeSlotVOToJson(this);
}