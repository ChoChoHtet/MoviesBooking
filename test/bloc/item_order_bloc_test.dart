import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies_booking/bloc/item_order_bloc.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';

import '../data/model/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Item Order Bloc Test", () {
    ItemOrderBloc? bloc;
    setUp(() {
      bloc = ItemOrderBloc(modelImpl: MovieBookingModelImplMock());
    });

    test("Get Snack List Test", () {
      expect(bloc?.snacksList?.contains(getMockSnacks().first), true);
    });

    test("Get Payment Method Test", () {
      expect(bloc?.paymentList?.contains(getMockPaymentMethod().last), true);
    });

    test("User Tap Decrease and Calculate  Total Price Test", () {
      bloc?.decreaseQty(0);
      expect(bloc?.totalPrice, 5);
    });

    test("Tap Increase and calculate total price test", () {
      bloc?.incrementQty(0);
      bloc?.incrementQty(0);
      expect(bloc?.totalPrice, 10);
    });

    test("Select Payment Test", () {
      var payment = PaymentVO(
          id: 1,
          name: "Credit Card",
          description: "Visa, Master Card, JCB",
          isSelected: false);
      bloc?.setPaymentSelected(payment);
      expect(bloc?.paymentList, getMockPaymentMethod());
    });
  });
}
