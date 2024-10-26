import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/controller/home_controller.dart';
import 'package:ok_kosher/utils/app_text.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/widgets/button_common.dart';

import '../utils/contants.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Padding(
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
                            text: category,
                            number: 0,
                            onTap: () {
                              homeController.pageController.jumpToPage(0);
                            },
                          ),
                          filterTitle(
                            text: productType,
                            number: 1,
                            onTap: () {
                              homeController.pageController.jumpToPage(1);
                            },
                          ),
                          filterTitle(
                            text: brand,
                            number: 2,
                            onTap: () {
                              homeController.pageController.jumpToPage(2);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Flexible(
                        child: PageView(
                          controller: homeController.pageController,
                          onPageChanged: (val) {
                            homeController.pageView.value = val;
                          },
                          children: [
                            ListView.builder(
                              // shrinkWrap: true,
                              itemCount: homeController.allCategory.length,
                              // physics: const NeverScrollableScrollPhysics(),
                              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 2,
                              //     childAspectRatio: 3,
                              //     mainAxisSpacing: 4,
                              //     crossAxisSpacing: 4
                              // ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => titleCheckBox(
                                      title: homeController.allCategory[index],
                                      value: homeController
                                              .selectedCategory.value ==
                                          homeController.allCategory[index],
                                      onTap: () {
                                        // if(homeController.selectedCategory.value == homeController.allCategory[index]){
                                        //   homeController.selectedCategory.value = "";
                                        // } else {0
                                        homeController.selectedCategory.value =
                                            homeController.allCategory[index];
                                        homeController.filtterCategory.value =
                                            homeController.allCategory[index];
                                        homeController.productList.clear();
                                        homeController.pg.value = 1;
                                        homeController.searchApiCalling();
                                        Get.back();
                                        // }
                                      }),
                                );
                              },
                            ),
                            ListView.builder(
                              // shrinkWrap: true,
                              itemCount: homeController.itemsForFilter.length,
                              // physics: const NeverScrollableScrollPhysics(),
                              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 2,
                              //     childAspectRatio: 3,
                              //     mainAxisSpacing: 4,
                              //     crossAxisSpacing: 4
                              // ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => titleCheckBox(
                                      title:
                                          homeController.itemsForFilter[index],
                                      value: homeController
                                              .selectedProductType.value ==
                                          homeController.itemsForFilter[index],
                                      onTap: () {
                                        // homeController.selectedProductType.value = homeController.items[index].name.toString();
                                        // if(homeController.selectedProductType.value == homeController.itemsForFilter[index]){
                                        //   homeController.selectedProductType.value = "";
                                        // } else {
                                        homeController.selectedProductType.value =
                                            homeController.itemsForFilter[index]
                                                .toString();
                                        homeController.filtterType.value =
                                            homeController.itemsForFilter[index]
                                                .toString();
                                        homeController.productList.clear();
                                        homeController.pg.value = 1;
                                        homeController.searchApiCalling();
                                        Get.back();
                                        // }
                                      }),
                                );
                              },
                            ),
                            ListView.builder(
                              // shrinkWrap: true,
                              itemCount: homeController.allBrand.length,
                              // physics: const NeverScrollableScrollPhysics(),
                              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 2,
                              //     childAspectRatio: 3,
                              //     mainAxisSpacing: 4,
                              //     crossAxisSpacing: 4
                              // ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => titleCheckBox(
                                      title: homeController.allBrand[index],
                                      value: homeController.selectedBrand.value == homeController.allBrand[index],
                                      onTap: () {
                                        // homeController.selectedBrand.value = homeController.allBrand[index];
                                        // if(homeController.selectedBrand.value == homeController.allBrand[index]){
                                        //   homeController.selectedBrand.value = "";
                                        // } else {
                                        homeController.selectedBrand.value =
                                            homeController.allBrand[index];
                                        homeController.filtterBrand.value =
                                            homeController.allBrand[index];
                                        // }
                                        homeController.productList.clear();
                                        homeController.pg.value = 1;
                                        homeController.searchApiCalling();
                                        Get.back();
                                      }),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            //     ListView(
            //   // crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //
            //     ListTile(
            //       titleAlignment: ListTileTitleAlignment.center,
            //       leading: const SizedBox(
            //         width: 50,
            //       ),
            //       title: const Center(
            //         child: Text(
            //           filter,
            //           style: TextStyle(
            //               color: appColor,
            //               fontSize: 20,
            //               fontFamily: ROBOTO_FONT,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //       trailing: IconButton(
            //         onPressed: () {
            //           Get.back();
            //         },
            //         icon: const Icon(Icons.clear),
            //       ),
            //     ),
            //     const SizedBox(
            //       height: 37,
            //     ),
            //     headerText(category),
            //     const SizedBox(
            //       height: 20,
            //     ),
            //     GridView.builder(
            //       shrinkWrap: true,
            //       itemCount: homeController.allCategory.length,
            //       physics: const NeverScrollableScrollPhysics(),
            //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2,
            //           childAspectRatio: 3,
            //           mainAxisSpacing: 4,
            //           crossAxisSpacing: 4
            //       ),
            //       padding: const EdgeInsets.symmetric(horizontal: 15),
            //       itemBuilder: (context, index) {
            //         return Obx(
            //               ()=> titleCheckBox(
            //               title: homeController.allCategory[index],
            //               value: homeController.selectedCategory == homeController.allCategory[index],
            //               onTap: () {
            //                 if(homeController.selectedCategory.value == homeController.allCategory[index]){
            //                   homeController.selectedCategory.value = "";
            //                 } else {
            //                   homeController.selectedCategory.value = homeController.allCategory[index];
            //                 }
            //               }),
            //         );
            //       },
            //     ),
            //     const SizedBox(
            //       height: 10,
            //     ),
            //     headerText(productType),
            //     const SizedBox(
            //       height: 20,
            //     ),
            //
            //     GridView.builder(
            //         shrinkWrap: true,
            //         itemCount: homeController.items.length,
            //         physics: const NeverScrollableScrollPhysics(),
            //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 2,
            //             childAspectRatio: 3,
            //             mainAxisSpacing: 4,
            //             crossAxisSpacing: 4
            //         ),
            //         padding: const EdgeInsets.symmetric(horizontal: 15),
            //         itemBuilder: (context, index) {
            //           return Obx(
            //                 ()=> titleCheckBox(
            //                 title: homeController.items[index].name,
            //                 value: homeController.selectedProductType.value == homeController.items[index].name,
            //                 onTap: () {
            //                   // homeController.selectedProductType.value = homeController.items[index].name.toString();
            //                   if(homeController.selectedProductType.value == homeController.items[index].name){
            //                     homeController.selectedProductType.value = "";
            //                   } else {
            //                     homeController.selectedProductType.value = homeController.items[index].name.toString();
            //                   }
            //                 }),
            //           );
            //         },
            //     ),
            //     const SizedBox(
            //       height: 10,
            //     ),
            //     headerText(brand),
            //     const SizedBox(
            //       height: 20,
            //     ),
            //
            //     GridView.builder(
            //       shrinkWrap: true,
            //       itemCount: homeController.allBrand.length,
            //       physics: const NeverScrollableScrollPhysics(),
            //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2,
            //           childAspectRatio: 3,
            //           mainAxisSpacing: 4,
            //           crossAxisSpacing: 4
            //       ),
            //       padding: const EdgeInsets.symmetric(horizontal: 15),
            //       itemBuilder: (context, index) {
            //         return Obx(
            //               ()=> titleCheckBox(
            //               title: homeController.allBrand[index],
            //               value: homeController.selectedBrand == homeController.allBrand[index],
            //               onTap: () {
            //                 // homeController.selectedBrand.value = homeController.allBrand[index];
            //                 if(homeController.selectedBrand.value == homeController.allBrand[index]){
            //                   homeController.selectedBrand.value = "";
            //                 } else {
            //                   homeController.selectedBrand.value = homeController.allBrand[index];
            //                 }
            //               }),
            //         );
            //       },
            //     ),
            //     const SizedBox(
            //       height: 20,
            //     ),
            //   ],
            // ),
            ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, top: 10),
        child: ButtonCommon(
          onPressed: () {
            // homeController.productList.clear();
            homeController.pg.value = 1;
            homeController.searchApiCalling();
            Get.back();
          },
          buttonName: showResult,
        ),
      ),
    );
  }

  Widget filterTitle({text, required int number, required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 46,
        width: (Get.width - 50) / 3,
        decoration: BoxDecoration(
          color: Get.put(HomeController()).pageView.value == number
              ? appColor
              : checkboxColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Get.put(HomeController()).pageView.value == number
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
      text,
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
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
