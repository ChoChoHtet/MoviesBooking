import 'package:flutter/material.dart';
import 'package:movies_booking/pages/payment_page.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/input_field_view.dart';

class AddCardInfoPage extends StatelessWidget {
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
              InputFieldView("Card Number"),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              InputFieldView("Card holder"),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: InputFieldView("Expiration Date"),
                  ),
                  SizedBox(
                    width: MARGIN_MEDIUM_3,
                  ),
                  Flexible(
                    child: InputFieldView("CVC"),
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
