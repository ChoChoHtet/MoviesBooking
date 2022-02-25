import 'package:hive/hive.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

import '../../data/vos/credit_vo.dart';

class CreditDao {
  CreditDao._internal();

  static final CreditDao _singleton = CreditDao._internal();

  factory CreditDao() {
    return _singleton;
  }
  Future<void> saveAllCast(List<CreditVO> creditList) async {
    Map<int,CreditVO> casts = Map.fromIterable( creditList,
        key: (cast) => cast.id, value: (cast) => cast);
    await getMovieBox().putAll(casts);
  }
  Box<CreditVO> getMovieBox(){
    return Hive.box<CreditVO>(BOX_NAMES_CREDIT_VO);
  }
}
