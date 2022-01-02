import 'package:flutter/material.dart';
import 'package:movies_booking/pages/home_page.dart';
import 'package:movies_booking/pages/movie_detail_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';

class ElevatedButtonView extends StatelessWidget {
  final String text;
  final Function onPressConfirm;
  ElevatedButtonView(this.text,this.onPressConfirm);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage()));
        },
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
