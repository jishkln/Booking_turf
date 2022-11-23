// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:truff_majestic/app/core/services/api_endpoints.dart';
import 'package:truff_majestic/app/core/services/dio_error_exce.dart';
import 'package:truff_majestic/app/core/services/interseptor.dart';
import 'package:truff_majestic/app/screens/home/model/home_model.dart';

class LocationProvider extends ChangeNotifier {
  final dataStorage = const FlutterSecureStorage();
  List<String> dis = [
    'Alappuzha',
    'Ernakulam',
    'Idukki',
    'Kannur',
    'Kasaragod',
    'Kollam',
    'Kottayam',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Pathanamthitta',
    'Thiruvananthapuram',
    'Thrissur',
    'Wayanad'
  ];
  bool isLoading = false;
  String? currentAddress;
  String? currentDistrict;
  Position? currentPosition;

  Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Location service are disabled. Please enable the service")));
      notifyListeners();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      notifyListeners();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location Permition are denied")));
        notifyListeners();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<void> getCurrerntPosition(BuildContext context) async {
    // final hasPermission = await handleLocationPermission(context);
    //  if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      getAddressFromLatLng(currentPosition!, context);

      notifyListeners();
    }).catchError((e) {
      debugPrint(e);

      notifyListeners();
    });
  }

  Future<void> getAddressFromLatLng(
      Position position, BuildContext context) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      currentAddress = ' ${place.subLocality},${place.subAdministrativeArea}';
      currentDistrict = "${place.subAdministrativeArea}";

      log('geolocation:$currentDistrict'.toString());
      // ${place.street}, ${place.postalCode},
      log('Current: ${place.subLocality}, ${place.subAdministrativeArea},'
          .toString());
      locationCurent(context);
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
      notifyListeners();
    });
  }

  locationCurent(BuildContext context) {
    if (currentDistrict == null) {
      getCurrerntPosition(context);
    } else if (currentDistrict != null) {
      for (var i = 0; i < dis.length; i++) {
        if (currentDistrict == dis[i]) {
          // log("message $currentDistrict");
          return currentDistrict;
        }
      }
    }
  }

  //==================NearBy Turff========================

  List<DataList> nearTurfList = [];

  // viewNreabyTurf() async {
  //   isLoading = true;
  //   //notifyListeners();

  //   String? place = currentDistrict;
  //   // log("place ${place.toString()}");
  //   String? token = await dataStorage.read(key: "token");
  //   log(" Geolocation token: ${token.toString()}");

  //   final response =
  //       await NearByServices().getNearTurf(place ?? "", token ?? "");

  //   if (response != null && response.status == true) {
  //     turfList.clear();
  //     turfList.addAll(response.data!);
  //   }
  //   isLoading = false;
  //   notifyListeners();
  // }

  bool turfLoading = false;

  viewNreabyTurf() async {
    turfLoading = true;
    String? place = currentDistrict;

    //String? place = place;
    log("geolocator place:$place");
    nearTurfList.clear();
    place ??= "Malappuram";

    try {
      Dio dio = await InterceptorHelper().getApiClient();
      Response response = await dio.get("${EndPoints.nearByTruf}$place");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        // log(response.data.toString());
        HomeResponse data = HomeResponse.fromJson(response.data);

        nearTurfList.addAll(data.data!);
        turfLoading = false;
        notifyListeners();
      }
    } on DioError catch (e) {
      turfLoading = false;
      notifyListeners();
      final errorMsg = DioException.fromDioError(e).toString();
      Fluttertoast.showToast(msg: errorMsg);
    }
  }
  //==================All Turff============================

  List<DataList> turfList = [];

  allTruff() async {
    turfLoading = true;

    String? id = await dataStorage.read(key: "id");
    log("geolocator place:$id");
    turfList.clear();

    try {
      Dio dio = await InterceptorHelper().getApiClient();
      Response response = await dio.get(EndPoints.viewAll);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        // log(response.data.toString());
        HomeResponse data = HomeResponse.fromJson(response.data);

        turfList.addAll(data.data!);
        turfLoading = false;
        notifyListeners();
      }
    } on DioError catch (e) {
      turfLoading = false;
      notifyListeners();
      final errorMsg = DioException.fromDioError(e).toString();
      Fluttertoast.showToast(msg: errorMsg);
    }
  }
}
