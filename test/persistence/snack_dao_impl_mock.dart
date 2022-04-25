import 'package:movies_booking/data/vos/snack_vo.dart';
import 'package:movies_booking/persistence/daos/snack_dao.dart';

import '../mock_data/mock_data.dart';

class SnackDaoImplMock extends SnackDao{
  Map<int,SnackVO> mockSnacks = {};
  @override
  List<SnackVO> getAllSnacks() {
   return getMockSnacks();
  }

  @override
  Stream<void> getSnackEventStream() {
   return Stream<void>.value(null);
  }

  @override
  Stream<List<SnackVO>> getSnackListStream() {
   return Stream.value(getMockSnacks());
  }

  @override
  void saveSnackList(List<SnackVO> snackList) {
    snackList.forEach((element) {
      mockSnacks[element.id ?? 0] = element  ;
    });
  }

}