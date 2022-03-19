import 'package:flutter/foundation.dart';

import '../data/models/movie_booking_model.dart';
import '../data/models/movie_booking_model_impl.dart';
import '../data/request/check_out_request.dart';
import '../data/vos/card_vo.dart';
import '../data/vos/checkout_vo.dart';

class PaymentBloc extends ChangeNotifier{
  MovieBookingModel _model = MovieBookingModelImpl();

  List<CardVO>? _cardList;
  int _selectCardId = 0;

  List<CardVO>? get cardList => _cardList;
  int get selectCardId => _selectCardId;


  PaymentBloc(){
    _model.getUserInfoDB().listen((userResponse) {
      _cardList = userResponse?.cards ;
      _selectCardId =  cardList != null && cardList!.isNotEmpty ? cardList![0].id ?? 0 : 0;
      notifyListeners();
    });
  }
  Future<CheckoutVO?> checkoutTicket(CheckOutRequest checkOutRequest){
    return _model.checkoutTicket(checkOutRequest);
  }
  void setSelectedCard(int index){
    _selectCardId = _cardList?[index].id ?? 0;
    print("Select Card -> index: $index, $selectCardId");
    notifyListeners();
  }
}