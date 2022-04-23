import 'package:movies_booking/data/vos/cinema_time_hive_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/persistence/daos/cinema_time_slot_dao.dart';

import '../mock_data/mock_data.dart';

class CinemaTimeSlotDaoImplMock extends CinemaTimeSlotDao {
  Map<String, CinemaTimeHiveVO> mockCinemaSlot = {};

  @override
  Stream<void> getCinemaEventStream() {
    return Stream.value(null);
  }

  @override
  Stream<List<CinemaVO>> getCinemaStream(String date) {
    return Stream.value(mockCinemaSlot[date]?.cinemaTime ?? []);
  }

  @override
  List<CinemaVO> getCinemaVO(String date) {
    return mockCinemaSlot[date]?.cinemaTime ?? [];
  }

  @override
  void saveDateTime(String date, CinemaTimeHiveVO cinemaVO) {
    mockCinemaSlot[date] = cinemaVO;
  }
}
