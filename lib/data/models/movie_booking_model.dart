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

abstract class MovieBookingModel{
  Future<UserVO?> emailRegister(String name, String email, String phone, String password);
  Future<UserVO?> emailLogin(String email,String password);
  Future<CommonResponse> logout();
  Future<UserVO?> getUserInfo();
  Future<List<CinemaVO>?> getCinemaTimeSlots(String date);

  Future<List<MovieVO>?> getNowShowingMovie();

  Future<List<MovieVO>?> getComingSoonMovie();

  Future<MovieVO?> getMovieDetail(int movieId);

  Future<List<CreditVO>?> getMovieCredit(int movieId);

  Future<List<CinemaSeatVO>?> getCinemaSeats(int timeSlotId,String bookingDate);


  Future<List<SnackVO>?> getSnacks();

  Future<List<PaymentVO>?> getPaymentMethod();

  Future<UserVO?> getUserProfile();

  Future<GetCardResponse> createCard( String cardNumber,
      String cardHolder, String expirationDate, String cvc);

  Future<CheckoutVO?> checkoutTicket(CheckOutRequest checkOutRequest);
}