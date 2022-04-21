import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/cinema_time_hive_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';



class CinemaTimeSlotDao{
  CinemaTimeSlotDao._internal();
  static final CinemaTimeSlotDao _singleton = CinemaTimeSlotDao._internal();
  factory CinemaTimeSlotDao(){
    return _singleton;
  }
  void saveDateTime(String date,CinemaTimeHiveVO cinemaVO) async {
    print("dao cinema list size: ${cinemaVO.cinemaTime?.length}");
    await getCinemaBox().put(date,cinemaVO);
  }

  List<CinemaVO> getCinemaVO(String date){
    return getCinemaBox().get(date)?.cinemaTime ?? [];
  }
  Box<CinemaTimeHiveVO> getCinemaBox(){
    return Hive.box<CinemaTimeHiveVO>(BOX_NAMES_DATE_TIME_VO);
  }

  Stream<void> getCinemaEventStream(){
    return getCinemaBox().watch();
  }

  Stream<List<CinemaVO>> getCinemaStream(String date){
    return Stream.value(getCinemaVO(date));
  }
}