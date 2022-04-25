import 'package:flutter/material.dart';
import 'package:movies_booking/bloc/add_card_bloc.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/close_button_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/input_field_view.dart';
import 'package:provider/provider.dart';

class AddCardInfoPage extends StatefulWidget {
  @override
  State<AddCardInfoPage> createState() => _AddCardInfoPageState();
}

class _AddCardInfoPageState extends State<AddCardInfoPage> {
  var _cardNumberTextController = TextEditingController();

  var _cardHolderTextController = TextEditingController();

  var _expireTextController = TextEditingController();

  var _cvcTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddCardBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(MARGIN_MEDIUM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CloseButtonView(() {
                    Navigator.pop(context, false);
                  }),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                InputFieldView(
                  "Card Number",
                  textController: _cardNumberTextController,
                  keyName:"Card Number" ,
                ),
                SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                InputFieldView(
                  "Card holder",
                  textController: _cardHolderTextController,
                  keyName: "Card holder" ,
                ),
                SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: InputFieldView(
                        "Expiration Date",
                        textController: _expireTextController,
                        keyName:"Expiration Date" ,
                      ),
                    ),
                    SizedBox(
                      width: MARGIN_MEDIUM_3,
                    ),
                    Flexible(
                      child: InputFieldView(
                        "CVC",
                        textController: _cvcTextController,
                        keyName: "CVC",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MARGIN_XXLARGE,
                ),
                Builder(builder: (context) {
                  return ElevatedButtonView("Confirm", () {
                    AddCardBloc bloc = Provider.of(context, listen: false);
                    bloc
                        .createCard(
                            _cardNumberTextController.text,
                            _cardHolderTextController.text,
                            _expireTextController.text,
                            _cvcTextController.text)
                        .then((response) {
                      if (response.code == 200) {
                        Navigator.pop(context);
                      }
                    },
                    );
                  },
                    keyName: KEY_CREATE_CARD_CONFIRM_BUTTON,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
