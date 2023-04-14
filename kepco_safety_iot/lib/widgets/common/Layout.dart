import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/models/models.dart';

import 'TopMenuBar.dart';
import 'DrawerBox.dart';

class Layout extends StatelessWidget {
  const Layout({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 13),
        child: TopMenuBar(title: title),
      ),
      // drawer: const DrawerBox(),
      body: body,
    );
  }
}
