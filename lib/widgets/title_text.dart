import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';

class TitleText extends StatelessWidget {
final String titleText;
final Color textColor;
const TitleText(this.titleText,{this.textColor = Colors.black87});
  @override
  Widget build(BuildContext context) {
    return  Text(
      titleText,
      style: TextStyle(
        color: textColor,
        fontSize: TEXT_REGULAR_1X,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
