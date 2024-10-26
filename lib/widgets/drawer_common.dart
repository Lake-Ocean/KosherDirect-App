// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ok_kosher/utils/app_text.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/contants.dart';
import 'package:ok_kosher/utils/images_path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/home_controller.dart';

// final advancedDrawerController = AdvancedDrawerController();
// ignore: must_be_immutable
class DrawerCommon extends StatefulWidget {
  Widget child;
  AdvancedDrawerController advancedDrawerController;
  DrawerCommon(
      {Key? key, required this.child, required this.advancedDrawerController})
      : super(key: key);

  @override
  State<DrawerCommon> createState() => _DrawerCommonState();
}

class _DrawerCommonState extends State<DrawerCommon> {
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: RadialGradient(
            center: Alignment(0.0, 0.0),
            radius: 0.6,
            // begin: Alignment.center,
            // end: Alignment.bottomLeft,
            colors: [appColor, splashShade],
          )),
          child: SafeArea(
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.end,
              alignment: Alignment.centerRight,
              children: [
                Container(
                  height: Get.height * 0.6,
                  width: 130,
                  decoration: BoxDecoration(
                      color: whiteColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: ListTile(
                    onTap: () {
                      widget.advancedDrawerController.hideDrawer();
                    },
                    trailing: const Icon(
                      Icons.clear,
                      color: whiteColor,
                    ),
                    title: const Text(
                      menu,
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 16,
                          fontFamily: ROBOTO_FONT,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        controller: widget.advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        openScale: 0.77,
        openRatio: 0.64,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 0.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        drawer: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 200,
              ),
              ListTile(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  homeController.searchTextController.clear();
                  // ...categories
                  homeController.filtterCategory.value = allCategories;
                  homeController.selectedCategory.value = allCategories;
                  //..products
                  homeController.filtterType.value = allTypes;
                  homeController.selectedProductType.value = allTypes;
                  // ...brand
                  homeController.filtterBrand.value = allBrands;
                  homeController.selectedBrand.value = allBrands;
                  // homeController.searchApiCalling();
                  homeController.productList.value = [];
                  widget.advancedDrawerController.hideDrawer();
                  setState(() {});
                  // Get.toNamed(ROUTE_HOME);
                },
                leading: const Icon(Icons.home_filled),
                title: const Text(
                  "Home",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                      fontFamily: ROBOTO_FONT,
                      fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Get.toNamed(ROUTE_Detail);
                },
                leading: SvgPicture.asset(restaurantIconImage),
                title: const Text(
                  restaurant,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                      fontFamily: ROBOTO_FONT,
                      fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Get.toNamed(ROUTE_ALERT);
                },
                leading: SvgPicture.asset(alertsIconImage),
                title: const Text(
                  alerts,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                      fontFamily: ROBOTO_FONT,
                      fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                onTap: () {
                  launch("https://www.ok.org/contact/?tab=4");
                },
                leading: SvgPicture.asset(
                  okLogoImage,
                  height: 30,
                ),
                title: const Text(
                  reportOKSymbol,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                      fontFamily: ROBOTO_FONT,
                      fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Get.toNamed(ROUTE_LINK);
                },
                leading: SvgPicture.asset(linksIconImage),
                title: const Text(
                  links,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                      fontFamily: ROBOTO_FONT,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
