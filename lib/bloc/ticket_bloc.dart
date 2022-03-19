import 'package:flutter/foundation.dart';

import '../data/vos/checkout_vo.dart';

class TicketBloc extends ChangeNotifier{
   CheckoutVO? _checkoutVO;
   String _cinemaName = "";
   String _moviePoster = "";

   CheckoutVO? get checkoutVO => _checkoutVO;
   String get cinemaName => _cinemaName;
   String get moviePoster => _moviePoster;

   TicketBloc(CheckoutVO? checkoutVO,String cinemaName,String moviePoster){
     _checkoutVO = checkoutVO;
     _cinemaName = cinemaName;
     _moviePoster = moviePoster;
   }
}