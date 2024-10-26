import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ok_kosher/controller/details_controller.dart';
import 'package:ok_kosher/utils/app_text.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/widgets/button_common.dart';

import '../utils/contants.dart';

class DetailsFilterScreen extends StatelessWidget {
  const DetailsFilterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final detailsController = Get.put(DetailsController());
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 37,
              ),
              headerText(stateCountry),
              const SizedBox(
                height: 20,
              ),
              titleCheckBox(
                title: viewAll,
                value: viewAll == detailsController.selectedCounty.value,
                onTap: () {
                  detailsController.selectedCounty.value = viewAll;
                  // setState(() { });
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: detailsController.stateCountryNameList.length,
                itemBuilder: (context, index) {
                  return titleCheckBox(
                      title: detailsController.stateCountryNameList[index],
                      value: detailsController.stateCountryNameList[index] ==
                          detailsController.selectedCounty.value,
                      onTap: () {
                        detailsController.selectedCounty.value =
                            detailsController.stateCountryNameList[index];
                        // setState(() { });
                      });
                },
              ),
              const Spacer(),
              ButtonCommon(
                  onPressed: () {
                    Get.back();
                    detailsController.filterRestaurantList(
                        detailsController.selectedCounty.value);
                  },
                  buttonName: showResult),
              const SizedBox(
                height: 20,
              ),
            ],
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
        height: 24,
        width: 24,
        decoration: BoxDecoration(
            color: value ? blackColor : checkboxColor,
            borderRadius: BorderRadius.circular(4)),
        child: value
            ? const Icon(
                Icons.check,
                color: whiteColor,
                size: 18,
              )
            : null,
      ),
    );
  }

  Widget titleCheckBox(
      {required title, required bool value, required Function onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 15),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            checkBoxCustom(
                value: value,
                onTap: () {
                  onTap();
                }),
            const SizedBox(
              width: 15,
            ),
            textCommon(title),
          ],
        ),
      ),
    );
  }
}
