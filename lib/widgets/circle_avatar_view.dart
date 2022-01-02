import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';

class CircleAvatarView extends StatelessWidget {
  final String url;
  const CircleAvatarView(this.url);
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          height: AVATAR_SIZE,
          width: AVATAR_SIZE,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              url,
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_SMALL_2,
        ),
      ],
    );
  }
}
