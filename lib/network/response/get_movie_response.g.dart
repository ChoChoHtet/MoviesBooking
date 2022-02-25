// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMovieResponse _$GetMovieResponseFromJson(Map<String, dynamic> json) =>
    GetMovieResponse(
      json['page'] as int?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMovieResponseToJson(GetMovieResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
    };
