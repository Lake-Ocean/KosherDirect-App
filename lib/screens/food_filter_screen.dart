import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/controller/food_controller.dart';
import 'package:ok_kosher/utils/app_text.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/widgets/button_common.dart';

import '../utils/contants.dart';

class FoodFilterScreen extends StatelessWidget {
  const FoodFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foodController = Get.put(FoodController());
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: const SizedBox(
                    width: 50,
                  ),
                  title: const Center(
                    child: Text(
                      filter,
                      style: TextStyle(
                          color: appColor,
                          fontSize: 20,
                          fontFamily: ROBOTO_FONT,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    filterTitle(
                      category,
                      0,
                      () {
                        foodController.pageController.jumpToPage(0);
                      },
                    ),
                    filterTitle(
                      productType,
                      1,
                      () {
                        foodController.pageController.jumpToPage(1);
                      },
                    ),
                    filterTitle(
                      brand,
                      2,
                      () {
                        foodController.pageController.jumpToPage(2);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Flexible(
                  child: PageView(
                    controller: foodController.pageController,
                    onPageChanged: (val) {
                      foodController.pageView.value = val;
                    },
                    children: [
                      ListView.builder(
                        // shrinkWrap: true,
                        itemCount: foodController.allCategory.length,
                        // physics: const NeverScrollableScrollPhysics(),
                        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 2,
                        //     childAspectRatio: 3,
                        //     mainAxisSpacing: 4,
                        //     crossAxisSpacing: 4
                        // ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemBuilder: (context, index) {
                          return Obx(
                            () => titleCheckBox(
                                title: foodController.allCategory[index],
                                value: foodController.selectedCategory.value ==
                                    foodController.allCategory[index],
                                onTap: () {
                                  // if(homeController.selectedCategory.value == homeController.allCategory[index]){
                                  //   homeController.selectedCategory.value = "";
                                  // } else {
                                  foodController.selectedCategory.value =
                                      foodController.allCategory[index];
                                  foodController.filtterCategory.value =
                                      foodController.allCategory[index];
                                  foodController.productList.clear();
                                  foodController.foodApiCalling(foodController.selectedProductType.value);
                                  Get.back();
                                  // }
                                }),
                          );
                        },
                      ),
                      ListView.builder(
                        // shrinkWrap: true,
                        itemCount: foodController.itemsForFilter.length,
                        // physics: const NeverScrollableScrollPhysics(),
                        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 2,
                        //     childAspectRatio: 3,
                        //     mainAxisSpacing: 4,
                        //     crossAxisSpacing: 4
                        // ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemBuilder: (context, index) {
                          return Obx(
                            () => Column(
                              children: [
                                titleCheckBox(
                                    title: foodController.itemsForFilter[index],
                                    value:
                                        foodController.selectedProductType.value ==
                                            foodController.itemsForFilter[index],
                                    onTap: () {
                                      // homeController.selectedProductType.value = homeController.items[index].name.toString();
                                      // if(homeController.selectedProductType.value == homeController.itemsForFilter[index]){
                                      //   homeController.selectedProductType.value = "";
                                      // } else {
                                      foodController.selectedProductType.value =
                                          foodController.itemsForFilter[index]
                                              .toString();
                                      foodController.filtterType.value =
                                          foodController.itemsForFilter[index]
                                              .toString();
                                      foodController.productList.clear();
                                      foodController.foodApiCalling(
                                          foodController.selectedProductType.value);
                                      Get.back();
                                      // }
                                    }),
                              ],
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        // shrinkWrap: true,
                        itemCount: foodController.allBrand.length,
                        // physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemBuilder: (context, index) {
                          return Obx(
                            () => titleCheckBox(
                                title: foodController.allBrand[index],
                                value: foodController.selectedBrand.value ==
                                    foodController.allBrand[index],
                                onTap: () {
                                  // homeController.selectedBrand.value = homeController.allBrand[index];
                                  // if(homeController.selectedBrand.value == homeController.allBrand[index]){
                                  //   homeController.selectedBrand.value = "";
                                  // } else {
                                  foodController.selectedBrand.value =
                                      foodController.allBrand[index];
                                   foodController.filtterBrand.value = foodController.allBrand[index];
                                  foodController.productList.clear();
                                  foodController.foodApiCalling(
                                      foodController.selectedProductType.value);
                                  Get.back();
                                  // }
                                }),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, top: 10),
        child: ButtonCommon(
          onPressed: () {
            foodController.productList.clear();
            foodController
                .foodApiCalling(foodController.selectedProductType.value);
            Get.back();
          },
          buttonName: showResult,
        ),
      ),
    );
  }

  Widget filterTitle(text, int number, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 46,
        width: (Get.width - 50) / 3,
        decoration: BoxDecoration(
          color: Get.put(FoodController()).pageView.value == number
              ? appColor
              : checkboxColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Get.put(FoodController()).pageView.value == number
                    ? whiteColor
                    : appColor,
                fontSize: 14,
                fontFamily: ROBOTO_FONT,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Widget headerText(text) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Text(
        text,
        style: const TextStyle(
            color: appColor,
            fontSize: 18,
            fontFamily: ROBOTO_FONT,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget textCommon(text) {
    return Text(
      text.toString(),
      style: const TextStyle(
          color: blackColor,
          fontSize: 14,
          fontFamily: ROBOTO_FONT,
          fontWeight: FontWeight.w400),
    );
  }

  Widget checkBoxCustom({required bool value, required Function onTap}) {
    return InkWell(
      onTap: () {
        // value = !value;
        onTap();
      },
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: value ? appColor : checkboxColor, shape: BoxShape.circle),
        child: value
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: whiteColor,
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget titleCheckBox(
      {required title, required bool value, required Function onTap}) {
    return Column(
      children: [
        const Divider(),
        InkWell(
          onTap: () {
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(child: textCommon(title)),
                const SizedBox(
                  width: 30,
                ),
                checkBoxCustom(
                  value: value,
                  onTap: () {
                    onTap();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
