import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/booking/controller/booking_provider.dart';
import 'package:truff_majestic/app/screens/home/model/home_model.dart';
import 'package:truff_majestic/app/screens/shared/coustum_boutten.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/constants/size_constants.dart';
import 'package:truff_majestic/app/utils/initsatate.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key, required this.bookingData});

  final DataList bookingData;

  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<BookingProvider>(context);
    final wid = MediaQuery.of(context).size.width;
    final high = MediaQuery.of(context).size.height;

    return StatefulWrapper(
      onInit: () {
        providers.times;
      },
      child: Scaffold(
        backgroundColor: backGrountColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: white1Color),
          centerTitle: true,
          elevation: 20,
          backgroundColor: black1Color,
          title: Text(
            "Book Now",
            style: TurffTheme.darkTextTheme.headline1,
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  kHight20,
                  Container(
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child:
                        // DatePicker(
                        //   DateTime.now(),
                        //   initialSelectedDate: DateTime.now(),
                        //   selectionColor: Colors.black,
                        //   selectedTextColor: Colors.white,
                        //   onDateChange: (date) {
                        //     // New date selected
                        //     providers.allReadyBooked(bookingData.id);
                        //     providers.checkingDate();
                        //     providers.totalPrice = 0;
                        //     providers.selectDate(date);
                        //   },
                        // ),

                        HorizontalCalendar(
                      date: DateTime.now().add(const Duration(days: 0)),
                      initialDate:
                          DateTime.now().subtract(const Duration(days: 0)),
                      textColor: white1Color,
                      backgroundColor: backGrountColor,
                      selectedColor: black1Color,
                      showMonth: true,
                      onDateSelected: (date) {
                        providers.allReadyBooked(bookingData.id);
                        providers.checkingDate();
                        providers.totalPrice = 0;
                        providers.selectDate(date);
                      },
                    ),
                  ),
                  kHight20,
                  Card(
                    shape: const BeveledRectangleBorder(),
                    color: black1Color,
                    elevation: 20,
                    margin: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        timePlay(
                          "Moring 🌞",
                          "₹ : ${bookingData.turfPrice!.morningPrice!}",
                        ),
                        timePlay(
                          "Afternoon 🌝",
                          "₹ : ${bookingData.turfPrice!.afternoonPrice!}",
                        ),
                        timePlay(
                          "Evning 🌜",
                          "₹ : ${bookingData.turfPrice!.eveningPrice!}",
                        ),
                      ],
                    ),
                  ),
                  kHight20,
                  subTextContainer(
                    bacgroundColor: white1Color,
                    title: Center(
                      child: Text(
                        "Time Slots",
                        style: TurffTheme.lightTextTheme.headline1,
                      ),
                    ),
                  ),
                  kHight20,
                  subTextContainer(
                    bacgroundColor: black1Color,
                    title: Text(
                      "Morning  ₹${bookingData.turfPrice!.morningPrice}",
                      style: TurffTheme.darkTextTheme.headline5,
                    ),
                  ),
                  kHight20,
                  Wrap(
                    children: List.generate(
                      providers.morningTime.length,
                      (index) => GestureDetector(
                        onTap: () {
                          providers.multySelect(
                              key: "Morning",
                              time: providers.morningTime[index],
                              price: bookingData.turfPrice!.morningPrice!);
                        },
                        child: TimesSlots(
                          cash: bookingData.turfPrice!.morningPrice!,
                          index: index,
                          setTime: providers.morningTime,
                          time: providers.morningTime[index],
                          heading: 'Morning',
                        ),
                      ),
                    ),
                  ),
                  kHight20,
                  subTextContainer(
                    bacgroundColor: black1Color,
                    title: Text(
                      "Afternoon",
                      style: TurffTheme.darkTextTheme.headline5,
                    ),
                  ),
                  kHight20,
                  Wrap(
                    children: List.generate(
                      providers.afternoonTime.length,
                      (index) => GestureDetector(
                        onTap: () {
                          providers.multySelect(
                            key: "Afternoon",
                            time: providers.afternoonTime[index],
                            price: bookingData.turfPrice!.afternoonPrice!,
                          );
                        },
                        child: TimesSlots(
                          cash: bookingData.turfPrice!.afternoonPrice!,
                          index: index,
                          setTime: providers.afternoonTime,
                          time: providers.afternoonTime[index],
                          heading: 'Afternoon',
                        ),
                      ),
                    ),
                  ),
                  kHight20,
                  subTextContainer(
                    bacgroundColor: black1Color,
                    title: Text(
                      "Evening",
                      style: TurffTheme.darkTextTheme.headline5,
                    ),
                  ),
                  kHight20,
                  Wrap(
                    children: List.generate(
                      providers.eveningTime.length,
                      (index) => GestureDetector(
                        onTap: () {
                          providers.multySelect(
                            key: "Evening",
                            time: providers.eveningTime[index],
                            price: bookingData.turfPrice!.eveningPrice!,
                          );
                        },
                        child: TimesSlots(
                          cash: bookingData.turfPrice!.eveningPrice!,
                          index: index,
                          setTime: providers.eveningTime,
                          time: providers.eveningTime[index],
                          heading: 'Evening',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Container(
                  width: wid / 3,
                  height: high / 15,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                        )
                      ]),
                  child: Center(
                    child: Text(
                      "₹ ${providers.totalPrice.toString()}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FloatingActionButton.extended(
                  onPressed: (() {
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: SizedBox(
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Are You Sure to payment',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Text(
                                    "₹ ${providers.totalPrice.toString()}",
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // controller.continueBooking(
                                            //     bookingDetails, context);
                                            providers.razorpayOption(
                                              providers.totalPrice,
                                              bookingData,
                                              context,
                                            );
                                          },
                                          child: const Text("Continue"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                  label: const Text(
                    "BOOK NOW",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  extendedPadding:
                      const EdgeInsetsDirectional.only(start: 100, end: 100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container subTextContainer(
      {required Widget title, required Color bacgroundColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: bacgroundColor,
      width: double.infinity,
      child: title,
    );
  }

  Container timePlay(String title, String amount) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 130,
      height: 50,
      decoration: BoxDecoration(
        color: white1Color,
        border: Border.all(color: white1Color),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TurffTheme.lightTextTheme.headline2,
            ),
            Text(
              amount,
              style: TurffTheme.lightTextTheme.headline2,
            )
          ],
        ),
      ),
    );
  }
}

class TimesSlots extends StatelessWidget {
  const TimesSlots({
    Key? key,
    required this.index,
    required this.setTime,
    required this.cash,
    required this.time,
    required this.heading,
  }) : super(key: key);

  final int index;
  final List setTime;
  final int cash;
  final String time;
  final String heading;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: provider.selectedTime.contains(setTime[index])
            ? Colors.yellow
            : provider.isAvailableCheckFunction(
                    item: setTime[index], heading: heading)
                ? provider.result.contains(provider.finalTime)
                    ? Colors.deepOrange.shade200
                    : Colors.cyan
                : Colors.white,
      ),
      child: Center(child: Text(time)),
    );
  }
}
