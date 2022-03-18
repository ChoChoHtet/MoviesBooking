import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies_booking/bloc/home_bloc.dart';
import 'package:movies_booking/data/models/movie_booking_model_impl.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/pages/registration_page.dart';
import 'package:movies_booking/persistence/hive_constants.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/viewItems/movies_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_text.dart';
import 'package:provider/provider.dart';

import '../data/models/movie_booking_model.dart';
import '../data/vos/movie_vo.dart';
import '../data/vos/user_vo.dart';
import 'movie_detail_page.dart';

class HomePage extends StatelessWidget {
  final List<String> menuTitle = [
    "Promotion Code",
    "Select a language",
    "Term of service",
    "Help",
    "Rate us"
  ];

  void _navigateRegistrationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationPage(),
      ),
    );
  }

  void _showCommonErrorDialog(BuildContext context, String message) {
    showCupertinoDialog(
        context: context,
        builder: (builder) => CupertinoAlertDialog(
              title: Text("Error"),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OKay"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (context) =>
                MenuButtonView(() => Scaffold.of(context).openDrawer()),
          ),
          actions: [
            SearchButtonView(),
          ],
        ),
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Drawer(
            child: Container(
              color: WELCOME_SCREEN_BACKGROUND_COLOR,
              padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
              child: Column(
                children: [
                  SizedBox(
                    height: 96,
                  ),
                  Selector<HomeBloc, UserVO?>(
                    selector: (context, bloc) => bloc.user,
                    builder: (BuildContext context, user, Widget? child) {
                      return DrawerHeaderSection(
                        email: user?.email ?? "",
                        name: user?.name ?? "",
                      );
                    },
                  ),
                  SizedBox(
                    height: MARGIN_XLARGE,
                  ),
                  DrawerContentSection(menuTitle: menuTitle),
                  Spacer(),
                  Selector<HomeBloc, CommonResponse?>(
                    selector: (context, bloc) => bloc.commonResponse,
                    builder: (BuildContext context, value, Widget? child) {
                      return LogoutView(
                        onTapLogout: () {
                          HomeBloc bloc = Provider.of<HomeBloc>(context,listen: false);
                          //Navigator.pop(context);
                         // showAlertDialog(context);
                           bloc.onTapLogout().then((value){
                            _navigateRegistrationPage(context);
                            bloc.clearUserInfo();
                          }).catchError((error){
                            //_showCommonErrorDialog(context, error as String);
                            debugPrint("Logout error: $error");
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: MARGIN_XLARGE,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(MARGIN_MEDIUM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<HomeBloc, UserVO?>(
                  selector: (context, bloc) => bloc.user,
                  builder: (BuildContext context, user, Widget? child) {
                    return UserProfileView(
                      username: user?.name ?? "",
                    );
                  },
                ),
                SizedBox(height: MARGIN_SMALL_2),
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (context, bloc) => bloc.nowShowingMovies,
                  builder:
                      (BuildContext context, nowShowingList, Widget? child) {
                    return HorizontalMovieView(
                      title: "Now Showing",
                      onTapPoster: (id) =>
                          _navigateToMoviesDetailScreen(context, id),
                      movieList: nowShowingList,
                    );
                  },
                ),
                SizedBox(height: MARGIN_XLARGE),
                Selector<HomeBloc, List<MovieVO>?>(
                    selector: (context, bloc) => bloc.comingSoonMovies,
                    builder:
                        (BuildContext context, comingSoonList, Widget? child) {
                      return HorizontalMovieView(
                        title: "Coming Soon",
                        onTapPoster: (id) =>
                            _navigateToMoviesDetailScreen(context, id),
                        movieList: comingSoonList,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text("Movie Booking"),
        content: Text("Are you sure want to logout"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("CANCEL"),
          ),
          TextButton(
            onPressed: () {
              //_logout(context);
              HomeBloc bloc = Provider.of<HomeBloc>(context, listen: false);
              bloc.onTapLogout().then((value) {
                _navigateRegistrationPage(context);
                bloc.clearUserInfo();
              }).catchError((error) {
                //_showCommonErrorDialog(context, error as String);
                debugPrint("Logout error: $error");
              });
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _navigateToMoviesDetailScreen(BuildContext context, int movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(
          movieId: movieId,
        ),
      ),
    );
    print("movies clicked");
  }
}

class LogoutView extends StatelessWidget {
  final VoidCallback onTapLogout;
  LogoutView({required this.onTapLogout});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapLogout,
      child: ListTile(
        leading: Icon(
          Icons.logout,
          size: 32,
          color: Colors.white,
        ),
        title: NormalTextView("Logout"),
      ),
    );
  }
}

class DrawerContentSection extends StatelessWidget {
  const DrawerContentSection({
    required this.menuTitle,
  });

  final List<String> menuTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: menuTitle
          .map(
            (text) => Container(
              margin: EdgeInsets.only(top: MARGIN_MEDIUM),
              child: ListTile(
                leading: Icon(
                  Icons.help,
                  size: 32,
                  color: Colors.white,
                ),
                title: NormalTextView(text),
              ),
            ),
          )
          .toList(),
    );
  }
}

class DrawerHeaderSection extends StatelessWidget {
  final String email;
  final String name;
  DrawerHeaderSection({required this.email, required this.name});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AVATAR_SIZE,
          height: AVATAR_SIZE,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/27/dffa4156-4f80-11e9-8617-6babbcfb60eb_image_hires_141554.JPG?itok=_XQdld_B&v=1553667358",
              ),
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              name,
              textColor: Colors.white,
            ),
            SizedBox(
              height: MARGIN_SMALL,
            ),
            Wrap(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: NormalTextView(
                    email,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                NormalTextView(
                  "Edit",
                  textColor: Colors.white,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class UserProfileView extends StatelessWidget {
  final String username;
  UserProfileView({required this.username});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: AVATAR_SIZE,
          width: AVATAR_SIZE,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/27/dffa4156-4f80-11e9-8617-6babbcfb60eb_image_hires_141554.JPG?itok=_XQdld_B&v=1553667358",
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        LargeTitleText(username),
      ],
    );
  }
}

class SearchButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: MARGIN_MEDIUM),
      child: Icon(
        Icons.search,
        color: Colors.black87,
      ),
    );
  }
}

class MenuButtonView extends StatelessWidget {
  final Function onTapMenu;

  const MenuButtonView(this.onTapMenu);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapMenu(),
      child: Icon(
        Icons.menu,
        color: Colors.black87,
      ),
    );
  }
}

class HorizontalMovieView extends StatelessWidget {
  final String title;
  final Function(int) onTapPoster;
  final List<MovieVO>? movieList;

  const HorizontalMovieView(
      {required this.title,
      required this.onTapPoster,
      required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(title),
        SizedBox(
          height: MARGIN_SMALL_2,
        ),
        Container(
          height: MOVIES_POSTER_ITEM_HEIGHT,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieList?.length ?? 0,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () => onTapPoster(movieList?[index].id ?? 0),
              child: MoviesView(
                movies: movieList?[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
