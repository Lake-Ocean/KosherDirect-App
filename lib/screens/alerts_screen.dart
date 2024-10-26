import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kosher_dart/kosher_dart.dart';
import 'package:ok_kosher/controller/alert_controller.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/contants.dart';
import 'package:ok_kosher/utils/internet_connecting.dart';
import 'package:ok_kosher/utils/store_data.dart';
import 'package:ok_kosher/widgets/appbar_common.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({Key? key}) : super(key: key);

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  ConnectivityController connectivityController = ConnectivityController();
  final alertController = Get.put(AlertController());
  HebrewDateFormatter hebrewDateFormatter = HebrewDateFormatter();
  Timer? timer;
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      Duration difference = DateTime.now()
          .difference(DateTime.parse(getData.read("loadDateTimeAlt")));

      if (difference.inHours >= 6) {
        alertController.alertApiCalling("1");
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
          alertController.alertModelList.clear();
          alertController.pageApi.value = 1;
          return alertController.alertApiCalling(alertController.pageApi.value);
        },
        child: ValueListenableBuilder(
            valueListenable: connectivityController.isConnected,
            builder: (context, value, child) {
              return Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (alertController.alertModelList.isNotEmpty)
                      const SizedBox(
                        height: 20,
                      ),
                    alertController.alertModelList.isEmpty
                        ? Center(
                            heightFactor: 7,
                            child: Column(
                              children: [
                                Text(
                                  alertController.isLoading.value
                                      ? ""
                                      : "Error loading alerts",
                                  // detailsController
                                  //         .restaurantList[0].state ??
                                  //
                                  //     "",
                                  style: const TextStyle(
                                      color: appColor,
                                      fontSize: 16,
                                      fontFamily: ROBOTO_FONT,
                                      fontWeight: FontWeight.w700),
                                ),
                                 const SizedBox(
                                    height: 5,
                                  ),
                                if (!alertController.isLoading.value)
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              side:
                                                  const BorderSide(color: appColor))),
                                      onPressed: () {
                                        alertController.alertModelList.clear();
                                        alertController.pageApi.value = 1;
                                        alertController.alertApiCalling(
                                            alertController.pageApi.value);
                                      },
                                      child: const Text(
                                        "Retry",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: ROBOTO_FONT,
                                            fontWeight: FontWeight.w500),
                                      ))
                              ],
                            ),
                          )
                        : Flexible(
                            child: Scrollbar(
                              radius: const Radius.circular(10),
                              thickness: 6,
                              controller: alertController.controllerListView,
                              child: ListView.builder(
                                controller: alertController.controllerListView,
                                itemCount:
                                    alertController.alertModelList.length,
                                scrollDirection: Axis.vertical,
                                // shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return
                                      // Obx(
                                      //     () =>
                                      Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 0, left: 15, right: 15),
                                    child: InkWell(
                                      onTap: () {
                                        alertController.alertModelList[index]
                                                .detailsOpen =
                                            !alertController
                                                .alertModelList[index]
                                                .detailsOpen!;
                                        alertController.alertModelList
                                            .refresh();
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // height: 110,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                // color: appLightColor,
                                                borderRadius:
                                                    BorderRadius.circular(0)),
                                            child: SizedBox(
                                              width: Get.width * 0.7,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        // "May 18,2023 11:30 AM",
                                                        // alertController.alertModelList[index].date.toString(),
                                                        "${hebrewDateFormatter.format(JewishDate.fromDateTime(alertController.alertModelList[index].date ?? DateTime.now()))} // ${DateFormat('MMM d, yyyy').format(alertController.alertModelList[index].date ?? DateTime.now())}",
                                                        // DateFormat('MMM d, yyyy hh:mm a').format(alertController.alertModelList[index].date).toString(),
                                                        style: const TextStyle(
                                                            color: blackColor,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                ROBOTO_FONT,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          DateFormat('hh:mm a')
                                                              .format(alertController
                                                                      .alertModelList[
                                                                          index]
                                                                      .date ??
                                                                  DateTime
                                                                      .now())
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: blackColor,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  ROBOTO_FONT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),

                                                  RichText(
                                                      text: TextSpan(
                                                    children: alertController
                                                        .title(alertController
                                                            .alertModelList[
                                                                index]
                                                            .title!
                                                            .rendered
                                                            .toString()),
                                                  )),

                                                  // SelectableText(
                                                  //   // "Lorem ipsum dolor sit amet consectetur. Blandit interdum adipiscing.",
                                                  //   // alertController.alertModelList[index].slug.toString().capitalizeFirst!..replaceAll("-", " "),
                                                  //   alertController.alertModelList[index].title.rendered,
                                                  //   style: const TextStyle(
                                                  //       color: textColor,
                                                  //       fontSize: 14,
                                                  //       fontFamily: ROBOTO_FONT,
                                                  //       fontWeight: FontWeight.w400),
                                                  // ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      // setState(() {
                                                      alertController
                                                              .alertModelList[index]
                                                              .detailsOpen =
                                                          !alertController
                                                              .alertModelList[
                                                                  index]
                                                              .detailsOpen!;
                                                      alertController
                                                          .alertModelList
                                                          .refresh();
                                                      // });
                                                    },
                                                    child: const Text(
                                                      "Details",
                                                      style: TextStyle(
                                                          color: appColor,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              ROBOTO_FONT,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          Visibility(
                                            visible: alertController
                                                    .alertModelList[index]
                                                    .detailsOpen ??
                                                false,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                    children: alertController
                                                        .title(alertController
                                                            .alertModelList[
                                                                index]
                                                            .content!
                                                            .rendered
                                                            .toString()),
                                                  )),
                                            ),
                                          ),

                                          // Visibility(
                                          //   visible: alertController.alertModelList[index].detailsOpen ?? false,
                                          //   child: Html(
                                          //   data:  alertController.alertModelList[index].content.rendered.toString(),
                                          //
                                          //     style: {
                                          //   "p": Style(
                                          //       color: blackColor,
                                          //       fontSize: FontSize(14),
                                          //       fontFamily: ROBOTO_FONT,
                                          //       textAlign: TextAlign.justify,
                                          //       fontWeight: FontWeight.w400),
                                          //   }
                                          //   ),
                                          // ),
                                          const Divider(),
                                        ],
                                      ),
                                    ),
                                  );
                                  // );
                                },
                              ),
                            ),
                          ),
                    if (alertController.isLoading.value)
                      const Center(
                          child: CircularProgressIndicator(
                        color: appColor,
                      ))
                  ],
                ),
              );
            }),
      ),
    );
  }
}
