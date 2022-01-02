import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';

class TitleText extends StatelessWidget {
final String titleText;
const TitleText(this.titleText);
  @override
  Widget build(BuildContext context) {
    return  Text(
      titleText,
      style: TextStyle(
        color: Colors.black87,
        fontSize: TEXT_REGULAR_1X,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
