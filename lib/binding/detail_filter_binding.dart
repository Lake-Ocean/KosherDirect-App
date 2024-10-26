import 'package:get/get.dart';
import 'package:ok_kosher/controller/details_controller.dart';

class DetailFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsController());
  }
}