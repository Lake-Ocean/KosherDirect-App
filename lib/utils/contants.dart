// ignore_for_file: constant_identifier_names, avoid_print

/* date: 06.08.21
* name: vennila
* task: forgot_password & login_change_logout(FORGOT,LOGIN_RESET,LOGIN_MOB) */
/*THEME*/
import 'dart:convert';
import 'package:dio/dio.dart' as api;

/*LANUGAE */
// const String SAVE_LANG = 'SAVELANG';

/*FONT */
const String ROBOTO_FONT = 'Roboto';

/*PAGE ROUTER*/
const ROUTE_HOME = '/home';
const ROUTE_FILTER = '/filterScreen';
const ROUTE_Detail = '/detailScreen';
const ROUTE_Detail_Filter = '/detailFilterScreen';
const ROUTE_LINK = '/linkScreen';
const ROUTE_ALERT = '/alertScreen';
const ROUTE_FOOD = '/foodScreen';
const ROUTE_FOOD_FILTER = '/foodFilterScreen';

/* PREF DATA */
const String FIREBASE_TOKEN = 'FIREBASE_TOKEN';
const String AUTH_CODE = 'AUTH_CODE';

String? convertMaptoString(Map<String, dynamic> value) {
  return json.encode(value);
}

Map<String, dynamic>? convertStringtoMap(String value) {
  return jsonDecode(value);
}

api.FormData inputParams(Map<String, dynamic> map) {
  print('PARAMS:- $map');
  return api.FormData.fromMap(map);
}

List<String> myCategory = ['Wine', 'Whiskey', 'Alcoholic Beverages','WINE','WHISKEY','ALCOHOLIC BEVERAGES'];

String formatDuration(Duration duration) {
  String formattedDuration = '';

  if (duration.inDays > 0) {
    formattedDuration += '${duration.inDays} days ago ';
  } else if (duration.inHours > 0) {
    formattedDuration += '${duration.inHours.remainder(24)} hours ago ';
  } else if (duration.inMinutes > 0) {
    formattedDuration += '${duration.inMinutes.remainder(60)} minutes ago';
  } else if (duration.inSeconds > 0) {
    formattedDuration += '${duration.inSeconds.remainder(60)} seconds ago';
  }

  return formattedDuration;
}
