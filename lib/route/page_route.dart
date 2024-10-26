
import 'package:get/get.dart';
import 'package:ok_kosher/binding/alert_binding.dart';
import 'package:ok_kosher/binding/detail_binding.dart';
import 'package:ok_kosher/binding/detail_filter_binding.dart';
import 'package:ok_kosher/binding/food_binding.dart';
import 'package:ok_kosher/binding/home_binding.dart';
import 'package:ok_kosher/binding/link_binding.dart';
import 'package:ok_kosher/screens/alerts_screen.dart';
import 'package:ok_kosher/screens/details_filter_screen.dart';
import 'package:ok_kosher/screens/details_screen.dart';
import 'package:ok_kosher/screens/filter_screen.dart';
import 'package:ok_kosher/screens/food_filter_screen.dart';
import 'package:ok_kosher/screens/food_screen.dart';
import 'package:ok_kosher/screens/home_screen.dart';
import 'package:ok_kosher/screens/link_screen.dart';
import 'package:ok_kosher/utils/contants.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: ROUTE_HOME,
        transition: Transition.noTransition,
        page: () => const HomeScreen(),
        binding: HomeBinding()
    ),
    GetPage(
        name: ROUTE_FILTER,
        transition: Transition.noTransition,
        page: () => const FilterScreen(),
        binding: HomeBinding()
    ),
    GetPage(
        name: ROUTE_Detail,
        transition: Transition.noTransition,
        page: () => const DetailsScreen(),
        binding: DetailBinding()
    ),
    GetPage(
        name: ROUTE_Detail_Filter,
        transition: Transition.noTransition,
        page: () => const DetailsFilterScreen(),
        binding: DetailFilterBinding()
    ),
    GetPage(
        name: ROUTE_LINK,
        transition: Transition.noTransition,
        page: () => const LinkScreen(),
        binding: LinkBinding()
    ),
    GetPage(
        name: ROUTE_ALERT,
        transition: Transition.noTransition,
        page: () => const AlertsScreen(),
        binding: AlertBinding()
    ),
    GetPage(
        name: ROUTE_FOOD,
        transition: Transition.noTransition,
        page: () => const FoodScreen(),
        binding: FoodBinding()
    ),
    GetPage(
        name: ROUTE_FOOD_FILTER,
        transition: Transition.noTransition,
        page: () => const FoodFilterScreen(),
        binding: FoodBinding()
    ),


  ];
}
