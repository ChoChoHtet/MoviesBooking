import 'package:movies_booking/data/request/check_out_request.dart';
import 'package:movies_booking/data/vos/checkout_vo.dart';
import 'package:movies_booking/data/vos/cinema_seat_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/data/vos/snack_vo.dart';
import 'package:movies_booking/network/dataagents/movie_booking_agents.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/network/response/get_user_response.dart';
import 'package:movies_booking/pages/get_card_response.dart';

class MovieDataAgentImpl extends MovieBookingAgent{
  @override
  Future<CheckoutVO?> checkoutTicket(String token, CheckOutRequest checkOutRequest) {
    // TODO: implement checkoutTicket
    throw UnimplementedError();
  }

  @override
  Future<GetCardResponse> createCard(String token, String cardNumber, String cardHolder, String expirationDate, String cvc) {
    // TODO: implement createCard
    throw UnimplementedError();
  }

  @override
  Future<GetUserResponse> emailLogin(String email, String password) {
    // TODO: implement emailLogin
    throw UnimplementedError();
  }

  @override
  Future<GetUserResponse> emailRegister(String name, String email, String phone, String password) {
    // TODO: implement emailRegister
    throw UnimplementedError();
  }

  @override
  Future<List<List<CinemaSeatVO>>?> getCinemaSeatPlans(String token, int timeSlotId, String bookingDate) {
    // TODO: implement getCinemaSeatPlans
    throw UnimplementedError();
  }

  @override
  Future<List<CinemaVO>?> getCinemaTimeSlots(String date, String token) {
    // TODO: implement getCinemaTimeSlots
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovie() {
    // TODO: implement getComingSoonMovie
    throw UnimplementedError();
  }

  @override
  Future<List<CreditVO>?> getMovieCredit(int movieId) {
    // TODO: implement getMovieCredit
    throw UnimplementedError();
  }

  @override
  Future<MovieVO?> getMovieDetail(int movieId) {
    // TODO: implement getMovieDetail
    throw UnimplementedError();
  }

  @override
  Future<List<MovieVO>?> getNowShowingMovie() {
    // TODO: implement getNowShowingMovie
    throw UnimplementedError();
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethod(String token) {
    // TODO: implement getPaymentMethod
    throw UnimplementedError();
  }

  @override
  Future<List<SnackVO>?> getSnacks(String token) {
    // TODO: implement getSnacks
    throw UnimplementedError();
  }

  @override
  Future<GetUserResponse?> getUserProfile(String token) {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }

  @override
  Future<GetUserResponse> googleRegister(String name, String email, String phone, String password, String googleToken) {
    // TODO: implement googleRegister
    throw UnimplementedError();
  }

  @override
  Future<GetUserResponse> loginGoogle(String accessToken) {
    // TODO: implement loginGoogle
    throw UnimplementedError();
  }

  @override
  Future<CommonResponse> logout(String token) {
    // TODO: implement logout
    throw UnimplementedError();
  }
  
}