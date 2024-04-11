import 'package:flutter/material.dart';

import '../Core/colors.dart';


class ReusableBg extends StatelessWidget {
  const ReusableBg({super.key});

  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        Positioned(
            left: -80,
            top: -80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: kSecondaryColor,
                  radius: 150,
                ),
                CircleAvatar(
                  backgroundColor: kThirdColor,
                  radius: 100,
                ),
              ],
            )),
        Positioned(
            right: -40,
            top: 270,
            child: CircleAvatar(
              backgroundColor: kThirdColor,
              radius: 40,
            )),
        Positioned(
            left: -40,
            top: 500,
            child: CircleAvatar(
              backgroundColor: kThirdColor,
              radius: 40,
            )),
        Positioned(
            right: -80,
            bottom: -80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: kSecondaryColor,
                  radius: 150,
                ),
                CircleAvatar(
                  backgroundColor: kThirdColor,
                  radius: 100,
                ),
              ],
            )),
      ],
    );
  }
}
