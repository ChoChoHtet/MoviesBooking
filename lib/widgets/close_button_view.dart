import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';

class CloseButtonView extends StatelessWidget {
  final VoidCallback onTapClose;
  const CloseButtonView(this.onTapClose);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapClose,
      child: Icon(
        Icons.close,
        size: LEADING_ICON_SIZE,
        color: Colors.black,
      ),
    );
  }
}
