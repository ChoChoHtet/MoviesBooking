// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieVOAdapter extends TypeAdapter<MovieVO> {
  @override
  final int typeId = 2;

  @override
  MovieVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieVO(
      id: fields[0] as int?,
      title: fields[1] as String?,
      overview: fields[2] as String?,
      posterPath: fields[3] as String?,
      voteAverage: fields[4] as double?,
      imdbId: fields[5] as String?,
      genres: (fields[6] as List?)?.cast<GenreVO>(),
      isNowShowing: fields[7] as bool?,
      isComingSoon: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieVO obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.voteAverage)
      ..writeByte(5)
      ..write(obj.imdbId)
      ..writeByte(6)
      ..write(obj.genres)
      ..writeByte(7)
      ..write(obj.isNowShowing)
      ..writeByte(8)
      ..write(obj.isComingSoon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVO _$MovieVOFromJson(Map<String, dynamic> json) => MovieVO(
      id: json['id'] as int?,
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      imdbId: json['imdb_id'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenreVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      isNowShowing: json['isNowShowing'] as bool?,
      isComingSoon: json['isComingSoon'] as bool?,
    );

Map<String, dynamic> _$MovieVOToJson(MovieVO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'imdb_id': instance.imdbId,
      'genres': instance.genres,
      'isNowShowing': instance.isNowShowing,
      'isComingSoon': instance.isComingSoon,
    };
