import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kepco_safety_iot/models/models.dart';

import 'package:kepco_safety_iot/pages/LoginPage.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 가로 왼쪽, 오른쪽 방향 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      title: TextModel.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SUIT',
      ),
      home: const LoginPage(),
    );
  }
}
