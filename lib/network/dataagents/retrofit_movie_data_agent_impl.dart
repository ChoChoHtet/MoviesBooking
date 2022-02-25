import 'package:dio/dio.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/network/api_constants.dart';
import 'package:movies_booking/network/dataagents/movie_booking_agents.dart';
import 'package:movies_booking/network/movie_api.dart';
import 'package:movies_booking/network/movie_booking_api.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/network/response/get_credit_response.dart';
import 'package:movies_booking/network/response/get_movie_response.dart';
import 'package:movies_booking/network/response/get_user_response.dart';

class RetrofitMovieDataAgentImpl extends MovieBookingAgent {
  late MovieBookingAPI movieBookingAPI;
  late MovieAPI movieAPI;
  //create privat constructor
  RetrofitMovieDataAgentImpl.internal() {
    final dio = Dio();
    movieBookingAPI = MovieBookingAPI(dio);
    movieAPI = MovieAPI(dio);
  }
  factory RetrofitMovieDataAgentImpl() {
    return _singleton;
  }
  static RetrofitMovieDataAgentImpl _singleton =
      RetrofitMovieDataAgentImpl.internal();

  @override
  Future<GetUserResponse> emailRegister(
      String name, String email, String phone, String password) {
    return movieBookingAPI.emailRegister(name, email, phone, password);
  }

  @override
  Future<GetUserResponse> emailLogin(String email, String password) {
    return movieBookingAPI.emailLogin(email, password);
  }

  @override
  Future<CommonResponse> logout(String token) {
    return movieBookingAPI.logout(token);
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovie() {
    return movieAPI
        .getComingSoonMovies(API_KEY, PAGE.toString(), LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getNowShowingMovie() {
    return movieAPI
        .getComingSoonMovies(API_KEY, PAGE.toString(), LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<CreditVO>?> getMovieCredit(int movieId) {
    return movieAPI
        .getMovieCredit(API_KEY, LANGUAGE_EN_US, movieId.toString())
        .asStream()
        .map((response) => response.cast)
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetail(int movieId) {
    return movieAPI.getMoviesDetail(
        API_KEY, LANGUAGE_EN_US, movieId.toString());
  }
}
