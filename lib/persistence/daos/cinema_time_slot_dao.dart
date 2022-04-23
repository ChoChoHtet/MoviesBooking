import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/cinema_time_hive_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';



abstract class CinemaTimeSlotDao {
  void saveDateTime(String date,CinemaTimeHiveVO cinemaVO) ;

  List<CinemaVO> getCinemaVO(String date);

  Stream<void> getCinemaEventStream();

  Stream<List<CinemaVO>> getCinemaStream(String date);

}