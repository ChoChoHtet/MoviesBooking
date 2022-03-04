import 'package:dio/dio.dart';
import 'package:movies_booking/data/request/check_out_request.dart';
import 'package:movies_booking/data/vos/checkout_vo.dart';
import 'package:movies_booking/network/api_constants.dart';
import 'package:movies_booking/network/response/checkout_reponse.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/network/response/get_cinema_response.dart';
import 'package:movies_booking/network/response/get_cinema_seat_response.dart';
import 'package:movies_booking/network/response/get_credit_response.dart';
import 'package:movies_booking/network/response/get_movie_response.dart';
import 'package:movies_booking/network/response/get_payment_response.dart';
import 'package:movies_booking/network/response/get_snack_response.dart';
import 'package:movies_booking/network/response/get_user_response.dart';
import 'package:movies_booking/pages/get_card_response.dart';
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

  //cinema timeslot
  @GET(CINEMA_TIME_SLOTS_END_POINT)
  Future<GetCinemaResponse> getCinemaTimeSlots(
      @Query("date") String date, @Header(PARAMS_AUTHORIZATION) String token);

  //cinema seat plan
  @GET(CINEMA_SEAT_PLAN_END_POINT)
  Future<GetCinemaSeatResponse> getCinemaSeatPlans(
      @Header(PARAMS_AUTHORIZATION) String token,
      @Query(PARAMS_CINEMA_TIME_SLOT_ID) String timeSlotId,
      @Query(PARAMS_BOOKING_DATE) String bookingDate);

  //snacks
  @GET(SNACKS_END_POINT)
  Future<GetSnackResponse> getSnacks(
      @Header(PARAMS_AUTHORIZATION) String token);

  //payment method
  @GET(PAYMENT_METHOD_END_POINT)
  Future<GetPaymentResponse> getPaymentMethods(
      @Header(PARAMS_AUTHORIZATION) String token);

  // create card
  @POST(CREATE_CARD_END_POINT)
  @FormUrlEncoded()
  Future<GetCardResponse> createCard(
      @Header(PARAMS_AUTHORIZATION) String token,
      @Field(PARAMS_CARD_NUMBER) String cardNumber,
      @Field(PARAMS_CARD_HOLDER) String cardHolder,
      @Field(PARAMS_CARD_EXPIRATION_DATE) String expirationDate,
      @Field(PARAMS_CARD_CVC) String cvc);

  //get user profile
  @GET(PROFILE_END_POINT)
  Future<GetUserResponse> getUserProfile(
      @Header(PARAMS_AUTHORIZATION) String token);

  //checkout
  @POST(CHECKOUT_END_POINT)
  Future<CheckoutResponse> checkoutTicket(
      @Header(PARAMS_AUTHORIZATION) String token,
      @Body() CheckOutRequest checkOutRequest);

}
