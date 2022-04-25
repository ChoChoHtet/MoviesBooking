import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

abstract class PaymentDao{

  void savePaymentMethod(List<PaymentVO> paymentList) ;

  List<PaymentVO> getPaymentMethods();

  Stream<void> getPaymentWatchStream();

  Stream<List<PaymentVO>> getPaymentMethodStream();
}