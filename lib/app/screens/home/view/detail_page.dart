import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/booking/controller/booking_provider.dart';
import 'package:truff_majestic/app/screens/booking/view/booking.dart';
import 'package:truff_majestic/app/screens/home/controller/home_view.dart';
import 'package:truff_majestic/app/screens/home/model/home_model.dart';
import 'package:truff_majestic/app/screens/shared/coustum_boutten.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/constants/size_constants.dart';
import 'package:truff_majestic/app/utils/initsatate.dart';
import 'package:truff_majestic/app/utils/navigation.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.data,
  });
  final DataList data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<HomeViewProvider>(context, listen: false);
    final providerBK = Provider.of<BookingProvider>(context);

    return StatefulWrapper(
      onInit: () {
        /// provider.catogry();
        provider.trufImg(data);
        provider.catogry(data);
        provider.trufAvailabile(data);
//============Booking slots================
        providerBK.times;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backGrountColor,
          body: Column(
            children: [
              DetailPageHead(data: data),
              kHight20,
              const Divider(
                thickness: 1,
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: size.height * .02, right: size.height * .02),
                  width: size.width,
                  height: size.height * .5887,
                  // color: Colors.amber,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Center(
                        child: Wrap(children: [
                          AmmenitiesList(
                              value: data.turfType!.turfSevens!, text: "7s"),
                          AmmenitiesList(
                              value: data.turfType!.turfSixes!, text: "6s")
                        ]),
                      ),
                      kHight10,
                      const Divider(
                        thickness: 1,
                      ),
                      kHight10,
                      ListTile(
                        trailing: Text(
                          "Turf  Rating : ${data.turfInfo!.turfRating}",
                          style: TurffTheme.lightTextTheme.headline3,
                        ),
                        leading: textContainer(
                          provider,
                        ),
                      ),
                      kHight10,
                      const Divider(
                        thickness: 1,
                      ),
                      kHight10,
                      Text(
                        "Turf Is confortable for playing ",
                        style: TurffTheme.lightTextTheme.headline3,
                      ),
                      kHight10,
                      Wrap(
                        children: [
                          AmmenitiesList(
                            text: 'Badminton',
                            value: data.turfCategory!.turfBadminton!,
                          ),
                          AmmenitiesList(
                            text: 'Cricket',
                            value: data.turfCategory!.turfCricket!,
                          ),
                          AmmenitiesList(
                            text: 'Football',
                            value: data.turfCategory!.turfFootball!,
                          ),
                          AmmenitiesList(
                            text: 'Yoga',
                            value: data.turfCategory!.turfYoga!,
                          ),
                        ],
                      ),
                      kHight10,
                      const Divider(
                        thickness: 1,
                      ),
                      kHight10,
                      Text(
                        " We provides ",
                        style: TurffTheme.lightTextTheme.headline3,
                      ),
                      kHight10,
                      Wrap(
                        children: [
                          AmmenitiesList(
                            text: 'Cafeteria',
                            value: data.turfAmenities!.turfCafeteria!,
                          ),
                          AmmenitiesList(
                            text: 'Dressing',
                            value: data.turfAmenities!.turfDressing!,
                          ),
                          AmmenitiesList(
                            text: 'Gallery',
                            value: data.turfAmenities!.turfGallery!,
                          ),
                          AmmenitiesList(
                            text: 'Parking',
                            value: data.turfAmenities!.turfParking!,
                          ),
                          AmmenitiesList(
                            text: 'Wash Room',
                            value: data.turfAmenities!.turfWashroom!,
                          ),
                          AmmenitiesList(
                            text: 'Water',
                            value: data.turfAmenities!.turfWater!,
                          ),
                        ],
                      ),
                      kHight10,
                      const Divider(
                        thickness: 1,
                      ),
                      kHight10,
                      SubmitButton(
                          buttonName: Text(
                            "Book",
                            style: TurffTheme.darkTextTheme.headline2,
                          ),
                          onTap: () {
                            NavigationServices.push(
                                screen: BookingPage(
                              bookingData: data,
                            ));

                            providerBK.timing(data);
                            providerBK.bookingDayTime(
                                providerBK.times[0],
                                providerBK.times[1],
                                providerBK.morningTime,
                                '');
                            providerBK.bookingDayTime(
                                providerBK.times[2],
                                providerBK.times[3],
                                providerBK.afternoonTime,
                                ' ');
                            providerBK.bookingDayTime(
                                providerBK.times[4],
                                providerBK.times[5],
                                providerBK.eveningTime,
                                '  ');
                            providerBK.selectedTime.clear();
                            providerBK.allReadyBooked(data.id);
                            providerBK.totalPrice = 0;
                            providerBK.sendToBackend.clear();
                          })
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Container textContainer(HomeViewProvider provider) {
    return Container(
      // padding: EdgeInsets.only(left: 10),
      height: 40,
      width: 250,
      decoration: const BoxDecoration(
        //color: Colors.amber,
        // border: Border.all(color: white1Color),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Wrap(
        children: [
          Text(
            provider.available ? "Available Now" : "Not Available",
            style: TurffTheme.lightTextTheme.headline4,
          ),
          kWidth20,
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: provider.available ? greenColor : redColor,
                borderRadius: BorderRadius.circular(90),
                border: Border.all(color: greyColor),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 75, 73, 73).withAlpha(60),
                    blurRadius: 6.0,
                    spreadRadius: 0.0,
                    offset: const Offset(
                      6.0,
                      3.0,
                    ),
                  ),
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withAlpha(60),
                    blurRadius: 6.0,
                    spreadRadius: 0.0,
                    offset: const Offset(
                      0.0,
                      3.0,
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

class DetailPageHead extends StatelessWidget {
  const DetailPageHead({
    required this.data,
    Key? key,
  }) : super(key: key);
  final DataList data;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<HomeViewProvider>(context);
    return SizedBox(
      width: size.width,
      height: size.height / 3,
      // color: Colors.amber,

      child: Stack(children: [
        Container(
          width: size.width,
          height: size.height * .7,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            color: buttonColor,
          ),
        ),
        //===================trufImagess============

        Positioned(
          top: 10,
          child: SizedBox(
            width: size.width,
            child: CarouselSlider.builder(
                itemCount: provider.imgs.length,
                itemBuilder: (BuildContext context, index, realIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(provider.imgs[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                )),
          ),
        ),
        //==================trufName================

        Positioned(
          bottom: 20,
          left: 20,
          //right: 100,
          child: Text(
            data.turfName.toString(),
            style: TurffTheme.darkTextTheme.headline1,
          ),
        ),

        //===============RatingText================
        Positioned(
          bottom: 80,
          left: 100,
          right: 100,
          child: SizedBox(
            child: Text(
              "Rating : ${data.turfInfo!.turfRating.toString()} ,",
              style: TurffTheme.lightTextTheme.headline3,
            ),
          ),
        ),

        //===============RatingStar================

        Positioned(
          bottom: 80,
          right: 180,
          // left: 0,
          child: RatingBarIndicator(
            rating: data.turfInfo!.turfRating?.toDouble() ?? 0.0,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
        ),
      ]),
    );
  }
}

class AmmenitiesList extends StatelessWidget {
  const AmmenitiesList({super.key, required this.value, required this.text});
  final bool value;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Visibility(
        visible: value,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: value
            //     ?
            color: Colors.greenAccent.withOpacity(0.2),
            // : Colors.grey.withOpacity(0.3),
            border: Border.all(color: Colors.green),
          ),
          height: 30,
          width: 100,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: value ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
