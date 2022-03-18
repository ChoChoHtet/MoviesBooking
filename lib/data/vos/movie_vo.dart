import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/data/vos/genre_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';
part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_MOVIE_ID,adapterName: "MovieVOAdapter")
class MovieVO{
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "title")
  @HiveField(1)
  String? title;

  @JsonKey(name: "overview")
  @HiveField(2)
  String? overview;

  @JsonKey(name: "poster_path")
  @HiveField(3)
  String? posterPath;

  @JsonKey(name: "vote_average")
  @HiveField(4)
  double? voteAverage;

  @JsonKey(name: "imdb_id")
  @HiveField(5)
  String? imdbId;

  @JsonKey(name: "genres")
  @HiveField(6)
  List<GenreVO>? genres;

  @HiveField(7)
  bool? isNowShowing;

  @HiveField(8)
  bool? isComingSoon;


  MovieVO(this.id, this.title, this.overview, this.posterPath, this.voteAverage,
      this.imdbId, this.genres, this.isNowShowing, this.isComingSoon);

  List<String> getGenreAsString(){
    return this.genres?.map((genre) => genre.name ?? "").toList() ?? [] ;
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          overview == other.overview &&
          posterPath == other.posterPath &&
          voteAverage == other.voteAverage &&
          imdbId == other.imdbId &&
          genres == other.genres &&
          isNowShowing == other.isNowShowing &&
          isComingSoon == other.isComingSoon;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      overview.hashCode ^
      posterPath.hashCode ^
      voteAverage.hashCode ^
      imdbId.hashCode ^
      genres.hashCode ^
      isNowShowing.hashCode ^
      isComingSoon.hashCode;

  factory MovieVO.fromJson(Map<String,dynamic>json) => _$MovieVOFromJson(json);
  Map<String,dynamic> toJson() => _$MovieVOToJson(this);
}