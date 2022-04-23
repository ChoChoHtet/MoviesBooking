import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/persistence/daos/payment_dao.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

class PaymentDaoImpl extends PaymentDao{
  PaymentDaoImpl._internal();
  static final PaymentDaoImpl _singleton = PaymentDaoImpl._internal();

  factory PaymentDaoImpl() {
    return _singleton;
  }

  @override
  void savePaymentMethod(List<PaymentVO> paymentList) async {
    Map<int, PaymentVO> movieMap = Map.fromIterable(paymentList,
        key: (method) => method.id, value: (method) => method);
    await getPaymentBox().putAll(movieMap);
  }

  Box<PaymentVO> getPaymentBox(){
    return Hive.box<PaymentVO>(BOX_NAMES_PAYMENT_VO);
  }

  @override
  List<PaymentVO> getPaymentMethods() {
    return getPaymentBox().values.toList();
  }

  @override
  Stream<void> getPaymentWatchStream(){
    return getPaymentBox().watch();
  }

  @override
  Stream<List<PaymentVO>> getPaymentMethodStream(){
    return Stream.value(getPaymentMethods());
  }
}