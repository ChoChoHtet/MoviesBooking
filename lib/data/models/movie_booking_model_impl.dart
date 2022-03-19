import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/request/check_out_request.dart';
import 'package:movies_booking/data/vos/checkout_vo.dart';
import 'package:movies_booking/data/vos/cinema_seat_vo.dart';
import 'package:movies_booking/data/vos/cinema_time_hive_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/data/vos/snack_vo.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/network/dataagents/movie_booking_agents.dart';
import 'package:movies_booking/network/dataagents/retrofit_movie_data_agent_impl.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/pages/get_card_response.dart';
import 'package:movies_booking/persistence/daos/cinema_time_slot_dao.dart';
import 'package:movies_booking/persistence/daos/credit_dao.dart';
import 'package:movies_booking/persistence/daos/movie_dao.dart';
import 'package:movies_booking/persistence/daos/payment_dao.dart';
import 'package:movies_booking/persistence/daos/snack_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../persistence/daos/user_dao.dart';
import '../vos/date_vo.dart';

class MovieBookingModelImpl extends MovieBookingModel {
  MovieBookingAgent _dataAgent = RetrofitMovieDataAgentImpl();
  UserDao userDao = UserDao();
  MovieDao movieDao = MovieDao();
  CreditDao creditDao = CreditDao();
  CinemaTimeSlotDao cinemaDao = CinemaTimeSlotDao();
  SnackDao snackDao = SnackDao();
  PaymentDao paymentDao = PaymentDao();

  MovieBookingModelImpl._internal();

  static MovieBookingModelImpl _singleton = MovieBookingModelImpl._internal();

  factory MovieBookingModelImpl() {
    return _singleton;
  }

  @override
  Future<UserVO?> emailRegister(
      String name, String email, String phone, String password) {
    return _dataAgent
        .emailRegister(name, email, phone, password)
        .then((userResponse) async {
      var userVo = userResponse.data;
      if (userVo != null) {
        userVo.token = userResponse.token;
        print("login token: ${userVo.token},res ${userResponse.token}");
        userDao.saveUserInfo(userVo);
      }
      return Future.value(userResponse.data);
    });
  }

  @override
  Future<UserVO?> googleRegister(String name, String email, String phone,
      String password, String googleToken) {
    return _dataAgent
        .googleRegister(name, email, phone, password, googleToken)
        .then((userResponse) async {
      var userVo = userResponse.data;
      if (userVo != null) {
        userVo.token = userResponse.token;
        print("Google Login token: ${userVo.token},res ${userResponse.token}");
        userDao.saveUserInfo(userVo);
      }
      return Future.value(userResponse.data);
    });
  }

  @override
  Future<UserVO?> emailLogin(String email, String password) {
    return _dataAgent.emailLogin(email, password).then((userResponse) async {
      var userVo = userResponse.data;
      //print("email login success: ${userResponse.toString()}");
      if (userResponse.code == 200) {
        if (userVo != null) {
          userVo.token = userResponse.token;
          print("login token: ${userVo.token},res ${userResponse.token}");
          userDao.saveUserInfo(userVo);
        }
        return Future.value(userVo);
      } else {
        return Future.error(userResponse.message ?? "Something went wrong");
      }
    });
  }

  @override
  Future<UserVO> loginGoogle(String accessToken) {
    return _dataAgent.loginGoogle(accessToken).then((userResponse) async {
      var userVo = userResponse.data;
      print("google login success: ${userResponse.toString()}");
      if (userVo != null) {
        userVo.token = userResponse.token;
        print(
            "google login success: ${userVo.token},res ${userResponse.token}");
        userDao.saveUserInfo(userVo);
      }
      if (userResponse.code == 200) {
        return Future.value(userResponse.data);
      } else {
        return Future.error(userResponse.message ?? "Something went wrong");
      }
    });
  }

  @override
  Future<CommonResponse> logout() async {
    var token = userDao.getUserInfo()?.getToken();
    print("token: $token");
    return _dataAgent.logout(token!).then((value) => value).asStream().first;
  }

  // @override
  // Future<UserVO?> getUserInfo() {
  //   return Future.value(userDao.getUserInfo());
  // }

  @override
  void getComingSoonMovie() {
    _dataAgent.getComingSoonMovie().then((comingSoon) async {
      List<MovieVO> movieList = comingSoon?.map((movie) {
            movie.isComingSoon = true;
            return movie;
          }).toList() ??
          [];
      movieDao.saveAllMovies(movieList);
      //return Future.value(comingSoon);
    });
  }

  @override
  void getNowShowingMovie() {
    _dataAgent.getNowShowingMovie().then((nowShowing) async {
      List<MovieVO> movieList = nowShowing?.map((movie) {
            movie.isNowShowing = true;
            return movie;
          }).toList() ??
          [];
      movieDao.saveAllMovies(movieList);
      //return Future.value(nowShowing);
    });
  }

  @override
  void getCinemaTimeSlots(String date) {
    var token = userDao.getUserInfo()?.getToken() ?? "";
   // debugPrint("cinema Token: ${ userDao.getUserInfo().toString()}");
    _dataAgent.getCinemaTimeSlots(date, token).then((timeSlot) async {
      List<CinemaVO> cinemaList = timeSlot?.map((time) {
            time.isSelected = false;
            return time;
          }).toList() ??
          [];
      cinemaDao.saveDateTime(date, CinemaTimeHiveVO(cinemaList));
    });
  }

