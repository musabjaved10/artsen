import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

const COLOR_BLACK = Color.fromRGBO(48, 47, 48, 1.0);
const COLOR_GREY = Color.fromRGBO(141, 141, 141, 1.0);

const COLOR_WHITE = Colors.white;
const COLOR_OFFWHITE = Color(0xddfefaff);
const COLOR_DARK_BLUE = Color(0xff424150);
const COLOR_LIGHT_BLUE = Color(0xff21c6e3);
final DEFAULT_PADDING = Get.width * 0.05;

const TextTheme TEXT_THEME_DEFAULT = TextTheme(
    headline1: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w600, fontSize: 22, letterSpacing: 3),
    headline2: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w600, fontSize: 22, letterSpacing: 3),
    headline3: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w500, fontSize: 19, letterSpacing: 1.5),
    headline4: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w500, fontSize: 19, letterSpacing: 1.5),
    headline5: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w600, fontSize: 14.5, letterSpacing: 1.35),
    headline6: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w600, fontSize: 14.5, letterSpacing: 1.35),
    bodyText1: TextStyle(
        color: COLOR_WHITE,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5),
    bodyText2: TextStyle(
        color: COLOR_BLACK,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5),
    button: TextStyle(
        letterSpacing: 3,
        color: COLOR_WHITE,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5),
    subtitle1: TextStyle(
        color: COLOR_WHITE, fontSize: 12, fontWeight: FontWeight.w400),
    subtitle2: TextStyle(
        color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w400));

const TextTheme TEXT_THEME_SMALL = TextTheme(
    headline1: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w600, fontSize: 21, letterSpacing: 3),
    headline2: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w600, fontSize: 21, letterSpacing: 3),
    headline3: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w500, fontSize: 17, letterSpacing: 1.5),
    headline4: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w500, fontSize: 17, letterSpacing: 1.5),
    headline5: TextStyle(
        color: COLOR_WHITE, fontWeight: FontWeight.w600, fontSize: 13.5, letterSpacing: 1.35),
    headline6: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w600, fontSize: 13.5, letterSpacing: 1.35),
    bodyText1: TextStyle(
        color: COLOR_WHITE,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5),
    bodyText2: TextStyle(
        color: COLOR_BLACK,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5),
    button: TextStyle(
        letterSpacing: 3,
        color: COLOR_WHITE,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5),
    subtitle1: TextStyle(
        color: COLOR_WHITE, fontSize: 10, fontWeight: FontWeight.w400),
    subtitle2: TextStyle(
        color: COLOR_BLACK, fontSize: 10, fontWeight: FontWeight.w400));
