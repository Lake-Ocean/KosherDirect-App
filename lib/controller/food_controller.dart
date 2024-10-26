// ignore_for_file: avoid_print, depend_on_referenced_packages, library_prefixes

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ok_kosher/controller/home_controller.dart';
import 'package:ok_kosher/models/search_model.dart';
import 'package:ok_kosher/provider/api_provider.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as dom;
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/contants.dart';
import 'package:ok_kosher/utils/images_path.dart';

import '../utils/app_text.dart';

class FoodController extends GetxController {
  RxBool searchListOpen = false.obs;
  RxBool isLoading = false.obs;

  // FoodModel? foodModel;
  // RxList<Product> foodList = RxList.empty();
  TextEditingController searchTextController = TextEditingController();
  PageController pageController = PageController();

  // RxString selectedProductType = "".obs;
  RxString renderedText = "".obs;
  RxInt pageView = 0.obs;

  RxList<String> itemsForFilter = [
    allTypes,
    "Pareve",
    "Dairy",
    "Meat",
    "Passover",
    "Cholov Yisroel",
    "Pas Yisroel",
    "Yoshon",
  ].obs;

  List<Widget> parseHtmlText(String htmlText) {
    List<Widget> widgets = [];
    var document = htmlParser.parse(htmlText);
    var body = document.body;
    if (body != null) {
      widgets.addAll(_parseNodes(body.nodes));
    }
    return widgets;
  }

  List<Widget> _parseNodes(List<dom.Node> nodes) {
    List<Widget> widgets = [];
    for (var node in nodes) {
      if (node is dom.Element) {
        if (node.localName == 'i' && node.classes.contains('icon-OK')) {
          widgets.add(SvgPicture.asset(
            okLogoBlackImage,
            // width: 16,
            height: 16,
          ));
        } else {
          widgets.addAll(_parseNodes(node.nodes));
        }
      } else if (node is dom.Text) {
        widgets.add(Text(
          node.text,
          style: const TextStyle(
              color: textColor,
              fontSize: 14,
              fontFamily: ROBOTO_FONT,
              fontWeight: FontWeight.w500),
        ));
      }
    }
    return widgets;
  }

  // RxList selectedBrand = RxList.empty();

