// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';

class CareCard extends StatelessWidget {
  const CareCard({
    Key? key,
    required this.title,
    required this.img,
    required this.ribi,
    required this.alarmdata,
  }) : super(key: key);

  final String title;
  final String img;
  final String ribi;
  final String alarmdata;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width * 0.18,
          height: height * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                color: ColorSelect.shadowColor,
                spreadRadius: 1,
                blurRadius: 6,
              ),
            ],
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                img,
                width: width * 0.02,
              ),
              SizedBox(
                child: Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.011,
                        fontFamily: 'SUIT',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.003),
                      child: Text(
                        ribi,
                        style: TextStyle(
                          color: ColorSelect.blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.011,
                          fontFamily: 'SUIT',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.022,
                height: height * 0.025,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ColorSelect.redColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        alarmdata,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.01,
                          fontFamily: 'SUIT',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
