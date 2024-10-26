// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/controller/details_controller.dart';
import 'package:ok_kosher/utils/app_text.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/contants.dart';
import 'package:ok_kosher/utils/images_path.dart';
import 'package:ok_kosher/utils/internet_connecting.dart';
import 'package:ok_kosher/utils/store_data.dart';
import 'package:ok_kosher/widgets/appbar_common.dart';
import 'package:ok_kosher/widgets/inputField.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final detailsController = Get.put(DetailsController());

  // detailsController.onInit();
  ConnectivityController connectivityController = ConnectivityController();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    if (detailsController.restaurantList == []) {
      detailsController.isLoading.value = true;
      setState(() {});
      detailsController.onInit();
    }
    timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      Duration difference = DateTime.now()
          .difference(DateTime.parse(getData.read("loadDateTimeRes")));
      print(difference.inHours);

      if (difference.inHours >= 6) {
        detailsController.detailsApiCalling().then((value) {
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon(visibleBackButton: true, onTap: () {}),
      body: RefreshIndicator(
        onRefresh: () {
          return detailsController.detailsApiCalling();
        },
        child: ValueListenableBuilder(
            valueListenable: connectivityController.isConnected,
            builder: (context, value, child) {
              return Obx(
                () => detailsController.isLoading.value &&
                        detailsController.restaurantList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: CommonTextFormFields(
                                    color: lightGrayColor1,
                                    onTap: () {
                                      detailsController.searchListOpen.value =
                                          true;
                                    },
                                    hintTxt: searchRestaurant,
                                    onChanged: (val) {
                                      detailsController.restaurantList.value =
                                          detailsController.detailsModelData!
                                              .results!.restaurants!
                                              .where((p0) => p0.name!
                                                  .toLowerCase()
                                                  .contains(val.toLowerCase()))
                                              .toList();
                                    },
                                    icon: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                InkWell(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    Get.toNamed(ROUTE_Detail_Filter);
                                  },
                                  child: SvgPicture.asset(filterIconImage),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              // ignore: invalid_use_of_protected_member
                              "${detailsController.restaurantList.value.length} $restaurant",
                              style: const TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                  fontFamily: ROBOTO_FONT,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (detailsController.restaurantList.isEmpty &&
                              detailsController.isNotAv.value)
                            Center(
                              heightFactor: 3,
                              child: Column(
                                children: [
                                  const Text(
                                    "Error loading restaurants", // detailsController.restaurantList[0].state ?? "",
                                    style: TextStyle(
                                        color: appColor,
                                        fontSize: 16,
                                        fontFamily: ROBOTO_FONT,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            side: const BorderSide(
                                                color: appColor))),
                                    onPressed: () {
                                      detailsController.restaurantList.clear();
                                      detailsController.detailsApiCalling();
                                    },
                                    child: const Text(
                                      "Retry",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: ROBOTO_FONT,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            )
                          else
                            Flexible(
                              child: Scrollbar(
                                controller: detailsController.scrollController,
                                radius: const Radius.circular(10),
                                thickness: 8,
                                // isAlwaysShown: true,
                                child: ListView.builder(
                                  controller:
                                      detailsController.scrollController,
                                  itemCount:
                                      detailsController.restaurantList.length,
                                  scrollDirection: Axis.vertical,
                                  // shrinkWrap: true,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return
                                        // Obx(() =>
                                        Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 0, left: 15, right: 15),
                                      child: InkWell(
                                        onTap: () async {
                                          String appleUrl =
                                              'https://maps.apple.com/?sll=${double.parse(detailsController.restaurantList[index].latitude.toString())},${double.parse(detailsController.restaurantList[index].longitude.toString())}';
                                          String googleUrl =
                                              'https://www.google.com/maps/search/?api=1&query=${double.parse(detailsController.restaurantList[index].latitude.toString())},${double.parse(detailsController.restaurantList[index].longitude.toString())}';
                                          // if (await canLaunch(googleUrl)) {
                                          if (Platform.isAndroid) {
                                            await launch(googleUrl);
                                          } else if (Platform.isIOS) {
                                            await launch(appleUrl);
                                          }
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (index == 0)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.0, bottom: 10),
                                                child: Text(
                                                  detailsController.statesVal
                                                      .where((element) =>
                                                          element.value
                                                              .toLowerCase() ==
                                                          detailsController
                                                              .restaurantList[0]
                                                              .state!
                                                              .toLowerCase())
                                                      .first
                                                      .name,
                                                  // detailsController.restaurantList[0].state ??"",
                                                  style: const TextStyle(
                                                      color: blackColor,
                                                      fontSize: 16,
                                                      fontFamily: ROBOTO_FONT,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            if (index > 0)
                                              if (detailsController
                                                      .restaurantList[index - 1]
                                                      .state !=
                                                  detailsController
                                                      .restaurantList[index]
                                                      .state)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0,
                                                          top: 14,
                                                          bottom: 6),
                                                  child: Text(
                                                    // detailsController.restaurantList[index].country ??"",
                                                    detailsController.statesVal
                                                        .where((element) =>
                                                            element.value ==
                                                            (detailsController
                                                                    .restaurantList[
                                                                        index]
                                                                    .state ??
                                                                detailsController
                                                                    .restaurantList[
                                                                        index]
                                                                    .state))
                                                        .first
                                                        .name,
                                                    style: const TextStyle(
                                                        color: blackColor,
                                                        fontSize: 16,
                                                        fontFamily: ROBOTO_FONT,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                            const Divider(),
                                            Container(
                                              // height: 110,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                // color: appLightColor,
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                              ),
                                              child: Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width - 135,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              detailsController
                                                                      .restaurantList[
                                                                          index]
                                                                      .name ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  color:
                                                                      blackColor,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      ROBOTO_FONT,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              "${detailsController.restaurantList[index].address!} ${detailsController.restaurantList[index].city!} ${detailsController.restaurantList[index].state!}, ${detailsController.restaurantList[index].postalCode!}",
                                                              style: const TextStyle(
                                                                  color:
                                                                      addressTextColor,
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      ROBOTO_FONT,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              detailsController
                                                                      .restaurantList[
                                                                          index]
                                                                      .certification ??
                                                                  "",
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
                                                                height: 4),
                                                            Text(
                                                              // "1,341 Miles",
                                                              // "${detailsController.getDistanceFromGPSPointsInRoute(detailsController.currentLat!.value, detailsController.currentLong!.value, double.parse(detailsController.restaurantList[index].latitude.toString()), double.parse(detailsController.restaurantList[index].longitude.toString())).toStringAsFixed(2)} Miles",
                                                              "${detailsController.restaurantList[index].distance?.toStringAsFixed(2)} Miles",
                                                              style: const TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      ROBOTO_FONT,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 8.0,
                                                                bottom: 10,
                                                                top: 10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      // final call = Uri.parse("tel:${detailsController.restaurantList[index].phone ?? "0"}");
                                                                      var url =
                                                                          "tel:${detailsController.restaurantList[index].phone ?? "0"}";
                                                                      // if (await canLaunch(url)) {
                                                                      print(
                                                                          url);
                                                                      await launch(url).catchError(
                                                                          // ignore: body_might_complete_normally_catch_error
                                                                          (val) {
                                                                        if (kDebugMode) {
                                                                          print(
                                                                              "Error :- Error $val");
                                                                        }
                                                                      });
                                                                      // } else {
                                                                      // throw 'Could not launch $url';
                                                                      // }
                                                                    },
                                                                    child: SvgPicture
                                                                        .asset(
                                                                            callingImage)),
                                                                IconButton(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5),
                                                                  onPressed:
                                                                      () async {
                                                                    String url = detailsController
                                                                        .restaurantList[
                                                                            index]
                                                                        .certificateUrl
                                                                        .toString();
                                                                    if (await canLaunch(
                                                                        url)) {
                                                                      await launch(
                                                                        url,
                                                                        headers: {
                                                                          "Content-Type":
                                                                              "application/pdf",
                                                                          "Content-Disposition":
                                                                              "inline"
                                                                        },
                                                                      );
                                                                      print(
                                                                          "browser url");
                                                                      print(
                                                                          url);
                                                                    } else {
                                                                      // can't launch url, there is some error
                                                                      throw "Could not launch $url";
                                                                    }
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .picture_as_pdf),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0),
                                                    child: SizedBox(
                                                      // width: Get.width * 0.22,
                                                      width: 100,
                                                      child: Text(
                                                        detailsController
                                                                .restaurantList[
                                                                    index]
                                                                .type ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 3,
                                                        style: const TextStyle(
                                                            color: appColor,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                ROBOTO_FONT,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                    // );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
              );
            }),
      ),
    );
  }
}
