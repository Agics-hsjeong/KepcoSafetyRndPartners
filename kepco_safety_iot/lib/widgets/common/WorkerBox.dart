import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Container(
      margin: EdgeInsets.all(width * 0.003),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(106, 106, 149, 0.3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          AiNetwork().OdPpeDetect();
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
                    width: width * 0.12,
                    height: height * 0.12,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorSelect.redShadowColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.report_problem_outlined,
                          size: width * 0.05,
                          color: ColorSelect.redColor,
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: width * 0.12,
                    height: height * 0.12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(widget.userState.imgUrl),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
            Text(
              "작업자${widget.index + 1}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: width * 0.011,
                  fontWeight: FontWeight.w500,
                  color: widget.userState.name == ""
                      ? ColorSelect.redColor
                      : ColorSelect.textColor4),
            ),
            Text(
              widget.userState.name == ""
                  ? "작업자를 수동 선택 해주세요"
                  : widget.userState.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize:
                    widget.userState.name == "" ? width * 0.008 : width * 0.01,
                fontWeight: widget.userState.name == ""
                    ? FontWeight.w400
                    : FontWeight.w600,
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
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      // print('MQTTClient:: userStages');
      setState(() {
        widget.userState;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [
            Container(
                width: width * 0.8,
                height: height * 0.8,
                padding: EdgeInsets.only(
                    left: width * 0.013,
                    right: width * 0.013,
                    top: width * 0.015,
                    bottom: width * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 1,
                      blurRadius: 20,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.012, bottom: width * 0.015),
                      child: Text(
                        "개인안전장구 착용",
                        style: TextStyle(
                            color: Color.fromRGBO(51, 65, 85, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.016),
                      ),
                    ),
                    //info table
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.01, vertical: 0),
                      child: Workerch(
                          userState: widget.userState, list: widget.list),
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
                      height: height * 0.24,
                      child: EquipBox(userState: widget.userState),
                    ),
                    //적용버튼
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Container(
                            width: width * 0.1,
                            height: height * 0.042,
                            decoration: BoxDecoration(
                                color: ColorSelect.toggleColor3,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 25, 255, 0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                  ),
                                ]),
                            child: Center(
                              child: Text("적용",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: width * 0.013,
                                      color: Colors.white)),
                            )),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                )),
            Positioned(
              right: width * 0.015,
              top: height * 0.02,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: width * 0.025,
                  height: height * 0.04,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(241, 245, 249, 1),
                      borderRadius: BorderRadius.circular(13)),
                  child: Icon(
                    Icons.close_rounded,
                    size: width * 0.02,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ]),
        ],
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
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SizedBox(
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: Image.asset(
                'assets/img/개인안전장구착용프로필사진.png',
                fit: BoxFit.fill,
                height: height * 0.3,
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
                          padding: EdgeInsets.only(top: height * 0.01),
                          height: height * 0.075,
                          child: Center(
                            child: Text(
                              e.value,
                              style: TextStyle(
                                  fontSize: width * 0.011,
                                  fontWeight: FontWeight.w400,
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
                                padding: EdgeInsets.only(top: height * 0.01),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.01),
                                      child: Row(
                                        children: [
                                          Text(
                                            e == "" ? "작업자 선택" : e,
                                            style: TextStyle(
                                              fontSize: width * 0.01,
                                              fontWeight: FontWeight.w400,
                                              color: e == ""
                                                  ? Colors.grey
                                                  : Colors.black,
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
                                              padding: EdgeInsets.only(
                                                  left: width * 0.003),
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: width * 0.01,
                                                  fontWeight: FontWeight.w400,
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
                                          chkUserInfo = widget.list[
                                              items.indexOf(value as String)];
                                          selectedValue = value as String;
                                        },
                                      );
                                    },
                                    buttonHeight: height * 0.04,
                                    buttonWidth: width * 0.01,
                                    itemHeight: height * 0.035,
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
                                height: height * 0.075,
                                padding: EdgeInsets.only(
                                    top: height * 0.045, left: width * 0.008),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: ColorSelect.grayColor))),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      fontSize: width * 0.01,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(83, 83, 83, 1)),
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
                          padding: EdgeInsets.only(
                              top: height * 0.01, left: width * 0.02),
                          height: height * 0.075,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontSize: width * 0.011,
                                  fontWeight: FontWeight.w400,
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
                          height: height * 0.063,
                          margin: EdgeInsets.only(bottom: height * 0.01),
                          padding: EdgeInsets.only(
                              top: height * 0.032, left: width * 0.008),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: ColorSelect.grayColor))),
                          child: Text(
                            e,
                            style: TextStyle(
                                fontSize: width * 0.01,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(83, 83, 83, 1)),
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
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return check
        ? Padding(
            padding: EdgeInsets.only(top: height * 0.01),
            child: Text("착용 완료",
                style: TextStyle(
                    fontSize: width * 0.01,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 33, 211, 42))),
          )
        : Padding(
            padding: EdgeInsets.only(top: height * 0.01),
            child: Text("미착용",
                style: TextStyle(
                    fontSize: width * 0.01,
                    fontWeight: FontWeight.w500,
                    color: Colors.red)),
          );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.userState.equi.length,
        itemBuilder: (context, int index) {
          return Container(
            height: height * 0.4,
            padding: EdgeInsets.only(left: width * 0.01),
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
                        height: height * 0.19,
                        width: height * 0.19,
                        decoration: BoxDecoration(
                            color: widget.userState.equi[index].isCheck
                                ? ColorSelect.toggleColor3
                                : Colors.white,
                            border: widget.userState.equi[index].isCheck
                                ? null
                                : Border.all(
                                    width: 1,
                                    color: ColorSelect.borderolor5,
                                  ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: widget.userState.equi[index].isCheck
                                ? [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 25, 255, 0.5),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : null),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: equipImage(
                                  widget.userState.equi[index].equipName,
                                  widget.userState.equi[index].isCheck),
                              height: height * 0.08,
                              width: width * 0.08,
                            ),
                            Text(
                              widget.userState.equi[index].equipName,
                              style: TextStyle(
                                fontSize: width * 0.013,
                                color: widget.userState.equi[index].isCheck
                                    ? Colors.white
                                    : ColorSelect.borderolor5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    widget.userState.equi[index].isCheck
                        ? Positioned(
                            top: height * 0.015,
                            right: 0,
                            child: Container(
                              height: height * 0.032,
                              width: width * 0.035,
                              decoration: BoxDecoration(
                                  color: widget.userState.equi[index].analyze
                                      ? ColorSelect.greenColor2
                                      : ColorSelect.redColor2),
                              child: Center(
                                child: Text(
                                  widget.userState.equi[index].analyze
                                      ? "자동"
                                      : "수동",
                                  style: TextStyle(
                                    fontSize: width * 0.01,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
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
