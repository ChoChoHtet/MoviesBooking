import 'package:hive/hive.dart';
import 'package:movies_booking/persistence/daos/snack_dao.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

import '../../../data/vos/snack_vo.dart';

class SnackDaoImpl extends SnackDao{
  SnackDaoImpl._internal();
  static final SnackDaoImpl _singleton = SnackDaoImpl._internal();

  factory SnackDaoImpl() {
    return _singleton;
  }

  @override
  void saveSnackList(List<SnackVO> snackList) async {
    Map<int, SnackVO> movieMap = Map.fromIterable(snackList,
        key: (snack) => snack.id, value: (snack) => snack);
    await getSnackBox().putAll(movieMap);
  }

  Box<SnackVO> getSnackBox(){
    return Hive.box<SnackVO>(BOX_NAMES_SNACK_VO);
  }

  @override
  List<SnackVO> getAllSnacks() {
    return getSnackBox().values.toList();
  }

  @override
  Stream<void> getSnackEventStream(){
    return getSnackBox().watch();
  }

  @override
  Stream<List<SnackVO>> getSnackListStream(){
    return Stream.value(getAllSnacks());
  }
}