import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/persistence/hive_constants.dart';
part 'time_slot_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TIME_SLOT,adapterName: "TimeSlotVOAdapter")
class TimeSlotVO{

  @JsonKey(name: "cinema_day_timeslot_id")
  @HiveField(0)
  int? timeSlotId;

  @JsonKey(name: "start_time")
  @HiveField(1)
  String? startTime;

  @HiveField(2)
  bool? isSelected ;

  TimeSlotVO(this.timeSlotId, this.startTime,this.isSelected);


  @override
  String toString() {
    return 'TimeSlotVO{timeSlotId: $timeSlotId, startTime: $startTime, isSelected: $isSelected}';
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlotVO &&
          runtimeType == other.runtimeType &&
          timeSlotId == other.timeSlotId &&
          startTime == other.startTime &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      timeSlotId.hashCode ^ startTime.hashCode ^ isSelected.hashCode;

  factory TimeSlotVO.fromJson(Map<String,dynamic>json) => _$TimeSlotVOFromJson(json);
  Map<String,dynamic> toJson() => _$TimeSlotVOToJson(this);
}