// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/widgets/common/Layout.dart';

class WorkerPage extends StatelessWidget {
  const WorkerPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Layout(
        title: title,
        body: Text("개발진행중입니다."),
      ),
    );
  }
}
