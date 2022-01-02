import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/circle_avatar_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/title_text.dart';

class MovieDetailPage extends StatelessWidget {
  final List<String> genreList = ["Mystery", "Adventure"];
  final List<String> castList = [
    "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/27/dffa4156-4f80-11e9-8617-6babbcfb60eb_image_hires_141554.JPG?itok=_XQdld_B&v=1553667358",
    "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/27/dffa4156-4f80-11e9-8617-6babbcfb60eb_image_hires_141554.JPG?itok=_XQdld_B&v=1553667358",
    "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/27/dffa4156-4f80-11e9-8617-6babbcfb60eb_image_hires_141554.JPG?itok=_XQdld_B&v=1553667358",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            height: MOVIES_DETAIL_POSTER_HEIGHT,
            child: MoviesPosterView(),
          ),
          Positioned(
            top: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
              child: BackButtonView((){
                Navigator.pop(context);
              }),
            ),
          ),
          Positioned(
            top: MOVIES_DETAIL_POSTER_HEIGHT / 2 - 50,
            left: MediaQuery
                .of(context)
                .size
                .width / 2.2,
            child: VideoPlayView(),
          ),
          Positioned(
            top: MOVIES_DETAIL_INFO_HEIGHT,
            child: MoviesInfoView(genreList: genreList, castList: castList)
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GetTicketButtonView(),
          ),
        ],
      ),
    );
  }
}

class GetTicketButtonView extends StatelessWidget {
  const GetTicketButtonView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MARGIN_MEDIUM),
      child: ElevatedButtonView("Get your Ticket",()=> print("Clicked get ticket ")),
    );
  }
}

class MoviesInfoView extends StatelessWidget {
  const MoviesInfoView({
    Key key,
    @required this.genreList,
    @required this.castList,
  }) : super(key: key);

  final List<String> genreList;
  final List<String> castList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height / 2,
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.symmetric(
          vertical: MARGIN_MEDIUM, horizontal: MARGIN_MEDIUM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LargeTitleText("Detective Pikachu"),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          MoviesTimeAndRatingView(),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: genreList
                .map((genre) => GeneralChipView(genre))
                .toList(),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TitleText("Plot Summary"),
          SizedBox(
            height: MARGIN_SMALL_2,
          ),
          Expanded(
            child: Text(
              "Ace detective Harry Goodman goes mysteriously missing, prompting his 21-year-old son, Tim, to find out what happened. Aiding in the investigation is Harry's former Pokémon partner, wise-cracking, adorable super-sleuth Detective Pikachu. Finding that they are uniquely equipped to work together, as Tim is the only human who can talk with Pikachu, they join forces to unravel the tangled mystery.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: TEXT_REGULAR,
              ),
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          TitleText("CAST"),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children:
            castList.map((url) => CircleAvatarView(url)).toList(),
          ),
        ],
      ),
    );
  }
}

class VideoPlayView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.play_circle_fill, size: 60, color: Colors.white,);
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;

  const BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTapBack,
      child: Icon(
        Icons.arrow_back_ios_outlined,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

class MoviesPosterView extends StatelessWidget {
  const MoviesPosterView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGFrQd3ez_nmjQhnH7F3vyJUbDogMKNqoU6nCd-7rJ3ZzgprZo",
      fit: BoxFit.cover,
    );
  }
}

class GeneralChipView extends StatelessWidget {
  final String text;

  const GeneralChipView(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          padding: EdgeInsets.all(MARGIN_SMALL_2),
          backgroundColor: Colors.white,
          label: Text(text),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
      ],
    );
  }
}

class MoviesTimeAndRatingView extends StatelessWidget {
  const MoviesTimeAndRatingView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "1h 45m",
          style: TextStyle(
            color: Colors.grey,
            fontSize: TEXT_REGULAR_1X,
          ),
        ),
        SizedBox(
          width: MARGIN_SMALL_2,
        ),
        RatingBar.builder(
          initialRating: 3.5,
          itemSize: 30,
          itemBuilder: (context, _) =>
              Icon(
                Icons.star,
                color: Colors.yellow,
              ),
          onRatingUpdate: (rating) {},
        ),
        SizedBox(
          width: MARGIN_SMALL_2,
        ),
        Text(
          "IMDB 6.6",
          style: TextStyle(
            color: Colors.grey,
            fontSize: TEXT_REGULAR_1X,
          ),
        ),
      ],
    );
  }
}
