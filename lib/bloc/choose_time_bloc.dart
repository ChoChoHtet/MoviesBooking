import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../data/models/movie_booking_model.dart';
import '../data/models/movie_booking_model_impl.dart';
import '../data/vos/cinema_vo.dart';
import '../data/vos/date_vo.dart';
import '../data/vos/time_slot_vo.dart';

class ChooseTimeBloc extends ChangeNotifier {
  MovieBookingModel _model = MovieBookingModelImpl();

  List<CinemaVO>? cinemaTimeList;
  int timeSlotId = 0;
  String bookingDate = "";
  String startTime = "";
  String cinemaName = "";
  int cinemaId = 0;
  List<DateVO> dateTime = [];

  ChooseTimeBloc({MovieBookingModel? modelImp}) {
    if(modelImp !=null){
      _model = modelImp;
    }

    getTwoWeekDate().then((dateTime) {
      getCinemaTimeSlot(dateTime.first.date);
    }).catchError((error) {
      debugPrint("Date Time: Error");
    });
  }
  void getCinemaTimeSlot(String date) {
    setDateTimeSelected(dateTime, date);
    _model.getCinemaTimeSlotDB(date).listen((timeSlots) {
      bookingDate = date;
      cinemaTimeList = timeSlots;
      notifyListeners();
    });
  }

  void setDateTimeSelected(List<DateVO> dateTime, String date) {
    List<DateVO> dateList = dateTime.map((element) {
      if (element.date == date) {
        element.isSelected = true;
      } else {
        element.isSelected = false;
      }
      return element;
    }).toList();
    this.dateTime = dateList;
    notifyListeners();
  }

  Future<List<DateVO>> getTwoWeekDate() {
    List<DateVO> dateTimeList =
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].map((numOfDays) {
      return DateTime.now().add(Duration(days: numOfDays));
    }).map((dateTime) {
      return DateVO(
          DateFormat("yyyy-MM-dd").format(dateTime),
          DateFormat("E").format(dateTime),
          DateFormat("dd").format(dateTime),
          DateTime.now() == dateTime ? true : false);
    }).toList();
    dateTime = dateTimeList;
    notifyListeners();
    return Future.value(dateTimeList);
  }

  void setTimeSlotSelected(CinemaVO? cinemaVO, int index) {
    TimeSlotVO? slot = cinemaVO?.timeSlots?[index];
    timeSlotId = slot?.timeSlotId ?? 0;
    startTime = slot?.startTime ?? "";
    cinemaName = cinemaVO?.cinema ?? "";
    cinemaId = cinemaVO?.cinemaId ?? 0;

    cinemaVO?.timeSlots?.forEachIndexed((index1, element) {
      if (element.timeSlotId == slot?.timeSlotId) {
        cinemaVO.timeSlots?[index1].isSelected = true;
      } else {
        cinemaVO.timeSlots?[index1].isSelected = false;
      }
    });
    List<CinemaVO>? cinemaList = cinemaTimeList?.map((element) {
      if (element.cinemaId == cinemaVO?.cinemaId) {
        element.isSelected = true;
      } else {
        element.isSelected = false;
      }
      return element;
    }).toList();
    cinemaTimeList = cinemaList;
    notifyListeners();
  }

  bool validateTimeSlot() {
    List<CinemaVO>? list =
        cinemaTimeList?.where((element) => element.isSelected == true).toList();
    return list != null && list.isNotEmpty;
  }
}
