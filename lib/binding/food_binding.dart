import 'package:get/get.dart';
import 'package:ok_kosher/controller/food_controller.dart';

class FoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodController());
  }
}