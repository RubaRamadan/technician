import 'package:flutter/material.dart';
import 'package:golden_test/Screens/Auth/sign_up_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate=false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child:   Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                bottom:animate? 300 :-170,
                child: const Logo())
          ],
        ),
      ),
    );
  }

  Future startAnimation() async{
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {animate=true;});
    await Future.delayed(const Duration(milliseconds: 1000));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const SignUpScreen()),
              (Route<dynamic> route) => false);

  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
              height: 150,
              width: 150,
              child: Image.asset('assets/images/logo.png')),
          const Text('Technician App',style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),)
        ],
      ),
    );
  }
}