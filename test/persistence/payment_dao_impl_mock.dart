import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/persistence/daos/payment_dao.dart';

import '../mock_data/mock_data.dart';

class PaymentDaoImplMock extends PaymentDao {
  Map<int, PaymentVO> mockPayment = {};

  @override
  Stream<List<PaymentVO>> getPaymentMethodStream() {
    return Stream.value(getMockPaymentMethod());
  }

  @override
  List<PaymentVO> getPaymentMethods() {
    return getMockPaymentMethod();
  }

  @override
  Stream<void> getPaymentWatchStream() {
    return Stream<void>.value(null);
  }

  @override
  void savePaymentMethod(List<PaymentVO> paymentList) {
    paymentList.forEach((element) {
      mockPayment[element.id ?? 0] = element;
    });
  }
}
