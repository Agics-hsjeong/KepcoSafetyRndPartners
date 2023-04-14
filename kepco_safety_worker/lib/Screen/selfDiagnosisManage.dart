import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kepco_safety_worker/Screen/selfDiagnosisList.dart';
import '../models/models.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:kepco_safety_worker/Screen/TableBox.dart';

class selfDiagnosisManage extends StatefulWidget {
  selfDiagnosisManage({Key? key}) : super(key: key);

  @override
  State<selfDiagnosisManage> createState() => _selfDiagnosisManageState();
}

class _selfDiagnosisManageState extends State<selfDiagnosisManage> {
  List<SingleRowState> PmisRow1 = List.empty(growable: true);
  List<SingleRowState> PmisRow2 = List.empty(growable: true);
  List<SingleRowState> PmisRow3 = List.empty(growable: true);
  List<SingleRowState> PmisRow4 = List.empty(growable: true);

  List<String> diseaseNm = List.empty(growable: true);
  List<String> empty = List.empty(growable: true);
  String? chkValue;
  bool isChk = false;
  bool _isChecked = false;
  String startYn = "";

  @override
  void initState() {
    diseaseNm = [
      '골절',
      '뇌졸증',
      '부상',
    ];

    empty = [
      '',
    ];

    PmisRow1 = [
      SingleRowState(
          contents: "음주 및 약물 복용 (수면제 등)", isChecked: false, type: "1"),
      SingleRowState(contents: "신체상태 (혈색 등) 이상", isChecked: false, type: "1"),
    ];

    PmisRow2 = [
      SingleRowState(
          contents: "음주 및 약물 복용 (수면제 등)", isChecked: false, type: "1"),
      SingleRowState(contents: "신체상태 (혈색 등)", isChecked: false, type: "1"),
    ];
    PmisRow3 = [
      SingleRowState(
          contents: "음주 및 약물 복용 (수면제 등)", isChecked: false, type: "1"),
      SingleRowState(contents: "신체상태 (혈색 등)", isChecked: false, type: "1"),
    ];
    PmisRow4 = [
      SingleRowState(
          contents: "음주 및 약물 복용 (수면제 등)", isChecked: false, type: "1"),
      SingleRowState(contents: "신체상태 (혈색 등)", isChecked: false, type: "1"),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: startYn == "" || startYn == "저장"
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.48,
                              height:
                                  MediaQuery.of(context).size.height * 0.028,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.all(3),
                                    minimumSize: Size.zero,
                                    primary: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            selfDiagnosisList()),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "자가진단팝업창",
                                      textScaleFactor: FontSize.h8,
                                      style: TextStyle(
                                          color: ColorSelect.greyolor),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 10,
                                      color: ColorSelect.greyolor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.18,
                              height:
                                  MediaQuery.of(context).size.height * 0.028,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.all(2),
                                    minimumSize: Size.zero,
                                    primary: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "이력보기",
                                      textScaleFactor: FontSize.h8,
                                      style: TextStyle(
                                          color: ColorSelect.greyolor),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 10,
                                      color: ColorSelect.greyolor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.36,
                      ),
                      Padding(padding: EdgeInsets.all(3)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: ColorSelect.lightGreyColor, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "신체 Physical",
                                  textScaleFactor: FontSize.h7,
                                  style: TextStyle(color: ColorSelect.greyolor),
                                ),
                                startYn == "저장"
                                    ? Text(
                                        "50",
                                        textScaleFactor: FontSize.h6,
                                        style: TextStyle(
                                            color: ColorSelect.pinkColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "0",
                                        textScaleFactor: FontSize.h6,
                                        style: TextStyle(
                                            color: ColorSelect.greyolor,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: ColorSelect.lightGreyColor, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "정신 Mental",
                                  textScaleFactor: FontSize.h7,
                                  style: TextStyle(color: ColorSelect.greyolor),
                                ),
                                startYn == "저장"
                                    ? Text(
                                        "50",
                                        textScaleFactor: FontSize.h6,
                                        style: TextStyle(
                                            color: ColorSelect.blueColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "0",
                                        textScaleFactor: FontSize.h6,
                                        style: TextStyle(
                                            color: ColorSelect.greyolor,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: ColorSelect.lightGreyColor, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "지성 Intelligent",
                                  textScaleFactor: FontSize.h7,
                                  style: TextStyle(color: ColorSelect.greyolor),
                                ),
                                startYn == "저장"
                                    ? Text(
                                        "25",
                                        textScaleFactor: FontSize.h6,
                                        style: TextStyle(
                                            color: ColorSelect.lightGreenColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "0",
                                        textScaleFactor: FontSize.h6,
                                        style: TextStyle(
                                            color: ColorSelect.greyolor,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: ColorSelect.lightGreyColor, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "감성 Sensible",
                                  textScaleFactor: FontSize.h7,
                                  style: TextStyle(color: ColorSelect.greyolor),
                                ),
                                startYn == "저장"
                                    ? Text(
                                        "25",
                                        textScaleFactor: FontSize.h6,
                                        style: TextStyle(
                                            color: ColorSelect.orangeColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "0",
                                        textScaleFactor: FontSize.h6,
                                        style: TextStyle(
                                            color: ColorSelect.greyolor,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorSelect.blueColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: () {
                            setState(() {
                              startYn = "시작";
                            });
                          },
                          child: startYn == "저장"
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: Icon(
                                        Icons.replay,
                                        size: 21,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      " 자가진단 다시하기",
                                      textScaleFactor: FontSize.h7,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              : Text(
                                  "자가진단 하기",
                                  textScaleFactor: FontSize.h7,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ],
                  )
                //자가진단창
                : Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(left: 3),
                                    child: Text(
                                      '오늘 발생한 증상을 선택해 주세요.',
                                      textScaleFactor: FontSize.h8,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            items: isChk
                                ? empty
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: null,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            item,
                                            textScaleFactor: FontSize.h8,
                                            style: const TextStyle(),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()
                                : diseaseNm
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            item,
                                            textScaleFactor: FontSize.h8,
                                            style: const TextStyle(),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            value: isChk ? null : chkValue,
                            onChanged: isChk
                                ? null
                                : (value) {
                                    setState(
                                      () {
                                        chkValue = value as String;
                                      },
                                    );
                                  },
                            focusColor: Color.fromRGBO(218, 223, 252, 1),
                            buttonHeight: 60,
                            buttonWidth: 80,
                            itemHeight: 40,
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                            ),
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.37,
                          child: Row(
                            children: [
                              Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                  activeColor: ColorSelect.blueColor,
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _isChecked = value!;
                                      isChk = _isChecked;
                                    });
                                  }),
                              Text(
                                "모든 증상 없음",
                                textScaleFactor: FontSize.h7,
                              )
                            ],
                          ),
                        ),
                      ),
                      TableBox(list: PmisRow1, title: "신체 Physical"),
                      TableBox(list: PmisRow2, title: "정신 Mental"),
                      TableBox(list: PmisRow3, title: "지성 Intelligent"),
                      TableBox(list: PmisRow4, title: "감성 Sensible"),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorSelect.blueColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: () {
                            setState(() {
                              startYn = "저장";
                            });
                          },
                          child: Text(
                            "저장",
                            textScaleFactor: FontSize.h7,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                    ],
                  ),
          )),
    );
  }
}
