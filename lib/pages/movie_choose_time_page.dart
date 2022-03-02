import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_booking/data/models/movie_booking_model.dart';
import 'package:movies_booking/data/models/movie_booking_model_impl.dart';
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
import 'package:collection/collection.dart';

class MovieChooseTimePage extends StatefulWidget {
  final List<DateVO> dateTime =
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].map((numOfDays) {
    return DateTime.now().add(Duration(days: numOfDays));
  }).map((dateTime) {
    return DateVO(
        DateFormat("yyyy-MM-dd").format(dateTime),
        DateFormat("E").format(dateTime),
        DateFormat("dd").format(dateTime),
        DateTime.now() == dateTime ? true : false);
  }).toList();

  final CinemaVO available = CinemaVO(
    1,
    "Available In",
    [
      TimeSlotVO(1, "2D"),
      TimeSlotVO(2, "3D"),
      TimeSlotVO(3, "IMAX"),
    ],
  );
  @override
  State<MovieChooseTimePage> createState() => _MovieChooseTimePageState();
}

class _MovieChooseTimePageState extends State<MovieChooseTimePage> {
  MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  List<CinemaVO>? cinemaTimeList;
  int timeSlotId =0;
  String bookingDate = "";
  String startTime = "";

  @override
  void initState() {
    _getCinemaTimeSlots(widget.dateTime.first.date);
    super.initState();
  }

  void _getCinemaTimeSlots(String date) {
    widget.dateTime.forEachIndexed((index, element) {
      if (element.date == date) {
        widget.dateTime[index].isSelected = true;
      } else {
        widget.dateTime[index].isSelected = false;
      }
    });
    _movieBookingModel.getCinemaTimeSlots(date).then((cinemas) {
      print("cinema slot ${cinemas.toString()}");
      setState(() {
        this.bookingDate = date;
        this.cinemaTimeList = cinemas;
      });
    }).catchError((error) {
      debugPrint("Cinema Time Slot Error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              MovieChooseDateView(
                dateTime: widget.dateTime,
                onTapDate: (date) {
                  print("Time Slot Selected Date: $date");
                  _getCinemaTimeSlots(date);
                },
              ),
              ChooseItemGridSectionView(
                cinemaList: this.cinemaTimeList,
                available: widget.available,onTapTime: (timeSlotId,startTime) {
                  setState(() {
                    this.timeSlotId = timeSlotId ;
                    this.startTime = startTime ;
                  });
              },
              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
                child: ElevatedButtonView("Next", () {
                  _navigateMovieSeatPage(context,timeSlotId,bookingDate,startTime);
                }),
              ),
              SizedBox(
                height: MARGIN_LARGE,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateMovieSeatPage(
      BuildContext context, int timeSlotId, String date,String startTime) {
    print("choose time -> id:$timeSlotId,date:$date");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieSeatPage(
          timeSlotId: timeSlotId,
          bookingDate: date,
          startTime: startTime,
        ),
      ),
    );
  }
}

class ChooseItemGridSectionView extends StatelessWidget {
  final List<CinemaVO>? cinemaList;
  final Function(int timeSlotId, String startTime) onTapTime;
  final CinemaVO? available;
  ChooseItemGridSectionView(
      {required this.cinemaList, required this.available,required this.onTapTime});
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
                        ?.map((cinema) => ChooseItemGridView(cinemaVO: cinema,onTapTime: onTapTime,))
                        .toList() ??
                    [])
          ],
        ));
  }
}

class ChooseItemGridView extends StatelessWidget {
  final CinemaVO? cinemaVO;
  final Function(int timeSlotId, String startTime) onTapTime;
  ChooseItemGridView({required this.cinemaVO, required this.onTapTime});
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
                onTap: () => onTapTime(
                  cinemaVO?.timeSlots?[index].timeSlotId ?? 0,
                  cinemaVO?.timeSlots?[index].startTime ?? "",
                ),
                child: Container(
                  margin: EdgeInsets.only(
                      left: MARGIN_SMALL,
                      right: MARGIN_SMALL,
                      top: MARGIN_SMALL),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Center(
                    child: NormalTextView(
                      "${cinemaVO?.timeSlots?[index].startTime ?? ""},${cinemaVO?.timeSlots?[index].timeSlotId ?? ""}",
                      textColor: Colors.grey,
                    ),
                  ),
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

class MovieChooseDateView extends StatelessWidget {
  final List<DateVO>? dateTime;
  final Function(String) onTapDate;
  const MovieChooseDateView({required this.dateTime, required this.onTapDate});

  @override
  Widget build(BuildContext context) {
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
                // dateTime?[index].isSelected = true ;
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
