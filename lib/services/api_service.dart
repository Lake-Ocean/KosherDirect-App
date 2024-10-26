// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:dio/dio.dart';

class ApiRequest {
  final String url;
  final Map<String, dynamic>? params;
  var formdataParams;

  ApiRequest({required this.url, this.params, this.formdataParams});

  Dio _dio() {
    // Put your authorization token here
    return Dio(BaseOptions(
      headers: {
        'Accept': 'application/json',
        "Content-Type": "multipart/form-data",
        //"Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGVtby5ncmVlbnBlbi5pblwvYXBpXC92MVwvbG9naW4iLCJpYXQiOjE2NDk2NzE0MjQsImV4cCI6MTY4MTIwNzQyNCwibmJmIjoxNjQ5NjcxNDI0LCJqdGkiOiIxVE91RkpaMTZSV092MTNIIiwic3ViIjoxOTEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.VwUfRomG97vcMVeilaiOnx16fQhBqRV8TLC8GgxYUE0",
        // "Authorization":
        //     "Bearer ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}"
      },
      responseType: ResponseType.json,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    ));
  }

  Future<void> get({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    print('GET METHOD DATA  URLS :- $url \n PARAMS :- $params');
    await _dio().get(url, queryParameters: params).then((res) {
      print("Response : ${res.statusCode}");
      print("Response : ${res.statusMessage}");
      // print("Response : ${res.data.toString()}");
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      print("Response Error : $error");
      if (onError != null) onError(_handleError(error));
    });
  }

  Future<void> postWithData({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    print(' POST METHOD  DATA  URLS :- $url \n PARAMS :- $params');
    // print("Authorization : ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}");
    await _dio().post(url, data: formdataParams).then((res) {
      print("Response : ${res.statusCode}");
      print("Response : ${res.statusMessage}");
      print("Response : ${res.data.toString()}");
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      print('ERROR VALUE $error');
      if (onError != null) onError(_handleError(error));
    });
  }

  Future<void> postWithQuery({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    print(' POST METHOD  DATA  URLS :- $url \n PARAMS :- $params');
    //print("Authorization : ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}");
    await _dio().post(url, queryParameters: params).then((res) {
      print('Log...${res.statusCode}');
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      print('ERROR VALUE :- $error');
      if (onError != null) onError(_handleError(error));
    });
  }

  Future<void> postWithFile({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    print(
        ' POST METHOD WITH FILE  DATA  URLS :- $url \n PARAMS :- $formdataParams');

    await _dio().post(url, data: formdataParams).then((res) {
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      print('ERROR VALUE $error');
      if (onError != null) onError(_handleError(error));
    });
  }
}

String _handleError(dynamic error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection Timeout!";
      case DioExceptionType.sendTimeout:
        return "Request Timeout!";
      case DioExceptionType.receiveTimeout:
        return "Response Timeout!";
      case DioExceptionType.badResponse:
        return "Internal Server Error. Please try again later.";
      case DioExceptionType.cancel:
        return "Request to API was cancelled";
      case DioExceptionType.badCertificate:
      // TODO: Handle this case.
      case DioExceptionType.connectionError:
        return 'Failed to establish a connection to the server';
      case DioExceptionType.unknown:
      // TODO: Handle this case.
    }
  }
  return "Unknown error occurred!";
}
 