import 'package:dio/dio.dart';
import 'package:movies_booking/network/api_constants.dart';
import 'package:movies_booking/network/response/get_user_response.dart';
import 'package:retrofit/http.dart';

part 'movie_booking_api.g.dart';

@RestApi(baseUrl: CINEMA_BASE_URL)
abstract class MovieBookingAPI {
  factory MovieBookingAPI(Dio dio) = _MovieBookingAPI;

  //Register user
  @POST(REGISTER_EMAIL_END_POINT)
  @FormUrlEncoded()
  Future<GetUserResponse> emailRegister(
      @Field("name")String name,
      @Field("email")String email,
      @Field("phone")String phone,
      @Field("password")String password
      );
}
