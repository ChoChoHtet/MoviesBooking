import 'package:flutter/material.dart';
import 'package:movies_booking/pages/payment_page.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/input_field_view.dart';

class AddCardInfoPage extends StatelessWidget {
  var _cardTextController = TextEditingController();
  var _cardHolderTextController = TextEditingController();
  var _expireTextController = TextEditingController();
  var _cvcTextController = TextEditingController();
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
              InputFieldView("Card Number",textController:_cardTextController ,),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              InputFieldView("Card holder",textController: _cardHolderTextController,),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: InputFieldView("Expiration Date",textController: _expireTextController,),
                  ),
                  SizedBox(
                    width: MARGIN_MEDIUM_3,
                  ),
                  Flexible(
                    child: InputFieldView("CVC",textController: _cvcTextController,),
                  ),
                ],
              ),
              SizedBox(
                height: MARGIN_XXLARGE,
              ),
              ElevatedButtonView("Confirm", () {
                Navigator.pop(context,);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
