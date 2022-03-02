// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cinema_seat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCinemaSeatResponse _$GetCinemaSeatResponseFromJson(
        Map<String, dynamic> json) =>
    GetCinemaSeatResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => CinemaSeatVO.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$GetCinemaSeatResponseToJson(
        GetCinemaSeatResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
