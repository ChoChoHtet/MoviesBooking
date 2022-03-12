import 'package:flutter/material.dart';
import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/pages/payment_page.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/close_button_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/input_field_view.dart';

import '../data/models/movie_booking_model_impl.dart';

class AddCardInfoPage extends StatefulWidget {
  @override
  State<AddCardInfoPage> createState() => _AddCardInfoPageState();
}

class _AddCardInfoPageState extends State<AddCardInfoPage> {
  MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  var _cardNumberTextController = TextEditingController();

  var _cardHolderTextController = TextEditingController();

  var _expireTextController = TextEditingController();

  var _cvcTextController = TextEditingController();
  void _createCard(
      String cardNumber, String cardHolder, String expirationDate, String cvc) {
    print("card Info: $cardNumber,$cardHolder,$expirationDate,$cvc");
    _movieBookingModel
        .createCard(cardNumber, cardHolder, expirationDate, cvc)
        .then((response) {
      print("card Success: ${response.code}");
      if (response.code == 200) {
        _movieBookingModel.getUserProfile();
        Navigator.pop(context, true);
      }
    }).catchError((error) {
      debugPrint("Create Card Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MARGIN_MEDIUM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: CloseButtonView(() {
                  Navigator.pop(context, false);
                }),
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              InputFieldView(
                "Card Number",
                textController: _cardNumberTextController,
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              InputFieldView(
                "Card holder",
                textController: _cardHolderTextController,
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: InputFieldView(
                      "Expiration Date",
                      textController: _expireTextController,
                    ),
                  ),
                  SizedBox(
                    width: MARGIN_MEDIUM_3,
                  ),
                  Flexible(
                    child: InputFieldView(
                      "CVC",
                      textController: _cvcTextController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MARGIN_XXLARGE,
              ),
              ElevatedButtonView(
                  "Confirm",
                  () => _createCard(
                      _cardNumberTextController.text,
                      _cardHolderTextController.text,
                      _expireTextController.text,
                      _cvcTextController.text)),
            ],
          ),
        ),
      ),
    );
  }
}
