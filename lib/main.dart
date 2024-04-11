import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golden_test/Screens/splash_screen.dart';

import 'Controller/LonLatController/lonlat_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    LonLatController productController=Get.put(LonLatController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
          fontFamily: 'Cairo'
      ),
      home: const SplashScreen(),
    );
  }
}

