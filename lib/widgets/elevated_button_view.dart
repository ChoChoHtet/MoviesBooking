import 'package:flutter/material.dart';
import 'package:movies_booking/pages/home_page.dart';
import 'package:movies_booking/pages/movie_detail_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';

class ElevatedButtonView extends StatelessWidget {
  final String text;
  final VoidCallback onPressConfirm;
  final String keyName;
  ElevatedButtonView(this.text,this.onPressConfirm,{this.keyName = ""});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        key: Key(keyName),
        onPressed: onPressConfirm,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_1),
            ),
            backgroundColor: MaterialStateProperty.all(
              WELCOME_SCREEN_BACKGROUND_COLOR,
            )),
        child: Text(
         text,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_1X,
          ),
        ),
      ),
    );
  }
}
