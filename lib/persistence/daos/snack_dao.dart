import 'package:hive/hive.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

import '../../data/vos/snack_vo.dart';

class SnackDao{
  SnackDao._internal();
  static final SnackDao _singleton = SnackDao._internal();

  factory SnackDao() {
    return _singleton;
  }

  void saveSnackList(List<SnackVO> snackList) async {
    Map<int, SnackVO> movieMap = Map.fromIterable(snackList,
        key: (snack) => snack.id, value: (snack) => snack);
    await getSnackBox().putAll(movieMap);
  }

  Box<SnackVO> getSnackBox(){
    return Hive.box<SnackVO>(BOX_NAMES_SNACK_VO);
  }

  List<SnackVO> getAllSnacks() {
    return getSnackBox().values.toList();
  }

  Stream<void> getSnackEventStream(){
    return getSnackBox().watch();
  }

  Stream<List<SnackVO>> getSnackListStream(){
    return Stream.value(getAllSnacks());
  }
}