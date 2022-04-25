import 'package:flutter_test/flutter_test.dart';
import 'package:movies_booking/bloc/registration_bloc.dart';

import '../data/model/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){
  group("Registration bloc test",(){
    RegistrationBloc? bloc;
    setUp((){
      bloc = RegistrationBloc(modelImpl: MovieBookingModelImplMock());
    });

    test("User Email Register Test",(){
      bloc?.registerWithEmail("name", "email", "phone", "password");
      expect(bloc?.user, getMockUser());
    });
  });
}