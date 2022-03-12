import 'package:movies_booking/data/vos/cinema_seat_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/user_vo.dart';

import '../../network/response/common_response.dart';
import '../../pages/get_card_response.dart';
import '../request/check_out_request.dart';
import '../vos/checkout_vo.dart';
import '../vos/movie_vo.dart';
import '../vos/payment_vo.dart';
import '../vos/snack_vo.dart';

abstract class MovieBookingModel {
  Future<UserVO?> emailRegister(
      String name, String email, String phone, String password);

  Future<UserVO?> googleRegister(String name, String email, String phone,
      String password, String googleToken);

  Future<UserVO?> emailLogin(String email, String password);

  Future<UserVO> loginGoogle(String accessToken);

  Future<CommonResponse> logout();

  void getCinemaTimeSlots(String date);

  void getNowShowingMovie();

  void getComingSoonMovie();

  Future<UserVO?> getUserInfo();

  void getUserProfile();

  void getMovieDetail(int movieId);

  void getDateTimeList();

  void getSnacks();

  void getPaymentMethod();

  Future<List<CreditVO>?> getMovieCredit(int movieId);

  Future<List<CinemaSeatVO>?> getCinemaSeats(
      int timeSlotId, String bookingDate);

  Future<GetCardResponse> createCard(
      String cardNumber, String cardHolder, String expirationDate, String cvc);

  Future<CheckoutVO?> checkoutTicket(CheckOutRequest checkOutRequest);

  ///Database
  Stream<List<MovieVO>?> getNowShowingMovieDB();
  Stream<List<MovieVO>?> getComingSoonMovieDB();
  Stream<UserVO?> getUserInfoDB();
  //Stream<MovieVO?> getMovieDetailDB(int movieId);
  Stream<List<CinemaVO>> getCinemaTimeSlotDB(String date);

  Stream<MovieVO?> getMovieDetailDB(int movieId);
  //Future<List<CinemaVO>> getCinemaTimeSlotDB(String date);
  Stream<List<SnackVO>> getSnackFromDB();
  Stream<List<PaymentVO>?> getPaymentMethodFromDB();
}
