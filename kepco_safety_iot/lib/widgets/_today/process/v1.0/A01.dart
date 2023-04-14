// ignore_for_file: avoid_print, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';

class A01 extends StatefulWidget {
  const A01(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<A01> createState() => _A01State();
}

class _A01State extends State<A01> {
  late ProgressTimeline progressTimeline;

  bool safrUserCheck = false;
  bool errorCheck = false;

  Future<dynamic> startProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'S');

    print('===>startProc $result');
  }

  Future<dynamic> endProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'E');

    print('===>endProc $result');
  }

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;
    startProc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "| ${widget.stateTitle}",
              style: const TextStyle(
                  fontSize: 20,
                  color: ColorSelect.blueColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("안전담당자(현장소장) 확인",
                      textScaleFactor: FontSize.h5,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.only(bottom: 30.0)),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Row(
                            children: [
                              Text(
                                '안전담당자             ',
                                textScaleFactor: FontSize.h6,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(81, 81, 81, 1)),
                              ),
                              Text(
                                '김*경',
                                textScaleFactor: FontSize.h6,
                                style: TextStyle(
                                    color: Color.fromRGBO(81, 81, 81, 1)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: safrUserCheck
                              ? OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: ColorSelect.toggleColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    side: BorderSide(
                                      width: 1.0,
                                      color: ColorSelect.iconColor,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      safrUserCheck = !safrUserCheck;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.check_rounded,
                                    size: 25,
                                    color: ColorSelect.blueColor,
                                  ),
                                  label: Text(
                                    "안전담당자 확인 후 체크",
                                    textScaleFactor: FontSize.h6,
                                    style: TextStyle(
                                      color: ColorSelect.blueColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: ColorSelect.grayColor3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    side: BorderSide(
                                      width: 1.0,
                                      color: ColorSelect.grayColor2,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      safrUserCheck = !safrUserCheck;
                                    });
                                  },
                                  child: Text(
                                    "안전담당자 확인 후 체크",
                                    textScaleFactor: FontSize.h6,
                                    style: TextStyle(
                                      color: ColorSelect.moregrayColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 30.0)),
                  Text("무정전 작업절차서 휴대 및 이상유무 확인",
                      textScaleFactor: FontSize.h5,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.only(bottom: 30.0)),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Text(
                            '무정전 작업절차서 휴대 및 이상유무 확인',
                            textScaleFactor: FontSize.h6,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(81, 81, 81, 1)),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: errorCheck
                              ? OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: ColorSelect.toggleColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    side: BorderSide(
                                      width: 1.0,
                                      color: ColorSelect.iconColor,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      errorCheck = !errorCheck;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.check_rounded,
                                    size: 25,
                                    color: ColorSelect.blueColor,
                                  ),
                                  label: Text(
                                    "무정전 작업절차서 휴대 및 이상유무 확인 후 체크",
                                    textScaleFactor: FontSize.h6,
                                    style: TextStyle(
                                      color: ColorSelect.blueColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: ColorSelect.grayColor3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    side: BorderSide(
                                      width: 1.0,
                                      color: ColorSelect.grayColor2,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        errorCheck = !errorCheck;
                                      },
                                    );
                                  },
                                  child: Text(
                                    "무정전 작업절차서 휴대 및 이상유무 확인 후 체크",
                                    textScaleFactor: FontSize.h6,
                                    style: TextStyle(
                                      color: ColorSelect.moregrayColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        progressTimeline.gotoPreviousStage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: ColorSelect.blueColor,
                            ),
                          ),
                          Text(
                            "이전",
                            textScaleFactor: FontSize.h4,
                            style: TextStyle(
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        progressTimeline.failCurrentStage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "오류",
                            textScaleFactor: FontSize.h4,
                            style: TextStyle(
                                color: ColorSelect.redColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        progressTimeline.gotoNextStage();
                        endProc();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "다음",
                            textScaleFactor: FontSize.h4,
                            style: TextStyle(
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: ColorSelect.blueColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
