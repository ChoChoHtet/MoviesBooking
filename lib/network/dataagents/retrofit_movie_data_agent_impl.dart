import 'package:dio/dio.dart';
import 'package:movies_booking/network/dataagents/movie_booking_agents.dart';
import 'package:movies_booking/network/movie_booking_api.dart';
import 'package:movies_booking/network/response/get_user_response.dart';

class RetrofitMovieDataAgentImpl extends MovieBookingAgent{
  late MovieBookingAPI movieBookingAPI ;
  //create privat constructor
  RetrofitMovieDataAgentImpl.internal(){
    final dio = Dio();
    movieBookingAPI = MovieBookingAPI(dio);
  }
  factory RetrofitMovieDataAgentImpl(){
    return _singleton ;
  }
  static RetrofitMovieDataAgentImpl _singleton = RetrofitMovieDataAgentImpl.internal();

  @override
  Future<GetUserResponse> emailRegister(String name, String email, String phone, String password) {
    return movieBookingAPI.emailRegister(name, email, phone, password);
  }

}