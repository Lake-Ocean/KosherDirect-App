// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ok_kosher/controller/food_controller.dart';
import 'package:ok_kosher/controller/home_controller.dart';
import 'package:ok_kosher/utils/app_text.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/contants.dart';
import 'package:ok_kosher/utils/images_path.dart';
import 'package:ok_kosher/widgets/appbar_common.dart';
import 'package:ok_kosher/widgets/inputField.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/search_model.dart';
import '../widgets/no_items_paged.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final foodController = Get.put(FoodController());

  @override
  Widget build(BuildContext context) {
    // final yourScrollController = ScrollController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbarCommon(visibleBackButton: true, onTap: () {}),
      body: Obx(
        () => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              physics:
                  //     (foodController.selectedProductType.value == "Pas Yisroel" ||
                  //             foodController.selectedProductType.value ==
                  //                 "Cholov Yisroel" ||
                  foodController.selectedProductType.value == "Yoshon"
                      ? const ClampingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: foodController.selectedProductType.value == "Yoshon"
                    ? Get.height + 100
                    : Get.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: CommonTextFormFields(
                              controller: foodController.searchTextController,
                              onTap: () {
                                foodController.searchListOpen.value = true;
                                print(
                                    "object ${foodController.searchListOpen.value}");
                              },
                              hintTxt:
                                  "$search ${(foodController.selectedProductType.value.isEmpty) ? Get.put(HomeController()).selectedItem.value : foodController.selectedProductType.value}",
                              onChanged: (val) {
                                // foodController.waitForAPi.value++;
                                // if (foodController.waitForAPi.value > 2) {foodController.waitForAPi.value = 0;foodController.foodApiCalling(foodController.selectedProductType.value);}
                                // foodController.foodList.value = foodController.foodModel.results.products.where((element) => element.)
                                if (foodController.timeHandle != null) {
                                  foodController.timeHandle!.cancel();
                                }
                                foodController.timeHandle = Timer(
                                    const Duration(milliseconds: 500), () {
                                  foodController.productList.clear();
                                  foodController.foodApiCalling(
                                      foodController.selectedProductType.value);
                                });
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
                          // InkWell(
                          //   onTap: () {
                          //     FocusScope.of(context).requestFocus(FocusNode());
                          //     foodController.pageView.value = 0;
                          //     Get.toNamed(ROUTE_FOOD_FILTER);
                          //   },
                          //   child: SvgPicture.asset(filterIconImage),
                          // ),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              InkWell(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    foodController.pageView.value = 0;
                                    Get.toNamed(ROUTE_FOOD_FILTER);
                                  },
                                  child: SvgPicture.asset(filterIconImage)),
                              Visibility(
                                visible: (foodController
                                            .selectedBrand.value.isNotEmpty &&
                                        foodController.selectedBrand.value !=
                                            allBrands) ||
                                    (foodController.selectedCategory.value
                                            .isNotEmpty &&
                                        foodController.selectedCategory.value !=
                                            allCategories) ||
                                    (foodController.selectedProductType.value
                                            .isNotEmpty &&
                                        foodController
                                                .selectedProductType.value !=
                                            allTypes),
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 1.0, top: 2),
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

                    // Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //     child: Html(
                    //       data: foodController.renderedText.value,
                    //       style: {
                    //         "p": Style(
                    //             color: textColor,
                    //             fontSize: FontSize(14),
                    //             textAlign: TextAlign.justify,
                    //             fontFamily: ROBOTO_FONT,
                    //             fontWeight: FontWeight.w500),
                    //       },
                    //     )
                    // ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              children: foodController.renderedTextWithOkImage(
                                  foodController.renderedText.value))),
                    ),

                    // const SizedBox(
                    //   height: 10,
                    // ),
                    (foodController.isLoading.value)
                        ? Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.2),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )
                        : SizedBox(
                            height: (foodController.selectedProductType.value ==
                                        "Pas Yisroel" ||
                                    foodController.selectedProductType.value ==
                                        "Cholov Yisroel")
                                ? Get.height / 2
                                : (foodController.selectedProductType.value ==
                                        "Yoshon")
                                    ? Get.height / 2.15
                                    : Get.height / 1.32,
                            child: Scrollbar(
                              radius: const Radius.circular(10),
                              child: Column(
                                children: [
                                  if (!foodController.isLoading.value)
                                    (foodController.filtterCategory.value != allCategories ||
                                            foodController.filtterType.value !=
                                                allTypes ||
                                            foodController.filtterBrand.value !=
                                                allBrands ||
                                            foodController.searchTextController
                                                .text.isNotEmpty)
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0, left: 15, right: 15),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Wrap(
                                                alignment: WrapAlignment.start,
                                                runAlignment:
                                                    WrapAlignment.start,
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.start,
                                                spacing: 5,
                                                runSpacing: 5,
                                                children: [
                                                  filterTypesNameBtn(
                                                      onTap: () {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                        //   foodController.filtterCategory .value = allCategories;
                                                        //   foodController.selectedCategory.value = allCategories;
                                                        //         //..products
                                                        //  foodController.filtterType.value = allTypes;
                                                        //  foodController.selectedProductType.value = allTypes;
                                                        //         // ...brand
                                                        //  foodController.filtterBrand.value = allBrands;
                                                        //  foodController.selectedBrand.value = allBrands;
                                                        foodController
                                                            .searchTextController
                                                            .clear();
                                                        foodController
                                                            .productList
                                                            .value = [];
                                                        foodController
                                                            .foodApiCalling(
                                                                foodController
                                                                    .selectedProductType
                                                                    .value)
                                                            .then((value) {
                                                          if (foodController
                                                                      .filtterCategory
                                                                      .value ==
                                                                  allCategories &&
                                                              foodController
                                                                      .filtterType
                                                                      .value ==
                                                                  allTypes &&
                                                              foodController
                                                                      .filtterBrand
                                                                      .value ==
                                                                  allBrands &&
                                                              foodController
                                                                  .searchTextController
                                                                  .text
                                                                  .isEmpty) {
                                                            foodController
                                                                .productList
                                                                .value = [];
                                                            Get.back();
                                                          }
                                                          // if (foodController.filtterType.value ==
                                                          //     allTypes) {
                                                          //   Get.back();
                                                          // }
                                                        });
                                                      },
                                                      data: foodController
                                                          .searchTextController
                                                          .text),
                                                  // Categories......
                                                  if (foodController
                                                          .filtterCategory
                                                          .value
                                                          .isNotEmpty &&
                                                      foodController
                                                              .filtterCategory
                                                              .value !=
                                                          allCategories)
                                                    filterTypesNameBtn(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                          foodController
                                                                  .filtterCategory
                                                                  .value =
                                                              allCategories;
                                                          foodController
                                                                  .selectedCategory
                                                                  .value =
                                                              allCategories;
                                                          foodController
                                                              .productList
                                                              .value = [];
                                                          foodController
                                                              .foodApiCalling(
                                                                  foodController
                                                                      .selectedProductType
                                                                      .value)
                                                              .then((value) {
                                                            if (foodController.filtterCategory.value == allCategories &&
                                                                foodController
                                                                        .filtterType
                                                                        .value ==
                                                                    allTypes &&
                                                                foodController
                                                                        .filtterBrand
                                                                        .value ==
                                                                    allBrands &&
                                                                foodController
                                                                    .searchTextController
                                                                    .text
                                                                    .isEmpty) {
                                                              foodController
                                                                  .productList
                                                                  .value = [];
                                                              Get.back();
                                                            }
                                                          });
                                                        },
                                                        data: foodController
                                                            .filtterCategory
                                                            .value),
                                                  // Types....
                                                  if ((foodController
                                                          .filtterType
                                                          .value
                                                          .isNotEmpty &&
                                                      foodController.filtterType
                                                              .value !=
                                                          allTypes &&
                                                      !(myCategory.contains(
                                                              foodController
                                                                  .filtterType
                                                                  .value) &&
                                                          (foodController
                                                                  .filtterCategory
                                                                  .value
                                                                  .isNotEmpty &&
                                                              foodController
                                                                      .filtterCategory
                                                                      .value !=
                                                                  allCategories))))
                                                    filterTypesNameBtn(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                          if (foodController
                                                              .searchTextController
                                                              .text
                                                              .isEmpty) {
                                                            foodController
                                                                .productList
                                                                .value = [];
                                                          }
                                                          // if (foodController
                                                          //     .searchTextController.text.isEmpty) {
                                                          //   foodController.filtterCategory.value =
                                                          //       allCategories;
                                                          //   foodController.selectedCategory.value =
                                                          //       allCategories;
                                                          //   // ...brand
                                                          //   foodController.filtterBrand.value =
                                                          //       allBrands;
                                                          //   foodController.selectedBrand.value =
                                                          //       allBrands;
                                                          // }
                                                          //..products
                                                          foodController
                                                              .filtterType
                                                              .value = allTypes;
                                                          foodController
                                                              .selectedProductType
                                                              .value = allTypes;
                                                          foodController
                                                              .productList
                                                              .value = [];
                                                          foodController
                                                              .foodApiCalling(
                                                                  foodController
                                                                      .selectedProductType
                                                                      .value)
                                                              .then((value) {
                                                            if (foodController.filtterCategory.value == allCategories &&
                                                                foodController
                                                                        .filtterType
                                                                        .value ==
                                                                    allTypes &&
                                                                foodController
                                                                        .filtterBrand
                                                                        .value ==
                                                                    allBrands &&
                                                                foodController
                                                                    .searchTextController
                                                                    .text
                                                                    .isEmpty) {
                                                              foodController
                                                                  .productList
                                                                  .value = [];
                                                              Get.back();
                                                            }
                                                            // if (foodController.searchTextController
                                                            //     .text.isEmpty) {
                                                            //   Get.back();
                                                            // }
                                                          });
                                                        },
                                                        data: foodController
                                                            .filtterType.value),
                                                  // Brands...
                                                  if (foodController
                                                          .filtterBrand
                                                          .value
                                                          .isNotEmpty &&
                                                      foodController
                                                              .filtterBrand
                                                              .value !=
                                                          allBrands)
                                                    filterTypesNameBtn(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                          foodController
                                                                  .filtterBrand
                                                                  .value =
                                                              allBrands;
                                                          foodController
                                                                  .selectedBrand
                                                                  .value =
                                                              allBrands;
                                                          print(
                                                              "filtterCategory.value :-${foodController.selectedCategory.value}");
                                                          print(
                                                              "filtterBrand.value :-${foodController.selectedBrand.value}");
                                                          print(
                                                              "filtterType.value :-${foodController.selectedProductType.value}");
                                                          foodController
                                                              .productList
                                                              .value = [];
                                                          foodController
                                                              .foodApiCalling(
                                                                  foodController
                                                                      .selectedProductType
                                                                      .value)
                                                              .then((value) {
                                                            if (foodController.filtterCategory.value == allCategories &&
                                                                foodController
                                                                        .filtterType
                                                                        .value ==
                                                                    allTypes &&
                                                                foodController
                                                                        .filtterBrand
                                                                        .value ==
                                                                    allBrands &&
                                                                foodController
                                                                    .searchTextController
                                                                    .text
                                                                    .isEmpty) {
                                                              foodController
                                                                  .productList
                                                                  .value = [];
                                                              Get.back();
                                                            }
                                                          });
                                                        },
                                                        data: foodController
                                                            .filtterBrand
                                                            .value),
                                                ],
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        return await Future.delayed(
                                            const Duration(seconds: 1),
                                            () => foodController
                                                .pagingController
                                                .refresh());
                                      },
                                      child:
                                          PagedListView<int, Product>.separated(
                                        pagingController:
                                            foodController.pagingController,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) =>
                                            const Divider(),
                                        builderDelegate:
                                            PagedChildBuilderDelegate(
                                          animateTransitions: true,
                                          itemBuilder: (context, item, index) {
                                            return
                                                // Obx(
                                                //     () =>
                                                Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0,
                                                  left: 15,
                                                  right: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                        // color: appLightColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0)),
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
                                                            item.brand ?? "",
                                                            style: const TextStyle(
                                                                color:
                                                                    textColor,
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
                                                            item.product ?? "",
                                                            style:
                                                                const TextStyle(
                                                              color: blackColor,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  ROBOTO_FONT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                            "${item.status ?? ""}${(item.passover == "1") ? " | Passover" : ""}${(item.yoshon == "1") ? " | Yoshon " : ""}${(item.cholovYisroel == "1") ? " | Cholov Yisroel " : ""}${(item.pasYisroel == "1") ? " | Pas Yisroel " : ""}${(item.glatt == "1") ? " | Glatt " : ""}${(item.fish == "1") ? " | Fish " : ""}${(item.kitnius == "1") ? " | Kitnius " : ""}",
                                                            style: const TextStyle(
                                                                color:
                                                                    textColor,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    ROBOTO_FONT,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
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
                                            // );
                                          },
                                          noItemsFoundIndicatorBuilder:
                                              (context) => const NoItemsPaged(
                                            title: "No Matching Items Found",
                                            message:
                                                "Please adjust your filters or search terms and try again.",
                                          ),
                                          firstPageErrorIndicatorBuilder:
                                              (context) => NoItemsPaged(
                                                  title: "Something went wrong",
                                                  message: foodController
                                                      .pagingErrorMessage.value,
                                                  onTryAgain: foodController
                                                      .pagingController
                                                      .retryLastFailedRequest),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: (foodController
                                                .selectedProductType.value ==
                                            "Yoshon")
                                        ? 60
                                        : 40,
                                  )
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Obx(
              () => (!foodController.isLoading.value)
                  ? Visibility(
                      visible: foodController.pagingController.itemList?.isNotEmpty ?? false,
                      // visible: foodController.productList.isNotEmpty,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: appColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
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
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 14,
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
}
