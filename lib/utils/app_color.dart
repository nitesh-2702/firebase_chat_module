import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF4E79FA);
  static const black3E = Color(0xff1A1A1A);
  static const whiteE5 = Color(0xffE5E5E5);
  static const grey4D = Color(0xff4D4D4D);
  static const greyEA = Color(0xffEAEAEA);
  static const grey9E = Color(0xff9E9E9E);
  static const grey80 = Color(0xff808080);
  static const blue4E = Color(0xff4E79FA);
  static const violet = Color(0xff2a499e);
  static const black05 = Color(0xff050505);
  static const whiteF = Color(0xffFFFFFF);
  static const green67 = Color.fromARGB(255, 67, 198, 111);
  static const greendark = Color.fromARGB(255, 34, 101, 56);
  static const green240 = Color.fromARGB(255, 240, 246, 242);
  static const yellow252 = Color.fromARGB(255, 252, 221, 24);
  static const yellow248 = Color.fromARGB(255, 255, 248, 206);
  static const yellow232 = Color.fromARGB(255, 232, 142, 21);
  static const whiteFF = Color.fromARGB(255, 255, 255, 255);
  static const whiteFFF = Color.fromARGB(254, 254, 254, 254);
  static const white238 = Color.fromARGB(255, 238, 238, 238);
  static const yellow70 = Color(0xFFFFB662);
  static const yellow225 = Color.fromARGB(255, 225, 150, 30);
  static const yellow244 = Color.fromARGB(255, 255, 244, 232);

  static const red212 = Color.fromARGB(255, 212, 60, 60);
  static const red252 = Color.fromARGB(255, 252, 214, 214);
  static const red240 = Color.fromARGB(255, 240, 50, 50);
  static const red241 = Color.fromARGB(255, 241, 71, 71);
  static const redDark = Color.fromARGB(255, 125, 30, 30);
  static const red253 = Color.fromARGB(255, 253, 235, 235);

  static const grey = Color.fromARGB(255, 196, 196, 196);
  static const grey77 = Color.fromARGB(255, 77, 77, 77);
  static const grey128 = Color.fromARGB(255, 128, 128, 128);
  static const grey244 = Color.fromARGB(255, 244, 246, 250);
  static const grey250 = Color.fromARGB(255, 250, 250, 250);
  static const grey62 = Color.fromARGB(255, 62, 62, 62);
  static const grey148 = Color.fromARGB(255, 148, 148, 148);
  static const greyEE = Color(0xffEEEEEE);
  static const grey158 = Color.fromARGB(255, 158, 158, 158);
  static const grey247 = Color.fromARGB(255, 247, 247, 247);
  static const grey204 = Color.fromARGB(255, 204, 204, 204);
  static const grey101 = Color.fromARGB(255, 101, 101, 101);
  static const grey229 = Color.fromARGB(255, 229, 229, 229);
  static const grey26 = Color.fromARGB(255, 26, 26, 26);
  static const grey184 = Color.fromARGB(255, 184, 184, 184);
  static const grey20 = Color(0xffCCCCCC);
  static const grey70 = Color(0xff4D4D4D);
  static const grey51 = Color(0xff333333);

  static const blue77 = Color.fromARGB(255, 77, 123, 212);
  static const blue235 = Color.fromARGB(255, 235, 253, 253);
  static const blue237 = Color.fromARGB(255, 237, 242, 255);
  static const blue220 = Color.fromARGB(255, 220, 228, 254);
  static const blue10 = Color.fromARGB(255, 237, 242, 255);

  static const black44 = Color.fromARGB(255, 44, 44, 44);
  static const trans = Colors.transparent;

  static const primaryBlue = Color.fromARGB(255, 77, 123, 212);

  static const inactiveGrey = Color(0xffEAEAEA);

  static const yellow255 = Color.fromARGB(255, 255, 150, 30);
  static const blue78 = Color.fromARGB(255, 78, 121, 250);

  static const shadowColor = Color.fromARGB(1, 0, 0, 0);
  static const shadowColor2 = Color.fromARGB(16, 0, 0, 0);

  static const yellow20 = Color(0xFFFFEAD2);
  static const red20 = Color(0xFFFCD6D6);
  static const blue20 = Color(0xFFDCE4FE);
  static const dark = Color(0xFF000000);
  static const blue90 = Color(0xFF6086FA);
  static const white = Color(0xFFFFFFFF);
  static const grey30 = Color(0xFFB3B3B3);
  static const borderBlue = Color(0xFFA7BCFC);
  static const borderGrey = Color(0xFFC4C4C4);

  static const yellow50 = Color(0xFFFFD5A5);
  // static const grey20 = Color(0xFFCCCCCC);
  static const red50 = Color(0xFFF79898);

  static const backgroundGreyColor = Color.fromRGBO(0, 0, 0, 0.5);
}

class ContainerDecoration {
  ///Application Primary Gradient
  static final appPrimaryGradient = BoxDecoration(
    gradient: LinearGradient(
        colors: [
          AppColors.red20.withOpacity(0.1),
          AppColors.primaryBlue.withOpacity(0.08)
        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(2.0, 0.3),
        stops: [0.0, 1.0],
        tileMode: TileMode.repeated),
  );
  static const lightBoxShadow = [
    BoxShadow(
        offset: Offset(0, 1), blurRadius: 5, color: AppColors.shadowColor2)
  ];
}
