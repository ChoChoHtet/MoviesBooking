
import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';

part 'get_movie_response.g.dart';
@JsonSerializable()
class GetMovieResponse{
  @JsonKey(name: "page")
  int? page;

  @JsonKey(name: "results")
  List<MovieVO>? results;


  GetMovieResponse(this.page, this.results);

  factory GetMovieResponse.fromJson(Map<String,dynamic>json) => _$GetMovieResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetMovieResponseToJson(this);
}