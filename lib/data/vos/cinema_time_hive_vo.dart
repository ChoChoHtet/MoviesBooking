import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';

import '../../persistence/hive_constants.dart';

part 'cinema_time_hive_vo.g.dart';


@HiveType(typeId: HIVE_DATE_TIME,adapterName: "CinemaTimeHiveVOAdapter")
class CinemaTimeHiveVO{

  @HiveField(0)
  List<CinemaVO>? cinemaTime;

  CinemaTimeHiveVO(this.cinemaTime);

  @override
  String toString() {
    return 'CinemaTimeHiveVO{cinemaTime: $cinemaTime}';
  }
}