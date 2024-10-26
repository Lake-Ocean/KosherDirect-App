import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/controller/alert_controller.dart';
import 'package:ok_kosher/screens/home_screen.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/images_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      Get.put(AlertController()).onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            gradient: RadialGradient(
          center: Alignment(0.0, 0.0),
          radius: 0.6,
          colors: [appColor, splashShade],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: Get.height * 0.25,
                child: SvgPicture.asset(splashTopImage,
                    fit: BoxFit.fitWidth, alignment: Alignment.topCenter)),
            SvgPicture.asset(okLogoImage),
            SizedBox(
                height: Get.height * 0.25,
                child: SvgPicture.asset(
                  splashBottomImage,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                )),
          ],
        ));
  }
}
