import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_booking/pages/registration_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/welcome_view.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: WELCOME_SCREEN_BACKGROUND_COLOR,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: MARGIN_LARGE, horizontal: MARGIN_MEDIUM),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: MARGIN_LARGE),
              MovieIllustrationView(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
              WelcomeView(WELCOME_DESCRIPTION_TEXT),
              Spacer(),
             GetStartedButton(),
              SizedBox(height: MARGIN_XXLARGE,)
            ],
          ),
        ),
      ),
    );
  }
}

class MovieIllustrationView extends StatelessWidget {
  //'assets/images/movie_illustration.jpg'
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/movie_illustration.png',
      width: WELCOME_ILLUSTRATION_WIDTH,
      height: WELCOME_ILLUSTRATION_HEIGHT,
    );
  }
}

class GetStartedButton extends StatelessWidget {
  // final Function getStartedButton;
  //
  // const GetStartedButton(this.getStartedButton);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlineButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegistrationPage()));
        },
        padding: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_1),
        borderSide: BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MARGIN_SMALL),
        ),
        child: Text(
          WELCOME_GET_STARTED_BUTTON_TEXT,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_1X,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }
}
