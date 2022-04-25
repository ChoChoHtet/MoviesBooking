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

import '../mock_data/mock_data.dart';

class MovieDataAgentImplMock extends MovieBookingAgent {
  @override
  Future<CheckoutVO?> checkoutTicket(
      String token, CheckOutRequest checkOutRequest) {
    return Future.value(getMockTicketCheckout());
  }

  @override
  Future<GetCardResponse> createCard(String token, String cardNumber,
      String cardHolder, String expirationDate, String cvc) {
    return Future.value(getMockCardResponse());
  }

  @override
  Future<GetUserResponse> emailLogin(String email, String password) {
    return Future.value(getMockUserResponse());
  }

  @override
  Future<GetUserResponse> emailRegister(
      String name, String email, String phone, String password) {
    return Future.value(getMockUserResponse());
  }

  @override
  Future<List<List<CinemaSeatVO>>?> getCinemaSeatPlans(
      String token, int timeSlotId, String bookingDate) {
    return Future.value([getMockSeats()]);
  }

  @override
  Future<List<CinemaVO>?> getCinemaTimeSlots(String date, String token) {
    return Future.value(getMockCinemaTime());
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovie() {
    return Future.value(getMockMovies());
  }

  @override
  Future<List<CreditVO>?> getMovieCredit(int movieId) {
    return Future.value(getMockCredits());
  }

  @override
  Future<MovieVO?> getMovieDetail(int movieId) {
    return Future.value(getMockMovies().first);
  }

  @override
  Future<List<MovieVO>?> getNowShowingMovie() {
    return Future.value(getMockMovies());
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethod(String token) {
    return Future.value(getMockPaymentMethod());
  }

  @override
  Future<List<SnackVO>?> getSnacks(String token) {
    return Future.value(getMockSnacks());
  }

  @override
  Future<GetUserResponse?> getUserProfile(String token) {
    return Future.value(getMockUserResponse());
  }

  @override
  Future<GetUserResponse> googleRegister(String name, String email,
      String phone, String password, String googleToken) {
    return Future.value(getMockUserResponse());
  }

  @override
  Future<GetUserResponse> loginGoogle(String accessToken) {
    return Future.value(getMockUserResponse());
  }

  @override
  Future<CommonResponse> logout(String token) {
    return Future.value(getMockCommonResponse());
  }
}
