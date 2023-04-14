import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kepco_safety_iot/models/designModel.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/CameraPlayer.dart';

class B06 extends StatefulWidget {
  const B06(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<B06> createState() => _B06State();
}

class _B06State extends State<B06> {
  late ProgressTimeline progressTimeline;
  List<SingleRiskState> process = List.empty(growable: true);

  final FlutterTts tts = FlutterTts();
  final TextEditingController controller =
      TextEditingController(text: '위험성 평가 결과 위험한 공정이 시작되오니 작업 진행에 유의해주세요');

  bool isSpeak = true;
  _B06State() {
    tts.setLanguage('ko');
    tts.setSpeechRate(0.4);
  }

  late Timer _timer;
  // late Timer _tts_timer;
  int fadeCnt = 0;

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

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;

    // FadeIn.status = true;

    process = [
      SingleRiskState(
          progress: "1.작업준비", contents: "통로확보, 교통안내원, 바퀴 고임목", rating: 1),
      SingleRiskState(
          progress: "2.안전회의", contents: "임무부여, 안전장구 상태 확인", rating: 1),
      SingleRiskState(
          progress: "3.중성선 방호", contents: "중성선 및 저압전선 충전부 방호", rating: 1),
      SingleRiskState(
          progress: "4.입상케이블 고정장치 설치", contents: "입상케이블 거치", rating: 3),
      SingleRiskState(
        progress: "5.입상케이블 설치, 연결",
        contents: "전선 탈피 및 입상케이블 연결",
        rating: 5,
      ),
      SingleRiskState(progress: "6.본작업 시행", contents: "변압기 교체", rating: 3),
      SingleRiskState(progress: "7.입상케이블 분리", contents: "입상케이블 분리", rating: 3),
      SingleRiskState(
          progress: "8.철거 및 작업 종료",
          contents: "부속자재, 방호선 철거 및 작업완료 통보",
          rating: 2),
    ];

