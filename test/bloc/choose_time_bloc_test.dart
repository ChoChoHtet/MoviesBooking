import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_booking/bloc/choose_time_bloc.dart';

import '../data/model/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){
  group("Choose Time Bloc Test", (){
    ChooseTimeBloc? bloc ;
    setUp((){
      bloc = ChooseTimeBloc(modelImp: MovieBookingModelImplMock());
      debugPrint("${bloc?.cinemaTimeList.toString()}");
    });

    test("Get Cinema Movie Time",(){
      expect(bloc?.cinemaTimeList, getMockCinemaTime());
    });

    test("Select Time Slot",(){
      bloc?.getCinemaTimeSlot("22-04-2022");
      expect(bloc?.cinemaTimeList, getMockCinemaTime());
    });
  });
}