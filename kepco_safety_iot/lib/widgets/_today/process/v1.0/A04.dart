// ignore_for_file: file_names, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/TableBox.dart';
import 'package:kepco_safety_iot/widgets/common/ToShoot.dart';

class A04 extends StatefulWidget {
  const A04(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<A04> createState() => _A04State();
}

class _A04State extends State<A04> {
  late TableBox tableBox1;
  late TableBox tableBox2;
  late ProgressTimeline progressTimeline;
  bool cameraYn = false;

  List<SingleRowState> allStages1 = List.empty(growable: true);
  List<SingleRowState> allStages2 = List.empty(growable: true);

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
    cameraYn = true;
    allStages1 = [
      SingleRowState(contents: "공사안내판", isChecked: [true, false]),
      SingleRowState(contents: "교통안전표시판", isChecked: [true, false]),
      SingleRowState(contents: "라바콘", isChecked: [true, false]),
      SingleRowState(contents: "구르프설치", isChecked: [true, false]),
      SingleRowState(contents: "구획로프설치", isChecked: [true, false]),
      SingleRowState(contents: "신호수배치", isChecked: [true, false]),
    ];

    tableBox1 = TableBox(title: "안전표지물", list: allStages1);

    allStages2 = [
      SingleRowState(
          contents: "케이블절면 측정, 도통상태 확인 및 방전 시행", isChecked: [true, false]),
      SingleRowState(
          contents: "무정전 변압기 투입, 차단상태 등 정상 여부 확인", isChecked: [true, false]),
    ];

    tableBox2 = TableBox(title: "안전 작업준비", list: allStages2);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            "| ${widget.stateTitle}",
            textScaleFactor: FontSize.h4,
            style: const TextStyle(
                color: ColorSelect.blueColor, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Column(
                  children: [
                    //안전표지물 테이블
                    Stack(children: [
                      tableBox1,
                      cameraYn
                          ? ToShoot(single: widget.single)
                          : const Text(""),
                    ]),
                    Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),
                    Divider(thickness: 1, height: 1, color: Colors.grey)
                  ],
                ),
                Column(
                  children: [
                    //안전작업준비 테이블
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Stack(children: [
                      tableBox2,
                      cameraYn
                          ? ToShoot(single: widget.single)
                          : const Text(""),
                    ]),
                  ],
                ),
              ],
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
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
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
                            style: TextStyle(
                                fontSize: 20,
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
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        progressTimeline.failCurrentStage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "오류",
                            style: TextStyle(
                                fontSize: 20,
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
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
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
                            style: TextStyle(
                                fontSize: 20,
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
