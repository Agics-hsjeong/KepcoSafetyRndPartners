import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:kepco_safety_iot/models/designModel.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/CameraPlayer.dart';

import 'B03.dart';

class B07 extends StatefulWidget {
  const B07(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<B07> createState() => _B07State();
}

class _B07State extends State<B07> {
  late ProgressTimeline progressTimeline;

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

  void showRiskPop() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          titlePadding: EdgeInsets.only(left: 10.0, right: 10.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Center(
                  child: Container(
                    width: 800,
                    height: 600,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 15, bottom: 20, left: 20, right: 20),
                              width: 420,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: const [
                                  BoxShadow(
                                    color: ColorSelect.redColor,
                                    spreadRadius: 1,
                                    blurRadius: 20,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "체온 이상 주의요망",
                                        textScaleFactor: FontSize.h4,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: ColorSelect.redColor),
                                      ),
                                      // Padding(
                                      //   padding:
                                      //       const EdgeInsets.only(bottom: 7.0),
                                      //   child: IconButton(
                                      //     padding: EdgeInsets.zero,
                                      //     constraints: BoxConstraints(),
                                      //     onPressed: () {
                                      //       Navigator.pop(context);
                                      //     },
                                      //     icon: Icon(
                                      //       Icons.close_rounded,
                                      //       color: ColorSelect.redColor,
                                      //       size: 33,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/체온이상팝업.svg',
                                    color: ColorSelect.redColor,
                                    width: 90,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '작업자A',
                                          textScaleFactor: FontSize.h4_5,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                            flex: 10, child: Dropdownwork()),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Flexible(
                                            flex: 2,
                                            child: SizedBox(
                                                height: 50,
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                      shape:
                                                          MaterialStateProperty
                                                              .all(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.black),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(ColorSelect
                                                                  .redColor)),
                                                  child: Text("확인",
                                                      textScaleFactor:
                                                          FontSize.h5,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();

                                                    HealthStatus.bodyStatus = 0;
                                                    HealthStatus.stressStatus =
                                                        0;
                                                    FadeIn.status = false;
                                                    Vibration.cancel();
                                                    // tts.pause();
                                                    isSpeak = false;
                                                    tts.stop();
                                                  },
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        // Container(
                        //   alignment: FractionalOffset(0.5, 0.17),
                        //   child: FractionallySizedBox(
                        //     widthFactor: 1 / 4,
                        //     heightFactor: 1 / 4,
                        //     child: Image.asset(
                        //       "assets/img/그룹 20783.png",
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  final FlutterTts tts = FlutterTts();
  final TextEditingController controller = TextEditingController(text: '위험합니다');

  late Timer _timer;
  late Timer _timer2;
  late Timer _tts_timer;
  int heart = 90;
  int fadeCnt = 0;

  bool isSpeak = true;
  _B07State() {
    tts.setLanguage('ko');
    tts.setSpeechRate(0.4);
  }

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;
    startProc();
    super.initState();
    FadeIn.status = true;
    selectedIndex = 0;
    Vibration.vibrate(
      pattern: [500, 1000, 500, 2000, 500, 3000, 500, 500],
      intensities: [0, 128, 0, 255, 0, 64, 0, 255],
    );

    HealthStatus.bodyStatus = 2;
    HealthStatus.stressStatus = 2;

    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        // print(fadeCnt);
        if (fadeCnt == 1) {
          showRiskPop();
        }
        // controller.reverse();

        fadeCnt++;
      });
    });
    _tts_timer = Timer.periodic(Duration(milliseconds: 1500), (timer) {
      setState(() {
        if (isSpeak) {
          tts.speak(controller.text);
        }
      });
    });
    _timer2 = Timer.periodic(Duration(milliseconds: 100), (timer) {
      int random1 = Random().nextInt(6) + 1;
      int random2 = Random().nextInt(6) + 1;

      setState(() {
        if (random1 == 3 || heart < 85) {
          heart++;
        } else if (random1 == 5 || heart > 145) {
          heart--;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    _timer2.cancel();
    _tts_timer.cancel();
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
        Column(
          children: [
            //내용시작
            Container(
              height: MediaQuery.of(context).size.height * 0.345,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 130,
                          height: 120,
                          child: Column(
                            children: [
                              Text(
                                "심박수",
                                textScaleFactor: FontSize.h4_5,
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: SvgPicture.asset(
                                  "assets/svg/심박수.svg",
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              fadeCnt >= 1
                                  ? Text(
                                      "${heart}bpm",
                                      textScaleFactor: FontSize.h4_5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455EEE),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                        Container(
                          width: 130,
                          height: 120,
                          child: Column(
                            children: [
                              Text(
                                "체온",
                                textScaleFactor: FontSize.h4_5,
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: SvgPicture.asset(
                                  "assets/svg/체온.svg",
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              fadeCnt >= 2
                                  ? Text(
                                      HealthStatus.bodyStatus == 0
                                          ? "37.5℃"
                                          : "39℃",
                                      textScaleFactor: FontSize.h4_5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455EEE),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                        Container(
                          width: 130,
                          height: 120,
                          child: Column(
                            children: [
                              Text(
                                "산소 포화도",
                                textScaleFactor: FontSize.h4_5,
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: SvgPicture.asset(
                                  "assets/svg/산소포화도.svg",
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              fadeCnt >= 3
                                  ? Text(
                                      HealthStatus.bodyStatus == 0
                                          ? "95%"
                                          : "70%",
                                      textScaleFactor: FontSize.h4_5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455EEE),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        )
                      ]),
                  Container(
                    height: 85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        fadeCnt >= 4
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: HealthStatus.bodyStatus == 2
                                          ? Color.fromRGBO(255, 96, 96, 1.0)
                                          : Color.fromRGBO(106, 219, 132, 1.0),
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                ),
                                width: 280,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 5.0,
                                      right: 5.0,
                                      bottom: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/신체이상종합판단.svg",
                                        color: HealthStatus.bodyStatus == 2
                                            ? Color.fromRGBO(255, 96, 96, 1.0)
                                            : Color.fromRGBO(
                                                106, 219, 132, 1.0),
                                        width: 30,
                                      ),
                                      Text(
                                        '작업자1',
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: HealthStatus.bodyStatus == 2
                                              ? Color.fromRGBO(255, 96, 96, 1.0)
                                              : Color.fromRGBO(
                                                  106, 219, 132, 1.0),
                                        ),
                                      ),
                                      Text(
                                        "생체 정보",
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: HealthStatus.bodyStatus == 2
                                              ? Color.fromRGBO(255, 96, 96, 1.0)
                                              : Color.fromRGBO(
                                                  106, 219, 132, 1.0),
                                        ),
                                      ),
                                      Text(
                                        HealthStatus.bodyStatus == 2
                                            ? '이상'
                                            : '정상',
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                            color: HealthStatus.bodyStatus == 2
                                                ? Color.fromRGBO(
                                                    255, 96, 96, 1.0)
                                                : Color.fromRGBO(
                                                    106, 219, 132, 1.0),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.345,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 130,
                          height: 120,
                          child: Column(
                            children: [
                              Text(
                                "뇌파",
                                textScaleFactor: FontSize.h4_5,
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: SvgPicture.asset(
                                  "assets/svg/뇌파.svg",
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              fadeCnt >= 5
                                  ? Text(
                                      HealthStatus.stressStatus == 2
                                          ? "위험"
                                          : "정상",
                                      textScaleFactor: FontSize.h4_5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455EEE),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                        // Container(
                        //   width: 130,
                        //   height: 120,
                        //   child: Column(
                        //     children: [
                        //       Text(
                        //         "체온",
                        //         textScaleFactor: FontSize.h4_5,
                        //         style: TextStyle(
                        //             color: Color(0xff000000),
                        //             fontWeight: FontWeight.w500),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 15.0),
                        //         child: SvgPicture.asset(
                        //           "assets/svg/체온.svg",
                        //           height: 40,
                        //           width: 40,
                        //           fit: BoxFit.scaleDown,
                        //         ),
                        //       ),
                        //       fadeCnt >= 6
                        //           ? Text(
                        //               HealthStatus.stressStatus == 0
                        //                   ? "37.5℃"
                        //                   : "39℃",
                        //               textScaleFactor: FontSize.h4_5,
                        //               style: TextStyle(
                        //                 fontWeight: FontWeight.w600,
                        //                 color: Color(0xff455EEE),
                        //               ),
                        //             )
                        //           : SizedBox.shrink(),
                        //     ],
                        //   ),
                        // ),
                      ]),
                  Container(
                    height: 85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        fadeCnt >= 6
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: HealthStatus.bodyStatus == 2
                                          ? Color.fromRGBO(255, 96, 96, 1.0)
                                          : Color.fromRGBO(106, 219, 132, 1.0),
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                ),
                                width: 280,
                                margin: EdgeInsets.only(top: 20, bottom: 0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 5.0,
                                      right: 5.0,
                                      bottom: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/스트레스종합판단.svg",
                                        color: HealthStatus.bodyStatus == 2
                                            ? Color.fromRGBO(255, 96, 96, 1.0)
                                            : Color.fromRGBO(
                                                106, 219, 132, 1.0),
                                        width: 30,
                                      ),
                                      Text(
                                        '작업자1',
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: HealthStatus.bodyStatus == 2
                                              ? Color.fromRGBO(255, 96, 96, 1.0)
                                              : Color.fromRGBO(
                                                  106, 219, 132, 1.0),
                                        ),
                                      ),
                                      Text(
                                        "스트레스",
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: HealthStatus.bodyStatus == 2
                                              ? Color.fromRGBO(255, 96, 96, 1.0)
                                              : Color.fromRGBO(
                                                  106, 219, 132, 1.0),
                                        ),
                                      ),
                                      Text(
                                        HealthStatus.bodyStatus == 2
                                            ? '이상'
                                            : '정상',
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                            color: HealthStatus.bodyStatus == 2
                                                ? Color.fromRGBO(
                                                    255, 96, 96, 1.0)
                                                : Color.fromRGBO(
                                                    106, 219, 132, 1.0),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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
                            'http://106.255.245.242:39104/video/6.위험작업알림_18s-converted.mp4');
                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // VideoStatus.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // CameraPlayer.state.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/6.위험작업알림_18s.mp4');
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
                            'http://106.255.245.242:39104/video/8.작업종료_10s-converted.mp4');
                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // VideoStatus.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // CameraPlayer.state.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/8.작업종료_10s.mp4');
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

class Dropdownwork extends StatefulWidget {
  const Dropdownwork({Key? key}) : super(key: key);

  @override
  State<Dropdownwork> createState() => _DropdownworkState();
}

class _DropdownworkState extends State<Dropdownwork> {
  final List<String> items = [
    '조치완료',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: ColorSelect.grayColor,
                width: 1,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8)),
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.search,
                size: 26,
                color: Colors.white,
              ),
              Text(
                '조치상태',
                textScaleFactor: FontSize.h5,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: ColorSelect.grayColor,
                ),
              ),
            ],
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(
              () {
                selectedValue = value as String;
              },
            );
          },
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          iconEnabledColor: Color(0xffd5d5d5),
          iconSize: 35,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 0,
                  color: Color.fromRGBO(255, 193, 7, 0))
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
