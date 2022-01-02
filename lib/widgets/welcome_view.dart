import 'package:flutter/material.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';

class WelcomeView extends StatelessWidget {
  final String descriptionText;
  final Color welcomeColor;
  final Color descriptionColor;
  final bool isStartAlign;

  const WelcomeView(this.descriptionText,
      {this.isStartAlign = false,
      this.welcomeColor = Colors.white,
      this.descriptionColor = WELCOME_SCREEN_TEXT_COLOR});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isStartAlign ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          "Welcome!",
          style: TextStyle(
            color: welcomeColor,
            fontWeight: FontWeight.w500,
            fontSize: TEXT_HEADING_1X,
          ),
        ),
        SizedBox(height: MARGIN_SMALL),
        Text(
          descriptionText,
          style: TextStyle(
            color: descriptionColor,
            fontSize: TEXT_REGULAR,
          ),
        ),
      ],
    );
  }
}
