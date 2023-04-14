import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/TableBox.dart';
import 'package:kepco_safety_iot/widgets/common/ToShoot.dart';

class C0103 extends StatefulWidget {
  const C0103({
    Key? key,
    required this.progressTimeline,
    required this.stateTitle,
    required this.single,
  }) : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<C0103> createState() => _C0103State();
}

class _C0103State extends State<C0103> with TickerProviderStateMixin {
  late ProgressTimeline progressTimeline;
  late TableBox tableBox1;
  late TableBox tableBox2;
  bool cameraYn = false;

  List<SingleRowState> allStages1 = List.empty(growable: true);
  List<SingleRowState> allStages2 = List.empty(growable: true);

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;

    stratProc(widget.single.state);

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
      SingleRowState(
          contents: "작업구간 통제 (보행통로 확보 및 안내자 배치)", isChecked: [true, false]),
      SingleRowState(
          contents: "활선차량 및 중장비 수평유지 접지시행", isChecked: [true, false]),
      SingleRowState(
          contents: "안전대 고리는 버켓 조작부 안전띠용 로프걸이에 체결", isChecked: [true, false]),
    ];

    tableBox2 = TableBox(title: "안전 작업준비", list: allStages2);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "| ${widget.stateTitle}",
              style: TextStyle(
                color: ColorSelect.blueColor,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.012,
                fontFamily: 'SUIT',
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.03),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //안전표지물 테이블
                  Stack(children: [
                    tableBox1,
                    cameraYn ? ToShoot(single: widget.single) : const Text(""),
                  ]),
                  Padding(padding: EdgeInsets.only(top: height * 0.03)),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: ColorSelect.borderColor2,
                  ),
                  //안전작업준비 테이블
                  Padding(padding: EdgeInsets.only(top: height * 0.03)),
                  tableBox2,
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      progressTimeline.gotoPreviousStage();
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.003),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: ColorSelect.textColor3,
                          ),
                        ),
                        Text(
                          "이전",
                          style: TextStyle(
                              fontSize: width * 0.01,
                              fontFamily: 'SUIT',
                              color: ColorSelect.textColor3,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.008, bottom: height * 0.008),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        progressTimeline.gotoNextStage();
                        endProc(widget.single.state);
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "다음",
                            style: TextStyle(
                                fontSize: width * 0.01,
                                fontFamily: 'SUIT',
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.003),
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
            ),
          ],
        ),
      ],
    );
  }
}
