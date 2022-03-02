import 'package:movies_booking/data/vos/cinema_seat_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/network/response/get_credit_response.dart';
import 'package:movies_booking/network/response/get_movie_response.dart';

import '../response/get_user_response.dart';

abstract class MovieBookingAgent {
  Future<GetUserResponse> emailRegister(
      String name, String email, String phone, String password);

  Future<GetUserResponse> emailLogin(String email, String password);

  Future<CommonResponse> logout(String token);

  Future<List<MovieVO>?> getNowShowingMovie();

  Future<List<MovieVO>?> getComingSoonMovie();

  Future<MovieVO?> getMovieDetail(int movieId);

  Future<List<CreditVO>?> getMovieCredit(int movieId);

  Future<List<CinemaVO>?> getCinemaTimeSlots(String date, String token);
  Future<List<List<CinemaSeatVO>>?> getCinemaSeatPlans(
      String token, int timeSlotId, String bookingDate);
}
