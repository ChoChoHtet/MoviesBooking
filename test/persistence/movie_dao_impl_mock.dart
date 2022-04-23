import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/persistence/daos/movie_dao.dart';

import '../mock_data/mock_data.dart';

class MovieDaoImplMock extends MovieDao {
  Map<int, MovieVO> mockMovieList = {};

  @override
  Stream<void> getAllMovieEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<MovieVO> getAllMovies() {
    return getMockMovies();
  }

  @override
  Stream<List<MovieVO>> getComingSoonMovieStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  @override
  List<MovieVO> getComingSoonMovies() {
    if (getAllMovies().isNotEmpty) {
      return getAllMovies()
          .where((element) => element.isComingSoon ?? false)
          .toList();
    } else
      return [];
  }

  @override
  Stream<MovieVO?> getMovieDetailStream(int movieId) {
    return Stream.value(getAllMovies().first);
  }

  @override
  MovieVO? getMoviesById(int movieId) {
    return getMockMovies().first;
  }

  @override
  Stream<List<MovieVO>> getNowShowingMovieStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isNowShowing ?? false)
        .toList());
  }

  @override
  List<MovieVO> getNowShowingMovies() {
    if (getAllMovies().isNotEmpty) {
      return getAllMovies()
          .where((element) => element.isNowShowing ?? false)
          .toList();
    } else
      return [];
  }

  @override
  void saveAllMovies(List<MovieVO> movieList) {
    movieList.forEach((element) {
      mockMovieList[element.id ?? 0] = element;
    });
  }

  @override
  void saveSingleMovie(MovieVO movie) {
    mockMovieList[movie.id ?? 0] = movie;
  }
}
