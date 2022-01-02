import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';

class InputFieldView extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType inputType;

  const InputFieldView(this.labelText,
      {this.obscureText = false, this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w400),
        ),
        TextField(
          obscureText: obscureText,
          style: TextStyle(fontWeight: FontWeight.w500),
          keyboardType: inputType,
          decoration: InputDecoration(),
        ),
      ],
    );
  }
}