    startProc();
    super.initState();
    HealthStatus.bodyStatus = 1;
    HealthStatus.stressStatus = 0;

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        if (fadeCnt == 4) {
          tts.speak(controller.text);
        } else if (fadeCnt == 16) {
          tts.speak(controller.text);
        }
        fadeCnt++;
        // controller.reverse();
        // print(fadeCnt);
      });
    });

    // _tts_timer = Timer.periodic(Duration(milliseconds: 6000), (timer) {
    //   setState(() {
    //     if (isSpeak) {
    //       tts.speak(controller.text);
    //     }
    //   });
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    // _tts_timer.cancel();
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
                textScaleFactor: FontSize.h4_5,
                style: const TextStyle(
                    color: ColorSelect.blueColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                Positioned(
                  top: 62,
                  left: 167,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.001,
                    height: MediaQuery.of(context).size.height *
                        (0.07 * process.length),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(142, 148, 189, 1),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            "현재 진행상황 (공정표)",
                            textScaleFactor: FontSize.h6,
                            style: TextStyle(
                                color: ColorSelect.headTextColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Center(
                              child: Text(
                                "내용",
                                textScaleFactor: FontSize.h6,
                                style: TextStyle(
                                    color: ColorSelect.headTextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Text(
                            "위험성 평가",
                            textScaleFactor: FontSize.h6,
                            style: TextStyle(
                                color: ColorSelect.headTextColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: process
                          .map((e) => Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              padding:
                                  EdgeInsets.only(top: 8, left: 5, right: 5),
                              margin: EdgeInsets.only(right: 15),
                              child: Stack(
                                children: [
                                  e.rating > 4 &&
                                          fadeCnt >= process.indexOf(e) + 1
                                      ? Positioned(
                                          child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.31,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          decoration: BoxDecoration(
                                              color: ColorSelect.redColor,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ))
                                      : fadeCnt == process.indexOf(e) + 1 &&
                                              fadeCnt < 6
                                          ? e.rating == 3
                                              ? Positioned(
                                                  child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.31,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          252, 200, 57, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                ))
                                              : Positioned(
                                                  child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.31,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          ColorSelect.blueColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                ))
                                          : Positioned(
                                              child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.31,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                            )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 5),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.12,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        child: Text(
                                          e.progress,
                                          textScaleFactor: FontSize.h7,
                                          style: TextStyle(
                                              color: e.rating > 4 &&
                                                      fadeCnt >=
                                                          process.indexOf(e) + 1
                                                  ? Colors.white
                                                  : fadeCnt ==
                                                              process.indexOf(
                                                                      e) +
                                                                  1 &&
                                                          fadeCnt < 6
                                                      ? Colors.white
                                                      : ColorSelect.grayColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      e.rating > 4 &&
                                              fadeCnt >= process.indexOf(e) + 1
                                          ? Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.001,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                  decoration: BoxDecoration(
                                                    color: e.rating > 4 &&
                                                            fadeCnt >=
                                                                process.indexOf(
                                                                        e) +
                                                                    1
                                                        ? Colors.white
                                                        : fadeCnt ==
                                                                    process.indexOf(
                                                                            e) +
                                                                        1 &&
                                                                fadeCnt < 6
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .grayColor,
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.007,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                  decoration: BoxDecoration(
                                                      color: e.rating > 4 &&
                                                              fadeCnt >=
                                                                  process.indexOf(
                                                                          e) +
                                                                      1
                                                          ? Colors.white
                                                          : fadeCnt ==
                                                                      process.indexOf(
                                                                              e) +
                                                                          1 &&
                                                                  fadeCnt < 6
                                                              ? Colors.white
                                                              : ColorSelect
                                                                  .grayColor,
                                                      shape: BoxShape.circle),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.001,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                  decoration: BoxDecoration(
                                                    color: e.rating > 4 &&
                                                            fadeCnt >=
                                                                process.indexOf(
                                                                        e) +
                                                                    1
                                                        ? Colors.white
                                                        : fadeCnt ==
                                                                    process.indexOf(
                                                                            e) +
                                                                        1 &&
                                                                fadeCnt < 6
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .grayColor,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : fadeCnt == process.indexOf(e) + 1 &&
                                                  fadeCnt < 6
                                              ? fadeCnt == 1
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.007,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.01,
                                                            decoration: BoxDecoration(
                                                                color: e.rating > 4 && fadeCnt >= process.indexOf(e) + 1
                                                                    ? Colors.white
                                                                    : fadeCnt == process.indexOf(e) + 1 && fadeCnt < 6
                                                                        ? Colors.white
                                                                        : ColorSelect.grayColor,
                                                                shape: BoxShape.circle),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.001,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: e.rating >
                                                                          4 &&
                                                                      fadeCnt >=
                                                                          process.indexOf(e) +
                                                                              1
                                                                  ? Colors.white
                                                                  : fadeCnt == process.indexOf(e) + 1 &&
                                                                          fadeCnt <
                                                                              6
                                                                      ? Colors
                                                                          .white
                                                                      : ColorSelect
                                                                          .grayColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Column(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.001,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: e.rating >
                                                                        4 &&
                                                                    fadeCnt >=
                                                                        process.indexOf(e) +
                                                                            1
                                                                ? Colors.white
                                                                : fadeCnt ==
                                                                            process.indexOf(e) +
                                                                                1 &&
                                                                        fadeCnt <
                                                                            6
                                                                    ? Colors
                                                                        .white
                                                                    : ColorSelect
                                                                        .grayColor,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.007,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: e.rating >
                                                                              4 &&
                                                                          fadeCnt >=
                                                                              process.indexOf(e) +
                                                                                  1
                                                                      ? Colors
                                                                          .white
                                                                      : fadeCnt == process.indexOf(e) + 1 &&
                                                                              fadeCnt <
                                                                                  6
                                                                          ? Colors
                                                                              .white
                                                                          : ColorSelect
                                                                              .grayColor,
                                                                  shape: BoxShape
                                                                      .circle),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.001,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: e.rating >
                                                                        4 &&
                                                                    fadeCnt >=
                                                                        process.indexOf(e) +
                                                                            1
                                                                ? Colors.white
                                                                : fadeCnt ==
                                                                            process.indexOf(e) +
                                                                                1 &&
                                                                        fadeCnt <
                                                                            6
                                                                    ? Colors
                                                                        .white
                                                                    : ColorSelect
                                                                        .grayColor,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 15),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.0065,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          142, 148, 189, 1),
                                                      shape: BoxShape.circle),
                                                ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.19,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        child: Text(
                                          e.contents,
                                          textScaleFactor: FontSize.h7,
                                          style: TextStyle(
                                              color: e.rating > 4 &&
                                                      fadeCnt >=
                                                          process.indexOf(e) + 1
                                                  ? Colors.white
                                                  : fadeCnt ==
                                                              process.indexOf(
                                                                      e) +
                                                                  1 &&
                                                          fadeCnt < 6
                                                      ? Colors.white
                                                      : ColorSelect.grayColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 15),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.027,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        decoration: BoxDecoration(
                                            color: e.rating > 2
                                                ? e.rating > 4
                                                    ? ColorSelect.redColor
                                                    : Color.fromRGBO(
                                                        252, 200, 57, 1)
                                                : ColorSelect.tableColor,
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Center(
                                          child: Text(
                                            e.rating.toString(),
                                            textScaleFactor: FontSize.h4,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: e.rating > 2
                                                    ? Colors.white
                                                    : ColorSelect
                                                        .headTextColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )))
                          .toList(),
                    ),
                  ],
                ),
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
                            'http://106.255.245.242:39104/video/5.안전장구착용여부확인_10s-converted.mp4');
                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // VideoStatus.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // CameraPlayer.state.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/5.안전장구착용여부확인_10s.mp4');
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
                            'http://106.255.245.242:39104/video/7.위험상황알림_7s-converted.mp4');
                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // VideoStatus.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');

                        // CameraPlayer.state.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/7.위험상황알림_7s.mp4');
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

class SingleRiskState {
  SingleRiskState(
      {required this.progress, required this.contents, required this.rating});

  String progress;
  String contents;
  int rating;
}
