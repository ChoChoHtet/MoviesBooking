// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCardResponse _$GetCardResponseFromJson(Map<String, dynamic> json) =>
    GetCardResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => CardVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCardResponseToJson(GetCardResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
