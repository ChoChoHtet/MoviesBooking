
import 'package:dio/dio.dart';
import 'package:movies_booking/network/api_constants.dart';
import 'package:movies_booking/network/response/get_credit_response.dart';
import 'package:movies_booking/network/response/get_movie_response.dart';
import 'package:retrofit/http.dart';

import '../data/vos/movie_vo.dart';

part 'movie_api.g.dart';

@RestApi(baseUrl: MOVIES_BASE_URL)
abstract class MovieAPI{
  factory MovieAPI(Dio dio) = _MovieAPI ;
  //Now Showing
  @GET(NOW_PLAYING_END_POINT)
  Future<GetMovieResponse> getNowShowingMovies(
      @Query(PARAMS_API_KEY) String apiKey,
      @Query(PARAMS_PAGE) String page,
      @Query(PARAMS_LANGUAGE) String language);

  //Coming Soon
  @GET(COMING_SOON_END_POINT)
  Future<GetMovieResponse> getComingSoonMovies(
      @Query(PARAMS_API_KEY) String apiKey,
      @Query(PARAMS_PAGE) String page,
      @Query(PARAMS_LANGUAGE) String language);

  //movie detail
  @GET("$MOVIE_DETAIL_END_POINT/{movie_id}")
  Future<MovieVO?> getMoviesDetail(
      @Query(PARAMS_API_KEY) String apiKey,
      @Query(PARAMS_LANGUAGE) String language,
      @Path("movie_id") String movieId);

  //movie credit
  @GET("/3/movie/{movie_id}/credits")
  Future<GetCreditResponse> getMovieCredit(
      @Query(PARAMS_API_KEY) String apiKey,
      @Query(PARAMS_LANGUAGE) String language,
      @Path("movie_id") String movieId);
}