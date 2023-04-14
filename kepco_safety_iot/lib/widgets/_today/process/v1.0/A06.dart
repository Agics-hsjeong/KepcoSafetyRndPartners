// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/TableBox.dart';
import 'package:kepco_safety_iot/widgets/common/RiskCheckBox.dart';
import 'package:kepco_safety_iot/widgets/common/ToShoot.dart';

class A06 extends StatefulWidget {
  const A06(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<A06> createState() => _A06State();
}

class _A06State extends State<A06> {
  late TableBox tableBox;
  late RiskCheckBox riskCheck;
  late ProgressTimeline progressTimeline;
  bool cameraYn = false;

  List<SingleRowState> allStages = List.empty(growable: true);
  List<RowState> dangerCheck = List.empty(growable: true);

  Future<dynamic> startProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'S');

    print('===>startProc ${result}');
  }

  Future<dynamic> endProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'E');

    print('===>endProc ${result}');
  }

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;
    startProc();
    cameraYn = true;
    allStages = [
      SingleRowState(
          contents:
              "중성선 방호, (필요시) COS, 전력선 (고압선, 저압선) 등 충전보 방호, \n완철덮개, 전주덮개 사용",
          isChecked: [true, false]),
    ];

    tableBox = TableBox(title: "", list: allStages);

    dangerCheck = [
      RowState(
        contents: "도로측부터 방호, 붐대 접촉주의",
        warnCn: [RiskState(contents: "")],
      ),
      RowState(
          contents: "지상 감시자 배치 및 상ㆍ하부 동시작업 금지",
          warnCn: [RiskState(contents: "")]),
    ];

    riskCheck =
        RiskCheckBox(list: dangerCheck, importance: 3, possibility: 3, risk: 6);

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
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                "| ${widget.stateTitle}",
                textScaleFactor: FontSize.h4,
                style: const TextStyle(
                    color: ColorSelect.blueColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  // 위험성 체크
                  Stack(children: [
                    riskCheck,
                    cameraYn ? ToShoot(single: widget.single) : const Text(""),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Image.asset("assets/img/충전부방호작업.png"),
                  ),
                  //안전작업관리 테이블
                  Container(
                      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                      child: tableBox),
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
