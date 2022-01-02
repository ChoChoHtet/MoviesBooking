import 'package:flutter/material.dart';
import 'package:movies_booking/pages/home_page.dart';
import 'package:movies_booking/pages/movie_detail_page.dart';
import 'package:movies_booking/pages/registration_page.dart';
import 'package:movies_booking/pages/welcome_page.dart';
import 'package:movies_booking/resources/colors.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(backgroundColor: WELCOME_SCREEN_BACKGROUND_COLOR),
      home: WelcomePage(),
    );
  }
}



