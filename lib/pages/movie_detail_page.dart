import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_booking/pages/item_order_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/back_button_view.dart';
import 'package:movies_booking/widgets/circle_avatar_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
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
        Positioned.fill(
          child: CustomScrollView(
            slivers: [
              MoviesSliverAppBar(() => Navigator.pop(context)),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    MoviesInfoView(genreList: genreList, castList: castList),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(MARGIN_MEDIUM),
            child: ElevatedButtonView(
              MOVIES_DETAIL_GET_YOUR_TICKET_BUTTON_TEXT,
              () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemOrderPage()));
              },
            ),
          ),
        ),
      ],
    ));
  }
}

class MoviesSliverAppBar extends StatelessWidget {
  final Function onTapBack;
  const MoviesSliverAppBar(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      backgroundColor: WELCOME_SCREEN_BACKGROUND_COLOR,
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: MoviesPosterView(onTapBack),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                )),
          )
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
      child: ElevatedButtonView(MOVIES_DETAIL_GET_YOUR_TICKET_BUTTON_TEXT,
          () => print("Clicked get ticket ")),
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
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            children: genreList.map((genre) => GeneralChipView(genre)).toList(),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          //MoviesPlotView(),
          TitleText(MOVIES_DETAIL_PLOT_SUMMARY),
          SizedBox(
            height: MARGIN_SMALL_2,
          ),
          Text(
            "Return or Fall During the Return, the hostility of the counter-party beats upon the soul of the hero. Freytag lays out two rules for this stage: the number of characters be limited as much as possible, and the number of scenes through which the hero falls should be fewer than in the rising movement.",
            style: TextStyle(
              color: Colors.grey,
              fontSize: TEXT_REGULAR,
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          MoviesCastView(castList: castList)
        ],
      ),
    );
  }
}

class MoviesCastView extends StatelessWidget {
  const MoviesCastView({
    Key key,
    @required this.castList,
  }) : super(key: key);

  final List<String> castList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIES_DETAIL_CAST),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Row(
          children: castList.map((url) => CircleAvatarView(url)).toList(),
        ),
        SizedBox(height: 80,)
      ],
    );
  }
}

class MoviesPlotView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText(MOVIES_DETAIL_PLOT_SUMMARY),
        SizedBox(
          height: MARGIN_SMALL_2,
        ),
        Text(
          "Return or Fall During the Return, the hostility of the counter-party beats upon the soul of the hero. Freytag lays out two rules for this stage: the number of characters be limited as much as possible, and the number of scenes through which the hero falls should be fewer than in the rising movement.",
          style: TextStyle(
            color: Colors.grey,
            fontSize: TEXT_REGULAR,
          ),
        ),
      ],
    );
  }
}

class VideoPlayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.play_circle_fill,
      size: 60,
      color: Colors.white,
    );
  }
}



class MoviesPosterView extends StatelessWidget {
  final Function onTapBack;
  const MoviesPosterView(this.onTapBack);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGFrQd3ez_nmjQhnH7F3vyJUbDogMKNqoU6nCd-7rJ3ZzgprZo",
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: MARGIN_XLARGE,left: MARGIN_MEDIUM),
            child: BackButtonView(() => onTapBack(),color: Colors.white,),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: VideoPlayView(),
        ),
      ],
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
          itemBuilder: (context, _) => Icon(
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
