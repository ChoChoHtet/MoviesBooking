import 'package:flutter/foundation.dart';
import 'package:movies_booking/resources/strings.dart';

import '../data/models/movie_booking_model.dart';
import '../data/models/movie_booking_model_impl.dart';
import '../data/request/snack_request.dart';
import '../data/vos/payment_vo.dart';
import '../data/vos/snack_vo.dart';
import 'package:collection/collection.dart';

class ItemOrderBloc extends ChangeNotifier {
  MovieBookingModel _model = MovieBookingModelImpl();

  List<SnackVO>? _snackList;
  List<PaymentVO>? _paymentList;
  int _totalPrice = 0;
  bool _isRefresh = false;

  List<SnackVO>? get snacksList => _snackList;
  List<PaymentVO>? get paymentList => _paymentList;
  int get totalPrice => _totalPrice;
  bool get isRefresh => _isRefresh;

  SnackVO? snackVO;
  List<SnackRequest> snackRequest = [];

  ItemOrderBloc() {
    // Get Snack from DB
    _model.getSnackFromDB().listen((snackResponse) {
      _snackList = snackResponse;
      notifyListeners();
    });

    // Get Payment Methods
    _model.getPaymentMethodFromDB().listen((paymentResponse) {
      _paymentList = paymentResponse;
      notifyListeners();
    });
  }

  void setPaymentSelected(PaymentVO? payment) {
    List<PaymentVO>? payments = _paymentList?.map((element) {
      if (element.id == payment?.id) {
        element.isSelected = true;
      } else {
        element.isSelected = false;
      }
      return element;
    }).toList();
    _paymentList = payments;
    notifyListeners();
  }

  void increaseOrDecreaseQty(String action,int quantity,int index){
    SnackVO? snack = _snackList?[index];
    if(ACTION_INCREASE == action){
      _totalPrice += snack?.price ?? 0 * quantity;
    }else{
      _totalPrice -= snack?.price ?? 0 * quantity;
    }
    _isRefresh = !_isRefresh;
    notifyListeners();
  }
  void addSnackRequest(){
    snackRequest.clear();
    _snackList?.forEach((element) {
      if (element.quantity != null && element.quantity != 0) {
        snackRequest.add(SnackRequest(element.id, element.quantity));
      }
    });
    notifyListeners();
  }
  void incrementQty(int curIndex){
   List<SnackVO>? snacks = _snackList?.mapIndexed((index,element){
      if(curIndex == index){
        int _count = element.quantity ?? 0;
        element.quantity= ++_count;
        _totalPrice += element.price ?? 0 * _count;
        //snackRequest.add(SnackRequest(element.id, element.quantity));
      }
      return element;
    }).toList();
   debugPrint("Snack Count Inc: ${snacks?[curIndex].quantity}");
   _snackList = snacks;
   notifyListeners();
  }
  void decreaseQty(int curIndex){
    List<SnackVO>? snacks = _snackList?.mapIndexed((index,element){
      if(curIndex == index){
        if( element.quantity != null && element.quantity! >= 1){
          int count = element.quantity!;
          element.quantity = --count;
          _totalPrice += element.price ?? 0 * count;
         // snackRequest.remove(SnackRequest(element.id, element.quantity));
        }
      }
      return element;
    }).toList();
    debugPrint("Snack Count Dec:  ${snacks?[curIndex].quantity}");
    _snackList = snacks;
    notifyListeners();
  }
}
