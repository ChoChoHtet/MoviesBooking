import 'package:flutter/foundation.dart';

import '../data/models/movie_booking_model.dart';
import '../data/models/movie_booking_model_impl.dart';
import '../data/vos/cinema_seat_vo.dart';
import 'package:collection/collection.dart';

class MovieSeatBloc extends ChangeNotifier {
  MovieBookingModel _model = MovieBookingModelImpl();

  List<CinemaSeatVO>? _cinemaSeats;
  List<CinemaSeatVO>? get cinemaSeatList => _cinemaSeats;

  int _seatCount = 0;
  int get seatCount => _seatCount;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  String _seatRows = "";
  String get seatRows => _seatRows;

  List<String> _seatRowList = [];
 // List<String> get seatRowList => _seatRowList;

  MovieSeatBloc(int timeSlotId, String bookingDate) {
    _model.getCinemaSeats(timeSlotId, bookingDate).then((seatList) {
      _cinemaSeats = seatList;
      notifyListeners();
    });
  }
  void setSeatSelected(CinemaSeatVO? seatVO, int index) {
    if (seatVO?.isSelected == false && seatVO?.isSeatTypeAvailable() == true) {
      List<CinemaSeatVO>? seatList =_cinemaSeats?.mapIndexed((curIndex, element) {
        if(index == curIndex){
          element.isSelected = true;
        }
        return element;
      }).toList();
      _cinemaSeats = seatList;
      _seatCount++;
      _totalPrice += seatVO?.price ?? 0;
      _seatRowList.add(seatVO?.seatName ?? "");
    } else {
      List<CinemaSeatVO>? seatList =_cinemaSeats?.mapIndexed((curIndex, element) {
        if(index == curIndex){
          element.isSelected = false;
        }
        return element;
      }).toList();
      _cinemaSeats = seatList;
      _seatCount--;
      _totalPrice -= seatVO?.price ?? 0;
      _seatRowList.remove(seatVO?.seatName ?? "");
    }
    _seatRows = _seatRowList.join(",");

    print("select seat: count: $seatCount,price: $totalPrice,row: $seatRows");
   // print("seat list: ${_cinemaSeats.toString()}");
    notifyListeners();
  }
}
