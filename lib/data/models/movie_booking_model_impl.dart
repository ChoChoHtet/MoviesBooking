import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/network/dataagents/movie_booking_agents.dart';
import 'package:movies_booking/network/dataagents/retrofit_movie_data_agent_impl.dart';

class MovieBookingModelImpl extends MovieBookingModel {
  MovieBookingAgent _dataAgent = RetrofitMovieDataAgentImpl();

  MovieBookingModelImpl._internal();

  static MovieBookingModelImpl _singleton = MovieBookingModelImpl._internal();

  factory MovieBookingModelImpl() {
    return _singleton;
  }

  @override
  Future<UserVO?> emailRegister(
      String name, String email, String phone, String password) {
    return _dataAgent
        .emailRegister(name, email, phone, password)
        .then((value) => value.data)
        .asStream()
        .first;
  }
}
