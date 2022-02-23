import '../response/get_user_response.dart';

abstract class MovieBookingAgent {
  Future<GetUserResponse> emailRegister(
      String name, String email, String phone, String password);
}
