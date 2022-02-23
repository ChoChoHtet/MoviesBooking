import 'package:movies_booking/data/vos/user_vo.dart';

abstract class MovieBookingModel{
  Future<UserVO?> emailRegister(String name, String email, String phone, String password);
}