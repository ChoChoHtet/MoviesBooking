import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

class MovieDao{
  MovieDao._internal();
  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() {
    return _singleton;
  }
  void saveAllMovies(List<MovieVO> movieList) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO movie) {
    getMovieBox().put(movie.id, movie);
  }

  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  MovieVO? getMoviesById(int movieId) {
    return getMovieBox().get(movieId);
  }

  Box<MovieVO> getMovieBox(){
    return Hive.box<MovieVO>(BOX_NAMES_MOVIE_VO);
  }
}