// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_seat_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaSeatVO _$CinemaSeatVOFromJson(Map<String, dynamic> json) => CinemaSeatVO(
      id: json['id'] as int?,
      type: json['type'] as String?,
      seatName: json['seat_name'] as String?,
      symbol: json['symbol'] as String?,
      price: json['price'] as int?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$CinemaSeatVOToJson(CinemaSeatVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
      'isSelected': instance.isSelected,
    };
