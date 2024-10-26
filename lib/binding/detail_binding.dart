import 'package:get/get.dart';
import 'package:ok_kosher/controller/details_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsController());
  }
}