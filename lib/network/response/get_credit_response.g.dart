// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_credit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCreditResponse _$GetCreditResponseFromJson(Map<String, dynamic> json) =>
    GetCreditResponse(
      json['id'] as int?,
      (json['cast'] as List<dynamic>?)
          ?.map((e) => CreditVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCreditResponseToJson(GetCreditResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast,
    };
