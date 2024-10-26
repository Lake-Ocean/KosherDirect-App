// ignore_for_file: depend_on_referenced_packages, library_prefixes, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/models/alert_model.dart';
import 'package:http/http.dart' as http;
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/contants.dart';
import 'package:ok_kosher/utils/images_path.dart';
import 'package:ok_kosher/utils/store_data.dart';
import 'package:ok_kosher/utils/url_utils.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as dom;

class AlertController extends GetxController {
  RxList<AlertModel> alertModelList = RxList.empty();
  RxBool isLoading = false.obs;
  RxBool isInternet = false.obs;
  final ScrollController controllerListView = ScrollController();
  RxInt pageApi = 1.obs;

  void scrollListener() {
    if (controllerListView.position.pixels ==
        controllerListView.position.maxScrollExtent) {
      pageApi.value++;
      alertApiCalling(pageApi.value);
    }
  }

  List<InlineSpan>? title(String title) {
    String? title2 = convertHtmlToPlainText(title);
    // print("title2 ${title2}");
    List<InlineSpan> list = [];
    title2.split("OK").forEach((element) {
      list.add(
        TextSpan(
          text: element,
          style: const TextStyle(
              color: addressTextColor,
              fontSize: 14,
              fontFamily: ROBOTO_FONT,
              fontWeight: FontWeight.w400),
        ),
      );
      list.add(WidgetSpan(
        child: SvgPicture.asset(
          okLogoBlackImage,
          width: 16,
          height: 16,
        ),
      ));
    });
    list.removeLast();
    return list;
  }

  String convertHtmlToPlainText(String htmlString) {
    dom.Document document = htmlParser.parse(htmlString);
    String parsedString = parseString(document.body!);
    return parsedString;
  }

  String parseString(dom.Node node) {
    String parsedString = '';
    if (node.nodeType == dom.Node.TEXT_NODE) {
      parsedString += node.text!;
    } else if (node.nodeType == dom.Node.ELEMENT_NODE) {
      for (var childNode in node.nodes) {
        parsedString += parseString(childNode);
      }
    }
    return parsedString;
  }

  @override
  void onInit() {
    pageApi.value = 1;
    alertApiCalling("1").then((value){
      save("loadDateTimeAlt", DateTime.now().toIso8601String());
    });
    alertModelList.clear();
    controllerListView.addListener(scrollListener);
    super.onInit();
  }

  Future<void> alertApiCalling(page) async {
    isLoading.value = true;

    print(alertUrl(page.toString()));
    // final response = await http.get(Uri.parse('https://www.okkosher.org/wp-json/wp/v2/alerts?per_page=20&alertcategory=44&page=1'));
    try {
      final response = await http.get(Uri.parse(alertUrl(page.toString())));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        final List<AlertModel> alerts =
            responseData.map((json) => AlertModel.fromJson(json)).toList();
        alertModelList.addAll(alerts);
        isLoading.value = false;
      } else {
        isLoading.value = false;

        // throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
    }
  }
}
