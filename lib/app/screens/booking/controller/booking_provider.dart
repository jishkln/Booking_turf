import 'dart:developer';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:intl/intl.dart';
import 'package:truff_majestic/app/screens/booking/model/booking_model.dart';
import 'package:truff_majestic/app/screens/booking/services/add_booking.dart';
import 'package:truff_majestic/app/screens/booking/services/booking_services.dart';
import 'package:truff_majestic/app/screens/home/model/home_model.dart';
import 'package:truff_majestic/app/screens/home/view/bottumnav.dart';
import 'package:truff_majestic/app/screens/home/view/home.dart';
import 'package:truff_majestic/app/utils/navigation.dart';

class BookingProvider extends ChangeNotifier {
  bool isTime = false;
  bool isSelected = false;
  var formatter = 0;
  var totalPrice = 0;
  DateTime selectedDate = DateTime.now();
  int selectedDay = DateTime.now().day;
  DateTime startDate = DateTime.now().subtract(const Duration(days: 0));
  DateTime endDate = DateTime.now().add(const Duration(days: 30));

  DatePickerController datePickerController = DatePickerController();

  bool morning = false;
  bool afternoon = false;
  bool evening = false;
  bool expiare = false;
  var finalTime = 0;
  late DataList id;
  dynamic context;

  Map<String, List<int>> alReadyBookedList = {};

  List<BookingList> allReadyBook = [];

  List<int> times = [];
  List<BookingList> booking = [];
  List morningTime = [];
  List afternoonTime = [];
  List eveningTime = [];
  List<int> sendToBackend = [];
  List result = [];
  List selectedTime = [];

//================Time Convertion==================
  void timing(DataList data) {
    times.clear();
    times.addAll([
      data.turfTime!.timeMorningStart!,
      data.turfTime!.timeMorningEnd!,
      data.turfTime!.timeAfternoonStart!,
      data.turfTime!.timeAfternoonEnd!,
      data.turfTime!.timeEveningStart!,
      data.turfTime!.timeEveningEnd!
    ]);

    for (int i = 0; i < times.length; i++) {
      if (times[i] > 12) {
        times[i] = times[i] - 12;
      }
    }
  }

  bookingDayTime(int start, int end, List alltimes, String space) {
    alltimes.clear();
    for (int i = start; i < end; i++) {
      alltimes.add("$space${i.toString()}:00 - ${(i + 1).toString()}:00$space");
    }
  }

  void multySelect({
    required String key,
    context,
    required String time,
    required int price,
  }) {
    int timeList;

    if (key == "Morning") {
      timeList = int.parse(time.trim().split(":").first);
    } else {
      timeList = int.parse(time.trim().split(":").first) + 12;
    }
    if (selectedDay == DateTime.now().day) {
      if (selectedTime.contains(time) || result.contains(timeList)) {
        if (timeList > DateTime.now().hour) {
          if (!result.contains(timeList)) {
            totalPrice -= price;
          }
          sendToBackend.remove(timeList);
          selectedTime.remove(time);
        }
      } else {
        if (timeList > DateTime.now().hour) {
          totalPrice += price;
          sendToBackend.add(timeList);
          selectedTime.add(time);
        } else {
          Fluttertoast.showToast(msg: "Time Out");
        }
      }
    } else {
      if (selectedTime.contains(time) || result.contains(timeList)) {
        if (!result.contains(timeList)) {
          totalPrice -= price;
          selectedTime.add(time);
          sendToBackend.add(timeList);
        }
        sendToBackend.remove(timeList);

        selectedTime.remove(time);
      } else {
        totalPrice += price;
        selectedTime.add(time);
        sendToBackend.add(timeList);
      }
    }
    log(time.toString());
    log("Selected time $selectedTime");
    log("send to backend $sendToBackend");
    notifyListeners();
  }

  //================= isAvailable=================
  bool isAvailableCheckFunction({
    required String item,
    required String heading,
  }) {
    var temp = item.trim();
    var splittedtime = temp.split(':').first;
    var parsedTime = int.parse(splittedtime);
    if (heading != 'Morning') {
      finalTime = parsedTime + 12;
    } else {
      finalTime = parsedTime;
    }
    return (DateTime.now().hour >= finalTime &&
            selectedDay == DateTime.now().day) ||
        result.contains(finalTime);
  }

  //==============selecting day===============
  selectDate(data) {
    final date = DateTime.parse(data.toString());
    log("selectDate $date".toString());
    selectedDate = date;
    selectedDay = int.parse(data.toString().split("-").last);
    selectedTime.clear();
    log("selectDate $selectedDay".toString());

    notifyListeners();
  }

  //============== check alredy booked=============

  allReadyBooked(idTurf) async {
    BookingResponse? bookedSlot =
        await BookingServices.instance.getBookingList(id: idTurf);
    alReadyBookedList.clear();
    if (bookedSlot != null) {
      for (var element in bookedSlot.data!) {
        alReadyBookedList[element.bookingDate!] = element.timeSlot!;
      }
      log("============R============${alReadyBookedList.toString()}");
    }
    notifyListeners();
  }

  checkingDate() {
    result.clear();
    final formatter = DateFormat.yMd().format(selectedDate);
    log("full selected slots   $alReadyBookedList");
    if (alReadyBookedList.containsKey(formatter)) {
      alReadyBookedList[formatter];
      result.addAll(alReadyBookedList[formatter]!);
      log("formated date $formatter");
    }
    log("result ${result.toString()}");
  }

//=============Booking Conform================

  continueBooking(DataList data, context) async {
    final bookInDate = DateFormat.yMd().format(selectedDate);
    final turfid = data.id;
    log(sendToBackend.toString());
    log(bookInDate);
    log('send to backend inside continue booking $sendToBackend');
    BookingList turfDetails = BookingList(
      bookingDate: bookInDate.toString(),
      turfId: turfid,
      timeSlot: sendToBackend,
    );
    bool bookInSlot = await BookingServiceAdd.instance.book(turfDetails);
    if (bookInSlot) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Booked"),
        backgroundColor: Color.fromARGB(255, 97, 98, 97),
      ));
      log(",,,,,,,,,,,,,,,,,,,,,,,,,,,$bookInSlot,,,,,,,");
    }
    log(",,,,,,,,,,,,77777777,,,,,,,,,,,,,,,$bookInSlot,,,,,,,");
    //navigation
    NavigationServices.pushRemoveUntil(screen: BottumNavi());
    notifyListeners();
  }

//=====================raZopay==================

  Razorpay razorpay = Razorpay();

  void oninit() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    continueBooking(id, context);
    // Get.offAll(() => BottomNavigation());
    NavigationServices.pushreplace(screen:   BottumNavi());
  }

  _handlePaymentError(PaymentFailureResponse response) {}

  _handleExternalWallet(ExternalWalletResponse response) {}
  @override
  void dispose() {
    super.dispose();

    razorpay.clear();
  }

  razorpayOption(int totalPrice, DataList data, context) {
    id = data;
    context = context;
    var options = {
      'key': 'rzp_test_JoO24Z2D1yYvCF',
      'amount': totalPrice * 100, //in the smallest currency sub-unit.
      'name': 'Jish',
      // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
      'description': 'Turf',
      'timeout': 60, // in seconds
      'prefill': {'contact': '8606586632', 'email': 'amalpkdrv@gmail.com'}
    };
    razorpay.open(options);
  }
}
