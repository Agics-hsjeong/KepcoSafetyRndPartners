import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';

class C01 extends StatefulWidget {
  const C01({
    Key? key,
    required this.progressTimeline,
    required this.stateTitle,
    required this.single,
  }) : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<C01> createState() => _C01State();
}

class _C01State extends State<C01> with TickerProviderStateMixin {
  late ProgressTimeline progressTimeline;
  bool safrUserCheck = false;
  bool errorCheck = false;

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;
    stratProc(widget.single.state);

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("안전담당자(현장소장) 확인",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.012,
                        fontFamily: 'SUIT',
                      )),
                  Padding(padding: EdgeInsets.only(bottom: height * 0.03)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Row(
                          children: [
                            Text(
                              '안전담당자             ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: ColorSelect.textColor,
                                fontSize: width * 0.011,
                                fontFamily: 'SUIT',
                              ),
                            ),
                            Text(
                              '김*경',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: ColorSelect.textColor,
                                fontSize: width * 0.011,
                                fontFamily: 'SUIT',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: height * 0.05,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: safrUserCheck
                                    ? ColorSelect.blueColor2
                                    : ColorSelect.toggleColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                side: BorderSide(
                                  width: 1.0,
                                  color: safrUserCheck
                                      ? ColorSelect.borderColor4
                                      : ColorSelect.borderColor3,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  safrUserCheck = !safrUserCheck;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  safrUserCheck
                                      ? Icon(
                                          Icons.check_rounded,
                                          size: width * 0.015,
                                          color: ColorSelect.toggleColor3,
                                        )
                                      : SizedBox.shrink(),
                                  Text(
                                    "안전담당자 확인 후 체크",
                                    style: TextStyle(
                                      color: safrUserCheck
                                          ? ColorSelect.toggleTextColor
                                          : ColorSelect.textColor2,
                                      fontSize: width * 0.01,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.03),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: ColorSelect.borderColor2,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: height * 0.03)),
                  Text("무정전 작업절차서 휴대 및 이상유무 확인",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.012,
                        fontFamily: 'SUIT',
                      )),
                  Padding(padding: EdgeInsets.only(bottom: height * 0.03)),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: height * 0.03),
                          child: Text(
                            '무정전 작업절차서 휴대 및 이상유무 확인',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: ColorSelect.textColor,
                              fontSize: width * 0.011,
                              fontFamily: 'SUIT',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.05,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: errorCheck
                                  ? ColorSelect.blueColor2
                                  : ColorSelect.toggleColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              side: BorderSide(
                                width: 1.0,
                                color: errorCheck
                                    ? ColorSelect.borderColor4
                                    : ColorSelect.borderColor3,
                                style: BorderStyle.solid,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                errorCheck = !errorCheck;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                errorCheck
                                    ? Icon(
                                        Icons.check_rounded,
                                        size: width * 0.015,
                                        color: ColorSelect.toggleColor3,
                                      )
                                    : SizedBox.shrink(),
                                Text(
                                  "무정전 작업절차서 휴대 및 이상유무 확인 후 체크",
                                  style: TextStyle(
                                    color: errorCheck
                                        ? ColorSelect.toggleTextColor
                                        : ColorSelect.textColor2,
                                    fontSize: width * 0.01,
                                    fontFamily: 'SUIT',
                                    fontWeight: FontWeight.w400,
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
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
