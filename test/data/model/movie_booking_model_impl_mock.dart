import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/request/check_out_request.dart';
import 'package:movies_booking/data/vos/checkout_vo.dart';
import 'package:movies_booking/data/vos/cinema_seat_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/data/vos/snack_vo.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/pages/get_card_response.dart';

import '../../mock_data/mock_data.dart';

class MovieBookingModelImplMock extends MovieBookingModel {
  @override
  Future<CheckoutVO?> checkoutTicket(CheckOutRequest checkOutRequest) {
    return Future.value(getMockTicketCheckout());
  }

  @override
  void clearUserData() {}

  @override
  Future<GetCardResponse> createCard(
      String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return Future.value(getMockCardResponse());
  }

  @override
  Future<UserVO?> emailLogin(String email, String password) {
    return Future.value(getMockUser());
  }

  @override
  Future<UserVO?> emailRegister(
      String name, String email, String phone, String password) {
    return Future.value(getMockUser());
  }

  @override
  Future<List<CinemaSeatVO>?> getCinemaSeats(
      int timeSlotId, String bookingDate) {
    return Future.value(getMockSeats());
  }

  @override
  Stream<List<CinemaVO>> getCinemaTimeSlotDB(String date) {
    return Stream.value(getMockCinemaTime());
  }

  @override
  void getCinemaTimeSlots(String date) {}

  @override
  void getComingSoonMovie() {}

  @override
  Stream<List<MovieVO>?> getComingSoonMovieDB() {
    return Stream.value(getMockMovies()
        .where((element) => element.isComingSoon ?? false)
        .toList());
  }

  @override
  Future<List<CreditVO>?> getMovieCredit(int movieId) {
    return Future.value(getMockCredits());
  }

  @override
  void getMovieDetail(int movieId) {
  }

  @override
  Stream<MovieVO?> getMovieDetailDB(int movieId) {
    return Stream.value(getMockMovies().first);
  }

  @override
  void getNowShowingMovie() {
  }

  @override
  Stream<List<MovieVO>?> getNowShowingMovieDB() {
    return Stream.value(getMockMovies()
        .where((element) => element.isNowShowing ?? false)
        .toList());
  }

  @override
  void getPaymentMethod() {
  }

  @override
  Stream<List<PaymentVO>?> getPaymentMethodFromDB() {
   return Stream.value(getMockPaymentMethod());
  }

  @override
  Stream<List<SnackVO>> getSnackFromDB() {
    return Stream.value(getMockSnacks());
  }

  @override
  void getSnacks() {

  }

  @override
  Future<UserVO?> getUserInfo() {
   return Future.value(getMockUser());
  }

  @override
  Stream<UserVO?> getUserInfoDB() {
    return Stream.value(getMockUser());
  }

  @override
  void getUserProfile() {
  }

  @override
  Future<UserVO?> googleRegister(String name, String email, String phone,
      String password, String googleToken) {
    return Future.value(getMockUser());
  }

  @override
  Future<UserVO> loginGoogle(String accessToken) {
    return Future.value(getMockUser());
  }

  @override
  Future<CommonResponse> logout() {
    return Future.value(getMockCommonResponse());
  }
}
