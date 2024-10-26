// ignore_for_file: deprecated_member_use, avoid_print, no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/controller/alert_controller.dart';
import 'package:ok_kosher/controller/details_controller.dart';
import 'package:ok_kosher/controller/home_controller.dart';
import 'package:ok_kosher/utils/app_text.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/contants.dart';
import 'package:ok_kosher/utils/images_path.dart';
import 'package:ok_kosher/utils/size_style.dart';
import 'package:ok_kosher/widgets/appbar_common.dart';
import 'package:ok_kosher/widgets/drawer_common.dart';
import 'package:ok_kosher/widgets/inputField.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final advancedDrawerController = AdvancedDrawerController();
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      if (homeController.searchTextController.text.isNotEmpty) {
        homeController.productList.clear();
        homeController.allCategory.clear();
        homeController.allCategory.add(allCategories);
        homeController.allBrand.clear();
        homeController.allBrand.add(allBrands);
        homeController.searchTextController.text = "";
        FocusScope.of(context).requestFocus(FocusNode());
        return false; // return true if the route to be popped
      } else {
        return true;
      }
    }

    // final yourScrollController = ScrollController();
    return DrawerCommon(
      advancedDrawerController: advancedDrawerController,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbarCommon(
            visibleBackButton: false,
            onTap: () {
              advancedDrawerController.showDrawer();
            }),
        body:
            // Obx(
            //   () => const
            WillPopScope(
          onWillPop: () {
            return _willPopCallback();
          },
          child: Obx(
            () => ListView(
              // alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: CommonTextFormFields(
                                color: lightGrayColor1,
                                controller: homeController.searchTextController,
                                hintTxt: searchItemHere,
                                onTap: () {
                                  homeController.searchListOpen.value = true;
                                  // homeController.searchedListFiltered.addAll(homeController.searchedList);
                                },
                                onChanged: (val) {
                                  // homeController.searchedListFiltered.clear();
                                  // homeController.waitForAPi.value++;
                                  if (homeController
                                      .searchTextController.text.isEmpty) {
                                    homeController.filtterCategory.value =
                                        allCategories;
                                    homeController.selectedCategory.value =
                                        allCategories;
                                    //..products

                                    homeController.filtterType.value = allTypes;
                                    homeController.selectedProductType.value =
                                        allTypes;

                                    // ...brand
                                    homeController.filtterBrand.value =
                                        allBrands;
                                    homeController.selectedBrand.value =
                                        allBrands;
                                    homeController.productList.clear();
                                    homeController
                                        .searchApiCalling()
                                        .then((value) {
                                      if ((homeController
                                                  .filtterCategory.value ==
                                              allCategories &&
                                          homeController.filtterType.value ==
                                              allTypes &&
                                          homeController.filtterBrand.value ==
                                              allBrands &&
                                          homeController
                                                  .searchTextController.text ==
                                              "")) {
                                        homeController.productList.value = [];
                                        setState(() {});
                                      }
                                    });
                                  }
                                  if (homeController.timeHandle != null) {
                                    homeController.timeHandle!.cancel();
                                  }
                                  if (homeController
                                      .searchTextController.text.isNotEmpty) {
                                    homeController.timeHandle = Timer(
                                        const Duration(milliseconds: 800), () {
                                      homeController.productList.clear();
                                      homeController.pg.value = 1;
                                      homeController
                                          .searchApiCalling()
                                          .then((value) {
                                        if ((homeController
                                                    .filtterCategory.value ==
                                                allCategories &&
                                            homeController.filtterType.value ==
                                                allTypes &&
                                            homeController.filtterBrand.value ==
                                                allBrands &&
                                            homeController.searchTextController
                                                    .text ==
                                                "")) {
                                          homeController.productList.value = [];
                                          setState(() {});
                                        }
                                      });
                                    });
                                  }

                                  // if (homeController.waitForAPi.value > 2) {
                                  //   homeController.waitForAPi.value = 0;
                                  //   // homeController.searchApiCalling();
                                  // }
                                  // homeController.searchedListFiltered.addAll(homeController.searchedList.where((p0) => p0.toLowerCase().contains(val.toLowerCase())));
                                },
                                icon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      searchIconImage,
                                      height: 16,
                                      width: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                InkWell(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      homeController.pageView.value = 0;
                                      Get.toNamed(ROUTE_FILTER);
                                    },
                                    child: SvgPicture.asset(filterIconImage)),
                                Visibility(
                                  visible: (homeController
                                              .selectedBrand.value.isNotEmpty &&
                                          homeController
                                                  .selectedBrand.value !=
                                              allBrands) ||
                                      (homeController.selectedCategory.value
                                              .isNotEmpty &&
                                          homeController
                                                  .selectedCategory.value !=
                                              allCategories) ||
                                      (homeController.selectedProductType.value
                                              .isNotEmpty &&
                                          homeController
                                                  .selectedProductType.value !=
                                              allTypes),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(right: 1.0, top: 2),
                                    child: CircleAvatar(
                                      radius: 2,
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // if (!homeController.isLoading.value)
                      // filterView(),
                      if (!homeController.isLoading.value &&
                          homeController.productList.isEmpty &&
                          homeController.searchTextController.text.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: const Text(
                            noMatches,
                            style: TextStyle(
                                color: appColor,
                                fontSize: 16,
                                fontFamily: ROBOTO_FONT,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      homeController.isLoading.value
                          ? Visibility(
                              visible: homeController.isLoading.value,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: appColor,
                                ),
                              ),
                            )
                          : Scrollbar(
                              // controller: homeController.scrollController,
                              // thickness: 6,
                              // radius: const Radius.circular(10),
                              child: SizedBox(
                                height: homeController.productList.isEmpty
                                    ? 0.0
                                    : Get.height / 1.30,
                                child: Column(
                                  children: [
                                    (homeController.filtterCategory.value != allCategories ||
                                            homeController.filtterType.value !=
                                                allTypes ||
                                            homeController.filtterBrand.value !=
                                                allBrands ||
                                            homeController.searchTextController
                                                .text.isNotEmpty)
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Wrap(
                                                    alignment:
                                                        WrapAlignment.start,
                                                    runAlignment:
                                                        WrapAlignment.start,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .start,
                                                    spacing: 5,
                                                    runSpacing: 5,
                                                    children: [
                                                      filterTypesNameBtn(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    FocusNode());
                                                            homeController
                                                                .searchTextController
                                                                .clear();
                                                            setState(() {});
                                                            if (homeController
                                                                .searchTextController
                                                                .text
                                                                .isEmpty) {
                                                              homeController
                                                                  .productList
                                                                  .value = [];
                                                              homeController
                                                                  .searchApiCalling()
                                                                  .then(
                                                                      (value) {
                                                                if ((homeController.filtterCategory.value == allCategories &&
                                                                    homeController
                                                                            .filtterType
                                                                            .value ==
                                                                        allTypes &&
                                                                    homeController
                                                                            .filtterBrand
                                                                            .value ==
                                                                        allBrands &&
                                                                    homeController
                                                                            .searchTextController
                                                                            .text ==
                                                                        "")) {
                                                                  homeController
                                                                      .productList
                                                                      .value = [];
                                                                  setState(
                                                                      () {});
                                                                }
                                                              });
                                                              //   homeController.filtterBrand
                                                              //     .value = allBrands;
                                                              // homeController.selectedBrand
                                                              //     .value = allBrands;
                                                              // homeController.filtterCategory.value = allCategories;
                                                              // homeController.selectedCategory.value = allCategories;
                                                              // homeController.filtterType.value = allTypes;
                                                              // homeController.selectedProductType.value = allTypes;
                                                              // homeController.productList.value =
                                                              //     [];
                                                            } else {
                                                              // homeController.filtterBrand
                                                              //     .value = allBrands;
                                                              // homeController.selectedBrand
                                                              //     .value = allBrands;
                                                              // homeController.filtterCategory
                                                              //     .value = allCategories;
                                                              // homeController.selectedCategory
                                                              //     .value = allCategories;
                                                              // homeController.filtterType.value =
                                                              //     allTypes;
                                                              // homeController.selectedProductType
                                                              //     .value = allTypes;
                                                              // homeController.productList.value =
                                                              //     [];
                                                              if (homeController
                                                                      .searchTextController
                                                                      .text !=
                                                                  "") {
                                                                homeController
                                                                    .productList
                                                                    .value = [];
                                                                homeController
                                                                    .searchApiCalling()
                                                                    .then(
                                                                        (value) {
                                                                  if ((homeController.filtterCategory.value == allCategories) &&
                                                                      (homeController
                                                                              .filtterType
                                                                              .value ==
                                                                          allTypes) &&
                                                                      (homeController
                                                                              .filtterBrand
                                                                              .value ==
                                                                          allBrands) &&
                                                                      (homeController
                                                                          .searchTextController
                                                                          .text
                                                                          .isEmpty)) {
                                                                    homeController
                                                                        .productList
                                                                        .value = [];
                                                                  }
                                                                });
                                                              }
                                                            }
                                                          },
                                                          data: homeController
                                                              .searchTextController
                                                              .text),

                                                      // Categories...
                                                      if (homeController
                                                              .filtterCategory
                                                              .value
                                                              .isNotEmpty &&
                                                          homeController
                                                                  .filtterCategory
                                                                  .value !=
                                                              allCategories)
                                                        filterTypesNameBtn(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      FocusNode());
                                                              homeController
                                                                      .filtterCategory
                                                                      .value =
                                                                  allCategories;
                                                              homeController
                                                                      .selectedCategory
                                                                      .value =
                                                                  allCategories;
                                                              if (homeController
                                                                  .searchTextController
                                                                  .text
                                                                  .isEmpty) {
                                                                homeController
                                                                    .productList
                                                                    .value = [];
                                                                homeController
                                                                    .searchApiCalling()
                                                                    .then(
                                                                        (value) {
                                                                  if ((homeController.filtterCategory.value == allCategories &&
                                                                      homeController
                                                                              .filtterType
                                                                              .value ==
                                                                          allTypes &&
                                                                      homeController
                                                                              .filtterBrand
                                                                              .value ==
                                                                          allBrands &&
                                                                      homeController
                                                                              .searchTextController
                                                                              .text ==
                                                                          "")) {
                                                                    homeController
                                                                        .productList
                                                                        .value = [];
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                });
                                                              }
                                                              homeController
                                                                  .productList
                                                                  .value = [];
                                                              homeController
                                                                  .searchApiCalling()
                                                                  .then(
                                                                      (value) {
                                                                if ((homeController.filtterCategory.value == allCategories) &&
                                                                    (homeController
                                                                            .filtterType
                                                                            .value ==
                                                                        allTypes) &&
                                                                    (homeController
                                                                            .filtterBrand
                                                                            .value ==
                                                                        allBrands) &&
                                                                    (homeController
                                                                        .searchTextController
                                                                        .text
                                                                        .isEmpty)) {
                                                                  homeController
                                                                      .productList
                                                                      .value = [];
                                                                }
                                                              });
                                                            },
                                                            data: homeController
                                                                .filtterCategory
                                                                .value),
                                                      // Types....
                                                      if (homeController
                                                              .filtterType
                                                              .value
                                                              .isNotEmpty &&
                                                          homeController
                                                                  .filtterType
                                                                  .value !=
                                                              allTypes)
                                                        filterTypesNameBtn(
                                                          onTap: () {
                                                            homeController
                                                                    .filtterType
                                                                    .value =
                                                                allTypes;
                                                            homeController
                                                                .selectedProductType
                                                                .value = allTypes;
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    FocusNode());
                                                            setState(() {});
                                                            if (homeController
                                                                .searchTextController
                                                                .text
                                                                .isEmpty) {
                                                              homeController
                                                                  .productList
                                                                  .value = [];
                                                              homeController
                                                                  .searchApiCalling()
                                                                  .then(
                                                                      (value) {
                                                                if ((homeController.filtterCategory.value == allCategories &&
                                                                    homeController
                                                                            .filtterType
                                                                            .value ==
                                                                        allTypes &&
                                                                    homeController
                                                                            .filtterBrand
                                                                            .value ==
                                                                        allBrands &&
                                                                    homeController
                                                                            .searchTextController
                                                                            .text ==
                                                                        "")) {
                                                                  homeController
                                                                      .productList
                                                                      .value = [];
                                                                  setState(
                                                                      () {});
                                                                }
                                                              });
                                                            }
                                                            homeController
                                                                .productList
                                                                .value = [];
                                                            homeController
                                                                .searchApiCalling()
                                                                .then((value) {
                                                              if ((homeController.filtterCategory.value == allCategories) &&
                                                                  (homeController
                                                                          .filtterType
                                                                          .value ==
                                                                      allTypes) &&
                                                                  (homeController
                                                                          .filtterBrand
                                                                          .value ==
                                                                      allBrands) &&
                                                                  (homeController
                                                                      .searchTextController
                                                                      .text
                                                                      .isEmpty)) {
                                                                homeController
                                                                    .productList
                                                                    .value = [];
                                                                setState(() {});
                                                              }
                                                              setState(() {});
                                                            });
                                                          },
                                                          data: homeController
                                                              .filtterType
                                                              .value,
                                                        ),
                                                      // Brands...
                                                      if (homeController
                                                              .filtterBrand
                                                              .value
                                                              .isNotEmpty &&
                                                          homeController
                                                                  .filtterBrand
                                                                  .value !=
                                                              allBrands)
                                                        filterTypesNameBtn(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      FocusNode());
                                                              homeController
                                                                      .filtterBrand
                                                                      .value =
                                                                  allBrands;
                                                              homeController
                                                                      .selectedBrand
                                                                      .value =
                                                                  allBrands;
                                                              if (homeController
                                                                  .searchTextController
                                                                  .text
                                                                  .isEmpty) {
                                                                homeController
                                                                    .productList
                                                                    .value = [];
                                                                homeController
                                                                    .searchApiCalling()
                                                                    .then(
                                                                        (value) {
                                                                  if ((homeController.filtterCategory.value == allCategories &&
                                                                      homeController
                                                                              .filtterType
                                                                              .value ==
                                                                          allTypes &&
                                                                      homeController
                                                                              .filtterBrand
                                                                              .value ==
                                                                          allBrands &&
                                                                      homeController
                                                                              .searchTextController
                                                                              .text ==
                                                                          "")) {
                                                                    homeController
                                                                        .productList
                                                                        .value = [];
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                });
                                                              }
                                                              print(
                                                                  "filtterCategory.value :-${homeController.selectedCategory.value}");
                                                              print(
                                                                  "filtterBrand.value :-${homeController.selectedBrand.value}");
                                                              print(
                                                                  "filtterType.value :-${homeController.selectedProductType.value}");
                                                              homeController
                                                                  .productList
                                                                  .value = [];
                                                              homeController
                                                                  .searchApiCalling()
                                                                  .then(
                                                                      (value) {
                                                                if ((homeController.filtterCategory.value == allCategories) &&
                                                                    (homeController
                                                                            .filtterType
                                                                            .value ==
                                                                        allTypes) &&
                                                                    (homeController
                                                                            .filtterBrand
                                                                            .value ==
                                                                        allBrands) &&
                                                                    (homeController
                                                                        .searchTextController
                                                                        .text
                                                                        .isEmpty)) {
                                                                  homeController
                                                                      .productList
                                                                      .value = [];
                                                                }
                                                              });
                                                            },
                                                            data: homeController
                                                                .filtterBrand
                                                                .value),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                    Expanded(
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            const Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 0,
                                              left: 15,
                                              right: 15,
                                              top: 10),
                                          child: Divider(),
                                        ),
                                        keyboardDismissBehavior:
                                            ScrollViewKeyboardDismissBehavior
                                                .onDrag,
                                        controller:
                                            homeController.scrollController,
                                        itemCount:
                                            homeController.productList.length,
                                        physics: ClampingScrollPhysics(),
                                        // shrinkWrap: true,
                                        // physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0,
                                                left: 15,
                                                right: 15,
                                                top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                      // color: appLightColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  child: SizedBox(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          homeController
                                                                  .productList[
                                                                      index]
                                                                  .brand ??
                                                              "",
                                                          style: const TextStyle(
                                                              color: textColor,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  ROBOTO_FONT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          homeController
                                                                  .productList[
                                                                      index]
                                                                  .product ??
                                                              "",
                                                          style: const TextStyle(
                                                              color: blackColor,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  ROBOTO_FONT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          "${homeController.productList[index].status} ${(homeController.productList[index].passover == "1") ? " | Passover" : ""}${(homeController.productList[index].yoshon == "1") ? " | Yoshon " : ""}${(homeController.productList[index].cholovYisroel == "1") ? " | Cholov Yisroel " : ""}${(homeController.productList[index].pasYisroel == "1") ? " | Pas Yisroel " : ""}${(homeController.productList[index].glatt == "1") ? " | Glatt " : ""}${(homeController.productList[index].fish == "1") ? " | Fish " : ""}${(homeController.productList[index].kitnius == "1") ? " | Kitnius " : ""}",
                                                          style:
                                                              const TextStyle(
                                                            color: textColor,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                ROBOTO_FONT,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                      Visibility(
                        visible: homeController.productList.isEmpty,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            GridView.count(
                              crossAxisCount: 4,
                              crossAxisSpacing: 9,
                              mainAxisSpacing: 9,
                              childAspectRatio:
                                  (Get.width / 4) / (Get.height / 6.5),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              children: List.generate(
                                homeController.items.length,
                                (index) {
                                  Items item = homeController.items[index];
                                  return GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      if (item.name == "Costco") {
                                        homeController.launchappCostco();
                                      } else {
                                          setState(() {
                                            if(myCategory.contains(item.name ?? "")){
                                              homeController.selectedItem.value =
                                                  item.name?.toUpperCase() ?? "";
                                            }else{
                                              homeController.selectedItem.value =
                                                  item.name ?? "";
                                            }
                                          });

                                        Get.toNamed(ROUTE_FOOD);
                                      }
                                    },
                                    child: Container(
                                      // height: 100,
                                      // width: Get.width / 4.8,
                                      decoration: BoxDecoration(
                                        color: appLightColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ([
                                              "Costco",
                                              "Wine",
                                              "Whiskey",
                                              "Alcoholic Beverages"
                                            ].contains(item.name))
                                                ? Image.asset(
                                                    height: 45,
                                                    width: 45,
                                                    item.image ?? "",
                                                    color: appColor,
                                                  )
                                                : SvgPicture.asset(
                                                    item.image ?? "",
                                                    color: appColor,
                                                    // homeController
                                                    //             .selectedItem.value ==
                                                    //         homeController.items[i].name
                                                    //     ? whiteColor
                                                    //     :
                                                  ),
                                            Text(
                                              item.name ?? "",
                                              style: TextStyle(
                                                color:
                                                    // homeController
                                                    //             .selectedItem.value ==
                                                    //         homeController.items[i].name
                                                    //     ? whiteColor
                                                    //     :
                                                    appColor,
                                                fontSize: size12,
                                                fontFamily: ROBOTO_FONT,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // SizedBox(
                            //   height: 100,
                            //   child: ListView.builder(
                            //     itemCount: homeController.items.length,
                            //     scrollDirection: Axis.horizontal,
                            //     itemBuilder: (context, index) {
                            //       return Obx(
                            //         () => Padding(
                            //           padding: EdgeInsets.only(
                            //               left: index == 0 ? 15.0 : 0, right: 15),
                            //           child: InkWell(
                            //             onTap: () {
                            //               homeController.selectedItem.value =
                            //                   homeController.items[index].name ??
                            //                       "";
                            //               FocusScope.of(context)
                            //                   .requestFocus(FocusNode());
                            //               Get.toNamed(ROUTE_FOOD);
                            //             },
                            //             child: Container(
                            //               height: 100,
                            //               width: 80,
                            //               decoration: BoxDecoration(
                            //                 color: homeController
                            //                             .selectedItem.value ==
                            //                         homeController.items[index].name
                            //                     ? appColor
                            //                     : appLightColor,
                            //                 borderRadius: BorderRadius.circular(10),
                            //               ),
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(8.0),
                            //                 child: Column(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.spaceEvenly,
                            //                   children: [
                            //                     SvgPicture.asset(
                            //                       homeController
                            //                               .items[index].image ??
                            //                           "",
                            //                       color: homeController
                            //                                   .selectedItem.value ==
                            //                               homeController
                            //                                   .items[index].name
                            //                           ? whiteColor
                            //                           : appColor,
                            //                     ),
                            //                     Text(
                            //                       homeController
                            //                               .items[index].name ??
                            //                           "",
                            //                       style: TextStyle(
                            //                         color: homeController
                            //                                     .selectedItem
                            //                                     .value ==
                            //                                 homeController
                            //                                     .items[index].name
                            //                             ? whiteColor
                            //                             : appColor,
                            //                         fontSize: 14,
                            //                         fontFamily: ROBOTO_FONT,
                            //                         fontWeight: FontWeight.w400,
                            //                       ),
                            //                       textAlign: TextAlign.center,
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  // GestureDetector(
                                  //   behavior: HitTestBehavior.opaque,
                                  //   onTap: () async {
                                  //     await homeController.checkApplication();
                                  //   },
                                  //   child: Stack(
                                  //     children: [
                                  //       Container(
                                  //         height: Get.height / 5,
                                  //         width: Get.width / 2,
                                  //         decoration: BoxDecoration(
                                  //             image: const DecorationImage(
                                  //                 image: AssetImage(
                                  //                   "assets/images/checking.png",
                                  //                 ),
                                  //                 fit: BoxFit.cover),
                                  //             color: appLightColor,
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10)),
                                  //         alignment: Alignment.bottomRight,
                                  //       ),
                                  //       Container(
                                  //         height: Get.height / 5,
                                  //         // width: Get.width / 2,
                                  //         decoration: BoxDecoration(
                                  //             gradient: const LinearGradient(
                                  //               colors: [
                                  //                 Colors.black12,
                                  //                 Colors.black87
                                  //               ],
                                  //               begin: Alignment.center,
                                  //               end: Alignment.bottomCenter,
                                  //             ),
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10)),
                                  //         alignment: Alignment.bottomRight,
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.all(10.0),
                                  //           child: Column(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.end,
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.end,
                                  //             children: [
                                  //               Container(
                                  //                 height: 55,
                                  //                 width: 55,
                                  //                 decoration: BoxDecoration(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(8),
                                  //                   color: Colors.transparent,
                                  //                   image: const DecorationImage(
                                  //                     fit: BoxFit.cover,
                                  //                     image: AssetImage(vegAppLogo),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               const Text(
                                  //                 "Vegetable Checking Guide",
                                  //                 textAlign: TextAlign.end,
                                  //                 style: TextStyle(
                                  //                     color: whiteColor,
                                  //                     fontSize: 16,
                                  //                     fontFamily: ROBOTO_FONT,
                                  //                     fontWeight: FontWeight.w500),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),

                                  Expanded(
                                    child: containerCommon(
                                        restaurantHeaderImage, restaurant, () {
                                      final detailsController =
                                          Get.put(DetailsController());
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      if (detailsController.restaurantList ==
                                          []) {
                                        detailsController.isLoading.value =
                                            true;
                                        detailsController.update();
                                      }
                                      Get.toNamed(ROUTE_Detail);

                                      detailsController.selectedCounty.value =
                                          viewAll;
                                      detailsController.filterRestaurantList(
                                          detailsController
                                              .selectedCounty.value);
                                    }, Get.width / 2, Get.height / 6),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        containerCommon(
                                            "assets/images/checking.png", "",
                                            () async {
                                          await homeController
                                              .checkApplication();
                                        }, Get.width / 2, Get.height / 6),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0,
                                              bottom: 10,
                                              left: 10),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: SizedBox(
                                                      height: 45,
                                                      width: 45,
                                                      child: Image.asset(
                                                          vegAppLogo)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Vegetable Checking Guide",
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      color: whiteColor,
                                                      fontSize: size16,
                                                      fontFamily: ROBOTO_FONT,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child:
                                  containerCommon(alertHeaderImage, alerts, () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                Get.toNamed(ROUTE_ALERT);
                                Get.put(AlertController()).alertApiCalling("1");
                              }, Get.width, Get.height / 7),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => (!homeController.isLoading.value)
                      ? Visibility(
                          visible: homeController.productList.isNotEmpty,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: appColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    launch("https://www.ok.org/contact/?tab=4");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        report,
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 14,
                                            fontFamily: ROBOTO_FONT,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      SvgPicture.asset(
                                        okLogoBlackImage,
                                        height: 16,
                                        width: 16,
                                        color: whiteColor,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text(
                                        symbol,
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 14,
                                            fontFamily: ROBOTO_FONT,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }

  Widget filterTypesNameBtn({required String data, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: (data.isNotEmpty)
          ? Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: appColor, borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      data,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: size13,
                        fontFamily: ROBOTO_FONT,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.close,
                    size: 20,
                    color: whiteColor,
                  )
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget containerCommon(
    image,
    name,
    void Function() param2,
    double width,
    double height,
  ) {
    return InkWell(
      onTap: () {
        param2();
      },
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      image,
                    ),
                    fit: BoxFit.cover),
                color: appLightColor,
                borderRadius: BorderRadius.circular(10)),
          ),
          Container(
            height: height,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.black12, Colors.black87],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                name,
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: whiteColor,
                    fontSize: size16,
                    fontFamily: ROBOTO_FONT,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
