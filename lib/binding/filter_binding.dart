import 'package:get/get.dart';
import 'package:ok_kosher/controller/home_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}