import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/CameraPlayer.dart';

class B02 extends StatefulWidget {
  B02(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  final _B02State state = _B02State();

  void onSelectWorker(int index) {
    state.onSelectWorker(index);
  }

  @override
  State<B02> createState() => state;
}

class _B02State extends State<B02> {
  late ProgressTimeline progressTimeline;

  int selectedIndex = 0;
  final _controller = ScrollController();

  late Timer _timer;

  int fadeCnt = 0;
  int workNm = 0;

  List<RowState> allStages = List.empty(growable: true);
  late RowState PmisRow;

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
      RowState(name: "작업자A", Pmis1: [
        PmisRowState(
            contents: "음주 및 약물복용 / 신체상태 이상",
            isChecked: [false, false],
            type: "1"),
      ], Pmis2: [
        PmisRowState(
            contents: "분담작업 시행의지 / 가정사 등 스트레스",
            isChecked: [false, false],
            type: "2"),
      ], Pmis3: [
        PmisRowState(
            contents: "분담작업 내용 숙지 / 안전작업수칙 숙지",
            isChecked: [false, false],
            type: "2"),
      ], Pmis4: [
        PmisRowState(
            contents: "충분한 숙면 여부 / 지시사항 반응 정도",
            isChecked: [false, false],
            type: "2"),
      ]),
      RowState(name: "작업자B", Pmis1: [
        PmisRowState(
            contents: "음주 및 약물복용 / 신체상태 이상",
            isChecked: [false, false],
            type: "1"),
      ], Pmis2: [
        PmisRowState(
            contents: "분담작업 시행의지 / 가정사 등 스트레스",
            isChecked: [false, false],
            type: "2"),
      ], Pmis3: [
        PmisRowState(
            contents: "분담작업 내용 숙지 / 안전작업수치 숙지",
            isChecked: [false, false],
            type: "2"),
      ], Pmis4: [
        PmisRowState(
            contents: "충분한 숙면 여부 / 지시사항 반응 정도",
            isChecked: [false, false],
            type: "2"),
      ]),
    ];

    PmisRow = allStages[selectedIndex];

    startProc();
    super.initState();
    HealthStatus.bodyStatus = 1;
    HealthStatus.stressStatus = 0;

