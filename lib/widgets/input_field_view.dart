import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';

class InputFieldView extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final String keyName;
  final TextInputType inputType;
  final TextEditingController textController;

  const InputFieldView(this.labelText,
      {required this.textController,
      this.obscureText = false,
      this.inputType = TextInputType.text,
      this.keyName = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalTextView(
          labelText,
          textColor: Colors.black26,
        ),
        TextField(
          obscureText: obscureText,
          key: Key(keyName),
          style: TextStyle(fontWeight: FontWeight.w500),
          keyboardType: inputType,
          decoration: InputDecoration(),
          controller: textController,
        ),
      ],
    );
  }
}
