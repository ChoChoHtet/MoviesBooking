import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';

class NormalTextView extends StatelessWidget {
  final String text;
  final Color textColor;

  const NormalTextView(this.text, {this.textColor = Colors.white70});

  @override
  Widget build(BuildContext context) {
    return Text(
     text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: TEXT_REGULAR,
        //overflow: TextOverflow.ellipsis
      ),
    );
  }
}
