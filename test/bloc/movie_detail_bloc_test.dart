import 'package:flutter_test/flutter_test.dart';
import 'package:movies_booking/bloc/movie_detail_bloc.dart';

import '../data/model/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){
  group("Movie Detail Bloc Test", (){
    MovieDetailBloc? bloc;

    setUp((){
      bloc = MovieDetailBloc(1,modelImpl: MovieBookingModelImplMock());
    });

    test("Get Movie Detail Test", (){
      expect(bloc?.movie, getMockMovies().first);
    });

    test("Get Movie Credit Test", (){
      expect(bloc?.castList?.contains(getMockCredits().last), true);
    });
  });
}