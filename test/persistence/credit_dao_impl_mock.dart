import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/persistence/daos/credit_dao.dart';

class CreditDaoImplMock extends CreditDao {
  Map<int, CreditVO> mockCreditList = {};

  @override
  void saveAllCast(List<CreditVO> creditList) {
    creditList.forEach((element) {
      mockCreditList[element.id ?? 0] = element;
    });
  }
}
