import 'package:hive/hive.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

import '../../data/vos/date_vo.dart';

class DateDao{
  DateDao._internal();
  static final DateDao _singleton = DateDao._internal();
  factory DateDao(){
    return _singleton;
  }
  void saveDateTime(List<DateVO> dates) async {
    Map<String,DateVO> movieMap = Map.fromIterable(
        dates,key: (dateTime) =>dateTime.date,value: (date) => date);
    await getDateBox().putAll(movieMap);
  }

  List<DateVO> getDateVO(){
    return getDateBox().values.toList();
  }
  Box<DateVO> getDateBox(){
    return Hive.box<DateVO>(BOX_NAMES_DATE_TIME_VO);
  }
}