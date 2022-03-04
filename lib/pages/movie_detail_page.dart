import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/models/movie_booking_model_impl.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/network/api_constants.dart';
import 'package:movies_booking/pages/item_order_page.dart';
import 'package:movies_booking/pages/movie_choose_time_page.dart';
import 'package:movies_booking/pages/movie_seats_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/back_button_view.dart';
import 'package:movies_booking/widgets/circle_avatar_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/large_title_text.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

import '../data/vos/movie_vo.dart';

class MovieDetailPage extends StatefulWidget {
  final int? movieId;
  MovieDetailPage({required this.movieId});
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  // final List<String> genreList = ["Mystery", "Adventure"];

  // final List<String> castList = [
  //   "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/27/dffa4156-4f80-11e9-8617-6babbcfb60eb_image_hires_141554.JPG?itok=_XQdld_B&v=1553667358",
  //   "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/27/dffa4156-4f80-11e9-8617-6babbcfb60eb_image_hires_141554.JPG?itok=_XQdld_B&v=1553667358",
  //   "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/27/dffa4156-4f80-11e9-8617-6babbcfb60eb_image_hires_141554.JPG?itok=_XQdld_B&v=1553667358",
  // ];
  MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  MovieVO? movie;
  List<CreditVO>? castList;
  @override
  void initState() {
    _getMovieDetail();
    _getMovieCredit();
    super.initState();
  }

  void _getMovieCredit() {
    _movieBookingModel.getMovieCredit(widget.movieId ?? 0).then((response) {
      setState(() {
        this.castList = response;
      });
    }).catchError((error) {
      debugPrint("Movie Credit Error :$error");
    });
  }

  void _getMovieDetail() {
    _movieBookingModel.getMovieDetail(widget.movieId ?? 0).then((response) {
      setState(() {
        this.movie = response;
      });
    }).catchError((error) {
      debugPrint("Movie Detail Error :$error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: CustomScrollView(
            slivers: [
              MoviesSliverAppBar(
                posterPath: movie?.posterPath ?? "",
                onTapBack: () => Navigator.pop(context),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    MoviesInfoView(
                      genreList: movie?.getGenreAsString() ?? [],
                      castList: this.castList,
                      movie: this.movie,
                    ),
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
                _navigateToChooseTimePage(context);
              },
            ),
          ),
        ),
      ],
    ));
  }

  void _navigateToChooseTimePage(BuildContext context) {
     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieChooseTimePage(
          movieID: this.movie?.id ?? 0,
          movieName: this.movie?.title ?? "",
          moviePath: this.movie?.posterPath ?? "",
        ),
      ),
    );
  }
}

class MoviesSliverAppBar extends StatelessWidget {
  final VoidCallback onTapBack;
  final String posterPath;

  const MoviesSliverAppBar({required this.onTapBack, required this.posterPath});

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
            background: MoviesPosterView(
              onTapBack: onTapBack,
              posterPath: posterPath,
            ),
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
  const MoviesInfoView(
      {required this.genreList, required this.castList, required this.movie});

  final List<String> genreList;
  final List<CreditVO>? castList;
  final MovieVO? movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          LargeTitleText(movie?.title ?? ""),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          MoviesTimeAndRatingView(
            voteAverage: movie?.voteAverage ?? 0.0,
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Wrap(
            direction: Axis.horizontal,
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
            movie?.overview ?? "",
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
    required this.castList,
  });

  final List<CreditVO>? castList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIES_DETAIL_CAST),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: castList
                    ?.map((cast) => CircleAvatarView(cast.profilePath ?? ""))
                    .toList() ??
                [],
          ),
        ),
        SizedBox(
          height: 80,
        )
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
  final VoidCallback onTapBack;
  final String posterPath;
  const MoviesPosterView({required this.posterPath, required this.onTapBack});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            "$MOVIE_IMAGE_URL$posterPath",
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding:
                const EdgeInsets.only(top: MARGIN_XLARGE, left: MARGIN_MEDIUM),
            child: BackButtonView(
              onTapBack,
              color: Colors.white,
            ),
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
      mainAxisSize: MainAxisSize.min,
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
  final double voteAverage;
  MoviesTimeAndRatingView({required this.voteAverage});
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
          initialRating: voteAverage,
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
          "IMDB $voteAverage",
          style: TextStyle(
            color: Colors.grey,
            fontSize: TEXT_REGULAR_1X,
          ),
        ),
      ],
    );
  }
}
