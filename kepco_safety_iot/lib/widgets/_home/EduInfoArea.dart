// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/models/models.dart';

class EduInfoArea extends StatelessWidget {
  const EduInfoArea({
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
        Container(
          padding: EdgeInsets.only(bottom: width * 0.005, left: width * 0.002),
          child: Row(
            children: [
              Text(
                "교육",
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
          height: height * 0.384,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            boxShadow: const [
              BoxShadow(
                color: ColorSelect.shadowColor,
                spreadRadius: 1,
                blurRadius: 6,
              ),
            ],
            color: Colors.white,
          ),
          child: ListView.separated(
            controller: ScrollController(initialScrollOffset: 1.0),
            padding: EdgeInsets.fromLTRB(
                width * 0.005, width * 0.003, width * 0.008, 0),
            itemCount: 5,
            itemBuilder: (context, index) => index == 0
                ? ListTile(
                    minLeadingWidth: 10,
                    dense: true,
                    visualDensity: VisualDensity(vertical: 2),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$index",
                          style: TextStyle(
                            fontSize: width * 0.012,
                          ),
                        ),
                      ],
                    ),
                    title: Text('22년 05월 07일 근로자 정기교육',
                        style: TextStyle(
                          fontSize: width * 0.01,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "안전교육장",
                          style: TextStyle(
                            color: ColorSelect.grayColor,
                            fontSize: width * 0.009,
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: width * 0.065,
                          height: height * 0.025,
                          child: OutlinedButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorSelect.orengeColor),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                            ),
                            child: Text("간접활선 교육",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.0085,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                        Text(
                          "2022-05-07 12:00 ~ 14:00",
                          style: TextStyle(
                            color: ColorSelect.grayColor,
                            fontSize: width * 0.009,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListTile(
                    minLeadingWidth: 10,
                    dense: true,
                    visualDensity: VisualDensity(vertical: 2),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "$index",
                          style: TextStyle(
                            color: ColorSelect.grayColor,
                            fontSize: width * 0.012,
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      '22년 04월 06일 근로자 정기교육',
                      style: TextStyle(
                        color: ColorSelect.grayColor,
                        fontSize: width * 0.01,
                      ),
                    ),
                    subtitle: Text(
                      "안전교육장",
                      style: TextStyle(
                        color: ColorSelect.grayColor,
                        fontSize: width * 0.009,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: width * 0.065,
                          height: height * 0.025,
                          child: OutlinedButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorSelect.grayColor),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                            ),
                            child: Text("간접활선 교육",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.0085,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                        Text(
                          "2022-05-07 12:00 ~ 14:00",
                          style: TextStyle(
                            color: ColorSelect.grayColor,
                            fontSize: width * 0.009,
                          ),
                        )
                      ],
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
