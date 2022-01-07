import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';

class BackButtonView extends StatelessWidget {
  final Function onTapBack;
  final Color color;

  const BackButtonView(this.onTapBack,{this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapBack,
      child: Icon(
        Icons.arrow_back_ios_outlined,
        color: color,
        size: LEADING_ICON_SIZE,
      ),
    );
  }
}