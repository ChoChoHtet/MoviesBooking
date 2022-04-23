import 'package:flutter_test/flutter_test.dart';
import 'package:movies_booking/bloc/home_bloc.dart';
import 'package:movies_booking/data/vos/user_vo.dart';

import '../data/model/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  HomeBloc? bloc;
  group("Home Bloc Test", (){
    setUp(() {
      bloc = HomeBloc(model: MovieBookingModelImplMock());
    });

    test("Get User Info Test", () {
      expect(bloc?.user,getMockUser());
    });
    

    test("Get Now Showing Movie Test", (){
      expect(bloc?.nowShowingMovies?.contains(getMockMovies().last),true);
    });

    test("Get Coming Soon Movie Test", (){
      expect(bloc?.comingSoonMovies?.contains(getMockMovies().first),true);
    });


  });
}