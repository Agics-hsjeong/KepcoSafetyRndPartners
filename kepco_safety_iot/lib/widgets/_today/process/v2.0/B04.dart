import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/designModel.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/CameraPlayer.dart';

class B04 extends StatefulWidget {
  const B04(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<B04> createState() => _B04State();
}

class _B04State extends State<B04> with TickerProviderStateMixin {
  late ProgressTimeline progressTimeline;
  List<RiskState> allStages = List.empty(growable: true);
  List<RiskState> result = List.empty(growable: true);

  Future<dynamic> startProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'S');

    // print('===>startProc ${result}');
  }

  Future<dynamic> endProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'E');

    // print('===>endProc ${result}');
  }

  late Timer _timer;

  int fadeCnt = 0;

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;

    allStages = [
      RiskState(
          code: "사람",
          riskCn: "- 작업자의정신적, 신체적상태불량시 안전사고 위험\n- 개인보호구미착용시 감전 및 안전사고 위험",
          riskState: "상"),
      RiskState(
          code: "장비",
          riskCn: "- 활선바켓트럭작업시 전도위험\n- 중장비사용시 끼임 및 충돌 위험",
          riskState: "상"),
      RiskState(
          code: "환경",
          riskCn: "- 도로상작업시 교통사고위험\n- 낙하물등에 의한 보행인 안전사고 위험",
          riskState: "상"),
      RiskState(
          code: "관리",
          riskCn: "- 작업계획미수립시 안전사고 위험\n- 작업절차미준수시 안전사고 위험",
          riskState: "상"),
    ];

    result = [
      RiskState(
          code: "사람", riskCn: "- 작업자의 PMIS체크\n- 개인보호구착용상태점검", riskState: "하"),
      RiskState(
          code: "장비",
          riskCn: "- 아웃트리거설치상태 및 지반상태점검\n- 지상 감시자배치 및 작업변경내접근 제한",
          riskState: "하"),
      RiskState(
          code: "환경",
          riskCn: "- 교통 정리원 배치 및 라바콘등 시설물 배치\n- 작업반경구획 및 보행인통제",
          riskState: "하"),
      RiskState(
          code: "관리",
          riskCn: "- 작업통보서발행 및 배전센터작업통보\n- 작업전안전회의실시 및 작업별임무 부여",
          riskState: "하"),
    ];

    startProc();
    super.initState();
    HealthStatus.bodyStatus = 1;
    HealthStatus.stressStatus = 0;

    _timer = Timer.periodic(Duration(milliseconds: 1100), (timer) {
      setState(() {
        fadeCnt++;

        // controller.reverse();
        // print(fadeCnt);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
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
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 6.0),
            //   child: Text(
            //     "| ${widget.stateTitle}",
            //     textScaleFactor: FontSize.h4_5,
            //     style: const TextStyle(
            //         color: ColorSelect.blueColor, fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  decoration: BoxDecoration(
                      color: ColorSelect.tableColor,
                      borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "구분",
                        textScaleFactor: FontSize.h6,
                        style: TextStyle(
                            color: ColorSelect.headTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: Center(
                          child: Text(
                            "유해·위험 요인",
                            textScaleFactor: FontSize.h6,
                            style: TextStyle(
                                color: ColorSelect.headTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(
                        "위험성 (현재)",
                        textScaleFactor: FontSize.h6,
                        style: TextStyle(
                            color: ColorSelect.headTextColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                fadeCnt >= 1
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.285,
                        child: Column(
                            children: allStages
                                .map(
                                  (e) => Container(
                                    padding: EdgeInsets.only(
                                        top: 7, bottom: 7, right: 8, left: 8),
                                    margin:
                                        EdgeInsets.only(right: 25, left: 10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Color.fromRGBO(
                                                    220, 225, 252, 1)))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e.code,
                                          textScaleFactor: FontSize.h5,
                                          style: TextStyle(
                                              color: ColorSelect.moregrayColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.22,
                                          child: Text(
                                            e.riskCn,
                                            textScaleFactor: FontSize.h7,
                                            style: TextStyle(
                                                height: 1.4,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          decoration: BoxDecoration(
                                              color: e.riskState == "상"
                                                  ? Color.fromRGBO(
                                                      255, 223, 223, 1)
                                                  : e.riskState == "중"
                                                      ? Color.fromARGB(
                                                          255, 250, 128, 71)
                                                      : Color.fromRGBO(
                                                          255, 248, 230, 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              e.riskState,
                                              textScaleFactor: FontSize.h4_5,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: e.riskState == "상"
                                                      ? Colors.red
                                                      : e.riskState == "중"
                                                          ? ColorSelect
                                                              .orengeColor
                                                          : ColorSelect
                                                              .greenColor),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                                .toList()),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.285,
                      ),
                fadeCnt >= 2
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.022,
                              height:
                                  MediaQuery.of(context).size.height * 0.032,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(178, 188, 248, 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationX(math.pi),
                                child: Icon(
                                  Icons.navigation_rounded,
                                  size: 21,
                                  color: ColorSelect.blueColor,
                                ),
                              ),
                            ),
                            Text(
                              "조치",
                              textScaleFactor: FontSize.h5,
                              style: TextStyle(
                                  color: ColorSelect.blueColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ))
                    : Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.022,
                          height: MediaQuery.of(context).size.height * 0.032,
                        ),
                      ),
                fadeCnt >= 3
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        decoration: BoxDecoration(
                            color: ColorSelect.tableColor,
                            borderRadius: BorderRadius.circular(18)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "구분",
                              textScaleFactor: FontSize.h6,
                              style: TextStyle(
                                  color: ColorSelect.headTextColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.18,
                              child: Center(
                                child: Text(
                                  "조치사항",
                                  textScaleFactor: FontSize.h6,
                                  style: TextStyle(
                                      color: ColorSelect.headTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Text(
                              "위험성 (조치시)",
                              textScaleFactor: FontSize.h6,
                              style: TextStyle(
                                  color: ColorSelect.headTextColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.04),
                Container(
                  height: MediaQuery.of(context).size.height * 0.29,
                  child: Column(
                      children: result
                          .map((e) => fadeCnt >= (result.indexOf(e) + 1) + 3
                              ? Container(
                                  padding: EdgeInsets.only(
                                      top: 7, bottom: 7, right: 8, left: 8),
                                  margin: EdgeInsets.only(right: 25, left: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color.fromRGBO(
                                                  220, 225, 252, 1)))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.code,
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                            color: ColorSelect.moregrayColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.22,
                                        child: Text(
                                          e.riskCn,
                                          textScaleFactor: FontSize.h7,
                                          style: TextStyle(
                                              height: 1.4,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        decoration: BoxDecoration(
                                            color: e.riskState == "상"
                                                ? Color.fromRGBO(
                                                    255, 223, 223, 1)
                                                : e.riskState == "중"
                                                    ? Color.fromARGB(
                                                        255, 250, 128, 71)
                                                    : Color.fromRGBO(
                                                        225, 248, 230, 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            e.riskState,
                                            textScaleFactor: FontSize.h4_5,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: e.riskState == "상"
                                                    ? Colors.red
                                                    : e.riskState == "중"
                                                        ? ColorSelect
                                                            .orengeColor
                                                        : ColorSelect
                                                            .greenColor),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                ))
                          .toList()),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.022,
                          height: MediaQuery.of(context).size.height * 0.035,
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.check_box_rounded,
                            size: 27,
                            color: ColorSelect.greenColor,
                          ),
                        ),
                        Text(
                          "평가 결과",
                          textScaleFactor: FontSize.h4_5,
                          style: TextStyle(
                              color: ColorSelect.moregrayColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(padding: EdgeInsets.only(right: 16)),
                        Text(
                          fadeCnt >= 8 ? "작업 가능" : "작업 불가능",
                          textScaleFactor: FontSize.h4_5,
                          style: TextStyle(
                              color: fadeCnt >= 8
                                  ? ColorSelect.greenColor
                                  : Colors.red,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
        //이전 다음 버튼
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        progressTimeline.gotoPreviousStage();
                        VideoStatus.controller.setMediaFromNetwork(
                            'http://106.255.245.242:39104/video/3.작업자PMISCheck(수치)_10s-converted.mp4');
                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // VideoStatus.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // CameraPlayer.state.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/3.작업자PMISCheck(수치)_10s.MOV');
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
                            textScaleFactor: FontSize.h4_5,
                            style: TextStyle(
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                        VideoStatus.controller.setMediaFromNetwork(
                            'http://106.255.245.242:39104/video/5.안전장구착용여부확인_10-converted.mp4');
                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // VideoStatus.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // CameraPlayer.state.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/5.안전장구착용여부확인_10.mp4');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "다음",
                            textScaleFactor: FontSize.h4_5,
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
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    )
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

class RiskState {
  RiskState(
      {required this.code, required this.riskCn, required this.riskState});

  String code;
  String riskCn;
  String riskState;
}
