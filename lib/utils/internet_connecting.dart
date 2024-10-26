// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/controller/alert_controller.dart';

class ConnectivityController {
  ValueNotifier<bool> isConnected = ValueNotifier(false);
  Future<void> init() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    isInternetConnected(result);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print("Connectivity result: $result");
      isInternetConnected(result);
    });
  }

  final alertController = Get.put(AlertController());
  Future<bool> isInternetConnected(ConnectivityResult? result) async {
    if (result == ConnectivityResult.none) {
      isConnected.value = false;
      print(isConnected.value);
      return false;
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      isConnected.value = true;
      print(isConnected.value);
      return true;
    }
    return isConnected.value;
  }
}
