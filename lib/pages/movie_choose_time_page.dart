import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_booking/bloc/choose_time_bloc.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/data/vos/date_vo.dart';
import 'package:movies_booking/data/vos/time_slot_vo.dart';
import 'package:movies_booking/pages/movie_seats_page.dart';
import 'package:movies_booking/resources/colors.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/widgets/back_button_view.dart';
import 'package:movies_booking/widgets/elevated_button_view.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_text.dart';
import 'package:provider/provider.dart';

class MovieChooseTimePage extends StatelessWidget {
  final String movieName;
  final int movieID;
  final String moviePath;
  MovieChooseTimePage(
      {required this.movieID,
      required this.movieName,
      required this.moviePath});

  final CinemaVO available = CinemaVO(1, "Available In", [
    TimeSlotVO(1, "2D", false),
    TimeSlotVO(2, "3D", false),
    TimeSlotVO(3, "IMAX", false),
  ]);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChooseTimeBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: WELCOME_SCREEN_BACKGROUND_COLOR,
          elevation: 0,
          leading: BackButtonView(
            () => Navigator.pop(context),
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Selector<ChooseTimeBloc, List<DateVO>>(
                  selector: (context, bloc) => bloc.dateTime,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (BuildContext context, dateList, Widget? child) {
                    ChooseTimeBloc timeBloc =
                        Provider.of<ChooseTimeBloc>(context, listen: false);
                    return MovieChooseDateView(
                      dateTime: dateList,
                      onTapDate: (date) {
                        // print("Time Slot Selected Date: $date, ${dateList.toString()}");
                        timeBloc.getCinemaTimeSlot(date);
                      },
                    );
                  },
                ),
                Selector<ChooseTimeBloc, List<CinemaVO>?>(
                  selector: (context, bloc) => bloc.cinemaTimeList,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (BuildContext context, cinemaList, Widget? child) {
                    return ChooseItemGridSectionView(
                      cinemaList: cinemaList,
                      available: available,
                      onTapTime: (cinemaVO, index) {
                        ChooseTimeBloc bloc =
                            Provider.of(context, listen: false);
                        bloc.setTimeSlotSelected(cinemaVO, index);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                Builder(
                  builder: (context) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                    child: ElevatedButtonView("Next", () {
                      ChooseTimeBloc bloc =
                          Provider.of<ChooseTimeBloc>(context, listen: false);
                      if (bloc.validateTimeSlot()) {
                        _navigateMovieSeatPage(
                            context,
                            bloc.timeSlotId,
                            bloc.bookingDate,
                            bloc.startTime,
                            bloc.cinemaName,
                            bloc.cinemaId);
                      } else {
                        _showAlertDialog(context);
                      }
                    }),
                  ),
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text("Movie Show Time"),
        content: Text("Please Select Movie Time"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _navigateMovieSeatPage(BuildContext context, int slotId,
      String bookingDate, String startTime, String cinemaName, int cinemaID) {
    print("choose time -> id:$slotId,date:$bookingDate");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieSeatPage(
            movieId: movieID,
            movieName: movieName,
            moviePath: moviePath,
            timeSlotId: slotId,
            bookingDate: bookingDate,
            cinemaName: cinemaName,
            startTime: startTime,
            cinemaId: cinemaID),
      ),
    );
  }
}

class ChooseItemGridSectionView extends StatelessWidget {
  final List<CinemaVO>? cinemaList;
  final Function(CinemaVO? cinemaVO, int index) onTapTime;
  final CinemaVO? available;
  ChooseItemGridSectionView(
      {required this.cinemaList,
      required this.available,
      required this.onTapTime});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(MARGIN_MEDIUM),
        color: Colors.white,
        child: Column(
          children: [
            //ChooseItemGridView(cinemaVO: available),
            Column(
                children: cinemaList
                        ?.map((cinema) => ChooseItemGridView(
                              cinemaVO: cinema,
                              onTapTime: onTapTime,
                            ))
                        .toList() ??
                    [])
          ],
        ));
  }
}

class ChooseItemGridView extends StatelessWidget {
  final CinemaVO? cinemaVO;
  final Function(CinemaVO? cinemaVO, int index) onTapTime;
  ChooseItemGridView({required this.cinemaVO, required this.onTapTime});
  bool _getTimeSlotSelected(CinemaVO? cinema, int index) {
    if (cinema?.isSelected ?? false) {
      return cinema?.timeSlots?[index].isSelected ?? false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(cinemaVO?.cinema ?? ""),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cinemaVO?.timeSlots?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 2.6),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // TimeSlotVO? slot = cinemaVO?.timeSlots?[index];
                  // _setTimeSlotSelected(cinemaVO, slot);
                  onTapTime(cinemaVO, index);
                },
                child: CustomRadioView(
                  startTime: cinemaVO?.timeSlots?[index].startTime ?? "",
                  id: cinemaVO?.timeSlots?[index].timeSlotId ?? 0,
                  isSelected: _getTimeSlotSelected(cinemaVO, index),
                ),
              );
            }),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
      ],
    );
  }
}

class CustomRadioView extends StatelessWidget {
  final int id;
  final String startTime;
  final bool isSelected;
  CustomRadioView(
      {required this.id, required this.startTime, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: MARGIN_SMALL, right: MARGIN_SMALL, top: MARGIN_SMALL),
      decoration: BoxDecoration(
          color: this.isSelected ? DATE_NONE_SELECT_COLOR : null,
          borderRadius: BorderRadius.circular(5),
          border: this.isSelected
              ? null
              : Border.all(color: Colors.grey, width: 1)),
      child: Center(
        child: NormalTextView(
          "$startTime",
          textColor: this.isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}

class MovieChooseDateView extends StatelessWidget {
  final List<DateVO>? dateTime;
  final Function(String) onTapDate;
  const MovieChooseDateView({required this.dateTime, required this.onTapDate});

  @override
  Widget build(BuildContext context) {
    debugPrint("Movie Choose Date Widget build");
    return Container(
      color: WELCOME_SCREEN_BACKGROUND_COLOR,
      height: 100,
      child: ListView.separated(
          padding: EdgeInsets.all(MARGIN_MEDIUM),
          separatorBuilder: (context, index) {
            return SizedBox(
              width: MARGIN_MEDIUM,
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: dateTime?.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onTapDate(dateTime?[index].date ?? "");
              },
              child: DateTimeView(
                dateTime: dateTime?[index] ?? DateVO("", "", "", false),
              ),
            );
          }),
    );
  }
}

class DateTimeView extends StatelessWidget {
  const DateTimeView({
    required this.dateTime,
  });

  final DateVO dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          dateTime.dayName ?? "",
          style: TextStyle(
            fontSize: TEXT_HEADING_1X,
            color: dateTime.isSelected ? Colors.white : DATE_NONE_SELECT_COLOR,
          ),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          dateTime.days ?? "",
          style: TextStyle(
            fontSize: TEXT_HEADING_1X,
            color: dateTime.isSelected ? Colors.white : DATE_NONE_SELECT_COLOR,
          ),
        )
      ],
    );
  }
}
