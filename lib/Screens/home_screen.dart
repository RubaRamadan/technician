import 'package:flutter/material.dart';
import 'package:golden_test/Core/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBasicColor,
        title: const Text('Tecnician App'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome To Tecnician App',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
