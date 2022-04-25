import 'package:flutter/foundation.dart';

import '../data/models/movie_booking_model.dart';
import '../data/models/movie_booking_model_impl.dart';
import '../data/vos/movie_vo.dart';
import '../data/vos/user_vo.dart';
import '../network/response/common_response.dart';

class HomeBloc extends ChangeNotifier {
  UserVO? user;
  CommonResponse? commonResponse;
  List<MovieVO>? nowShowingMovies;
  List<MovieVO>? comingSoonMovies;

  MovieBookingModel _model = MovieBookingModelImpl();

  HomeBloc({MovieBookingModel? model}) {
    if(model !=null){
      _model = model ;
    }
    //User Profile
    _model.getUserInfoDB().listen((userProfile) {
      user = userProfile;
      notifyListeners();
    }).onError((error) {});

    // Now showing
    _model.getNowShowingMovieDB().listen((nowShowing) {
      nowShowingMovies = nowShowing;
      notifyListeners();
    }).onError((error) {});

    // Coming Soon
    _model.getComingSoonMovieDB().listen((comingSoon) {
      comingSoonMovies = comingSoon;
    }).onError((error) {});

    _model.getSnacks();
  }

  Future<CommonResponse?> onTapLogout() {
     return _model.logout().then((value) {
       clearUserInfo();
       return Future.value(value);
     });
  }

  void clearUserInfo() {
    _model.clearUserData();
  }
}
