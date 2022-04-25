import 'package:flutter/foundation.dart';

import '../data/models/movie_booking_model.dart';
import '../data/models/movie_booking_model_impl.dart';
import '../pages/get_card_response.dart';

class AddCardBloc extends ChangeNotifier {
  MovieBookingModel _model = MovieBookingModelImpl();

  Future<GetCardResponse> createCard(
      String cardNumber, String cardHolder, String expirationDate, String cvc) {
    // print("card Info: $cardNumber,$cardHolder,$expirationDate,$cvc");
    return _model
        .createCard(cardNumber, cardHolder, expirationDate, cvc)
        .then((value) {
      refreshUserCard();
      return Future.value(value);
    });
  }

  void refreshUserCard() {
    _model.getUserProfile();
  }
}
