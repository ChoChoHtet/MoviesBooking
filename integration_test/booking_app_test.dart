import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movies_booking/data/vos/card_vo.dart';
import 'package:movies_booking/data/vos/cinema_time_hive_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/genre_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/data/vos/snack_vo.dart';
import 'package:movies_booking/data/vos/time_slot_vo.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/main.dart';
import 'package:movies_booking/pages/add_card_info_page.dart';
import 'package:movies_booking/pages/home_page.dart';
import 'package:movies_booking/pages/item_order_page.dart';
import 'package:movies_booking/pages/movie_choose_time_page.dart';
import 'package:movies_booking/pages/movie_detail_page.dart';
import 'package:movies_booking/pages/movie_seats_page.dart';
import 'package:movies_booking/pages/movie_ticket_page.dart';
import 'package:movies_booking/pages/payment_page.dart';
import 'package:movies_booking/pages/registration_page.dart';
import 'package:movies_booking/pages/welcome_page.dart';
import 'package:movies_booking/persistence/hive_constants.dart';
import 'package:movies_booking/resources/strings.dart';

import 'test_data/test_data.dart';

void main() async{
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(CreditVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(CinemaVOAdapter());
  Hive.registerAdapter(TimeSlotVOAdapter());
  Hive.registerAdapter(CinemaTimeHiveVOAdapter());
  Hive.registerAdapter(SnackVOAdapter());
  Hive.registerAdapter(CardVOAdapter());
  Hive.registerAdapter(PaymentVOAdapter());

  await Hive.openBox<UserVO>(BOX_NAMES_USER_VO);
  await Hive.openBox<MovieVO>(BOX_NAMES_MOVIE_VO);
  await Hive.openBox<CreditVO>(BOX_NAMES_CREDIT_VO);
  await Hive.openBox<GenreVO>(BOX_NAMES_GENRE_VO);
  await Hive.openBox<CinemaVO>(BOX_NAMES_CINEMA_TIME_SLOT_VO);
  await Hive.openBox<TimeSlotVO>(BOX_NAMES_TIME_SLOT_VO);
  await Hive.openBox<CinemaTimeHiveVO>(BOX_NAMES_DATE_TIME_VO);
  await Hive.openBox<SnackVO>(BOX_NAMES_SNACK_VO);
  await Hive.openBox<CardVO>(BOX_NAMES_CARD_VO);
  await Hive.openBox<PaymentVO>(BOX_NAMES_PAYMENT_VO);
  testWidgets("Movie Booking UI Test", (WidgetTester tester) async{
    await tester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 5));
    //Welcome Page
    expect(find.byType(WelcomePage), findsOneWidget);
    expect(find.text(WELCOME_GET_STARTED_BUTTON_TEXT), findsOneWidget);
    await tester.tap(find.text(WELCOME_GET_STARTED_BUTTON_TEXT));
    await tester.pumpAndSettle(Duration(seconds: 5));

    // Login Page
    expect(find.byType(RegistrationPage), findsOneWidget);
    var emailTextField = find.byKey(Key(KEY_LOGIN_EMAIL));
    expect(emailTextField, findsOneWidget);
    await tester.enterText(emailTextField, "michochohtet2017@gmail.com");
    var passwordTextField = find.byKey(Key(KEY_LOGIN_PASSWORD));
    expect(passwordTextField, findsOneWidget);
    await tester.enterText(passwordTextField, "12345678");
    expect(find.byKey(Key(KEY_LOGIN_CONFIRM)), findsOneWidget);
    await tester.tap(find.byKey(Key(KEY_LOGIN_CONFIRM)));
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Home Page
    expect(find.byType(HomePage), findsOneWidget);
    var movieText = find.text(TAP_MOVIE_NAME);
    expect(movieText, findsOneWidget);
    await tester.tap(movieText);
    await tester.pumpAndSettle(Duration(seconds: 5));

    //movie details
    expect(find.byType(MovieDetailPage), findsOneWidget);
    expect(find.text(TAP_MOVIE_NAME), findsOneWidget);
    //expect(find.text(TEST_DATA_RATING), findsOneWidget);
    await tester.tap(find.byKey(Key(KEY_MOVIE_DETAIL_GET_TICKET)));
    await tester.pumpAndSettle(Duration(seconds: 3));

    // movie choose time
    expect(find.byType(MovieChooseTimePage), findsOneWidget);
    expect(find.byKey(Key(KEY_CINEMA_TIME_NEXT_BUTTON)),findsOneWidget);
    await tester.tap(find.byKey(Key(KEY_CINEMA_TIME_NEXT_BUTTON)));
    await tester.pumpAndSettle(Duration(seconds: 3));

    // click dialog okay button
    expect(find.byKey(Key(KEY_CINEMA_TIME_DIALOG_OKAY)), findsOneWidget);
    await tester.tap(find.byKey(Key(KEY_CINEMA_TIME_DIALOG_OKAY)));
    await tester.pumpAndSettle(Duration(seconds: 5));

    // Select Booking Date
    expect(find.text("26"),findsOneWidget);
    await tester.tap(find.text("26"));
    await tester.pumpAndSettle(Duration(seconds: 5));

    //Select Cinema Movie Time
    expect(find.byKey(Key("18")),findsOneWidget);
    await tester.tap(find.byKey(Key("18")));
    await tester.pumpAndSettle(Duration(seconds: 6));
    //Tap Next button
    await tester.tap(find.byKey(Key(KEY_CINEMA_TIME_NEXT_BUTTON)));
    await tester.pumpAndSettle(Duration(seconds: 5));

    //cinema seat
    expect(find.byType(MovieSeatPage), findsOneWidget);

    //select first seat
    expect(find.byKey(Key(TEST_FIRST_SEAT)), findsOneWidget);
    await tester.tap(find.byKey(Key(TEST_FIRST_SEAT)));
    await tester.pump();

    // select second seat
    expect(find.byKey(Key(TEST_SECOND_SEAT)), findsOneWidget);
    await tester.tap(find.byKey(Key(TEST_SECOND_SEAT)));
    await tester.pump();

    expect(find.byKey(Key(KEY_SEAT_PAGE_SCROLL)), findsOneWidget);
    await tester.drag(find.byKey(Key(KEY_SEAT_PAGE_SCROLL)), Offset(0,-100));
    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.byKey(Key(KEY_SEAT_BUY_TICKET)), findsOneWidget);
    await tester.tap(find.byKey(Key(KEY_SEAT_BUY_TICKET)));
    await tester.pumpAndSettle(Duration(seconds: 5));

    // Item Order page
    expect(find.byType(ItemOrderPage), findsOneWidget);
    //Pop corn
    expect(find.byKey(Key("Snack_0")),findsOneWidget);
    await tester.tap(find.byKey(Key("Increase_0")));
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.byKey(Key("Increase_0")));
    await tester.pumpAndSettle(Duration(seconds: 3));

    //Smoothies
    expect(find.byKey(Key("Snack_1")),findsOneWidget);
    await tester.tap(find.byKey(Key("Increase_1")));
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Decrease Pop Corn Count
    expect(find.byKey(Key("Decrease_0")),findsOneWidget);
    await tester.tap(find.byKey(Key("Decrease_0")));
    await tester.pumpAndSettle(Duration(seconds: 3));

  /*  // Scroll order screen
    expect(find.byKey(Key(KEY_ITEM_ORDER_PAGE_SCROLL)), findsOneWidget);
    await tester.drag(find.byKey(Key(KEY_ITEM_ORDER_PAGE_SCROLL)), Offset(0,-100));
    await tester.pumpAndSettle(Duration(seconds: 4));*/
    
    await tester.dragUntilVisible(find.byKey(Key("Payment_Method_1")),
        find.byType(SingleChildScrollView), Offset(0,-300));

    // Choose Payment Method
    //set payment id as Key
    await tester.ensureVisible(find.byKey(Key("Payment_Method_1")));
    expect(find.byKey(Key("Payment_Method_1")),findsOneWidget);
    await tester.tap(find.byKey(Key("Payment_Method_1")));
    await tester.pumpAndSettle(Duration(seconds: 4));

    //Click Pay Button
    expect(find.byKey(Key(KEY_ITEM_ORDER_PAY_BUTTON)),findsOneWidget);
    await tester.tap(find.byKey(Key(KEY_ITEM_ORDER_PAY_BUTTON)));
    await tester.pumpAndSettle(Duration(seconds: 5));

    // Payment Page
    expect(find.byType(PaymentPage), findsOneWidget);
    // Click create new card
    expect(find.text( "Add New Card"),findsOneWidget);
    await tester.tap(find.text("Add New Card"));
    await tester.pumpAndSettle(Duration(seconds: 4));
    
    //TODO Please Change Card Info Data
    // Add Card Info
    expect(find.byType(AddCardInfoPage),findsOneWidget);

    var cardNumber = find.byKey(Key("Card Number"));
    expect(cardNumber, findsOneWidget);
    await tester.enterText(cardNumber, "0010");
   // await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.pump();

    var cardHolder = find.byKey(Key("Card holder"));
    expect(cardHolder, findsOneWidget);
    await tester.enterText(cardHolder, TEST_CARD_HOLDER);
   // await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.pump();

    var expireDate = find.byKey(Key("Expiration Date"));
    expect(expireDate, findsOneWidget);
    await tester.enterText(expireDate, "06/22");
    //await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.pump();

    var cvc = find.byKey(Key("CVC"));
    expect(cvc, findsOneWidget);
    await tester.enterText(cvc, "225");
    await tester.pumpAndSettle(Duration(seconds: 2));

    expect(find.byKey(Key(KEY_CREATE_CARD_CONFIRM_BUTTON)),findsOneWidget);
    await tester.tap(find.byKey(Key(KEY_CREATE_CARD_CONFIRM_BUTTON)));
    await tester.pumpAndSettle(Duration(seconds: 5));
    

    //Select Payment
    expect(find.byType(PaymentPage), findsOneWidget);
    //TODO increase offset whenever create new card one card == 20
    await tester.dragUntilVisible(find.text(TEST_CARD_HOLDER),
        find.byType(CarouselSlider), Offset(-190,0));
    /*final gesture = await tester.startGesture(Offset(0, 0)); //Position of the scrollview
    await gesture.moveBy(Offset(-90, 0)); //How much to scroll by
    await tester.pump();*/
    expect(find.text(TEST_CARD_HOLDER),findsOneWidget);
   
    await tester.tap(find.text("Confirm"));
    await tester.pumpAndSettle(Duration(seconds: 5));

    // Checkout Screen
    expect(find.byType(MovieTicketPage), findsOneWidget);
    expect(find.text("$TEST_FIRST_SEAT,$TEST_SECOND_SEAT"), findsOneWidget);
    expect(find.text("\$11"), findsOneWidget);
    
  });
}