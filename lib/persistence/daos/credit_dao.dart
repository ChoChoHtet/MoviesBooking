import 'package:hive/hive.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

import '../../data/vos/credit_vo.dart';

abstract class CreditDao {

  void saveAllCast(List<CreditVO> creditList) ;

}
