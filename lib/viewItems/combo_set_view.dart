import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_and_description_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

class ComboSetView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: TitleAndDescriptionView(
              "Combo Set M",
              "Combo size  220z Coke (X1) and medium popcorn(X1)",
            ),
          ),
          Spacer(),
          ComboPricerAndNumbersView(),
        ],
      ),
    );
  }
}
class ComboPricerAndNumbersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText("15\$"),
        SizedBox(
          height: 4,
        ),
        NumberPickerView()
      ],
    );
  }
}

class NumberPickerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: MARGIN_SMALL_2, right: MARGIN_CARD_SMALL),
            child: Icon(
              Icons.remove,
              size: 18,
            ),
          ),
          VerticalDivider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
            child: NormalTextView(
              "0",
              textColor: Colors.black26,
            ),
          ),
          VerticalDivider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: MARGIN_CARD_SMALL, right: MARGIN_SMALL_2),
            child: Icon(
              Icons.add,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
