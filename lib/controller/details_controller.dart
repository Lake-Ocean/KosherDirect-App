// ignore_for_file: avoid_print, body_might_complete_normally_catch_error

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/models/details_model.dart';
import 'package:ok_kosher/provider/api_provider.dart';
import 'package:ok_kosher/utils/app_text.dart';
import 'package:ok_kosher/utils/contants.dart';
import 'dart:math' show asin, cos, pi, pow, sin, sqrt;

import 'package:ok_kosher/utils/store_data.dart';

class DetailsController extends GetxController {
  RxBool searchListOpen = false.obs;
  RxBool isLoading = false.obs;
  RxBool isNotAv = false.obs;
  RxString totalProducts = "".obs;
  DetailsModel? detailsModelData;

  RxList<String> stateCountryNameList = RxList.empty();
  RxString selectedCounty = "".obs;
  RxList<Restaurant> restaurantList = RxList.empty();
  ScrollController scrollController = ScrollController();

  Position? currentPosition;
  RxDouble? currentLat = 0.0.obs;
  RxDouble? currentLong = 0.0.obs;

  @override
  void onInit() {
    isLoading.value = true;
    update();
    if (currentLat!.value == 0.0 && currentLong!.value == 0.0) {
      getCurrentPosition().whenComplete(() {
        isLoading.value = true;
        save("loadDateTimeRes", DateTime.now().toIso8601String());
        detailsApiCalling().then((value) {});
        update();
      });
    } else {
      isLoading.value = true;
      save("loadDateTimeRes", DateTime.now().toIso8601String());
      detailsApiCalling().then((value) {});
      update();
    }
    super.onInit();
  }

  LocationPermission? permission;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Get.showSnackbar(
      //     const GetSnackBar(title: 'Location services are disabled. Please enable the services'));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Get.showSnackbar(
        //     const GetSnackBar(title: 'Location permissions are denied'));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Get.showSnackbar(
      //     const GetSnackBar(title: 'Location permissions are permanently denied, we cannot request permissions.'));
      return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(currentLat!.value, currentLong!.value)
        .then((List<Placemark> placemarks) {
      // ignore: unused_local_variable
      Placemark place = placemarks[0];
      // _currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
      desiredAccuracy: permission == LocationPermission.always
          ? LocationAccuracy.medium
          : LocationAccuracy.low,
    ).then((Position position) {
      isLoading.value = true;
      print(position);
      currentPosition = position;
      currentLat!.value = position.latitude;
      currentLong!.value = position.longitude;
      update();
      Get.toNamed(ROUTE_Detail);
      update();
      // _getAddressFromLatLng(currentPosition!);
    }).catchError((e) {
      print("sdsadas");
      debugPrint(e);
    });
  }

  double getDistanceFromGPSPointsInRoute(double startLatitude,
      double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
            startLatitude, startLongitude, endLatitude, endLongitude) /
        1609.344; // in meters
  }

  double distance(double lat1, double lon1, double lat2, double lon2) {
    const r = 6372.8; // Earth radius in kilometers

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final lat1Radians = _toRadians(lat1);
    final lat2Radians = _toRadians(lat2);

    final a =
        _haversin(dLat) + cos(lat1Radians) * cos(lat2Radians) * _haversin(dLon);
    final c = 2 * asin(sqrt(a));

    return r * c;
  }

  double _toRadians(double degrees) => degrees * pi / 180;

  num _haversin(double radians) => pow(sin(radians / 2), 2);

  Future<void> detailsApiCalling() async {
    isLoading.value = true;
    restaurantList.clear();
    selectedCounty.value = viewAll;
    try {
      APIProvider().detailsAPI(
          nameParams: "0.8",
          onSuccess: (val) {
            detailsModelData = val;
            for (var element in val.results!.restaurants!) {
              element.distance = getDistanceFromGPSPointsInRoute(
                  currentLat!.value,
                  currentLong!.value,
                  double.parse(element.latitude.toString()),
                  double.parse(element.longitude.toString()));
            }
            update();
            val.results!.restaurants!.sort(
              (a, b) {
                return a.distance!.compareTo(b.distance!);
              },
            );

            totalProducts.value = val.results!.paging!.totalproducts.toString();

            for (var element in val.results!.restaurants!) {
              String stateName = statesVal
                  .where((obj) => obj.value
                      .contains(element.state ?? element.country ?? ""))
                  .toList()
                  .first
                  .name;
              stateCountryNameList.add(stateName);
            }

            stateCountryNameList.value = stateCountryNameList.toSet().toList();

            // ignore: invalid_use_of_protected_member
            for (var obj in stateCountryNameList.value) {
              for (var element in val.results!.restaurants!) {
                if (statesVal
                        .where((element) => element.name.contains(obj))
                        .first
                        .value ==
                    (element.state ?? element.country)) {
                  // ignore: invalid_use_of_protected_member
                  // print(element);
                  // ignore: invalid_use_of_protected_member
                  restaurantList.value.add(element);
                }
              }
            }
            update();
            isLoading.value = false;
          },
          onError: (err) {
            print("Error:&&&&&&&&&&&&&&&&&& ");
            isLoading.value = false;
            isNotAv.value = true;
          });
    } catch (e) {
      print("Error:&&&&&&&&&&&&&&&&&& ");
      isLoading.value = false;
      isNotAv.value = true;
    }
  }

