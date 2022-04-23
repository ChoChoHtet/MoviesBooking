import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/persistence/daos/movie_dao.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

class MovieDaoImpl extends MovieDao {
  MovieDaoImpl._internal();

  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl() {
    return _singleton;
  }

  @override
  void saveAllMovies(List<MovieVO> movieList) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movieList,
        key: (movie) => movie.id, value: (movie) => movie);
    await getMovieBox().putAll(movieMap);
  }

  @override
  void saveSingleMovie(MovieVO movie) {
    getMovieBox().put(movie.id, movie);
  }

  @override
  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  @override
  MovieVO? getMoviesById(int movieId) {
    return getMovieBox().get(movieId);
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAMES_MOVIE_VO);
  }

  /// Reactive Programming

  @override
  Stream<void> getAllMovieEventStream() {
    return getMovieBox().watch();
  }

  @override
  Stream<List<MovieVO>> getNowShowingMovieStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isNowShowing ?? false)
        .toList());
  }

  @override
  Stream<List<MovieVO>> getComingSoonMovieStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  @override
  Stream<MovieVO?> getMovieDetailStream(int movieId) {
    return Stream.value(getMoviesById(movieId));
  }

  @override
  List<MovieVO> getNowShowingMovies() {
    if (getAllMovies().isNotEmpty) {
      return getAllMovies()
          .where((element) => element.isNowShowing ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  List<MovieVO> getComingSoonMovies() {
    if (getAllMovies().isNotEmpty) {
      return getAllMovies()
          .where((element) => element.isComingSoon ?? false)
          .toList();
    } else {
      return [];
    }
  }
}
