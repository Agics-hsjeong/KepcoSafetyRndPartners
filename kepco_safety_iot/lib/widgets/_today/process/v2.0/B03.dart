import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/CameraPlayer.dart';

class B03 extends StatefulWidget {
  B03(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  final _B03State state = _B03State();

  void onSelectWorker(int index) {
    state.onSelectWorker(index);
  }

  @override
  State<B03> createState() => state;
}

class _B03State extends State<B03> {
  late ProgressTimeline progressTimeline;
  int selectedIndex = 0;

  late Timer _timer;
  late Timer _timer2;
  int fadeCnt = 0;
  int workNm = 0;

  final _controller = ScrollController();

  List<RowState_B> allStages = List.empty(growable: true);
  late RowState_B PmisRow;

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

  void onSelectWorker(int index) {
    setState(() {
      PmisRow = allStages[index];
      selectedIndex = index;
      workNm = index;
      _controller.animateTo(100.0 * selectedIndex,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn);
    });
  }

  void gotoNextWorker() {
    setState(() {
      if (selectedIndex < allStages.length - 1) {
        selectedIndex++;
        PmisRow = allStages[selectedIndex];
        _controller.animateTo(100.0 * selectedIndex,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      }
    });
  }

  void gotoPrevWorker() {
    setState(() {
      if (selectedIndex > 0) {
        selectedIndex--;
        PmisRow = allStages[selectedIndex];
        _controller.animateTo(100.0 * selectedIndex,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      }
    });
  }

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;

    allStages = [
      RowState_B(
          name: "작업자A",
          heart: 70,
          temperature: 36.5,
          oxygen: 99,
          brainWaves: "정상"),
      RowState_B(
          name: "작업자B",
          heart: 80,
          temperature: 36.7,
          oxygen: 98,
          brainWaves: "정상"),
    ];

    PmisRow = allStages[selectedIndex];

    startProc();
    super.initState();
    HealthStatus.bodyStatus = 1;
    HealthStatus.stressStatus = 0;

    _timer = Timer.periodic(Duration(milliseconds: 700), (timer) {
      setState(() {
        fadeCnt++;
        // controller.reverse();
        // print(fadeCnt);
        if (fadeCnt >= 8) {
          onSelectWorker(1);
        }
      });
    });

    _timer2 = Timer.periodic(Duration(milliseconds: 100), (timer) {
      int random1 = Random().nextInt(6) + 1;
      int random2 = Random().nextInt(6) + 1;

      setState(() {
        if (random1 == 3 || allStages[0].heart < 85) {
          allStages[0].heart++;
        } else if (random1 == 5 || allStages[0].heart > 145) {
          allStages[0].heart--;
        }

        if (random2 == 3 || allStages[1].heart < 85) {
          allStages[1].heart++;
        } else if (random2 == 5 || allStages[1].heart > 145) {
          allStages[1].heart--;
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
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                "| ${widget.stateTitle}",
                textScaleFactor: FontSize.h4_5,
                style: const TextStyle(
                    color: ColorSelect.blueColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        //작업자선택 슬라이드 버튼
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.065,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //왼쪽 슬라이드 버튼
                Container(
                  height: MediaQuery.of(context).size.height * 0.065,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: IconButton(
                    padding: EdgeInsets.zero, // 패딩 설정
                    constraints: BoxConstraints(), // constraints
                    splashRadius: 20.0,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: ColorSelect.blueColor,
                    ),
                    onPressed: () {
                      gotoPrevWorker();
                    },
                  ),
                ),
                //슬라이드 선택 박스
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    itemCount: allStages.length,
                    itemBuilder: (context, index) => buildStates()[index],
                  ),
                ),
                //오른쪽 슬라이드 버튼
                Container(
                  height: MediaQuery.of(context).size.height * 0.065,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: IconButton(
                    padding: EdgeInsets.zero, // 패딩 설정
                    constraints: BoxConstraints(), // constraints
                    splashRadius: 20.0,
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorSelect.blueColor,
                    ),
                    onPressed: () {
                      gotoNextWorker();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.32,
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
                              workNm == 1
                                  ? fadeCnt >= 9
                                      ? Text(
                                          PmisRow.heart.toString() + "bpm",
                                          textScaleFactor: FontSize.h4_5,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455EEE),
                                          ),
                                        )
                                      : SizedBox.shrink()
                                  : fadeCnt >= 1
                                      ? Text(
                                          PmisRow.heart.toString() + "bpm",
                                          textScaleFactor: FontSize.h4_5,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455EEE),
                                          ),
                                        )
                                      : SizedBox.shrink()
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
                              workNm == 1
                                  ? fadeCnt >= 10
                                      ? Text(
                                          PmisRow.temperature.toString() + "℃",
                                          textScaleFactor: FontSize.h4_5,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455EEE),
                                          ),
                                        )
                                      : SizedBox.shrink()
                                  : fadeCnt >= 2
                                      ? Text(
                                          PmisRow.temperature.toString() + "℃",
                                          textScaleFactor: FontSize.h4_5,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455EEE),
                                          ),
                                        )
                                      : SizedBox.shrink()
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
                              workNm == 1
                                  ? fadeCnt >= 11
                                      ? Text(
                                          PmisRow.oxygen.toString() + "%",
                                          textScaleFactor: FontSize.h4_5,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455EEE),
                                          ),
                                        )
                                      : SizedBox.shrink()
                                  : fadeCnt >= 3
                                      ? Text(
                                          PmisRow.oxygen.toString() + "%",
                                          textScaleFactor: FontSize.h4_5,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455EEE),
                                          ),
                                        )
                                      : SizedBox.shrink()
                            ],
                          ),
                        )
                      ]),
                  Container(
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        workNm == 1
                            ? fadeCnt >= 12
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.greenColor,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                    width: 280,
                                    margin: EdgeInsets.only(top: 20, bottom: 0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0,
                                          left: 5.0,
                                          right: 5.0,
                                          bottom: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/신체이상종합판단.svg",
                                            color: ColorSelect.greenColor,
                                            width: 25,
                                          ),
                                          Text(
                                            "생체이상 종합 판단",
                                            textScaleFactor: FontSize.h4_5,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '정상',
                                            textScaleFactor: FontSize.h4_5,
                                            style: TextStyle(
                                                color: ColorSelect.greenColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink()
                            : fadeCnt >= 4
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.greenColor,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                    width: 280,
                                    margin: EdgeInsets.only(top: 20, bottom: 0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0,
                                          left: 5.0,
                                          right: 5.0,
                                          bottom: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/신체이상종합판단.svg",
                                            color: ColorSelect.greenColor,
                                            width: 25,
                                          ),
                                          Text(
                                            "생체이상 종합 판단",
                                            textScaleFactor: FontSize.h4_5,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '정상',
                                            textScaleFactor: FontSize.h4_5,
                                            style: TextStyle(
                                                color: ColorSelect.greenColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.32,
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
                              workNm == 1
                                  ? fadeCnt >= 13
                                      ? Text(
                                          PmisRow.brainWaves,
                                          textScaleFactor: FontSize.h4_5,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455EEE),
                                          ),
                                        )
                                      : SizedBox.shrink()
                                  : fadeCnt >= 5
                                      ? Text(
                                          PmisRow.brainWaves,
                                          textScaleFactor: FontSize.h4_5,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455EEE),
                                          ),
                                        )
                                      : SizedBox.shrink()
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
                        //       workNm == 1
                        //           ? fadeCnt >= 14
                        //               ? Text(
                        //                   PmisRow.temperature.toString() + "℃",
                        //                   textScaleFactor: FontSize.h4_5,
                        //                   style: TextStyle(
                        //                     fontWeight: FontWeight.w600,
                        //                     color: Color(0xff455EEE),
                        //                   ),
                        //                 )
                        //               : SizedBox.shrink()
                        //           : fadeCnt >= 6
                        //               ? Text(
                        //                   PmisRow.temperature.toString() + "℃",
                        //                   textScaleFactor: FontSize.h4_5,
                        //                   style: TextStyle(
                        //                     fontWeight: FontWeight.w600,
                        //                     color: Color(0xff455EEE),
                        //                   ),
                        //                 )
                        //               : SizedBox.shrink()
                        //     ],
                        //   ),
                        // ),
                      ]),
                  Container(
                    height: 75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        workNm == 1
                            ? fadeCnt >= 15
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.greenColor,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                    width: 280,
                                    margin: EdgeInsets.only(top: 20, bottom: 0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0,
                                          left: 5.0,
                                          right: 5.0,
                                          bottom: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/스트레스종합판단.svg",
                                            color: ColorSelect.greenColor,
                                            width: 25,
                                          ),
                                          Text(
                                            "스트레스 종합 판단",
                                            textScaleFactor: FontSize.h4_5,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '정상',
                                            textScaleFactor: FontSize.h4_5,
                                            style: TextStyle(
                                                color: ColorSelect.greenColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink()
                            : fadeCnt >= 7
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.greenColor,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                    width: 280,
                                    margin: EdgeInsets.only(top: 20, bottom: 0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0,
                                          left: 5.0,
                                          right: 5.0,
                                          bottom: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/스트레스종합판단.svg",
                                            color: ColorSelect.greenColor,
                                            width: 25,
                                          ),
                                          Text(
                                            "스트레스 종합 판단",
                                            textScaleFactor: FontSize.h4_5,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '정상',
                                            textScaleFactor: FontSize.h4_5,
                                            style: TextStyle(
                                                color: ColorSelect.greenColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        //이전 다음 버튼
        Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
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
                            'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s-converted.mp4');
                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // VideoStatus.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // CameraPlayer.state.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
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
                            'http://106.255.245.242:39104/video/4.위험성평가_11s-converted.mp4');
                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // VideoStatus.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // CameraPlayer.state.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/4.위험성평가_11s.mp4');
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

  List<Widget> buildStates() {
    List<Widget> allStates = [];
    int len = allStages.length;

    for (var i = 0; i < len; i++) {
      allStates.add(_RenderedState(
        name: allStages[i].name,
        isCurrent: i == selectedIndex,
        index: i,
        widget: widget,
      ));
    }

    return allStates;
  }
}

class _RenderedState extends StatelessWidget {
  const _RenderedState({
    Key? key,
    required this.name,
    required this.isCurrent,
    required this.index,
    required this.widget,
  }) : super(key: key);

  final String name;
  final bool isCurrent;
  final int index;

  final B03 widget;

  Color getBackColor() {
    return isCurrent ? ColorSelect.blueColor : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12.0, top: 8.0, bottom: 8.0),
      width: MediaQuery.of(context).size.width * 0.13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isCurrent
                ? Color.fromRGBO(69, 94, 238, 0.5)
                : Color.fromRGBO(160, 160, 160, 0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(2, 2),
          ),
        ],
        color: getBackColor(),
      ),
      child: OutlinedButton(
        child: Text(
          name,
          textScaleFactor: FontSize.h5,
          style: TextStyle(
              color: isCurrent ? Colors.white : ColorSelect.grayColor),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 0.0, color: Colors.transparent),
        ),
        onPressed: () {
          widget.onSelectWorker(index);
        },
      ),
    );
  }
}

class RowState_B {
  RowState_B({
    required this.name,
    required this.heart,
    required this.temperature,
    required this.oxygen,
    required this.brainWaves,
  });

  String name;
  int heart;
  double temperature;
  int oxygen;
  String brainWaves;
}
