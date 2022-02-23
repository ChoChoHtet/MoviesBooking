import 'package:flutter/material.dart';
import 'package:movies_booking/pages/movie_seats_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/back_button_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

class MovieChooseTimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WELCOME_SCREEN_BACKGROUND_COLOR,
        elevation: 0,
        leading: BackButtonView(
              () => Navigator.pop(context),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              MovieChooseDateView(),
              ChooseItemGridSectionView(),
              SizedBox(height: MARGIN_LARGE,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                child: ElevatedButtonView("Next", () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MovieSeatPage(),),);
                }),
              ),
              SizedBox(height: MARGIN_LARGE,),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseItemGridSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MARGIN_MEDIUM),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChooseItemGridView(),
          ChooseItemGridView(),
          ChooseItemGridView(),
        ],
      ),
    );
  }
}

class ChooseItemGridView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("Available Time"),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 2.6),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                    left: MARGIN_SMALL, right: MARGIN_SMALL, top: MARGIN_SMALL),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Center(
                  child: NormalTextView(
                    "2D",
                    textColor: Colors.grey,
                  ),
                ),
              );
            }),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
      ],
    );
  }
}

class MovieChooseDateView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WELCOME_SCREEN_BACKGROUND_COLOR,
      height: 100,
      child: ListView.separated(
          padding: EdgeInsets.all(MARGIN_MEDIUM),
          separatorBuilder: (context, index) {
            return SizedBox(
              width: MARGIN_MEDIUM,
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: 20,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(
                  "Web",
                  style: TextStyle(
                    fontSize: TEXT_HEADING_1X,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MARGIN_SMALL,
                ),
                Text(
                  "10",
                  style: TextStyle(
                    fontSize: TEXT_HEADING_1X,
                    color: Colors.white,
                  ),
                )
              ],
            );
          }),
    );
  }
}
