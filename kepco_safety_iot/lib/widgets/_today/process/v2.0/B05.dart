import 'dart:math';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/models/designModel.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:kepco_safety_iot/widgets/common/CameraPlayer.dart';

class B05 extends StatefulWidget {
  const B05(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<B05> createState() => _B05State();
}

class _B05State extends State<B05> {
  late ProgressTimeline progressTimeline;
  late Timer _timer;

  int count = 0;
  int fadeCnt = 0;
  bool isFirst = false;
  bool isFinding = false;

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

  List<UserState_B> userStages = List.empty(growable: true);

  void getWorker() {
    if (count == 0) {
      var rendom1 = Random().nextInt(2);
      var rendom2 = Random().nextInt(2);
      var rendom3 = Random().nextInt(2);
      setState(() {
        userStages.add(
          UserState_B(
            name: "작업자A",
            age: "52",
            sex: "남",
            depart: "(주)금광전기",
            operatorNo: "GRM-201255445",
            career: "15",
            qualification: "N",
            deadline: "35",
            imgUrl1: "assets/img/작업자1.png",
            imgUrl2: "assets/img/작업자1전신.png",
            equi: [
              EquipState_B(
                equipName: "안전모",
                isCheck: true,
                analyze: true,
              ),
              EquipState_B(
                equipName: "방염복",
                isCheck: true,
                analyze: true,
              ),
              EquipState_B(
                equipName: "안전화",
                isCheck: true,
                analyze: true,
              ),
              EquipState_B(
                equipName: "안전화",
                isCheck: true,
                analyze: true,
              ),
            ],
          ),
        );
      });
    } else if (count == 1) {
      var rendom1 = Random().nextInt(2);
      var rendom2 = Random().nextInt(2);
      var rendom3 = Random().nextInt(2);
      setState(() {
        userStages.add(
          UserState_B(
            name: "작업자B",
            age: "48",
            sex: "남",
            depart: "(주)금광전기",
            operatorNo: "GRM-201255458",
            career: "12",
            qualification: "N",
            deadline: "15",
            imgUrl1: "assets/img/작업자2.png",
            imgUrl2: "assets/img/작업자2전신.png",
            equi: [
              EquipState_B(
                equipName: "안전모",
                isCheck: true,
                analyze: true,
              ),
              EquipState_B(
                equipName: "방염복",
                isCheck: true,
                analyze: true,
              ),
              EquipState_B(
                equipName: "안전화",
                isCheck: true,
                analyze: true,
              ),
              EquipState_B(
                equipName: "안전화",
                isCheck: true,
                analyze: true,
              ),
            ],
          ),
        );
      });
    } else {
      _timer.cancel();
      setState(() {
        isFinding = false;
        isFirst = true;
        _timer = Timer.periodic(Duration(milliseconds: 700), (timer) {
          setState(() {
            fadeCnt++;

            if (fadeCnt == 1) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return WorkerPopup_B(
                    userState: userStages[0],
                    personChk: false,
                    list: userStages,
                  );
                },
              );
            }

            if (fadeCnt == 5) {
              if (isChecked == false) {
                Navigator.of(context).pop();
              } else {
                _timer.cancel();
              }
            }
          });
        });
      });
    }

    // print(count);
    count++;
  }

  void findWorker() {
    setState(() {
      isFinding = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      getWorker();
    });
  }

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;
    findWorker();

    startProc();
    super.initState();
    HealthStatus.bodyStatus = 1;
    HealthStatus.stressStatus = 0;
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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "| ${widget.stateTitle}",
              textScaleFactor: FontSize.h4_5,
              style: const TextStyle(
                  color: ColorSelect.blueColor, fontWeight: FontWeight.bold),
            ),
            isFirst
                ? count >= userStages.length
                    ? SizedBox.shrink()
                    : InkWell(
                        onTap: () {
                          setState(() {
                            isFirst = false;
                          });
                          findWorker();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.cached_rounded,
                              color: ColorSelect.blueColor,
                            ),
                            Text(
                              " 인식 재시작",
                              style: const TextStyle(
                                  fontSize: 20, color: ColorSelect.blueColor),
                            ),
                          ],
                        ),
                      )
                : SizedBox.shrink(),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 7, right: 7, left: 5),
                  child: GridView.builder(
                    itemCount: userStages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    itemBuilder: (context, int index) {
                      // return Text("${userStages[index].name}");
                      return WorkerBox_B(
                        userState: userStages[index],
                        index: index,
                        allList: userStages,
                      );
                    },
                  ),
                ),
              ),
              isFirst
                  ? const SizedBox.shrink()
                  : ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Container(
                          color: Color.fromRGBO(255, 255, 255, 0.6),
                        ),
                      ),
                    ),
              isFirst
                  ? const SizedBox.shrink()
                  : Center(
                      child: Padding(
                        padding: isFinding
                            ? const EdgeInsets.only(top: 120.0)
                            : const EdgeInsets.only(top: 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shadowColor: ColorSelect.blueColor,
                                      primary: isFinding
                                          ? Colors.white
                                          : ColorSelect.blueColor,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                  child: Icon(
                                    isFinding
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    size: 60,
                                    color: isFinding
                                        ? ColorSelect.blueColor
                                        : null,
                                  ),
                                  onPressed: () {
                                    findWorker();
                                  },
                                ),
                                isFinding
                                    ? TextButton(
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 1)),
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            backgroundColor:
                                                ColorSelect.blueColor,
                                            strokeWidth: 10.0,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _timer.cancel();
                                            isFinding = false;
                                            isFirst = true;
                                          });
                                        },
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                isFinding ? '인식중 입니다' : '인식 시작',
                                textScaleFactor: FontSize.h2_5,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 35.0),
                              child: Text(
                                isFinding ? "" : '제대로 된 인식을 위해',
                                textScaleFactor: FontSize.h3,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      isFinding ? "" : '카메라위치조정',
                                      textScaleFactor: FontSize.h3,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: ColorSelect.blueColor,
                                          height: 1.2),
                                    ),
                                    Text(
                                      isFinding ? "" : '을 해주세요',
                                      textScaleFactor: FontSize.h3,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          height: 1.2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
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
                            'http://106.255.245.242:39104/video/6.위험작업알림_18s-converted.mp4');
                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
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

