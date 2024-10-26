// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/utils/app_text.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/contants.dart';
import 'package:ok_kosher/utils/images_path.dart';
import 'package:ok_kosher/widgets/appbar_common.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkScreen extends StatelessWidget {
  const LinkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCommon(visibleBackButton: true, onTap: () {}),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: linkBox(okLinkImage, wwwOKOrg, () {
                    launch("http://www.okkosher.org");
                  }),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: linkBox(guideImage, vegetableCheckingGuide, () {
                    launch("http://www.okkosher.org/kosherspirit/");
                  }),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: linkBox(spiritImage, kosherSpiritMagazine, () {
                    launch(
                        "http://www.okkosher.org/consumers/your-kosher-kitchen/ok-vegetable-food-checking-guide/");
                  }),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: SizedBox(
                  height: 140,
                  width: Get.width / 2,
                ))
              ],
            )
            // Wrap(
            //   crossAxisAlignment: WrapCrossAlignment.center,
            //         children: [
            //           linkBox(okLinkImage, wwwOKOrg, (){
            //             launch("http://www.okkosher.org");
            //           }),
            //           linkBox(guideImage, vegetableCheckingGuide, (){
            //             launch("http://www.okkosher.org/kosherspirit/");
            //           }),
            //           linkBox(spiritImage, kosherSpiritMagazine, (){
            //             launch("http://www.okkosher.org/consumers/your-kosher-kitchen/ok-vegetable-food-checking-guide/");
            //           }),

            //         ],
            //       ),
          ],
        ),
      ),
    );
  }

  Widget linkBox(imageName, text, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 150,
        width: Get.width / 2,
        decoration: BoxDecoration(
          color: lightGrayColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Container(
              height: 97,
              decoration: BoxDecoration(
                  color: lightGrayColor,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: AssetImage(imageName), fit: BoxFit.fill)),
              // child: Image.asset(imageName, fit: BoxFit.fill),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: blackColor,
                  fontSize: 12,
                  fontFamily: ROBOTO_FONT,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
