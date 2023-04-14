// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/models/models.dart';

class NotifiStatArea extends StatelessWidget {
  const NotifiStatArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              Text(
                "금일 경고 알림 현황",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.01,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.005),
                child: SizedBox(
                  width: width * 0.02,
                  height: height * 0.02,
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
                          '10',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.008,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: width * 0.3,
          height: height * 0.43,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              boxShadow: const [
                BoxShadow(
                    color: ColorSelect.shadowColor,
                    spreadRadius: 1,
                    blurRadius: 6),
              ],
              color: Colors.white),
          child: ListView.separated(
            controller: ScrollController(initialScrollOffset: 1.0),
            padding: EdgeInsets.fromLTRB(
                width * 0.005, width * 0.002, width * 0.008, 0),
            itemCount: 5,
            itemBuilder: (context, index) => index == 0
                ? ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: 2),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                    minLeadingWidth: 10,
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.report_problem_rounded,
                          color: ColorSelect.redColor,
                          size: width * 0.015,
                        ),
                      ],
                    ),
                    title: Text('안전모 미착용 탐지',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.011,
                        )),
                    subtitle: Text(
                      "2022-04-26 09:34:23",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.01,
                      ),
                    ),
                    trailing: Text(
                      "안읽음",
                      style: TextStyle(
                        color: ColorSelect.redColor,
                        fontSize: width * 0.01,
                      ),
                    ),
                  )
                : ListTile(
                    dense: true,
                    visualDensity: const VisualDensity(vertical: 2),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                    minLeadingWidth: 10,
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.report_problem_rounded,
                          size: width * 0.015,
                        ),
                      ],
                    ),
                    title: Text(
                      '안전모 미착용 탐지',
                      style: TextStyle(
                        color: ColorSelect.grayColor,
                        fontSize: width * 0.011,
                      ),
                    ),
                    subtitle: Text(
                      "2022-04-26 09:34:23",
                      style: TextStyle(
                        color: ColorSelect.grayColor,
                        fontSize: width * 0.01,
                      ),
                    ),
                    trailing: Text(
                      "읽음",
                      style: TextStyle(
                        color: ColorSelect.grayColor,
                        fontSize: width * 0.01,
                      ),
                    ),
                  ),
            separatorBuilder: ((context, index) {
              return const Divider(height: 1.0, color: ColorSelect.grayColor);
            }),
          ),
        ),
      ],
    );
  }
}
