import 'package:hive/hive.dart';
import 'package:movies_booking/persistence/daos/credit_dao.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

import '../../../data/vos/credit_vo.dart';

class CreditDaoImpl extends CreditDao {
  CreditDaoImpl._internal();

  static final CreditDaoImpl _singleton = CreditDaoImpl._internal();

  factory CreditDaoImpl() {
    return _singleton;
  }

  @override
  void saveAllCast(List<CreditVO> creditList) async {
    Map<int,CreditVO> casts = Map.fromIterable( creditList,
        key: (cast) => cast.id, value: (cast) => cast);
    await getMovieBox().putAll(casts);
  }

  Box<CreditVO> getMovieBox(){
    return Hive.box<CreditVO>(BOX_NAMES_CREDIT_VO);
  }
}
