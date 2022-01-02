import 'package:flutter/material.dart';
import 'package:movies_booking/pages/movie_detail_page.dart';
import 'package:movies_booking/resources/dimen.dart';

class MoviesView extends StatelessWidget {
  final Function onTapPoster;
  const MoviesView(this.onTapPoster);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: MARGIN_MEDIUM),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              print("poster tap");
              //onTapPoster ;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => MovieDetailPage(),
              ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(MARGIN_SMALL),
              child: Image.network(
                "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/27/dffa4156-4f80-11e9-8617-6babbcfb60eb_image_hires_141554.JPG?itok=_XQdld_B&v=1553667358",
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Text(
            "Detective Pikachu",
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
