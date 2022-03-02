import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/genre_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/pages/welcome_page.dart';
import 'package:movies_booking/persistence/hive_constants.dart';
import 'package:movies_booking/resources/colors.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(CreditVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());

  await Hive.openBox<UserVO>(BOX_NAMES_USER_VO);
  await Hive.openBox<MovieVO>(BOX_NAMES_MOVIE_VO);
  await Hive.openBox<CreditVO>(BOX_NAMES_CREDIT_VO);
  await Hive.openBox<GenreVO>(BOX_NAMES_GENRE_VO);

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
            primary: WELCOME_SCREEN_BACKGROUND_COLOR, secondary: Colors.grey),
      ),
      home: WelcomePage(),
    );
  }
}
