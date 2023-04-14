import 'dart:math';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class A02 extends StatefulWidget {
  const A02(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<A02> createState() => _A02State();
}

class _A02State extends State<A02> {
  late ProgressTimeline progressTimeline;
  Timer? _timer;

  int count = 0;
  bool isFirst = false;
  bool isFinding = false;

  Future<dynamic> startProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'S');

    print('===>startProc $result');
  }

  Future<dynamic> endProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'E');

    print('===>endProc $result');
  }

  List<UserState> userStages = List.empty(growable: true);

  void getWorker() {
    if (count == 0) {
      var rendom1 = Random().nextInt(2);
      var rendom2 = Random().nextInt(2);
      var rendom3 = Random().nextInt(2);
      setState(() {
        userStages.add(
          UserState(
            name: "홍길동",
            age: "48",
            sex: "남",
            depart: "(주)금광전기",
            operatorNo: "GRM-201255446",
            career: "12",
            qualification: "N",
            deadline: "10",
            imgUrl: "assets/img/사용자 아이콘.png",
            equi: [
              EquipState(
                equipName: "안전모",
                isCheck: rendom1 == 0 ? false : true,
                analyze: rendom1 == 0 ? false : true,
              ),
              EquipState(
                equipName: "방염복",
                isCheck: rendom2 == 0 ? false : true,
                analyze: rendom2 == 0 ? false : true,
              ),
              EquipState(
                equipName: "안전화",
                isCheck: rendom3 == 0 ? false : true,
                analyze: rendom3 == 0 ? false : true,
              ),
              EquipState(
                equipName: "방염복",
                isCheck: rendom3 == 0 ? false : true,
                analyze: rendom3 == 0 ? false : true,
              ),
              EquipState(
                equipName: "안전화",
                isCheck: rendom3 == 0 ? false : true,
                analyze: rendom3 == 0 ? false : true,
              ),
              EquipState(
                equipName: "안전화",
                isCheck: rendom3 == 0 ? false : true,
                analyze: rendom3 == 0 ? false : true,
              ),
              EquipState(
                equipName: "안전모",
                isCheck: rendom3 == 0 ? false : true,
                analyze: rendom3 == 0 ? false : true,
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
          UserState(
            name: "성춘향",
            age: "52",
            sex: "여",
            depart: "(주)금광전기",
            operatorNo: "GRM-201255445",
            career: "15",
            qualification: "N",
            deadline: "35",
            imgUrl: "",
            equi: [
              EquipState(
                equipName: "안전모",
                isCheck: rendom1 == 0 ? false : true,
                analyze: rendom1 == 0 ? false : true,
              ),
              EquipState(
                equipName: "방염복",
                isCheck: rendom2 == 0 ? false : true,
                analyze: rendom2 == 0 ? false : true,
              ),
              EquipState(
                equipName: "안전화",
                isCheck: rendom3 == 0 ? false : true,
                analyze: rendom3 == 0 ? false : true,
              ),
            ],
          ),
        );
      });
    } else if (count == 2) {
      var rendom1 = Random().nextInt(2);
      var rendom2 = Random().nextInt(2);
      var rendom3 = Random().nextInt(2);
      setState(() {
        userStages.add(
          UserState(
            name: "이몽룡",
            age: "54",
            sex: "남",
            depart: "(주)금광전기",
            operatorNo: "GRM-201255447",
            career: "17",
            qualification: "N",
            deadline: "0",
            imgUrl: "assets/img/사용자 아이콘.png",
            equi: [
              EquipState(
                equipName: "안전모",
                isCheck: rendom1 == 0 ? false : true,
                analyze: rendom1 == 0 ? false : true,
              ),
              EquipState(
                equipName: "방염복",
                isCheck: rendom2 == 0 ? false : true,
                analyze: rendom2 == 0 ? false : true,
              ),
              EquipState(
                equipName: "안전화",
                isCheck: rendom3 == 0 ? false : true,
                analyze: rendom3 == 0 ? false : true,
              ),
            ],
          ),
        );
      });
    } else if (count == 3) {
      var rendom1 = Random().nextInt(2);
      var rendom2 = Random().nextInt(2);
      var rendom3 = Random().nextInt(2);
      setState(() {
        userStages.add(
          UserState(
            name: "유관순",
            age: "30",
            sex: "여",
            depart: "(주)금광전기",
            operatorNo: "GRM-201255448",
            career: "3",
            qualification: "N",
            deadline: "0",
            imgUrl: "assets/img/사용자 아이콘.png",
            equi: [
              EquipState(
                equipName: "안전모",
                isCheck: rendom1 == 0 ? false : true,
                analyze: rendom1 == 0 ? false : true,
              ),
              EquipState(
                equipName: "방염복",
                isCheck: rendom2 == 0 ? false : true,
                analyze: rendom2 == 0 ? false : true,
              ),
              EquipState(
                equipName: "안전화",
                isCheck: rendom3 == 0 ? false : true,
                analyze: rendom3 == 0 ? false : true,
              ),
            ],
          ),
        );
      });
    } else if (count == 4) {
      var rendom1 = Random().nextInt(2);
      var rendom2 = Random().nextInt(2);
      var rendom3 = Random().nextInt(2);
      setState(() {
        userStages.add(
          UserState(
            name: "유관순",
            age: "30",
            sex: "여",
            depart: "(주)금광전기",
            operatorNo: "GRM-201255448",
            career: "3",
            qualification: "N",
            deadline: "0",
            imgUrl: "assets/img/사용자 아이콘.png",
            equi: [
              EquipState(
                equipName: "안전모",
                isCheck: rendom1 == 0 ? false : true,
                analyze: rendom1 == 0 ? false : true,
              ),
              EquipState(
                equipName: "방염복",
                isCheck: rendom2 == 0 ? false : true,
                analyze: rendom2 == 0 ? false : true,
              ),
              EquipState(
                equipName: "안전화",
                isCheck: rendom3 == 0 ? false : true,
                analyze: rendom3 == 0 ? false : true,
              ),
            ],
          ),
        );
      });
    } else if (count == 5) {
      var rendom1 = Random().nextInt(2);
      var rendom2 = Random().nextInt(2);
      var rendom3 = Random().nextInt(2);
      setState(() {
        userStages.add(
          UserState(
            name: "유관순",
            age: "30",
            sex: "여",
            depart: "(주)금광전기",
            operatorNo: "GRM-201255448",
            career: "3",
            qualification: "N",
            deadline: "0",
            imgUrl: "assets/img/사용자 아이콘.png",
            equi: [
              EquipState(
                equipName: "안전모",
                isCheck: rendom1 == 0 ? false : true,
                analyze: rendom1 == 0 ? false : true,
              ),
              EquipState(
                equipName: "방염복",
                isCheck: rendom2 == 0 ? false : true,
                analyze: rendom2 == 0 ? false : true,
              ),
              EquipState(
                equipName: "안전화",
                isCheck: rendom3 == 0 ? false : true,
                analyze: rendom3 == 0 ? false : true,
              ),
            ],
          ),
        );
      });
    } else {
      _timer!.cancel();
      setState(() {
        isFinding = false;
        isFirst = true;
      });
    }

    print(count);
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
    startProc();

    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }

    super.dispose();
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
              textScaleFactor: FontSize.h4,
              style: const TextStyle(
                  color: ColorSelect.blueColor, fontWeight: FontWeight.bold),
            ),
            isFirst
                ? count >= 6
                    ? Text("")
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
                : Text(""),
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
                      return WorkerBox(
                        userState: userStages[index],
                        index: index,
                        allList: userStages,
                      );
                    },
                  ),
                ),
              ),
              isFirst
                  ? const Text("")
                  : ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Container(
                          color: Color.fromRGBO(255, 255, 255, 0.6),
                        ),
                      ),
                    ),
              isFirst
                  ? const Text("")
                  : Center(
                      child: Padding(
                        padding: isFinding
                            ? const EdgeInsets.only(top: 100.0)
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
                                            _timer!.cancel();
                                            isFinding = false;
                                            isFirst = true;
                                          });
                                        },
                                      )
                                    : const Text(""),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                isFinding ? '인식중 입니다.' : '인식 시작',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 35.0),
                              child: Text(
                                isFinding ? "" : '제대로 된 인식을 위해',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500),
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
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          color: ColorSelect.blueColor,
                                          height: 1.2),
                                    ),
                                    Text(
                                      isFinding ? "" : '을 해주세요',
                                      style: TextStyle(
                                          fontSize: 25,
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
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        progressTimeline.gotoPreviousStage();
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
                            textScaleFactor: FontSize.h4,
                            style: TextStyle(
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
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
                        progressTimeline.failCurrentStage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "오류",
                            textScaleFactor: FontSize.h4,
                            style: TextStyle(
                                color: ColorSelect.redColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
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
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "다음",
                            textScaleFactor: FontSize.h4,
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

class WorkerBox extends StatefulWidget {
  const WorkerBox({
    Key? key,
    required this.allList,
    required this.userState,
    required this.index,
  }) : super(key: key);
  final List<UserState> allList;
  final UserState userState;
  final int index;

  @override
  State<WorkerBox> createState() => _WorkerBoxState();
}

class _WorkerBoxState extends State<WorkerBox> {
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
              return WorkerPopup(
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
            widget.userState.imgUrl == ""
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
                        image: AssetImage(widget.userState.imgUrl),
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
              textScaleFactor: FontSize.h4,
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

class WorkerPopup extends StatefulWidget {
  const WorkerPopup({
    Key? key,
    required this.list,
    required this.userState,
    required this.personChk,
  }) : super(key: key);

  final UserState userState;
  final bool personChk;
  final List<UserState> list;

  @override
  State<WorkerPopup> createState() => _WorkerPopupState();
}

class _WorkerPopupState extends State<WorkerPopup> {
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
                    },
                  ),
                ],
              ),
            ),
            //info table
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              child: Workerch(userState: widget.userState, list: widget.list),
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
              child: EquipBox(userState: widget.userState),
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

class Workerch extends StatefulWidget {
  Workerch({Key? key, required this.userState, required this.list})
      : super(key: key);
  final List<UserState> list;
  final UserState userState;
  final _WorkerchState state = _WorkerchState();

  @override
  _WorkerchState createState() => state;
}

class _WorkerchState extends State<Workerch> {
  List<String> items = List.empty(growable: true);
  late UserState chkUserInfo;
  String? selectedValue;

  @override
  void initState() {
    setState(() {
      items = widget.list.map((e) => e.name).toList();
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
                'assets/img/개인안전장구착용프로필사진.png',
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
                "${chkUserInfo.age}세",
                chkUserInfo.sex,
                chkUserInfo.depart
              ]
                  .map(
                    (e) => TableRow(
                      children: [
                        e == chkUserInfo.name
                            ? Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            e == "" ? "작업자 선택" : e,
                                            textScaleFactor: FontSize.h6,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
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
                                          selectedValue = value as String;
                                        },
                                      );
                                    },
                                    buttonHeight: 40,
                                    buttonWidth: 200,
                                    itemHeight: 40,
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey),
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
                                  e,
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

class EquipBox extends StatefulWidget {
  EquipBox({
    Key? key,
    required this.userState,
  }) : super(key: key);

  final UserState userState;

  final _EquipBoxState state = _EquipBoxState();

  @override
  _EquipBoxState createState() => state;
}

class _EquipBoxState extends State<EquipBox> {
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
                        : const Text(""),
                  ],
                ),
                renderWearState(widget.userState.equi[index].isCheck),
              ],
            ),
          );
        });
  }
}

class EquipState {
  String equipName;
  bool isCheck;
  bool analyze;

  EquipState({
    required this.equipName,
    required this.isCheck,
    required this.analyze,
  });
}

class UserState {
  String name;
  String age;
  String sex;
  String depart;
  String operatorNo;
  String career;
  String qualification;
  String deadline; // 자격 기한
  String imgUrl;
  List<EquipState> equi;

  UserState({
    required this.name,
    required this.age,
    required this.sex,
    required this.depart,
    required this.operatorNo,
    required this.career,
    required this.qualification,
    required this.deadline,
    required this.imgUrl,
    required this.equi,
  });
}
