import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:truff_majestic/app/screens/home/controller/geolocator.dart';
import 'package:truff_majestic/app/screens/home/model/home_model.dart';

class HomeViewProvider extends ChangeNotifier {
  int _currentIndex = 0;

  final List<String> catogary = <String>[];
  final List<String> imgs = <String>[];
  final List<String> type = <String>[];
  final List<String> amenties = <String>[];
  late List foundTurf = [];

  // final List carogary = [
  //   'turfCricket',
  //   'turfFootball',
  //   'turfBadminton',
  //   'turfYoga',
  // ];
  bool available = true;
  get currentIndexx => _currentIndex;

  set bottomNaviState(int intex) {
    _currentIndex = intex;
    notifyListeners();
  }

  bool isLoading = false;

  onInt(context) {
    isLoading = true;
    // notifyListeners();

    LocationProvider().allTruff();

    isLoading = false;
    // notifyListeners();
  }
  // bool catogary(){

  //if(data.tr)
  // }

  void catogry(DataList data) {
    //   final List  carogary=[ 'turfCricket',
    //  'turfFootball',
    //  'turfBadminton',
    //  'turfYoga',]; else{return "";}
    catogary.clear();
//  notifyListeners();
    if (data.turfCategory!.turfBadminton! == true) {
      catogary.add("Badminton");
    }
    if (data.turfCategory!.turfCricket! == true) {
      catogary.add("Cricket");
    }
    if (data.turfCategory!.turfFootball! == true) {
      catogary.add("Football");
    }
    if (data.turfCategory!.turfYoga! == true) {
      catogary.add("Yoga");
    }

    log(catogary.toString());
  }

  void trufImg(DataList data) {
    imgs.clear();
    imgs.addAll([
      data.turfImages!.turfImages1!,
      data.turfImages!.turfImages2!,
      data.turfImages!.turfImages3!,
    ]);
    // notifyListeners();
  }

  void turfType(DataList data) {
    type.clear();
//  notifyListeners();
    if (data.turfType!.turfSevens! == true) {
      type.add("Sevens");
    }
    if (data.turfType!.turfSixes! == true) {
      type.add("Sixes");
    }
    // notifyListeners();
  }

  void trufAvailabile(DataList data) {
    available = false;
    if (data.turfInfo!.turfIsAvailable! == true) {
      available = true;
      // notifyListeners();
      // return "Available Now";
    } else {
      available = false;

      // return " Not Available";
    }
  }

  void trufAmenties(DataList data) {
    amenties.clear();

    if (data.turfAmenities!.turfCafeteria! == true) {
      amenties.add("Cafeteria");
    }
    if (data.turfAmenities!.turfDressing! == true) {
      amenties.add("Dressing");
    }
    if (data.turfAmenities!.turfGallery! == true) {
      amenties.add("Gallery");
    }
    if (data.turfAmenities!.turfParking! == true) {
      amenties.add("Parking");
    }
    if (data.turfAmenities!.turfWashroom! == true) {
      amenties.add("Washroom");
    }
    if (data.turfAmenities!.turfWater! == true) {
      amenties.add("Water");
    }
    // notifyListeners();
    log(amenties.toString());
  }

//      List<TurfAmenities> bools = data["turf_amenities"]?.values.toList();
//  print(bools);
// final data = {
//   "turf_amenities": {
//     "turf_washroom": true,
//     "turf_water": true,
//     "turf_dressing": false,
//     "turf_parking": true,
//     "turf_gallery": true,
//     "turf_cafeteria": true
//   },
// };
// final values = data.values.toList();
// print(
//     values); //[{turf_washroom: true, turf_water: true, turf_dressing: false, turf_parking: true, turf_gallery: true, turf_cafeteria: true}]
// final bools = data["turf_amenities"]?.values.toList();
// print(bools); //[true, true, false, true, true, true]
  // final value = data["turf_amenities"].value.toList;
  // log(value.toString());

//====================Searching===============

  TextEditingController searchController = TextEditingController();

  bool suffixIcon = false;
  void suffixButton({required bool suffixIcon, required BuildContext context}) {
    if (!suffixIcon) {
      searchList.clear();
      searchController.clear();
      FocusScope.of(context).unfocus();
    }
    this.suffixIcon = suffixIcon;
    notifyListeners();
  }

  List<DataList> searchList = [];
  bool initSearching = false;

  void searchFilter(
      {required BuildContext context, required String query}) async {
    initSearching = true;
    notifyListeners();
    List<DataList> list = context.read<LocationProvider>().turfList;

    if (query.isEmpty) {
      searchList = list;
    } else {
      searchList = list
          .where(
            (element) => element.turfName!.toLowerCase().contains(
                  query.toLowerCase().trim(),
                ),
          )
          .toList();
    }
    log(searchList.length.toString());
  }

  
}
