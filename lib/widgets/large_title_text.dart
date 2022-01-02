import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';

class LargeTitleText extends StatelessWidget {
  final String text;

  const LargeTitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black87,
        fontSize: TEXT_HEADING_3X,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
