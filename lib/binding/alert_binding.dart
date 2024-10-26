import 'package:get/get.dart';
import 'package:ok_kosher/controller/alert_controller.dart';

class AlertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlertController());
  }
}