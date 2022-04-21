import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

class MovieDaoImpl{
  MovieDaoImpl._internal();
  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl() {
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
  /// Reactive Programming

  Stream<void> getAllMovieEventStream(){
    return getMovieBox().watch();
  }
  Stream<List<MovieVO>> getNowShowingMovieStream() {
    return Stream.value(getAllMovies()
    // .where((element) => element.isNowShowing ?? false)
        .toList());
  }

  Stream<List<MovieVO>> getComingSoonMovieStream() {
    return Stream.value(getAllMovies()
   // .where((element) => element.isComingSoon ?? false)
        .toList());
  }
  Stream<MovieVO?> getMovieDetailStream(int movieId){
    return Stream.value(getMoviesById(movieId));
  }
  List<MovieVO> getNowShowingMovies(){
    if( getAllMovies().isNotEmpty){
      return getAllMovies()
          .where((element) => element.isNowShowing ?? false).toList();
    }else {
      return [];
    }
  }

  List<MovieVO> getComingSoonMovies(){
    if( getAllMovies().isNotEmpty){
      return getAllMovies()
          .where((element) => element.isComingSoon ?? false).toList();
    }else {
      return [];
    }
  }
}