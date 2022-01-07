import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/back_button_view.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

class PaymentPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButtonView((){}),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NormalTextView(PAYMENT_AMOUNT,textColor: Colors.black26,),
            SizedBox(height: MARGIN_SMALL,),
            TitleText("\$ 9426.21"),
            SizedBox(height: MARGIN_MEDIUM,),

          ],
        ),
      ),
    );
  }
}
