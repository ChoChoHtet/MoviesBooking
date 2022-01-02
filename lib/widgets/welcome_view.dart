import 'package:flutter/material.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';

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
          WELCOME_TEXT,
          style: TextStyle(
            color: welcomeColor,
            fontWeight: FontWeight.w400,
            fontSize: TEXT_HEADING_2X,
          ),
        ),
        SizedBox(height: MARGIN_SMALL),
        NormalTextView(descriptionText,textColor: descriptionColor,)
      ],
    );
  }
}
