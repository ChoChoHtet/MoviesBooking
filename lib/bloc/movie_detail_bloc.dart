import 'package:flutter/foundation.dart';

import '../data/models/movie_booking_model.dart';
import '../data/models/movie_booking_model_impl.dart';
import '../data/vos/credit_vo.dart';
import '../data/vos/movie_vo.dart';

class MovieDetailBloc extends ChangeNotifier{
  MovieBookingModel model = MovieBookingModelImpl();

  MovieVO? movie;
  List<CreditVO>? castList;

  MovieDetailBloc(int movieId, {MovieBookingModel? modelImpl}){
    if(modelImpl != null){
      model = modelImpl ;
    }
    //Movie detail
    model.getMovieDetailDB(movieId).listen((movieDetail) {
      movie= movieDetail;
      notifyListeners();
    }).onError((error){});

    // movie credit
    model.getMovieCredit(movieId).then((credits){
      castList = credits;
      notifyListeners();
    });
  }
}