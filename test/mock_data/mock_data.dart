import 'package:movies_booking/data/vos/card_vo.dart';
import 'package:movies_booking/data/vos/checkout_vo.dart';
import 'package:movies_booking/data/vos/cinema_seat_vo.dart';
import 'package:movies_booking/data/vos/cinema_vo.dart';
import 'package:movies_booking/data/vos/credit_vo.dart';
import 'package:movies_booking/data/vos/movie_vo.dart';
import 'package:movies_booking/data/vos/payment_vo.dart';
import 'package:movies_booking/data/vos/snack_vo.dart';
import 'package:movies_booking/data/vos/time_slot_vo.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/network/response/common_response.dart';
import 'package:movies_booking/network/response/get_user_response.dart';
import 'package:movies_booking/pages/get_card_response.dart';

GetUserResponse getMockUserResponse() =>
    GetUserResponse(200, "create user successfully", getMockUser(), "abcdefg");

UserVO getMockUser() => UserVO(
    id: 1,
    name: "Tester",
    email: "tester@gmail.com",
    phone: "9591234",
    totalExpense: 10,
    token: "abcdefg",
    cards: getMockCardVO());

List<MovieVO> getMockMovies() => [
      MovieVO(
        id: 1,
        title: "ABC",
        overview: "ABC Overview",
        posterPath: "http://abc",
        voteAverage: 8.0,
        imdbId: "123",
        isComingSoon: true,
        isNowShowing: false,
      ),
      MovieVO(
        id: 2,
        title: "DEF",
        overview: "DEF Overview",
        posterPath: "http://def",
        voteAverage: 8.0,
        imdbId: "12378",
        isComingSoon: false,
        isNowShowing: true,
      ),
    ];

List<CreditVO> getMockCredits() => [
      CreditVO(123, "Tom", "http://tom", "23"),
      CreditVO(124, "John Smith", "http://smith", "24"),
    ];

List<SnackVO> getMockSnacks() => [
      SnackVO(
          id: 1,
          name: "Popcorn",
          description: "Hello Popcorn",
          price: 5,
          image: "https://tmba.padc.com.mm/img/snack.jpg",
          quantity: 2),
      SnackVO(
          id: 2,
          name: "Carrots",
          description: "Hello Carrots",
          price: 4,
          image: "https://tmba.padc.com.mm/img/snack.jpg",
          quantity: 1),
      SnackVO(
          id: 3,
          name: "Smoothies",
          description: "Hello Smoothies",
          price: 6,
          image: "https://tmba.padc.com.mm/img/snack.jpg",
          quantity: 2),
    ];

List<PaymentVO> getMockPaymentMethod() => [
      PaymentVO(
          id: 1,
          name: "Credit Card",
          description: "Visa, Master Card, JCB",
          isSelected: true),
      PaymentVO(
          id: 2,
          name: "ATM Card",
          description: "Visa, Master Card, JCB",
          isSelected: false),
      PaymentVO(
          id: 3,
          name: "E-Wallet",
          description: "AyaPay, KbzPay, WavePay",
          isSelected: false),
    ];

List<CardVO> getMockCardVO() => [
      CardVO(
          id: 1,
          cardHolder: "John ",
          cardNumber: "2345",
          expirationDate: "08/24",
          cardType: "JCB"),
      CardVO(
          id: 2,
          cardHolder: "Jessica ",
          cardNumber: "2890",
          expirationDate: "07/24",
          cardType: "JCB"),
    ];

GetCardResponse getMockCardResponse() =>
    GetCardResponse(200, "Success", getMockCardVO());

List<CinemaSeatVO> getMockSeats() => [
      CinemaSeatVO(
          id: 1,
          type: "text",
          seatName: "",
          symbol: "A",
          price: 0,
          isSelected: false),
      CinemaSeatVO(
          id: 2,
          type: "space",
          seatName: "",
          symbol: "A",
          price: 0,
          isSelected: false),
      CinemaSeatVO(
          id: 3,
          type: "available",
          seatName: "A-2",
          symbol: "A",
          price: 2,
          isSelected: false),
      CinemaSeatVO(
          id: 4,
          type: "available",
          seatName: "A-3",
          symbol: "A",
          price: 2,
          isSelected: true),
      CinemaSeatVO(
          id: 5,
          type: "taken",
          seatName: "B-2",
          symbol: "B",
          price: 4,
          isSelected: false)
    ];

List<CinemaSeatVO> getMockAvailableSeats() => [
      CinemaSeatVO(
          id: 1,
          type: "text",
          seatName: "",
          symbol: "A",
          price: 0,
          isSelected: false),
      CinemaSeatVO(
          id: 2,
          type: "space",
          seatName: "",
          symbol: "A",
          price: 0,
          isSelected: false),
      CinemaSeatVO(
          id: 3,
          type: "available",
          seatName: "A-2",
          symbol: "A",
          price: 2,
          isSelected: true),
      CinemaSeatVO(
          id: 4,
          type: "available",
          seatName: "A-3",
          symbol: "A",
          price: 2,
          isSelected: true),
      CinemaSeatVO(
          id: 5,
          type: "taken",
          seatName: "B-2",
          symbol: "B",
          price: 4,
          isSelected: false),
    ];

List<CinemaVO> getMockCinemaTime() => [
      CinemaVO(
        cinemaId: 1,
        cinema: "Cinema A",
        timeSlots: getMockTimeSlot(),
      ),
      CinemaVO(cinemaId: 2, cinema: "Cinema B", timeSlots: getMockTimeSlot())
    ];

List<TimeSlotVO> getMockTimeSlot() => [
      TimeSlotVO(timeSlotId: 11, startTime: "9:30 AM"),
      TimeSlotVO(timeSlotId: 12, startTime: "11:30 AM"),
      TimeSlotVO(timeSlotId: 13, startTime: "3:30 PM"),
    ];

CheckoutVO getMockTicketCheckout() => CheckoutVO(
    id: 1,
    bookingNo: "22",
    bookingDate: "2/3/2022",
    row: "A",
    seat: "A-2,B-2",
    totalSeat: 2,
    total: "22",
    movieId: 1,
    cinemaId: 1,
    username: "Tester",
    timeSlot: getMockTimeSlot().first,
    snacks: getMockSnacks(),
    qrCode: "hello Qr code");

CommonResponse getMockCommonResponse() => CommonResponse(200, "Successful");
