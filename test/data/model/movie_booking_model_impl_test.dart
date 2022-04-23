import 'package:flutter_test/flutter_test.dart';
import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/models/movie_booking_model_impl.dart';
import 'package:movies_booking/data/request/check_out_request.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/persistence/daos/snack_dao.dart';

import '../../mock_data/mock_data.dart';
import '../../network/movie_data_agent_impl_mock.dart';
import '../../persistence/cinema_time_slot_dao_impl_mock.dart';
import '../../persistence/credit_dao_impl_mock.dart';
import '../../persistence/movie_dao_impl_mock.dart';
import '../../persistence/payment_dao_impl_mock.dart';
import '../../persistence/snack_dao_impl_mock.dart';
import '../../persistence/user_dao_impl_mock.dart';

void main() {
  var bookingModel = MovieBookingModelImpl();
  group("movie booking model impl test", () {
    setUp(() {
      bookingModel.setDaoAndAgentTest(
          MovieDataAgentImplMock(),
          UserDaoImplMock(),
          MovieDaoImplMock(),
          CreditDaoImplMock(),
          CinemaTimeSlotDaoImplMock(),
          SnackDaoImplMock(),
          PaymentDaoImplMock());
    });

    test("user email register and save user to db test", () {
      expect(bookingModel.emailRegister("name", "email", " phone", "password"),
          completion(equals(getMockUser())));
    });

    test("user google register and save user to db test", () {
      expect(
          bookingModel.googleRegister(
              "name", "email", "phone", "password", "googleToken"),
          completion(equals(getMockUser())));
    });

    test("email login Test", () {
      expect(bookingModel.emailLogin("email", "password"),
          completion(equals(getMockUser())));
    });

    test("google login Test", () {
      expect(bookingModel.loginGoogle("accessToken"),
          completion(equals(getMockUser())));
    });

    test("user logout Test", () {
      expect(
          bookingModel.logout(), completion(equals(getMockCommonResponse())));
    });

    test("Get Cinema Seats Test", () {
      expect(bookingModel.getCinemaSeats(1, "23/04/2022"),
          completion(equals(getMockSeats())));
    });
    test("Create Card Test", () {
      expect(
          bookingModel.createCard(
              "cardNumber", "cardHolder", "expirationDate", "cvc"),
          completion(equals(getMockCardResponse())));
    });

    test("Get User Info Test", () {
      expect(bookingModel.getUserInfo(), completion(equals(getMockUser())));
    });

    test("Checkout Tickets Test", () {
      var request = CheckOutRequest(
          1, "seatNumber", "bookingDate", 1, 1, 1, 2, List.empty());
      expect(bookingModel.checkoutTicket(request),
          completion(equals(getMockTicketCheckout())));
    });

    test("Get Movie Credit Test", () {
      expect(
          bookingModel.getMovieCredit(1), completion(equals(getMockCredits())));
    });

    test("Get Movie Coming Soon from DB Test", () {
      expect(
          bookingModel.getComingSoonMovieDB(),
          emits([
            MovieVO(
              id: 1,
              title: "ABC",
              overview: "ABC Overview",
              posterPath: "http://abc",
              voteAverage: 8.0,
              imdbId: "123",
              isComingSoon: true,
              isNowShowing: false,
            )
          ]));
    });

    test("Get Now Showing from DB Test", () {
      expect(
          bookingModel.getNowShowingMovieDB(),
          emits([
            MovieVO(
              id: 2,
              title: "DEF",
              overview: "DEF Overview",
              posterPath: "http://def",
              voteAverage: 8.0,
              imdbId: "12378",
              isComingSoon: false,
              isNowShowing: true,
            )
          ]));
    });
    test("Get User Info from DB Test", () {
      expect(
          bookingModel.getUserInfoDB(),
          emits(getMockUser()));
    });
    test("Get Movie Detail from DB Test", () {
      expect(
          bookingModel.getMovieDetailDB(1),
          emits(getMockMovies().first));
    });
    test("Get Cinema List from DB Test", () {
      expect(
          bookingModel.getCinemaTimeSlotDB("23/3/2022"),
          emits(getMockCinemaTime()));
    });
    test("Get Snack List from DB Test", () {
      expect(
          bookingModel.getSnackFromDB(),
          emits(getMockSnacks()));
    });
    test("Get Payment Method from DB Test", () {
      expect(
          bookingModel.getPaymentMethodFromDB(),
          emits(getMockPaymentMethod()));
    });

  });
}
