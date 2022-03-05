import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Metropolis',
  primarySwatch: mainColor,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    titleSpacing: 20,
    color: Colors.white,
    //backwardsCompatibility: false,
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: 'Jannah',
  primarySwatch: mainColor,
  scaffoldBackgroundColor: const Color(0xff333739),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xff333739),
    elevation: 0,
    titleSpacing: 20,
    //backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff333739),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    selectedIconTheme: IconThemeData(
      color: Colors.red,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.grey,
    ),
    backgroundColor: Color(0xff333739),
  ),
);
