import 'package:flutter_test/flutter_test.dart';
import 'package:movies_booking/bloc/payment_bloc.dart';
import 'package:movies_booking/data/request/check_out_request.dart';

import '../data/model/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Payment Bloc Test", () {
    PaymentBloc? bloc;
    setUp(() {
      bloc = PaymentBloc(modelImpl: MovieBookingModelImplMock());
    });

    test("Get User Card Test", () {
      expect(bloc?.cardList?.contains(getMockCardVO().first), true);
    });

    test("Select Card Test", () {
      bloc?.setSelectedCard(1);
      expect(bloc?.selectCardId, 2);
    });
    
  });
}
