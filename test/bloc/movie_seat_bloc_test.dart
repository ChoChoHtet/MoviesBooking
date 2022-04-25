import 'package:flutter_test/flutter_test.dart';
import 'package:movies_booking/bloc/movie_seat_bloc.dart';
import 'package:movies_booking/data/vos/cinema_seat_vo.dart';

import '../data/model/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Movie Seat Bloc Test", () {
    MovieSeatBloc? bloc;

    setUp(() {
      bloc = MovieSeatBloc(11, "23-04-2022",
          modelImpl: MovieBookingModelImplMock());
    });

    test("Get Seats Test", () {
      expect(bloc?.cinemaSeatList?.contains(getMockSeats().first), true);
    });

    test("Select Available Seat Test", () {
      // first time
      var seat = CinemaSeatVO(
          id: 3,
          type: "available",
          seatName: "A-2",
          symbol: "A",
          price: 2,
          isSelected: false);
      bloc?.setSeatSelected(seat, 2);
      expect(bloc?.cinemaSeatList?.contains(getMockAvailableSeats()[2]), true);
      // second time
      var seat2 = CinemaSeatVO(
          id: 3,
          type: "available",
          seatName: "A-3",
          symbol: "A",
          price: 2,
          isSelected: false);
      bloc?.setSeatSelected(seat2, 3);
      expect(bloc?.cinemaSeatList?.contains(getMockAvailableSeats()[3]), true);

     /* // taken seat
      // second time
      var seat3 =  CinemaSeatVO(
          id: 5,
          type: "taken",
          seatName: "B-2",
          symbol: "B",
          price: 4,
          isSelected: false);
      bloc?.setSeatSelected(seat3, 3);
      expect(bloc?.cinemaSeatList?.contains(getMockSeats().last), true);*/

      expect(bloc?.totalPrice, 4);
      expect(bloc?.seatRows, "A-2,A-3");
    });
  });
}