  @override
  Future<List<CreditVO>?> getMovieCredit(int movieId) {
    return _dataAgent.getMovieCredit(movieId).then((credit) async {
      creditDao.saveAllCast(credit ?? []);
      return Future.value(credit);
    });
  }

  @override
  void getMovieDetail(int movieId) {
    _dataAgent.getMovieDetail(movieId).then((movie) async {
      if (movie != null) {
        movieDao.saveSingleMovie(movie);
      }
      //return Future.value(movie);
    });
  }


  @override
  Future<List<CinemaSeatVO>?> getCinemaSeats(
      int timeSlotId, String bookingDate) {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    return _dataAgent
        .getCinemaSeatPlans(token, timeSlotId, bookingDate)
        .then((seatResponse) {
      List<CinemaSeatVO>? seatList =
          seatResponse?.expand((element) => element).map((seat) {
        seat.isSelected = false;
        return seat;
      }).toList();
     // print("seat plan api response: ${seatList.toString()}");
      return Future.value(seatList);
    });
  }

  @override
  void getPaymentMethod() {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    _dataAgent.getPaymentMethod(token).then((paymentList) {
      List<PaymentVO> payments = paymentList?.map((methods) {
            methods.isSelected = false;
            return methods;
          }).toList() ??
          [];
      paymentDao.savePaymentMethod(payments);
    });
  }

  @override
  void getSnacks() {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    _dataAgent.getSnacks(token).then((snack) {
      snackDao.saveSnackList(snack ?? []);
    });
  }

  @override
  Future<GetCardResponse> createCard(
      String cardNumber, String cardHolder, String expirationDate, String cvc) {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    return _dataAgent.createCard(
        token, cardNumber, cardHolder, expirationDate, cvc);
  }

  @override
  void getUserProfile() {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    _dataAgent.getUserProfile(token).then((user){
     // debugPrint("profile token: ${user.toString()}");
      if(user != null){
        var userVO = user.data ;
        userVO?.token = userDao.getUserInfo()?.token;
        userDao.saveUserInfo(userVO!);
      }
    });
  }
  @override
  void clearUserData() {
    userDao.deleteUser();
  }

  @override
  Future<UserVO?> getUserInfo() {
   return Future.value(userDao.getUserInfo());
  }

  @override
  Future<CheckoutVO?> checkoutTicket(CheckOutRequest checkOutRequest) {
    var token = userDao.getUserInfo()?.getToken() ?? "";
    return _dataAgent.checkoutTicket(token, checkOutRequest);
  }

  // Database

  @override
  Stream<List<MovieVO>?> getComingSoonMovieDB() {
    getComingSoonMovie();
    return movieDao
        .getAllMovieEventStream()
        .startWith(movieDao.getComingSoonMovieStream())
        .map((event) => movieDao.getComingSoonMovies());
  }

  @override
  Stream<List<MovieVO>?> getNowShowingMovieDB() {
    getNowShowingMovie();
    return movieDao
        .getAllMovieEventStream()
        .startWith(movieDao.getNowShowingMovieStream())
       .map((event) => movieDao.getNowShowingMovies());
  }

  Stream<UserVO?> getUserInfoDB() {
    getUserProfile();
    return userDao
        .getUserEventStream()
        .startWith(userDao.getUserStream())
        .map((event) => userDao.getUserInfo());
  }

/*  @override
  Stream<MovieVO?> getMovieDetailDB(int movieId) {
    getMovieDetail(movieId);
    return movieDao
        .getAllMovieEventStream()
        .startWith(movieDao.getMovieDetailStream(movieId))
        .map((event) => movieDao.getMovieDetailStream(movieId));
       */ /* .combineLatest(movieDao.getMovieDetailStream(movieId),
            (event, movie) => movie as MovieVO?)
        .first;*/ /*
  }*/
  @override
  Stream<MovieVO?> getMovieDetailDB(int movieId) {
    getMovieDetail(movieId);
    return movieDao
        .getAllMovieEventStream()
        .startWith(movieDao.getMovieDetailStream(movieId))
        .map((event) => movieDao.getMoviesById(movieId));
  }

  Stream<List<CinemaVO>> getCinemaTimeSlotDB(String date) {
    getCinemaTimeSlots(date);
    return cinemaDao
        .getCinemaEventStream()
        .startWith(cinemaDao.getCinemaStream(date))
        .map((event) => cinemaDao.getCinemaVO(date));

  }

  @override
  Stream<List<SnackVO>> getSnackFromDB() {
    return snackDao
        .getSnackEventStream()
        .startWith(snackDao.getSnackListStream())
        .map((event) => snackDao.getAllSnacks());
  }

  @override
  Stream<List<PaymentVO>?> getPaymentMethodFromDB() {
    getPaymentMethod();
    return paymentDao
        .getPaymentWatchStream()
        .startWith(paymentDao.getPaymentMethodStream())
        .map((event) => paymentDao.getPaymentMethods());
  }

}
