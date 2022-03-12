import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

class PaymentDao{
  PaymentDao._internal();
  static final PaymentDao _singleton = PaymentDao._internal();

  factory PaymentDao() {
    return _singleton;
  }

  void savePaymentMethod(List<PaymentVO> paymentList) async {
    Map<int, PaymentVO> movieMap = Map.fromIterable(paymentList,
        key: (method) => method.id, value: (method) => method);
    await getPaymentBox().putAll(movieMap);
  }

  Box<PaymentVO> getPaymentBox(){
    return Hive.box<PaymentVO>(BOX_NAMES_PAYMENT_VO);
  }

  List<PaymentVO> getPaymentMethods() {
    return getPaymentBox().values.toList();
  }

  Stream<void> getPaymentWatchStream(){
    return getPaymentBox().watch();
  }

  Stream<List<PaymentVO>> getPaymentMethodStream(){
    return Stream.value(getPaymentMethods());
  }
}