// ignore_for_file: empty_catches, duplicate_ignore, avoid_print

import 'dart:async';
// import 'package:device_apps/device_apps.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/models/search_model.dart';
import 'package:ok_kosher/provider/api_provider.dart';
import 'package:ok_kosher/utils/app_text.dart';
import 'package:ok_kosher/utils/images_path.dart';
import 'package:url_launcher/url_launcher.dart';

class Items {
  String? image;
  String? name;

  Items(this.name, this.image);
}

class HomeController extends GetxController {
  RxString selectedItem = "".obs;
  RxBool searchListOpen = false.obs;
  RxBool isLoading = false.obs;
  RxInt waitForAPi = 0.obs;

  TextEditingController searchTextController = TextEditingController();
  Timer? timeHandle;

  RxList<String> searchedListFiltered = RxList.empty();

  RxList<Items> items = [
    Items("Pareve", fishIconImage),
    Items("Dairy", cheeseIconImage),
    Items("Meat", meatIconImage),
    Items("Passover", drinkIconImage),
    Items("Cholov Yisroel", pizzaIconImage),
    Items("Pas Yisroel", breadIconImage),
    Items("Yoshon", leafIconImage),
    Items("Costco", costcoButtonIcon),
    Items("Wine", winePNGIconImage),
    Items("Whiskey", whiskeyIconImage),
    Items("Alcoholic Beverages", beveragesIconImage),
  ].obs;

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

  RxString selectedCategory = allCategories.obs;
  RxString filtterCategory = allCategories.obs;
  RxList allCategory = RxList.empty();
  RxString selectedBrand = allBrands.obs;
  RxString filtterBrand = allBrands.obs;
  RxList allBrand = RxList.empty();
  RxString selectedProductType = allTypes.obs;
  RxString filtterType = allTypes.obs;
  RxInt pg = 1.obs;
  RxInt pageCount = 1.obs;
  RxInt pageView = 0.obs;
  PageController pageController = PageController();

  RxList<Product> productList = RxList.empty();
  ScrollController scrollController = ScrollController();
  Future<void> checkApplication() async {
    await LaunchApp.openApp(
      androidPackageName: "com.okkosher.vegetableguide",
      iosUrlScheme: 'pulsesecure://',
      appStoreLink:
      // https://apps.apple.com/in/app/ok-vegetable-guide/id1317992536
      'itms-apps://itunes.apple.com/in/app/ok-vegetable-guide/id1317992536',
      // openStore: false
    );
  }

  Future<void> launchapp() async {
    final Uri url = Uri.parse('https://www.ok.org/vegetable-guide/');
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(url.toString())) {
        // ignore: deprecated_member_use
        await launch(url.toString());
      } else {
        throw 'Could not launch $url';
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> launchappCostco() async {
    final Uri url = Uri.parse('https://www.ok.org/costco-bakery-guide/');
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(url.toString())) {
        // ignore: deprecated_member_use
        await launch(url.toString());
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {}
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (pg.value <= pageCount.value) {
        pg.value++;
        searchApiCalling();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    selectedProductType.value = selectedItem.value;
    print("selectedProductType.value ${selectedProductType.value}");
    productList.clear();
    pg.value = 1;
    allCategory.add(allCategories);
    allBrand.add(allBrands);
    scrollController.addListener(scrollListener);
  }

  Future<void> searchApiCalling() async {
    isLoading.value = true;
    // productList.clear();
    allCategory.clear();
    allCategory.add(allCategories);
    allBrand.clear();
    allBrand.add(allBrands);
    await APIProvider().searchAPI(
        paramsTerm: searchTextController.text,
        paramsBrand:
            selectedBrand.value == allBrands ? "" : selectedBrand.value,
        paramsCategory: selectedCategory.value == allCategories
            ? ""
            : selectedCategory.value,
        paramsType: selectedProductType.value == allTypes
            ? ""
            : selectedProductType.value,
        pg: pg.value.toString(),
        onSuccessModel: (res) {
          filtterCategory.value = filtterCategory.value == allCategories
              ? selectedCategory.value
              : filtterCategory.value;
          filtterBrand.value = filtterBrand.value == allBrands
              ? selectedBrand.value
              : filtterBrand.value;
          filtterType.value = selectedProductType.value;
          pageCount.value = res.results!.paging!.pagecount ?? 1;
          if (pg.value == 1) {
            print("Page weqweqweqw ${pg.value}");
            if (res.results!.products!.isEmpty) {
              productList.clear();
            }
          }
          print(res.results!.products!.length);
          if (res.results!.products!.isNotEmpty) {
            for (var element in res.results!.products!) {
              productList.add(element);
            }
          }
          for (var element in res.results!.categories!) {
            if (element.length != 1 && element.isNotEmpty) {
              allCategory.add(element);
            }
          }

          for (var element in res.results!.brands!) {
            allBrand.add(element);
          }
          // ignore: invalid_use_of_protected_member
          if (!allCategory.value.contains(selectedCategory.value)) {
            selectedCategory.value = allCategories;
          }
          // ignore: invalid_use_of_protected_member
          if (!allBrand.value.contains(selectedBrand.value)) {
            selectedBrand.value = allBrands;
          }

          productList.removeWhere((element) => element.product == "");

          if (searchTextController.text.isEmpty) {
            // productList.clear();
            allBrand.clear();
            allBrand.add(allBrands);
            allCategory.clear();
            allCategory.add(allCategories);
            // selectedBrand.value = "";
            // selectedCategory.value = "";
            // selectedProductType.value = "";
            pg.value = 1;
          }
        },
        onError: (err) {});
    isLoading.value = false;
  }
}
