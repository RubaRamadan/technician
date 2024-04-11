import 'package:get/get.dart';


class LonLatController extends GetxController {
  double long = 0.0;
  double lat = 0.0;
  setLongLatValue(double lon,double la) {
    long = lon;
    lat = la;
    update();
  }
}
