// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/models/models.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuArea extends StatelessWidget {
  const MenuArea({
    Key? key,
    required this.titleMenu,
    required this.image,
    required this.format,
  }) : super(key: key);

  final String titleMenu;
  final String image;
  final String format;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Container(
      width: width * 0.23,
      height: height * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: ColorSelect.shadowColor, spreadRadius: 3, blurRadius: 8),
          ],
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          format == 'img'
              ? Image(
                  image: AssetImage(image),
                  height: width * 0.06,
                )
              : SvgPicture.asset(
                  image,
                  height: width * 0.06,
                ),
          Text(
            titleMenu,
            style: TextStyle(
                color: ColorSelect.moregrayColor,
                fontWeight: FontWeight.w600,
                fontSize: width * 0.01),
          ),
        ],
      ),
    );
  }
}
