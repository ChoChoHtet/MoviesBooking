import 'package:hive/hive.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

import '../../data/vos/snack_vo.dart';

abstract class SnackDao{

  void saveSnackList(List<SnackVO> snackList);

  List<SnackVO> getAllSnacks();

  Stream<void> getSnackEventStream();

  Stream<List<SnackVO>> getSnackListStream();
}