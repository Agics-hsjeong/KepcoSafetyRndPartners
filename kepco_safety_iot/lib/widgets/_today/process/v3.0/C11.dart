import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/RiskCheckBox.dart';
import 'package:kepco_safety_iot/widgets/common/ToShoot.dart';

class C11 extends StatefulWidget {
  const C11({
    Key? key,
    required this.progressTimeline,
    required this.stateTitle,
    required this.single,
  }) : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<C11> createState() => _C11State();
}

class _C11State extends State<C11> with TickerProviderStateMixin {
  late ProgressTimeline progressTimeline;
  late RiskCheckBox riskCheck;
  List<RowState> dangerCheck = List.empty(growable: true);
  bool cameraYn = false;

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;

    stratProc(widget.single.state);

    cameraYn = true;
    dangerCheck = [
      RowState(
        contents: "바이패스 케이블 풀링시 협착 주의",
        warnCn: [RiskState(contents: "바이패스케이블 절연손상으로 인한 감전예방 필요")],
      ),
    ];

    riskCheck =
        RiskCheckBox(list: dangerCheck, importance: 3, possibility: 3, risk: 6);
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
                  Stack(children: [
                    riskCheck,
                    cameraYn ? ToShoot(single: widget.single) : const Text(""),
                  ]),
                  Padding(padding: EdgeInsets.only(bottom: height * 0.02)),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorSelect.tableColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: double.infinity,
                    height: height * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("이미지 넣어주기 C11",
                            style: TextStyle(
                                color: ColorSelect.headTextColor,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
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
