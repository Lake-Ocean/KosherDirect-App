import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/contants.dart';

// ignore: must_be_immutable
class ButtonCommon extends StatelessWidget {
  Function onPressed;
  String buttonName;
  ButtonCommon({Key? key, required this.onPressed, required this.buttonName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {  
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
            // foregroundColor: appColor,
            backgroundColor: appColor,
            fixedSize: Size(Get.width, 46),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          buttonName,
          style: const TextStyle(
              color: whiteColor,
              fontSize: 14,
              fontFamily: ROBOTO_FONT,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
