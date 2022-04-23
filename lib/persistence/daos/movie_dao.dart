
import 'package:movies_booking/data/vos/movie_vo.dart';


abstract class MovieDao{

  void saveAllMovies(List<MovieVO> movieList);

  void saveSingleMovie(MovieVO movie);

  List<MovieVO> getAllMovies();

  MovieVO? getMoviesById(int movieId);

  Stream<void> getAllMovieEventStream();

  Stream<List<MovieVO>> getNowShowingMovieStream();

  Stream<List<MovieVO>> getComingSoonMovieStream();

  Stream<MovieVO?> getMovieDetailStream(int movieId);

  List<MovieVO> getNowShowingMovies();

  List<MovieVO> getComingSoonMovies();
}