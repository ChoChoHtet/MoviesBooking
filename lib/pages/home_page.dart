import 'package:flutter/material.dart';
import 'package:movies_booking/pages/welcome_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/viewItems/movies_view.dart';
import 'package:movies_booking/widgets/circle_avatar_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

import 'movie_detail_page.dart';

class HomePage extends StatelessWidget {
  final List<String> menuTitle = [
    "Promotion Code",
    "Select a language",
    "Term of service",
    "Help",
    "Rate us"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                DrawerHeaderSection(),
                SizedBox(
                  height: MARGIN_XLARGE,
                ),
                DrawerContentSection(menuTitle: menuTitle),
                Spacer(),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    size: 32,
                    color: Colors.white,
                  ),
                  title: NormalTextView("Logout"),
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
              UserProfileView(),
              SizedBox(height: MARGIN_SMALL_2),
              HorizontalMovieView(
                  "Now Showing", () => _navigateToMoviesDetailScreen(context)),
              SizedBox(height: MARGIN_XLARGE),
              HorizontalMovieView(
                  "Coming Soon", () => _navigateToMoviesDetailScreen(context)),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMoviesDetailScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(),
      ),
    );
    print("confirm clicked");
  }
}

class DrawerContentSection extends StatelessWidget {
  const DrawerContentSection({
    Key key,
    @required this.menuTitle,
  }) : super(key: key);

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
  const DrawerHeaderSection({
    Key key,
  }) : super(key: key);

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
              "Lily Johnson",
              textColor: Colors.white,
            ),
            SizedBox(
              height: MARGIN_SMALL,
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width *0.4,
                  child: NormalTextView(
                    "Lily Johnson@gmail.com",
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatarView(
          "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/27/dffa4156-4f80-11e9-8617-6babbcfb60eb_image_hires_141554.JPG?itok=_XQdld_B&v=1553667358",
        ),
        LargeTitleText("Hi LiLy!"),
      ],
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key key,
  }) : super(key: key);

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
  final Function onTapPoster;

  const HorizontalMovieView(this.title, this.onTapPoster);

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
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) =>
                  MoviesView(onTapPoster)),
        ),
      ],
    );
  }
}
