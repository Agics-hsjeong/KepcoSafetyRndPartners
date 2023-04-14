// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:timer_builder/timer_builder.dart';

import 'designModel.dart';

class timerModel extends StatelessWidget {
  const timerModel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Row(
      children: [
        SizedBox(
          width: 330,
          child: TimerBuilder.periodic(
            const Duration(seconds: 1),
            builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: ColorSelect.skyColor,
                        size: width * 0.012,
                      ),
                      Text(
                        formatDate(
                            DateTime.now(), [' ', yyyy, ' ', mm, ' ', dd, ' '],
                            locale: const KoreanDateLocale()),
                        style: TextStyle(
                            color: ColorSelect.headTextColor,
                            fontSize: width * 0.01,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        formatDate(DateTime.now(), [DD],
                            locale: const KoreanDateLocale()),
                        style: TextStyle(
                            color: ColorSelect.headTextColor,
                            fontSize: width * 0.01,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        color: ColorSelect.skyColor,
                        size: width * 0.012,
                      ),
                      Text(
                        formatDate(DateTime.now(), [' ', HH, ':', nn, ':', ss],
                            locale: const KoreanDateLocale()),
                        style: TextStyle(
                          color: ColorSelect.headTextColor,
                          fontWeight: FontWeight.normal,
                          fontSize: width * 0.01,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
