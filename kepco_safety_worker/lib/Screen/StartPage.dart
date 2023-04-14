import 'dart:async';

import '../Constant/Constant.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  void navigationPage() {
    Navigator.of(context).pushNamed(LOGIN_SCREEN);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        textStyle: const TextStyle(fontSize: 14),
        primary: Color.fromRGBO(69, 94, 238, 1),
        fixedSize: Size(MediaQuery.of(context).size.width - 40, 40));
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          // fit: StackFit.passthrough,
          children: <Widget>[
            Positioned(
              top: 200,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.03,
                    ),
                    child: Text(
                      "LogoLogo",
                      style: TextStyle(
                        color: Colors.black87,
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
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    "실시간 건강관리까지",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  // alignment: WrapAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        LOGIN_STATE = '한전';
                        print(LOGIN_STATE);
                        navigationPage();
                      },
                      child: const Text('한전'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        LOGIN_STATE = '도급';
                        print(LOGIN_STATE);
                        navigationPage();
                      },
                      child: const Text('도급 근로자'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: style,
                      onPressed: () {
                        LOGIN_STATE = '일용';
                        print(LOGIN_STATE);
                        navigationPage();
                      },
                      child: const Text('일용 근로자'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
