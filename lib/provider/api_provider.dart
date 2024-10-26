/* date: 06.08.21
* name: vennila
* task: forgot_password (forgotAPI and resetApi added)*/
import 'dart:convert';

import 'package:ok_kosher/models/alert_model.dart';
import 'package:ok_kosher/models/details_model.dart';
// import 'package:ok_kosher/models/food_model.dart';
import 'package:ok_kosher/models/page_model.dart';
import 'package:ok_kosher/models/search_model.dart';
import 'package:ok_kosher/services/api_service.dart';
import 'package:ok_kosher/utils/debugLog.dart';
import 'package:ok_kosher/utils/url_utils.dart';

class APIProvider {
  // Future<void> loginAPI({
  //   var params,
  //   Function()? beforeSend,
  //   Function(LoginModel data)? onSuccess,
  //   Function(dynamic error)? onError,
  // }) async {
  //   await ApiRequest(url: urlLogin, formdataParams: params).postWithData(
  //     beforeSend: () => {if (beforeSend != null) beforeSend()},
  //     onSuccess: (data) {
  //       LoginModel res = LoginModel.fromJson(json.decode(data.toString()));
  //       onSuccess!(res);
  //     },
  //     onError: (error) => {if (onError != null) onError(error)},
  //   );
  // }

  Future<void> alertAPI({
    var params,
    String? page,
    Function()? beforeSend,
    Function(AlertModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    Debug(alertUrl(page!));
    await ApiRequest(url: alertUrl(page), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        Debug("API Data $data");
        final List<AlertModel> alerts =
            data.map((json) => AlertModel.fromJson(json)).toList();
        // Debug("API res ${res}");
        Debug("API res $alerts");

        // onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> detailsAPI(
      {var params,
      String? nameParams,
      Function()? beforeSend,
      Function(DetailsModel data)? onSuccess,
      Function(dynamic error)? onError}) async {
    Debug(detailsUrl(nameParams!));
    await ApiRequest(url: detailsUrl(nameParams.toString()), params: params)
        .get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        // Debug("Res :- $data");
        DetailsModel res = DetailsModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {
        if (onError != null) onError(error),
      },
    );
  }

  // Future<void> foodAPI({
  //   var params,
  //   String? nameParams,
  //   Function()? beforeSend,
  //   Function(FoodModel data)? onSuccess,
  //   Function(dynamic error)? onError,
  // }) async {
  //   await ApiRequest(url: foodUrl(nameParams!), params: params).get(
  //     // beforeSend: () => {if (beforeSend != null) beforeSend()},
  //     onSuccess: (data) {
  //       Debug("Res Data :- $data");
  //       FoodModel res = FoodModel.fromJson(json.decode(data.toString()));

  //       onSuccess!(res);
  //     },
  //     onError: (error) => {if (onError != null) onError(error)},
  //   );
  // }

  Future<void> pageAPI({
    var params,
    String? id,
    Function()? beforeSend,
    Function(PageModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    Debug("££££££££££££££££££££ ${pagesUrl(id!)}");
    await ApiRequest(url: pagesUrl(id.toString().toLowerCase()), params: params)
        .get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        Debug("Res Data :- $data");
        PageModel res = PageModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> searchAPI({
    var params,
    String? paramsTerm,
    String? paramsType,
    String? paramsBrand,
    String? paramsCategory,
    String? pg,
    Function()? beforeSend,
    required Function(SearchModel data) onSuccessModel,
    Function(dynamic error)? onError,
  }) async {
    // Debug( searchUrl(paramsTerm!, paramsType!, paramsBrand!,
    //             paramsCategory!, pg ?? "1"));
    final validCharacters = RegExp(r'&');
    await ApiRequest(
            url: searchUrl(
                paramsTerm!.replaceAll(validCharacters, "%26"),
                paramsType!.replaceAll(validCharacters, "%26"),
                paramsBrand!.replaceAll(validCharacters, "%26"),
                paramsCategory!.replaceAll(validCharacters, "%26"),
                pg ?? "1"),
            params: params)
        .get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        Debug("Res Data :- $data");
        SearchModel res = searchModelFromJson(data.toString());
        onSuccessModel(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> searchAPI2({
    var params,
    String? paramsTerm,
    String? paramsType,
    String? paramsBrand,
    String? paramsCategory,
    String? pg,
    Function()? beforeSend,
    Function(SearchModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    // Debug( searchUrl(paramsTerm!, paramsType!, paramsBrand!,
    //             paramsCategory!, pg ?? "1"));
    await ApiRequest(
            url: searchUrl2(paramsTerm!, paramsType!, paramsBrand!,
                paramsCategory!, pg ?? "1"),
            params: params)
        .get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        Debug("Res Data :- $data");
        SearchModel res = SearchModel.fromJson(
          json.decode(
            data.toString(),
          ),
        );
        onSuccess!(res);
      },
      onError: (error) => {
        if (onError != null) onError(error),
      },
    );
  }
}
