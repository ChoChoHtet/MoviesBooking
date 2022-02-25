

import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/network/dataagents/movie_booking_agents.dart';
import 'package:movies_booking/network/dataagents/retrofit_movie_data_agent_impl.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/persistence/daos/credit_dao.dart';
import 'package:movies_booking/persistence/daos/movie_dao.dart';

import '../../persistence/daos/user_dao.dart';

class MovieBookingModelImpl extends MovieBookingModel {
  MovieBookingAgent _dataAgent = RetrofitMovieDataAgentImpl();
  UserDao userDao = UserDao();
  MovieDao movieDao = MovieDao();
  CreditDao creditDao = CreditDao();

  MovieBookingModelImpl._internal();

  static MovieBookingModelImpl _singleton = MovieBookingModelImpl._internal();

  factory MovieBookingModelImpl() {
    return _singleton;
  }

  @override
  Future<UserVO?> emailRegister(
      String name, String email, String phone, String password) {
    // return _dataAgent
    //     .emailRegister(name, email, phone, password)
    //     .then((value) => value.data)
    //     .asStream()
    //     .first;
    return _dataAgent
        .emailRegister(name, email, phone, password)
        .then((userResponse) async {
      var userVo = userResponse.data;
      if (userVo != null) {
        userVo.token = userResponse.token;
        print("login token: ${userVo.token},res ${userResponse.token}");
        userDao.saveUserInfo(userVo);
      }
      return Future.value(userResponse.data);
    });
  }

  @override
  Future<UserVO?> emailLogin(String email, String password) {
    return _dataAgent.emailLogin(email, password).then((userResponse) async {
      var userVo = userResponse.data;
      print("email login success");
      if (userVo != null) {
        userVo.token = userResponse.token;
        print("login token: ${userVo.token},res ${userResponse.token}");
        userDao.saveUserInfo(userVo);
      }
      return Future.value(userResponse.data);
    });
  }

  @override
  Future<CommonResponse> logout() async {
    var token = userDao.getUserInfo()?.getToken();
    print("token: $token");
    return _dataAgent.logout(token!).then((value) => value).asStream().first;
  }

  @override
  Future<UserVO?> getUserInfo() {
    return Future.value(userDao.getUserInfo());
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovie() {
    return _dataAgent.getComingSoonMovie().then((comingSoon) async {
      List<MovieVO> movieList = comingSoon?.map((movie) {
            movie.isComingSoon = true;
            return movie;
          }).toList() ??
          [];
      movieDao.saveAllMovies(movieList);
      return Future.value(comingSoon);
    });
  }

  @override
  Future<List<CreditVO>?> getMovieCredit(int movieId) {
    return _dataAgent.getMovieCredit(movieId).then((credit) async {
      creditDao.saveAllCast(credit ?? []);
      return Future.value(credit);
    });
  }

  @override
  Future<MovieVO?> getMovieDetail(int movieId) {
    return _dataAgent.getMovieDetail(movieId).then((movie) async {
      if (movie != null) {
        movieDao.saveSingleMovie(movie);
      }
      return Future.value(movie);
    });
  }

  @override
  Future<List<MovieVO>?> getNowShowingMovie() {
    return _dataAgent.getNowShowingMovie().then((nowShowing) async {
      List<MovieVO> movieList = nowShowing?.map((movie) {
            movie.isNowShowing = true;
            return movie;
          }).toList() ??
          [];
      movieDao.saveAllMovies(movieList);
      return Future.value(nowShowing);
    });
  }
}
