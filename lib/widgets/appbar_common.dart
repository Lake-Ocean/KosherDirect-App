
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/images_path.dart';

PreferredSizeWidget appbarCommon({Function()? onTap, required bool visibleBackButton}) {
  return AppBar(
    leading: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap:visibleBackButton ? (){Get.back();} : onTap ??
                  () {
                // Get.back();
              },
          child: visibleBackButton ? const Icon(Icons.arrow_back, color: blackColor,) : SvgPicture.asset(menuIconImage, height: 30,),
        ),
      ],
    ),
    title: Image.asset(logoPngImage, height: 35, width: 115,),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.transparent,
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
  );
}
