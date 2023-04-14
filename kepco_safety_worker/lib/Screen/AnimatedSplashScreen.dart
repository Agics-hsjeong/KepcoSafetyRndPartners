import 'dart:async';

import '../Constant/Constant.dart';
import 'package:flutter/material.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(START_SCREEN);
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    // animation =
    //     CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation = Tween<double>(begin: 0, end: 1000).animate(animationController);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(69, 94, 238, 1),
      body: Stack(
        children: [
          Positioned(
            top: 200,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.03,
                  ),
                  child: Text(
                    "LogoLogo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Text(
                    "작업 관리·작업 위험도 확인",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
                Text(
                  "실시간 건강관리까지",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle, //making box to circle
          //       color: Colors.deepOrangeAccent //background of container
          //       ),
          //   height: animation.value, //value from animation controller
          //   width: animation.value, //value from animation controller
          // ),
        ],
      ),
    );
  }
}
