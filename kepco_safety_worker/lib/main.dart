import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kepco_safety_worker/Screen/LoginPage.dart';

import 'Constant/Constant.dart';
import 'Screen/AnimatedSplashScreen.dart';
import 'Screen/StartPage.dart';
import 'Screen/HomePage.dart';

Future main() async {
  runApp(MaterialApp(
    title: 'FluterSplashDemo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.red,
      fontFamily: 'SUIT',
    ),
    home: const AnimatedSplashScreen(),
    routes: <String, WidgetBuilder>{
      START_SCREEN: (BuildContext context) => const StartScreen(),
      LOGIN_SCREEN: (BuildContext context) => const LoginScreen(),
      HOME_SCREEN: (BuildContext context) => const HomeRoute(),
    },
  ));
}
