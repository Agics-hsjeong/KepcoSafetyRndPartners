import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/designModel.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/pages/HomePage.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/CameraPlayer.dart';
import 'package:kepco_safety_iot/pages/TodaysPage.dart';

class B08 extends StatefulWidget {
  const B08(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<B08> createState() => _B08State();
}

class _B08State extends State<B08> {
  late ProgressTimeline progressTimeline;
  List<CautionState> allStages = List.empty(growable: true);

  late Timer _timer;
  late Timer _timer2;
  int fadeCnt = 0;

  ScrollController _scrollController = ScrollController();

  void scrollDown() {
    Timer(Duration(seconds: 1), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 20),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

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

    allStages = [
      CautionState(contents: "활선작업차의 접지를 철거한다."),
      CautionState(contents: "공사안내표지판, 교통안전표지판, 라바콘, 구획로프 등을 철거한다."),
      CautionState(contents: "민원이 발생되지 않도록 현장주변을 정리한다."),
    ];

    _timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      setState(() {
        fadeCnt++;
      });
    });

    startProc();
    super.initState();
    HealthStatus.bodyStatus = 0;
    HealthStatus.stressStatus = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    _timer2.cancel();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 8, bottom: 10),
                  child: Text(
                    "위험사항 체크",
                    textScaleFactor: FontSize.h4,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "작업 마무리 시 방심 주의",
                    textScaleFactor: FontSize.h5,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Column(
                    children: allStages
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      size: 20,
                                      color: ColorSelect.greenColor,
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    Text(
                                      e.contents,
                                      textScaleFactor: FontSize.h6,
                                      style: TextStyle(
                                          color: ColorSelect.moregrayColor),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList()),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "작업 사진",
                    textScaleFactor: FontSize.h4,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            fadeCnt >= 1
                                ? Stack(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.17,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.18,
                                          child: Image.asset(
                                            "assets/img/작업완료4.png",
                                            fit: BoxFit.fill,
                                          )),
                                      Positioned(
                                        right: 5,
                                        child: Icon(
                                          Icons.close_rounded,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.17,
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                  ),
                            fadeCnt >= 2
                                ? Stack(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.17,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.18,
                                          child: Image.asset(
                                            "assets/img/작업완료3.png",
                                            fit: BoxFit.fill,
                                          )),
                                      Positioned(
                                        right: 5,
                                        child: Icon(
                                          Icons.close_rounded,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.17,
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                  ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          fadeCnt >= 3
                              ? Stack(
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.17,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.18,
                                        child: Image.asset(
                                          "assets/img/작업완료2.png",
                                          fit: BoxFit.fill,
                                        )),
                                    Positioned(
                                      right: 5,
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.17,
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                ),
                          fadeCnt >= 4
                              ? Stack(
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.17,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.18,
                                        child: Image.asset(
                                          "assets/img/작업완료1.png",
                                          fit: BoxFit.fill,
                                        )),
                                    Positioned(
                                      right: 5,
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.17,
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.05,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            color: ColorSelect.blueColor,
                            borderRadius: BorderRadius.circular(25)),
                        child: TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Text(
                                  "촬영",
                                  textScaleFactor: FontSize.h6,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                )
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
                      onPressed: () =>
                          ShowDialog.quitDialog(context, widget.stateTitle, () {
                        endProc();
                        Navigator.of(context).pop();

                        setState(() {
                          _timer2 = Timer(Duration(seconds: 1), () {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: Duration(seconds: 18),
                              curve: Curves.fastOutSlowIn,
                            );
                          });
                          isRisk = true;
                        });
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "종료",
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

class CautionState {
  String contents;

  CautionState({required this.contents});
}
