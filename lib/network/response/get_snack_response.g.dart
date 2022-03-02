// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_snack_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSnackResponse _$GetSnackResponseFromJson(Map<String, dynamic> json) =>
    GetSnackResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => SnackVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSnackResponseToJson(GetSnackResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
