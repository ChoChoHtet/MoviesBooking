import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movies_booking/network/api_constants.dart';
import 'package:movies_booking/pages/movie_detail_page.dart';
import 'package:movies_booking/resources/dimen.dart';

import '../data/vos/movie_vo.dart';

class MoviesView extends StatelessWidget {
 // final Function(int) onTapPoster;
  final MovieVO? movies;
  const MoviesView({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MOVIES_POSTER_ITEM_WIDTH,
      margin: EdgeInsets.only(right: MARGIN_MEDIUM),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(MARGIN_SMALL),
            child: Image.network(
              "$MOVIE_IMAGE_URL${movies?.posterPath}",
              fit: BoxFit.cover,
              height: MOVIES_IMAGE_HEIGHT,
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Text(
            movies?.title ?? "",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black87,
              fontSize: TEXT_REGULAR,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
              "Mystery/Adventure. 1hr 45m",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
                fontSize: TEXT_SMALL,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }
}
