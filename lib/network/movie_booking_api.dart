import 'package:dio/dio.dart';
import 'package:movies_booking/network/api_constants.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/network/response/get_credit_response.dart';
import 'package:movies_booking/network/response/get_movie_response.dart';
import 'package:movies_booking/network/response/get_user_response.dart';
import 'package:retrofit/http.dart';

import '../data/vos/movie_vo.dart';

part 'movie_booking_api.g.dart';

@RestApi(baseUrl: CINEMA_BASE_URL)
abstract class MovieBookingAPI {
  factory MovieBookingAPI(Dio dio) = _MovieBookingAPI;

  //Register user
  @POST(REGISTER_EMAIL_END_POINT)
  @FormUrlEncoded()
  Future<GetUserResponse> emailRegister(
      @Field("name") String name,
      @Field("email") String email,
      @Field("phone") String phone,
      @Field("password") String password);

  //Email login
  @POST(EMAIL_LOGIN_END_POINT)
  @FormUrlEncoded()
  Future<GetUserResponse> emailLogin(
      @Field("email") String email, @Field("password") String password);

  //user logout
  @POST(LOGOUT_END_POINT)
  Future<CommonResponse> logout(@Header(PARAMS_AUTHORIZATION) String token);


}
