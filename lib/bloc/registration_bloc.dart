import 'package:flutter/foundation.dart';
import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/models/movie_booking_model_impl.dart';
import 'package:movies_booking/data/vos/user_vo.dart';

class RegistrationBloc extends ChangeNotifier {
  //State
  UserVO? user;

  //Model
  MovieBookingModel model = MovieBookingModelImpl();

  RegistrationBloc({MovieBookingModel? modelImpl}) {
    if (modelImpl != null) {
      model = modelImpl;
    }
  }

  Future<UserVO?> loginWithEmail(String email, String password) {
    return model.emailLogin(email, password).then((userResponse) {
      user = userResponse;
      notifyListeners();
    }).catchError((error) {});
  }

  Future<UserVO?> registerWithEmail(
      String name, String email, String phone, String password) {
    return model.emailRegister(name, email, phone, password)
        .then((userResponse) {
      user = userResponse;
      notifyListeners();
    }).catchError((error) {});
  }
}
