import 'package:flutter/material.dart';
import 'package:movies_booking/network/api_constants.dart';
import 'package:movies_booking/resources/dimen.dart';

class CircleAvatarView extends StatelessWidget {
  final String url;
  const CircleAvatarView(this.url);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: AVATAR_SIZE,
          width: AVATAR_SIZE,
          child: CircleAvatar(
            backgroundImage: url.isNotEmpty ? NetworkImage("$MOVIE_IMAGE_URL$url"):
            NetworkImage(AVATAR_IMAGE_URL)
          ),
        ),
        SizedBox(
          width: MARGIN_SMALL_2,
        ),
      ],
    );
  }
}
