import 'package:dio/dio.dart';
import 'package:movies_booking/data/request/check_out_request.dart';
import 'package:movies_booking/data/vos/checkout_vo.dart';
import 'package:movies_booking/data/vos/cinema_seat_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/data/vos/snack_vo.dart';
import 'package:movies_booking/network/api_constants.dart';
import 'package:movies_booking/network/dataagents/movie_booking_agents.dart';
import 'package:movies_booking/network/movie_api.dart';
import 'package:movies_booking/network/movie_booking_api.dart';
import 'package:movies_booking/network/response/checkout_reponse.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/network/response/get_user_response.dart';
import 'package:movies_booking/pages/get_card_response.dart';

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
  Future<GetUserResponse> googleRegister(String name, String email,
      String phone, String password, String googleToken) {
    return movieBookingAPI.googleOrFacebookRegister(name, email, phone, password,googleToken,"");
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
        .getNowShowingMovies(API_KEY, PAGE.toString(), LANGUAGE_EN_US)
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

  @override
  Future<List<CinemaVO>?> getCinemaTimeSlots(String date, String token) {
    return movieBookingAPI
        .getCinemaTimeSlots(date, token)
        .asStream()
        .map((cinema) => cinema.data)
        .first;
  }

  @override
  Future<List<List<CinemaSeatVO>>?> getCinemaSeatPlans(
      String token, int timeSlotId, String bookingDate) {
    return movieBookingAPI
        .getCinemaSeatPlans(token, timeSlotId.toString(), bookingDate)
        .asStream()
        .map((seats) => seats.data)
        .first;
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethod(String token) {
    return movieBookingAPI
        .getPaymentMethods(token)
        .asStream()
        .map((payments) => payments.data)
        .first;
  }

  @override
  Future<List<SnackVO>?> getSnacks(String token) {
    return movieBookingAPI
        .getSnacks(token)
        .asStream()
        .map((snacks) => snacks.data)
        .first;
  }

  @override
  Future<GetCardResponse> createCard(String token, String cardNumber,
      String cardHolder, String expirationDate, String cvc) {
    return movieBookingAPI.createCard(
        token, cardNumber, cardHolder, expirationDate, cvc);
  }

  @override
  Future<GetUserResponse?> getUserProfile(String token) {
    return movieBookingAPI
        .getUserProfile(token);
        /*.asStream()
        .map((profile) => profile.data)
        .first;*/
  }

  @override
  Future<CheckoutVO?> checkoutTicket(String token, CheckOutRequest checkOutRequest) {
    return movieBookingAPI.checkoutTicket(token, checkOutRequest).then((value){
      print("check response : ${value.toString()}");
      if(value.code == 200){
        return Future<CheckoutResponse>.value(value);
      }else{
        return Future<CheckoutResponse>.error(value.message ?? "Checkout error");
      }
    }).asStream()
        .map((checkout) => checkout.data)
        .first ;


  }

  @override
  Future<GetUserResponse> loginGoogle(String accessToken) {
    return movieBookingAPI.loginGoogle(accessToken);
  }


}