    _timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      setState(() {
        fadeCnt++;
        // controller.reverse();
        // print(fadeCnt);
        if (fadeCnt >= 5) {
          onSelectWorker(1);
        }
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
        //슬라이드탭버튼
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
                  // width: MediaQuery.of(context).size.width * 0.291,
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
        //버튼내용
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 17.0),
                    //title + 무/유 버튼 박스
                    child: Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '신체 (Physical)',
                          textScaleFactor: FontSize.h4_5,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        children: PmisRow.Pmis1.map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: 10),
                                  child: Text(
                                    e.contents,
                                    textScaleFactor: FontSize.h5,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xfff9f9f9),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  margin: EdgeInsets.only(right: 8),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: ToggleButtons(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderColor: Color(0xffb7b7b7),
                                    fillColor: workNm >= 1
                                        ? fadeCnt ==
                                                allStages[1].Pmis1.indexOf(e) +
                                                    6
                                            ? Colors.red[50]
                                            : Color(0xffe2e6ff)
                                        : fadeCnt ==
                                                allStages[0].Pmis1.indexOf(e) +
                                                    1
                                            ? Colors.red[50]
                                            : Color(0xffe2e6ff),
                                    selectedColor: ColorSelect.blueColor,
                                    selectedBorderColor: ColorSelect.blueColor,
                                    color: Color(0xffb7b7b7),
                                    constraints: BoxConstraints.expand(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5.65),
                                    children: <Widget>[
                                      Text(e.type == "1" ? "무" : "양",
                                          textScaleFactor: FontSize.h5,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      Text(e.type == "1" ? "유" : "불",
                                          textScaleFactor: FontSize.h5,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                    onPressed: (int index) {
                                      setState(() {
                                        for (int i = 0;
                                            i < e.isChecked.length;
                                            i++) {
                                          if (i == index) {
                                            if (e.isChecked[i] != true) {
                                              e.isChecked[i] = !e.isChecked[i];
                                            }
                                          } else {
                                            e.isChecked[i] = false;
                                          }
                                        }
                                      });
                                    },
                                    isSelected: [
                                      workNm >= 1
                                          ? fadeCnt >=
                                                  allStages[1]
                                                          .Pmis1
                                                          .indexOf(e) +
                                                      6
                                              ? true
                                              : false
                                          : fadeCnt >=
                                                  allStages[0]
                                                          .Pmis1
                                                          .indexOf(e) +
                                                      1
                                              ? true
                                              : false,
                                      false
                                    ],
                                  ),
                                ),
                              ],
                            )).toList(),
                      )
                    ])),
                Container(
                    margin: EdgeInsets.only(bottom: 17.0),
                    //title + 무/유 버튼 박스
                    child: Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '정신 (Mental)',
                          textScaleFactor: FontSize.h4_5,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        children: PmisRow.Pmis2.map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: 10),
                                  child: Text(
                                    e.contents,
                                    textScaleFactor: FontSize.h5,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xfff9f9f9),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  margin: EdgeInsets.only(right: 8),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: ToggleButtons(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderColor: Color(0xffb7b7b7),
                                    fillColor: workNm >= 1
                                        ? fadeCnt ==
                                                allStages[1].Pmis2.indexOf(e) +
                                                    7
                                            ? Colors.red[50]
                                            : Color(0xffe2e6ff)
                                        : fadeCnt ==
                                                allStages[0].Pmis2.indexOf(e) +
                                                    2
                                            ? Colors.red[50]
                                            : Color(0xffe2e6ff),
                                    selectedColor: ColorSelect.blueColor,
                                    selectedBorderColor: ColorSelect.blueColor,
                                    color: Color(0xffb7b7b7),
                                    constraints: BoxConstraints.expand(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5.65),
                                    children: <Widget>[
                                      Text(e.type == "1" ? "무" : "양",
                                          textScaleFactor: FontSize.h5,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      Text(e.type == "1" ? "유" : "불",
                                          textScaleFactor: FontSize.h5,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                    onPressed: (int index) {
                                      setState(() {
                                        for (int i = 0;
                                            i < e.isChecked.length;
                                            i++) {
                                          if (i == index) {
                                            if (e.isChecked[i] != true) {
                                              e.isChecked[i] = !e.isChecked[i];
                                            }
                                          } else {
                                            e.isChecked[i] = false;
                                          }
                                        }
                                      });
                                    },
                                    isSelected: [
                                      workNm >= 1
                                          ? fadeCnt >=
                                                  allStages[1]
                                                          .Pmis2
                                                          .indexOf(e) +
                                                      7
                                              ? true
                                              : false
                                          : fadeCnt >=
                                                  allStages[0]
                                                          .Pmis2
                                                          .indexOf(e) +
                                                      2
                                              ? true
                                              : false,
                                      false
                                    ],
                                  ),
                                ),
                              ],
                            )).toList(),
                      )
                    ])),
                Container(
                    margin: EdgeInsets.only(bottom: 17.0),
                    //title + 무/유 버튼 박스
                    child: Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '지성 (Intelligent)',
                          textScaleFactor: FontSize.h4_5,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        children: PmisRow.Pmis3.map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: 10),
                                  child: Text(
                                    e.contents,
                                    textScaleFactor: FontSize.h5,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xfff9f9f9),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  margin: EdgeInsets.only(right: 8),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: ToggleButtons(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderColor: Color(0xffb7b7b7),
                                    fillColor: workNm >= 1
                                        ? fadeCnt ==
                                                allStages[1].Pmis3.indexOf(e) +
                                                    8
                                            ? Colors.red[50]
                                            : Color(0xffe2e6ff)
                                        : fadeCnt ==
                                                allStages[0].Pmis3.indexOf(e) +
                                                    3
                                            ? Colors.red[50]
                                            : Color(0xffe2e6ff),
                                    selectedColor: ColorSelect.blueColor,
                                    selectedBorderColor: ColorSelect.blueColor,
                                    color: Color(0xffb7b7b7),
                                    constraints: BoxConstraints.expand(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5.65),
                                    children: <Widget>[
                                      Text(e.type == "1" ? "무" : "양",
                                          textScaleFactor: FontSize.h5,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      Text(e.type == "1" ? "유" : "불",
                                          textScaleFactor: FontSize.h5,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                    onPressed: (int index) {
                                      setState(() {
                                        for (int i = 0;
                                            i < e.isChecked.length;
                                            i++) {
                                          if (i == index) {
                                            if (e.isChecked[i] != true) {
                                              e.isChecked[i] = !e.isChecked[i];
                                            }
                                          } else {
                                            e.isChecked[i] = false;
                                          }
                                        }
                                      });
                                    },
                                    isSelected: [
                                      workNm >= 1
                                          ? fadeCnt >=
                                                  allStages[1]
                                                          .Pmis3
                                                          .indexOf(e) +
                                                      8
                                              ? true
                                              : false
                                          : fadeCnt >=
                                                  allStages[0]
                                                          .Pmis3
                                                          .indexOf(e) +
                                                      3
                                              ? true
                                              : false,
                                      false
                                    ],
                                  ),
                                ),
                              ],
                            )).toList(),
                      )
                    ])),
                Container(
                    margin: EdgeInsets.only(bottom: 17.0),
                    //title + 무/유 버튼 박스
                    child: Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '감성 (Sensible)',
                          textScaleFactor: FontSize.h4_5,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        children: PmisRow.Pmis4.map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: 10),
                                  child: Text(
                                    e.contents,
                                    textScaleFactor: FontSize.h5,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xfff9f9f9),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  margin: EdgeInsets.only(right: 8),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: ToggleButtons(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderColor: Color(0xffb7b7b7),
                                    fillColor: workNm >= 1
                                        ? fadeCnt ==
                                                allStages[1].Pmis4.indexOf(e) +
                                                    9
                                            ? Colors.red[50]
                                            : Color(0xffe2e6ff)
                                        : fadeCnt ==
                                                allStages[0].Pmis4.indexOf(e) +
                                                    4
                                            ? Colors.red[50]
                                            : Color(0xffe2e6ff),
                                    selectedColor: ColorSelect.blueColor,
                                    selectedBorderColor: ColorSelect.blueColor,
                                    color: Color(0xffb7b7b7),
                                    constraints: BoxConstraints.expand(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5.65),
                                    children: <Widget>[
                                      Text(e.type == "1" ? "무" : "양",
                                          textScaleFactor: FontSize.h5,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      Text(e.type == "1" ? "유" : "불",
                                          textScaleFactor: FontSize.h5,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                    onPressed: (int index) {
                                      setState(() {
                                        for (int i = 0;
                                            i < e.isChecked.length;
                                            i++) {
                                          if (i == index) {
                                            if (e.isChecked[i] != true) {
                                              e.isChecked[i] = !e.isChecked[i];
                                            }
                                          } else {
                                            e.isChecked[i] = false;
                                          }
                                        }
                                      });
                                    },
                                    isSelected: [
                                      workNm >= 1
                                          ? fadeCnt >=
                                                  allStages[1]
                                                          .Pmis4
                                                          .indexOf(e) +
                                                      9
                                              ? true
                                              : false
                                          : fadeCnt >=
                                                  allStages[0]
                                                          .Pmis4
                                                          .indexOf(e) +
                                                      4
                                              ? true
                                              : false,
                                      false
                                    ],
                                  ),
                                ),
                              ],
                            )).toList(),
                      )
                    ]))
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
                            'http://106.255.245.242:39104/video/1.작업신원확인_5s-converted.mp4');
                        // VideoStatus.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');

                        // CameraPlayer.state.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/1.작업신원확인_5s.mp4');
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
                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        VideoStatus.controller.setMediaFromNetwork(
                            'http://106.255.245.242:39104/video/3.작업자PMISCheck(수치)_10s-converted.mp4');
                        // VideoStatus.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // CameraPlayer.state.setVideoCheing(
                        //     'http://106.255.245.242:39104/video/3.작업자PMISCheck(수치)_10s.MOV');
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

  final B02 widget;

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

class RowState {
  RowState(
      {required this.name,
      required this.Pmis1,
      required this.Pmis2,
      required this.Pmis3,
      required this.Pmis4});

  String name;
  List<PmisRowState> Pmis1;
  List<PmisRowState> Pmis2;
  List<PmisRowState> Pmis3;
  List<PmisRowState> Pmis4;
}

class PmisRowState {
  String contents;
  String type;
  List<bool> isChecked;

  PmisRowState({
    required this.contents,
    required this.type,
    required this.isChecked,
  });
}
