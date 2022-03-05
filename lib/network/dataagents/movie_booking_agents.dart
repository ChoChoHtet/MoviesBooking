import 'package:movies_booking/data/request/check_out_request.dart';
import 'package:movies_booking/data/vos/card_vo.dart';
import 'package:movies_booking/data/vos/checkout_vo.dart';
import 'package:movies_booking/data/vos/cinema_seat_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/data/vos/snack_vo.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/network/response/get_credit_response.dart';
import 'package:movies_booking/network/response/get_movie_response.dart';
import 'package:movies_booking/pages/get_card_response.dart';

import '../response/get_user_response.dart';

abstract class MovieBookingAgent {
  Future<GetUserResponse> emailRegister(
      String name, String email, String phone, String password);

  Future<GetUserResponse> googleRegister(
      String name, String email, String phone, String password,String googleToken);

  Future<GetUserResponse> emailLogin(String email, String password);

  Future<GetUserResponse> loginGoogle(String accessToken);

  Future<CommonResponse> logout(String token);

  Future<List<MovieVO>?> getNowShowingMovie();

  Future<List<MovieVO>?> getComingSoonMovie();

  Future<MovieVO?> getMovieDetail(int movieId);

  Future<List<CreditVO>?> getMovieCredit(int movieId);

  Future<List<CinemaVO>?> getCinemaTimeSlots(String date, String token);

  Future<List<List<CinemaSeatVO>>?> getCinemaSeatPlans(
      String token, int timeSlotId, String bookingDate);

  Future<List<SnackVO>?> getSnacks(String token);

  Future<List<PaymentVO>?> getPaymentMethod(String token);

  Future<UserVO?> getUserProfile(String token);

  Future<GetCardResponse> createCard(String token, String cardNumber,
      String cardHolder, String expirationDate, String cvc);

  Future<CheckoutVO?> checkoutTicket(String token,CheckOutRequest checkOutRequest);
}
