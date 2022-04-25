// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_time_hive_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaTimeHiveVOAdapter extends TypeAdapter<CinemaTimeHiveVO> {
  @override
  final int typeId = 6;

  @override
  CinemaTimeHiveVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaTimeHiveVO(
      (fields[0] as List?)?.cast<CinemaVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, CinemaTimeHiveVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.cinemaTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaTimeHiveVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
