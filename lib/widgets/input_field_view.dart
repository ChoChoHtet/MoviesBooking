import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';

class InputFieldView extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType inputType;
  final Function(String) textValue;

  const InputFieldView(this.labelText,
      { required this.textValue,this.obscureText = false, this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalTextView(labelText,textColor: Colors.black26,),
        TextField(
          obscureText: obscureText,
          style: TextStyle(fontWeight: FontWeight.w500),
          keyboardType: inputType,
          decoration: InputDecoration(),
          onChanged: (value) => textValue(value) ,
        ),
      ],
    );
  }
}
