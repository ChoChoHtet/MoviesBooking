import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

class TitleAndDescriptionView extends StatelessWidget {
  final String title;
  final String description;
  final Color textColor;

  const TitleAndDescriptionView(this.title, this.description,{this.textColor = Colors.black26});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title,textColor: textColor,
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Expanded(
          child: NormalTextView(
            description,
            textColor: textColor,
          ),
        )
      ],
    );
  }
}