// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentVOAdapter extends TypeAdapter<PaymentVO> {
  @override
  final int typeId = 10;

  @override
  PaymentVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentVO(
      id: fields[0] as int?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      isSelected: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentVO _$PaymentVOFromJson(Map<String, dynamic> json) => PaymentVO(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$PaymentVOToJson(PaymentVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isSelected': instance.isSelected,
    };
