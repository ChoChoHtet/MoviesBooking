// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotVO _$TimeSlotVOFromJson(Map<String, dynamic> json) => TimeSlotVO(
      json['cinema_day_timeslot_id'] as int?,
      json['start_time'] as String?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$TimeSlotVOToJson(TimeSlotVO instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.timeSlotId,
      'start_time': instance.startTime,
      'isSelected': instance.isSelected,
    };