  filterRestaurantList(selectedState) {
    isLoading.value = true;
    // ignore: invalid_use_of_protected_member
    restaurantList.value.clear();
    if (selectedState == viewAll) {
      selectedState = "";
      for (var obj in stateCountryNameList) {
        for (var element in detailsModelData!.results!.restaurants!) {
          if (statesVal
                  .where((element) => element.name.contains(obj))
                  .first
                  .value ==
              (element.state ?? element.country)) {
            // ignore: invalid_use_of_protected_member
            restaurantList.value.add(element);
          }
        }
      }
    } else {
      selectedState = statesVal
          .where((element) => element.name == selectedState)
          .first
          .value;
      restaurantList.value = detailsModelData!.results!.restaurants!
          .where(
              (element) => (element.state ?? element.country) == selectedState)
          .toList();
    }
    isLoading.value = false;
  }

  /// list

  List<StateNameVal> statesVal = [
    StateNameVal(name: 'ALABAMA', value: 'AL'),
    StateNameVal(name: 'ALASKA', value: 'AK'),
    StateNameVal(name: 'AMERICAN SAMOA', value: 'AS'),
    StateNameVal(name: 'ARIZONA', value: 'AZ'),
    StateNameVal(name: 'ARKANSAS', value: 'AR'),
    StateNameVal(name: 'CALIFORNIA', value: 'CA'),
    StateNameVal(name: 'COLORADO', value: 'CO'),
    StateNameVal(name: 'CONNECTICUT', value: 'CT'),
    StateNameVal(name: 'DELAWARE', value: 'DE'),
    StateNameVal(name: 'DISTRICT OF COLUMBIA', value: 'DC'),
    StateNameVal(name: 'FEDERATED STATES OF MICRONESIA', value: 'FM'),
    StateNameVal(name: 'FLORIDA', value: 'FL'),
    StateNameVal(name: 'GEORGIA', value: 'GA'),
    StateNameVal(name: 'GUAM', value: 'GU'),
    StateNameVal(name: 'HAWAII', value: 'HI'),
    StateNameVal(name: 'IDAHO', value: 'ID'),
    StateNameVal(name: 'ILLINOIS', value: 'IL'),
    StateNameVal(name: 'INDIANA', value: 'IN'),
    StateNameVal(name: 'IOWA', value: 'IA'),
    StateNameVal(name: 'KANSAS', value: 'KS'),
    StateNameVal(name: 'KENTUCKY', value: 'KY'),
    StateNameVal(name: 'LOUISIANA', value: 'LA'),
    StateNameVal(name: 'MAINE', value: 'ME'),
    StateNameVal(name: 'MARSHALL ISLANDS', value: 'MH'),
    StateNameVal(name: 'MARYLAND', value: 'MD'),
    StateNameVal(name: 'MASSACHUSETTS', value: 'MA'),
    StateNameVal(name: 'MICHIGAN', value: 'MI'),
    StateNameVal(name: 'MINNESOTA', value: 'MN'),
    StateNameVal(name: 'MISSISSIPPI', value: 'MS'),
    StateNameVal(name: 'MISSOURI', value: 'MO'),
    StateNameVal(name: 'MONTANA', value: 'MT'),
    StateNameVal(name: 'NEBRASKA', value: 'NE'),
    StateNameVal(name: 'NEVADA', value: 'NV'),
    StateNameVal(name: 'NEW HAMPSHIRE', value: 'NH'),
    StateNameVal(name: 'NEW JERSEY', value: 'NJ'),
    StateNameVal(name: 'NEW MEXICO', value: 'NM'),
    StateNameVal(name: 'NEW YORK', value: 'NY'),
    StateNameVal(name: 'NORTH CAROLINA', value: 'NC'),
    StateNameVal(name: 'NORTH DAKOTA', value: 'ND'),
    StateNameVal(name: 'NORTHERN MARIANA ISLANDS', value: 'MP'),
    StateNameVal(name: 'OHIO', value: 'OH'),
    StateNameVal(name: 'OKLAHOMA', value: 'OK'),
    StateNameVal(name: 'OREGON', value: 'OR'),
    StateNameVal(name: 'PALAU', value: 'PW'),
    StateNameVal(name: 'PENNSYLVANIA', value: 'PA'),
    StateNameVal(name: 'PUERTO RICO', value: 'PR'),
    StateNameVal(name: 'RHODE ISLAND', value: 'RI'),
    StateNameVal(name: 'SOUTH CAROLINA', value: 'SC'),
    StateNameVal(name: 'SOUTH DAKOTA', value: 'SD'),
    StateNameVal(name: 'TENNESSEE', value: 'TN'),
    StateNameVal(name: 'TEXAS', value: 'TX'),
    StateNameVal(name: 'UTAH', value: 'UT'),
    StateNameVal(name: 'VERMONT', value: 'VT'),
    StateNameVal(name: 'VIRGIN ISLANDS', value: 'VI'),
    StateNameVal(name: 'VIRGINIA', value: 'VA'),
    StateNameVal(name: 'WASHINGTON', value: 'WA'),
    StateNameVal(name: 'WEST VIRGINIA', value: 'WV'),
    StateNameVal(name: 'WISCONSIN', value: 'WI'),
    StateNameVal(name: 'WYOMING', value: 'WY'),
    StateNameVal(name: 'DOMINICAN REPUBLIC', value: 'DR')
  ];
}

class StateNameVal {
  String name;
  String value;

  StateNameVal({required this.name, required this.value});
}
