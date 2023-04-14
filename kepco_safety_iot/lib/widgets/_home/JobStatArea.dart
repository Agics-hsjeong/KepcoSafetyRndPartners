// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/designModel.dart';

class JobStatArea extends StatefulWidget {
  const JobStatArea({
    Key? key,
  }) : super(key: key);

  @override
  State<JobStatArea> createState() => _JobStatAreaState();
}

class _JobStatAreaState extends State<JobStatArea> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: width * 0.01),
          child: Row(
            children: [
              Text(
                "실시간 작업 현황",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * 0.01),
              ),
            ],
          ),
        ),
        Container(
          width: width * 0.3,
          height: height * 0.16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              boxShadow: const [
                BoxShadow(
                    color: ColorSelect.shadowColor,
                    spreadRadius: 1,
                    blurRadius: 6),
              ],
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("10",
                            style: TextStyle(
                              // color: ColorSelect.blueColor,
                              fontSize: width * 0.02,
                              fontWeight: FontWeight.bold,
                            )),
                        Text("총 작업",
                            style: TextStyle(
                              // color: ColorSelect.blueColor,
                              fontSize: width * 0.01,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                    const VerticalDivider(color: Colors.grey, thickness: 0.2),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "1",
                          style: TextStyle(
                            color: ColorSelect.blueColor,
                            fontSize: width * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("작업허가",
                            style: TextStyle(
                              color: ColorSelect.grayColor2,
                              fontSize: width * 0.01,
                            ))
                      ],
                    ),
                    const VerticalDivider(color: Colors.grey, thickness: 0.2),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "1",
                          style: TextStyle(
                            color: ColorSelect.redColor,
                            fontSize: width * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("작업중지",
                            style: TextStyle(
                              color: ColorSelect.grayColor2,
                              fontSize: width * 0.01,
                            ))
                      ],
                    ),
                    const VerticalDivider(color: Colors.grey, thickness: 0.2),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "8",
                          style: TextStyle(
                            color: ColorSelect.greenColor,
                            fontSize: width * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("작업종료",
                            style: TextStyle(
                              color: ColorSelect.grayColor2,
                              fontSize: width * 0.01,
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.015, 0, width * 0.008, 0),
                      child: LinearProgressIndicator(
                        backgroundColor: ColorSelect.grayColor4,
                        color: ColorSelect.blueColor,
                        value: 0.8,
                        minHeight: width * 0.004,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                    child: Text("80%",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.012,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
