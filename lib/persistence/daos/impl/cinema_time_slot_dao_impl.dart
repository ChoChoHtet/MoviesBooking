import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/cinema_time_hive_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

import '../cinema_time_slot_dao.dart';

class CinemaTimeSlotDaoImpl extends CinemaTimeSlotDao{
  CinemaTimeSlotDaoImpl._internal();

  static final  CinemaTimeSlotDaoImpl _singleton =  CinemaTimeSlotDaoImpl._internal();

  factory  CinemaTimeSlotDaoImpl() {
    return _singleton;
  }

  @override
  void saveDateTime(String date, CinemaTimeHiveVO cinemaVO) async {
    print("dao cinema list size: ${cinemaVO.cinemaTime?.length}");
    await getCinemaBox().put(date, cinemaVO);
  }

  @override
  List<CinemaVO> getCinemaVO(String date) {
    return getCinemaBox().get(date)?.cinemaTime ?? [];
  }

  Box<CinemaTimeHiveVO> getCinemaBox() {
    return Hive.box<CinemaTimeHiveVO>(BOX_NAMES_DATE_TIME_VO);
  }

  @override
  Stream<void> getCinemaEventStream() {
    return getCinemaBox().watch();
  }

  @override
  Stream<List<CinemaVO>> getCinemaStream(String date) {
    return Stream.value(getCinemaVO(date));
  }
}