  List<InlineSpan>? renderedTextWithOkImage(String title) {
    String? title2 = convertHtmlToPlainText(title);
    // print("title2 ${title2}");
    List<InlineSpan> list = [];
    title2.split("OK").forEach((element) {
      list.add(TextSpan(
        text: element,
        style: const TextStyle(
          color: textColor,
          fontSize: 13,
          // textAlign: TextAlign.justify,
          fontFamily: ROBOTO_FONT,
          fontWeight: FontWeight.w500,
        ),
      ));
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

  RxString selectedCategory = allCategories.obs;
  RxString filtterCategory = allCategories.obs;
  RxString filtterBrand = allBrands.obs;
  RxList allCategory = RxList.empty();
  RxString selectedBrand = allBrands.obs;
  RxString selectedProductType = allTypes.obs;
  RxString filtterType = allTypes.obs;
  RxList allBrand = RxList.empty();
  Timer? timeHandle;
  RxList<Product> foodItemList = RxList.empty();

  // RxString selectedProductType = "".obs;
  // RxInt waitForAPi = 0.obs;

  RxList<Product> productList = RxList.empty();
  PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 1);
  RxString pagingErrorMessage = "".obs;

  @override
  void onInit() {
    final productType = Get.put(HomeController()).selectedItem.value;

    if (myCategory.contains(productType)) {
      selectedCategory.value = productType;
    } else {
      selectedProductType.value = productType;
    }
    productList.clear();
    allCategory.add(allCategories);
    allBrand.add(allBrands);
    pagingController.addPageRequestListener((pageKey) {
      APIProvider().searchAPI(
          paramsTerm: searchTextController.text,
          paramsBrand:
              selectedBrand.value == allBrands ? "" : selectedBrand.value,
          paramsCategory: selectedCategory.value == allCategories
              ? ""
              : selectedCategory.value,
          paramsType: selectedProductType.value == allTypes
              ? ""
              : selectedProductType.value,
          pg: pageKey.toString(),
          onSuccessModel: (res) {
            filtterCategory.value = filtterCategory.value == allCategories
                ? selectedCategory.value
                : filtterCategory.value;
            filtterBrand.value = filtterBrand.value == allBrands
                ? selectedBrand.value
                : filtterBrand.value;
            filtterType.value = selectedProductType.value;
            productList.value = res.results?.products ?? [];
            final isLastPage = productList.isEmpty;
            if (isLastPage) {
              pagingController.appendLastPage(productList);
            } else {
              final nextPageKey = pageKey + 1;
              pagingController.appendPage(productList, nextPageKey);
            }
            for (var element in res.results!.categories!) {
              if (element.length != 1 && element.isNotEmpty) {
                allCategory.add(element);
              }
            }
            allCategory.value = allCategory.toSet().toList();
            allCategory.value =
                groupAndSortByFirstLetter(allCategory, "All Categories");
            for (var element in res.results!.brands!) {
              allBrand.add(element);
            }
            allBrand.value = allBrand.toSet().toList();
            allBrand.value = groupAndSortByFirstLetter(allBrand, "All Brands");

            if (myCategory.contains(selectedProductType.value)) {
              selectedCategory.value = selectedProductType.value.toUpperCase();
            }

            if (!allCategory.contains(selectedCategory.value) &&
                !myCategory.contains(selectedCategory.value)) {
              selectedCategory.value = allCategories;
            }
            if (!allBrand.contains(selectedBrand.value)) {
              selectedBrand.value = allBrands;
            }
            productList.removeWhere((element) => element.product == "");

            print("food productList ${productList.length}");
          },
          onError: (err) {

            pagingController.error = err;
            pagingErrorMessage.value = err;
            isLoading.value = false;
          });
      foodItemList.value = pagingController.itemList ?? [];
    });
    pagingController.addStatusListener(
      (status) {
        print("status$status");
      },
    );
    foodApiCalling(Get.put(HomeController()).selectedItem.value);
    super.onInit();
  }

  Future<void> foodApiCalling(String foodName) async {
    isLoading.value = true;
    renderedText.value = "";
    if (foodName == "Cholov Yisroel" ||
        foodName == "Pas Yisroel" ||
        foodName == "Yoshon") {
      String id = foodName == "Cholov Yisroel"
          ? "12147"
          : foodName == "Pas Yisroel"
          ? "12151"
          : "12210";
      await APIProvider().pageAPI(
        id: foodName,
        onSuccess: (val) {
          print(val);
          renderedText.value = val.content!.rendered ?? "";
          update();
          // isLoading.value = false;
        },
        onError: (err) {
          isLoading.value = false;
          print("Error :-  $err");
        },
      );
    }
    pagingController.refresh();
    // allCategory.clear();
    // allBrand.clear();
    // allCategory.add(allCategories);
    // allBrand.add(allBrands);
    isLoading.value = false;
  }

  List<String> statusArray = [
    'Passover',
    'Passover',
    'Yoshon',
    'Yoshon',
    'CholovYisroel',
    'Cholov Yisroel',
    'PasYisroel',
    'Pas Yisroel',
    'Glatt',
    'Glatt',
    'Fish',
    'Fish',
    'Kitnius',
    'Kitnius'
  ];

  String calculateStatus(Product product) {
    String status = '';
    for (int i = 0; i < statusArray.length; i++) {
      print("*****************${product.status}");
      print(product.status);

      if (statusArray[i] == product.status) {
        if (status == '') {
          status += statusArray[i + 1];
        } else {
          status += ' | ${statusArray[i + 1]}';
        }
      }
      i++;
    }
    return status;
  }

  List<String> groupAndSortByFirstLetter(List items, String firstItem) {
    // Create a map to group items by their first letter
    Map<String, List<String>> groupedItems = {};

    for (var item in items) {
      String firstLetter =
          item[0].toUpperCase(); // Get the first letter of the item

      // If the letter doesn't exist in the map, create a new list for it
      if (!groupedItems.containsKey(firstLetter)) {
        groupedItems[firstLetter] = [];
      }

      // Add the item to the corresponding list
      groupedItems[firstLetter]!.add(item);
    }

    // Create a new list to hold the sorted items
    List<String> sortedList = [];

    // If the item to appear first exists in the list, add it first
    if (items.contains(firstItem)) {
      sortedList.add(firstItem.toString());
      // Remove the item from its group so it's not repeated in the final list
      String firstItemFirstLetter = firstItem[0].toUpperCase();
      groupedItems[firstItemFirstLetter]!.remove(firstItem);
    }

    // Sort the map by keys (first letter)
    var sortedKeys = groupedItems.keys.toList()..sort();

    // For each group (sorted by first letter), sort the items and add to the final list
    for (var key in sortedKeys) {
      groupedItems[key]!
          .sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
      sortedList
          .addAll(groupedItems[key]!); // Add the sorted items to the final list
    }

    return sortedList;
  }
  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
