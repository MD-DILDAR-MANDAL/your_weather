import 'package:flutter/material.dart';

class Constants {
  final primaryColor = Color(0xffE08019);
  final secondaryColor = const Color(0xffCF9D67);
  final tertiaryColor = const Color(0xffA15F19);
  final blackColor = const Color(0xff000000);

  final greyColor = const Color(0xffA17A50);

  final Shader shader = const LinearGradient(
    colors: <Color>[Color(0xffA17A50), Color(0xffA15F19)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final linearGradientBlue = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.topLeft,
    colors: [Color(0xffCF9D67), Color(0xffA15F19)],
    stops: [0.0, 1.0],
  );

  final linearGradientPurple = const LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xff51087e), Color.fromARGB(255, 120, 1, 195)],
    stops: [0.0, 1.0],
  );
}