class WorkerBox_B extends StatefulWidget {
  const WorkerBox_B({
    Key? key,
    required this.allList,
    required this.userState,
    required this.index,
  }) : super(key: key);
  final List<UserState_B> allList;
  final UserState_B userState;
  final int index;

  @override
  State<WorkerBox_B> createState() => _WorkerBox_BState();
}

class _WorkerBox_BState extends State<WorkerBox_B> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(54, 187, 187, 187),
            blurRadius: 2.5,
            spreadRadius: 2.5,
            offset: Offset(1.5, 1.5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return WorkerPopup_B(
                userState: widget.userState,
                personChk: false,
                list: widget.allList,
              );
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.userState.imgUrl1 == ""
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 227, 229, 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.report_problem_outlined,
                          size: 70,
                          color: Color.fromRGBO(255, 96, 96, 1),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(widget.userState.imgUrl1),
                        fit: BoxFit.contain,
                      ),
                    ),
                    // child: CircleAvatar(
                    //   radius: 50,
                    //   backgroundColor: Colors.white,
                    //   backgroundImage: AssetImage(widget.userState.imgUrl),
                    // ),
                  ),
            Text("작업자${widget.index + 1}",
                textAlign: TextAlign.center,
                textScaleFactor: FontSize.h4,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: widget.userState.name == ""
                        ? Color.fromRGBO(255, 96, 96, 1)
                        : Color.fromRGBO(80, 93, 112, 1))),
            Text(
              widget.userState.name == ""
                  ? "작업자를 수동 선택 해주세요"
                  : widget.userState.name,
              textAlign: TextAlign.center,
              textScaleFactor: FontSize.h5,
              style: TextStyle(
                fontWeight: widget.userState.name == ""
                    ? FontWeight.normal
                    : FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkerPopup_B extends StatefulWidget {
  const WorkerPopup_B({
    Key? key,
    required this.list,
    required this.userState,
    required this.personChk,
  }) : super(key: key);

  final UserState_B userState;
  final bool personChk;
  final List<UserState_B> list;

  @override
  State<WorkerPopup_B> createState() => _WorkerPopup_BState();
}

class _WorkerPopup_BState extends State<WorkerPopup_B> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.77,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //title
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "개인안전장구 착용",
                    textScaleFactor: FontSize.h4,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.close,
                      size: 37.0,
                      color: Color.fromRGBO(51, 65, 85, 1),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      isChecked = true;
                    },
                  ),
                ],
              ),
            ),
            //info table
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              child: Workerch_B(userState: widget.userState, list: widget.list),
            ),
            //자동체크수동체크
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              padding: EdgeInsets.only(right: 30),
              height: MediaQuery.of(context).size.height * 0.05,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: ColorSelect.greenColor2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "자동체크",
                          textScaleFactor: FontSize.h6,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: ColorSelect.redColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "수동체크",
                            textScaleFactor: FontSize.h6,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            //안전장구 착용 & 미착용
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.235,
              child: EquipBox_B(userState: widget.userState),
            ),
            //적용버튼
            Container(
              padding: EdgeInsets.only(bottom: 15),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: ColorSelect.blueColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                  child: const Text(
                    "적용",
                    textScaleFactor: FontSize.h6,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    isChecked = true;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Workerch_B extends StatefulWidget {
  Workerch_B({Key? key, required this.userState, required this.list})
      : super(key: key);
  final List<UserState_B> list;
  final UserState_B userState;
  final _Workerch_BState state = _Workerch_BState();

  @override
  _Workerch_BState createState() => state;
}

class _Workerch_BState extends State<Workerch_B> {
  List<String> items = List.empty(growable: true);
  late UserState_B chkUserInfo;
  String? selectedValue;

  @override
  void initState() {
    setState(() {
      items = [
        "작업자A",
        "작업자B",
      ];
      chkUserInfo = widget.userState;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: Image.asset(
                chkUserInfo.imgUrl2,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.35,
              )),
          Expanded(
            flex: 1,
            child: Table(
              children: ["성명", "연령", "성별", "소속"]
                  .asMap()
                  .entries
                  .map(
                    (e) => TableRow(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 16.0),
                          height: 60.0,
                          child: Center(
                            child: Text(
                              e.value,
                              textScaleFactor: FontSize.h6,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Table(
              children: [
                chkUserInfo.name,
                chkUserInfo.age != "" ? "${chkUserInfo.age}세" : "",
                chkUserInfo.sex,
                chkUserInfo.depart
              ]
                  .asMap()
                  .entries
                  .map(
                    (e) => TableRow(
                      children: [
                        e.key == 0
                            ? Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            e.value == "" ? "작업자 선택" : e.value,
                                            textScaleFactor: FontSize.h6,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    items: items
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 13.0),
                                              child: Text(
                                                item,
                                                textScaleFactor: FontSize.h6,
                                                style: const TextStyle(),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          chkUserInfo = widget.list[
                                              items.indexOf(value as String)];
                                          // print(chkUserInfo);
                                          selectedValue = value as String;
                                          // print(selectedValue);
                                        },
                                      );
                                    },
                                    buttonHeight: 40,
                                    buttonWidth: 250,
                                    itemHeight: 40,
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorSelect.blueColor),
                                      color: Colors.white,
                                    ),
                                    dropdownPadding: null,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 20.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: ColorSelect.grayColor))),
                                height: 60.0,
                                child: Text(
                                  e.value,
                                  textScaleFactor: FontSize.h6,
                                ),
                              )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Table(
              children: ["작업자번호", "경력", "자격증", "자격 기한"]
                  .map(
                    (e) => TableRow(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 16, left: 25),
                          height: 60.0,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e,
                              textScaleFactor: FontSize.h6,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Table(
              children: [
                chkUserInfo.operatorNo,
                "${chkUserInfo.career}년",
                chkUserInfo.qualification == "Y" ? "있음" : "없음",
                "${chkUserInfo.deadline}일 남음"
              ]
                  .map(
                    (e) => TableRow(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 25.0, left: 20.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: ColorSelect.grayColor))),
                          height: 60.0,
                          child: Text(
                            e,
                            textScaleFactor: FontSize.h6,
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class EquipBox_B extends StatefulWidget {
  EquipBox_B({
    Key? key,
    required this.userState,
  }) : super(key: key);

  final UserState_B userState;

  final _EquipBox_BState state = _EquipBox_BState();

  @override
  _EquipBox_BState createState() => state;
}

class _EquipBox_BState extends State<EquipBox_B> {
  @override
  void initState() {
    super.initState();
  }

  AssetImage equipImage(String name, bool check) {
    String imgUrl = "assets/img/방염복_NO.png";
    if (name == '안전모') {
      imgUrl = check ? "assets/img/안전모_YES.png" : "assets/img/안전모_NO.png";
    } else if (name == '방염복') {
      imgUrl = check ? "assets/img/방염복_YES.png" : "assets/img/방염복_NO.png";
    } else if (name == '안전화') {
      imgUrl = check ? "assets/img/안전화_YES.png" : "assets/img/안전화_NO.png";
    } else {}

    return AssetImage(imgUrl);
  }

  Widget renderWearState(bool check) {
    return check
        ? Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: const Text("착용 완료",
                textScaleFactor: FontSize.h6,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 33, 211, 42))),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: const Text("미착용",
                textScaleFactor: FontSize.h6,
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.red)),
          );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.userState.equi.length,
        itemBuilder: (context, int index) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.only(left: 25),
            child: Column(
              children: [
                Stack(
                  children: [
                    InkWell(
                      onTap: () => setState(() {
                        widget.userState.equi[index].isCheck =
                            !widget.userState.equi[index].isCheck;
                        widget.userState.equi[index].analyze = false;
                      }),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.19,
                        width: MediaQuery.of(context).size.height * 0.20,
                        decoration: BoxDecoration(
                            color: widget.userState.equi[index].isCheck
                                ? ColorSelect.blueColor
                                : null,
                            border: widget.userState.equi[index].isCheck
                                ? null
                                : Border.all(
                                    width: 1,
                                    color: ColorSelect.borderColor,
                                  ),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: equipImage(
                                  widget.userState.equi[index].equipName,
                                  widget.userState.equi[index].isCheck),
                              height: MediaQuery.of(context).size.height * 0.10,
                              width: MediaQuery.of(context).size.height * 0.10,
                            ),
                            Text(
                              widget.userState.equi[index].equipName,
                              textScaleFactor: FontSize.h5,
                              style: TextStyle(
                                color: widget.userState.equi[index].isCheck
                                    ? Colors.white
                                    : ColorSelect.borderColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    widget.userState.equi[index].isCheck
                        ? Positioned(
                            top: 12,
                            right: 0,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                              width: MediaQuery.of(context).size.height * 0.055,
                              decoration: BoxDecoration(
                                  color: widget.userState.equi[index].analyze
                                      ? ColorSelect.greenColor2
                                      : ColorSelect.redColor),
                              child: Center(
                                child: Text(
                                  widget.userState.equi[index].analyze
                                      ? "자동"
                                      : "수동",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                renderWearState(widget.userState.equi[index].isCheck),
              ],
            ),
          );
        });
  }
}

class EquipState_B {
  String equipName;
  bool isCheck;
  bool analyze;

  EquipState_B({
    required this.equipName,
    required this.isCheck,
    required this.analyze,
  });
}

class UserState_B {
  String name;
  String age;
  String sex;
  String depart;
  String operatorNo;
  String career;
  String qualification;
  String deadline; // 자격 기한
  String imgUrl1;
  String imgUrl2;
  List<EquipState_B> equi;

  UserState_B({
    required this.name,
    required this.age,
    required this.sex,
    required this.depart,
    required this.operatorNo,
    required this.career,
    required this.qualification,
    required this.deadline,
    required this.imgUrl1,
    required this.imgUrl2,
    required this.equi,
  });
}
