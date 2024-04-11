
import 'package:get/get.dart';

import 'lonlat_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
   Get.put(LonLatController());
  }
}