import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/pages/RiskReportPage.dart';

import 'package:kepco_safety_iot/widgets/common/Layout.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'RiskReportPage.dart';

class WorkDetailPage extends StatefulWidget {
  const WorkDetailPage({Key? key, required this.gateYn}) : super(key: key);
  final bool gateYn;

  @override
  State<WorkDetailPage> createState() => _WorkDetailPageState();
}

class _WorkDetailPageState extends State<WorkDetailPage> {
  bool editChecked = false;
  List<String> chkItems = List.empty(growable: true);
  List<String> mainItems = List.empty(growable: true);
  List<String> subItems = List.empty(growable: true);
  List<String> ynItems = List.empty(growable: true);
  List workList = List.empty(growable: true);
  List deviceList = List.empty(growable: true);
  List managerList = List.empty(growable: true);

  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;
  String? selectedValue4;
  String? chkValue;

  void checkOfManager() {
    setState(() {
      chkItems = [
        '선택값',
        '선택',
      ];
    });
  }

  void divisionOfWork() {
    setState(() {
      workList = [
        {'name': '홍길동', 'tel': '010-1244-6788'},
        {'name': '김나나', 'tel': '010-1266-0988'},
        {'name': '유관순', 'tel': '010-5444-0988'},
      ];
    });
  }

  void divisionOfDevice() {
    setState(() {
      deviceList = [
        {'name': '장비1', 'number': '232323'},
        {'name': '장비2', 'number': '767676'},
      ];
    });
  }

  void divisionOfManager() {
    setState(() {
      managerList = [
        {'chk': '선택값', 'name': '박나나', 'tel': '010-1244-6788'},
      ];
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    checkOfManager();
    divisionOfWork();
    divisionOfDevice();
    divisionOfManager();
    super.initState();
  }

  final ScrollController _controller1 = ScrollController();
  final ScrollController _controller2 = ScrollController();
  final ScrollController _controller3 = ScrollController();
  final ScrollController _controller4 = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
        child: Layout(
            title: TextModel.title,
            body: Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.01, width * 0.003, width * 0.007, width * 0.007),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "금일 현장 관리 상세",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: width * 0.011,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SUIT',
                          ),
                        ),
                        // 버튼 모음
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              widget.gateYn
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 5,
                                        backgroundColor:
                                            ColorSelect.toggleColor3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        shadowColor: ColorSelect.toggleColor3,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (editChecked == false) {
                                            editChecked = true;
                                          } else {
                                            editChecked = false;
                                          }
                                        });
                                      },
                                      child: Text(
                                        editChecked ? '저장' : '수정',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: width * 0.008,
                                          fontFamily: 'SUIT',
                                        ),
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 5,
                                        backgroundColor:
                                            ColorSelect.toggleColor3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        shadowColor: ColorSelect.toggleColor3,
                                      ),
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RiskReportPage(),
                                        ),
                                      ),
                                      child: Text(
                                        '보고서',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: width * 0.008,
                                          fontFamily: 'SUIT',
                                        ),
                                      ),
                                    ),
                              SizedBox(width: width * 0.008),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor:
                                      Color.fromRGBO(116, 150, 255, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  shadowColor: ColorSelect.toggleColor3,
                                ),
                                onPressed: () {
                                  setState(() {
                                    editChecked
                                        ? popup(context)
                                        : Navigator.pop(context);
                                  });
                                },
                                child: Text(
                                  '목록',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.008,
                                    fontFamily: 'SUIT',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.005, bottom: height * 0.015),
                              child: Text(
                                "공사정보",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: width * 0.01,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'SUIT',
                                    color: ColorSelect.textColor5),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorSelect.tableBorderColor2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Table(
                                          border: const TableBorder(
                                            verticalInside: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                            bottom: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                          ),
                                          columnWidths: const {
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(4),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(4),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "공사명",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "주촌내삼 김해시장 도로확장 지장이설 공사",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "공사구분",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "선택",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Table(
                                          border: const TableBorder(
                                            verticalInside: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                            bottom: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                          ),
                                          columnWidths: const {
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(4),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(4),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "공사번호",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "5611-2012-4255",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "공사기간",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5))),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "2023-02-21 ~ 2023-02-28",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Table(
                                          border: const TableBorder(
                                            verticalInside: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                            bottom: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                          ),
                                          columnWidths: const {
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(4),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(2),
                                            4: FlexColumnWidth(1),
                                            5: FlexColumnWidth(1),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "1차 사업소",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "선택",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "2차 사업소",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "선택",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "공사담당관",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5))),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "공사담당관",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Table(
                                          border: const TableBorder(
                                            verticalInside: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                          ),
                                          columnWidths: const {
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(4),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(4),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "협력회사",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "협력회사",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "현장책임자",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5))),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "현장책임자",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.03, bottom: height * 0.015),
                              child: Text(
                                "작업정보",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: width * 0.01,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'SUIT',
                                    color: ColorSelect.textColor5),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(158, 170, 202, 1)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Table(
                                          border: const TableBorder(
                                            verticalInside: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                            bottom: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                          ),
                                          columnWidths: const {
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(4),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(2),
                                            4: FlexColumnWidth(1),
                                            5: FlexColumnWidth(1),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "작업명",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "작업명",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "작업일시",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "작업일시",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "활선작업여부",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "작업여부",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Table(
                                          border: const TableBorder(
                                            verticalInside: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                            bottom: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                          ),
                                          columnWidths: const {
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(4),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(4),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: height * 0.07,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "공종선택",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.07,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Table(
                                                  columnWidths: {
                                                    0: FlexColumnWidth(1),
                                                    1: FlexColumnWidth(1),
                                                    2: FlexColumnWidth(1),
                                                  },
                                                  children: [
                                                    TableRow(children: [
                                                      Container(
                                                        height: height * 0.025,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        245,
                                                                        246,
                                                                        250,
                                                                        1),
                                                                border: Border(
                                                                  bottom: BorderSide(
                                                                      width: 1,
                                                                      color: Color.fromRGBO(
                                                                          158,
                                                                          170,
                                                                          202,
                                                                          1)),
                                                                  right:
                                                                      BorderSide(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            158,
                                                                            170,
                                                                            202,
                                                                            1),
                                                                  ),
                                                                )),
                                                        child: Center(
                                                          child: Text(
                                                            "대분류",
                                                            style: TextStyle(
                                                              color: ColorSelect
                                                                  .textColor5,
                                                              fontSize:
                                                                  width * 0.009,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height * 0.025,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        245,
                                                                        246,
                                                                        250,
                                                                        1),
                                                                border: Border(
                                                                  bottom: BorderSide(
                                                                      width: 1,
                                                                      color: Color.fromRGBO(
                                                                          158,
                                                                          170,
                                                                          202,
                                                                          1)),
                                                                  right:
                                                                      BorderSide(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            158,
                                                                            170,
                                                                            202,
                                                                            1),
                                                                  ),
                                                                )),
                                                        child: Center(
                                                          child: Text(
                                                            "중분류",
                                                            style: TextStyle(
                                                              color: ColorSelect
                                                                  .textColor5,
                                                              fontSize:
                                                                  width * 0.009,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height * 0.025,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        245,
                                                                        246,
                                                                        250,
                                                                        1),
                                                                border: Border(
                                                                  bottom: BorderSide(
                                                                      width: 1,
                                                                      color: Color.fromRGBO(
                                                                          158,
                                                                          170,
                                                                          202,
                                                                          1)),
                                                                )),
                                                        child: Center(
                                                          child: Text(
                                                            "소분류",
                                                            style: TextStyle(
                                                              color: ColorSelect
                                                                  .textColor5,
                                                              fontSize:
                                                                  width * 0.009,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                    TableRow(children: [
                                                      Container(
                                                        height: height * 0.045,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            158,
                                                                            170,
                                                                            202,
                                                                            1),
                                                                  ),
                                                                )),
                                                        child: Center(
                                                          child: Text(
                                                            "내용",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  width * 0.009,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height * 0.045,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                    width: 1,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            158,
                                                                            170,
                                                                            202,
                                                                            1),
                                                                  ),
                                                                )),
                                                        child: Center(
                                                          child: Text(
                                                            "내용",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  width * 0.009,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height * 0.045,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "내용",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  width * 0.009,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.07,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "선택된 공종",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.07,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5))),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.025,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "선택된 공종",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Table(
                                          border: const TableBorder(
                                            verticalInside: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                            bottom: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                          ),
                                          columnWidths: const {
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(4),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(4),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "작업장소(구간)",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "구간",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "작업장소(주소)",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.06,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.02,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "주소",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Table(
                                          border: const TableBorder(
                                            verticalInside: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                            bottom: BorderSide(
                                                color: ColorSelect
                                                    .tableBorderColor2,
                                                width: 1),
                                          ),
                                          columnWidths: const {
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(9),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: height * 0.1,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "작업내용",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.1,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: height * 0.015,
                                                    left: width * 0.01),
                                                child: Text(
                                                  "작업내용",
                                                  style: TextStyle(
                                                    fontSize: width * 0.009,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Table(
                                          border: const TableBorder(
                                            verticalInside: BorderSide(
                                                color: Color.fromRGBO(
                                                    158, 170, 202, 1),
                                                width: 1),
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    158, 170, 202, 1),
                                                width: 1),
                                          ),
                                          columnWidths: const {
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(4),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(4),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: height * 0.16,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "작업자 명단",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  height: height * 0.16,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Color.fromRGBO(
                                                                    202,
                                                                    212,
                                                                    236,
                                                                    1))),
                                                  ),
                                                  padding: editChecked
                                                      ? EdgeInsets.only(
                                                          left: width * 0.01,
                                                          right: width * 0.01,
                                                          top: height * 0.008,
                                                          bottom:
                                                              height * 0.008)
                                                      : EdgeInsets.zero,
                                                  child: editChecked
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  height:
                                                                      height *
                                                                          0.035,
                                                                  margin: EdgeInsets.only(
                                                                      bottom: height *
                                                                          0.01),
                                                                  decoration: BoxDecoration(
                                                                      color: Color.fromRGBO(
                                                                              225,
                                                                              234,
                                                                              254,
                                                                              1)
                                                                          .withOpacity(
                                                                              0.39),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border: Border.all(
                                                                          color:
                                                                              ColorSelect.textColor3)),
                                                                  child:
                                                                      TextButton
                                                                          .icon(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .file_download_outlined,
                                                                      size: width *
                                                                          0.012,
                                                                      color: ColorSelect
                                                                          .textColor5,
                                                                    ),
                                                                    label: Text(
                                                                      '작업자 현황 불러오기',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ColorSelect
                                                                            .textColor5,
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                        fontSize:
                                                                            width *
                                                                                0.008,
                                                                        fontFamily:
                                                                            'SUIT',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  child:
                                                                      Container(
                                                                    width: width *
                                                                        0.022,
                                                                    height:
                                                                        height *
                                                                            0.035,
                                                                    margin: EdgeInsets.only(
                                                                        bottom: height *
                                                                            0.01),
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        color: Color.fromRGBO(
                                                                                225,
                                                                                234,
                                                                                254,
                                                                                1)
                                                                            .withOpacity(
                                                                                0.39),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        border: Border.all(
                                                                            color:
                                                                                ColorSelect.textColor3)),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      size: width *
                                                                          0.02,
                                                                      color: ColorSelect
                                                                          .textColor5,
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      workList
                                                                          .add({
                                                                        'name':
                                                                            '홍길동',
                                                                        'tel':
                                                                            '010'
                                                                      });
                                                                    });
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: Scrollbar(
                                                                thumbVisibility:
                                                                    true,
                                                                controller:
                                                                    _controller2,
                                                                child: ListView
                                                                    .builder(
                                                                  controller:
                                                                      _controller2,
                                                                  itemCount:
                                                                      workList
                                                                          .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              height * 0.008),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                width * 0.1,
                                                                            height:
                                                                                height * 0.04,
                                                                            child:
                                                                                TextFormField(
                                                                              readOnly: true,
                                                                              initialValue: workList[index]['name'],
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                contentPadding: EdgeInsets.all(width * 0.008),
                                                                                hintText: "이름",
                                                                                hintStyle: TextStyle(color: ColorSelect.textColor3, fontSize: width * 0.009),
                                                                                fillColor: Colors.white,
                                                                                filled: true,
                                                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: ColorSelect.textColor3, width: 1)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: width * 0.01),
                                                                          SizedBox(
                                                                            width:
                                                                                width * 0.15,
                                                                            height:
                                                                                height * 0.04,
                                                                            child:
                                                                                TextFormField(
                                                                              readOnly: true,
                                                                              initialValue: workList[index]['tel'],
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                contentPadding: EdgeInsets.all(width * 0.008),
                                                                                hintText: "전화번호",
                                                                                hintStyle: TextStyle(color: ColorSelect.textColor3, fontSize: width * 0.009),
                                                                                fillColor: Colors.white,
                                                                                filled: true,
                                                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: ColorSelect.textColor3, width: 1)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: width * 0.005),
                                                                          IconButton(
                                                                            icon:
                                                                                Icon(Icons.clear_sharp),
                                                                            color:
                                                                                Colors.red,
                                                                            iconSize:
                                                                                width * 0.016,
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                workList.removeAt(index);
                                                                              });
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Column(
                                                          children: [
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                      decoration: const BoxDecoration(
                                                                          color: Color.fromRGBO(
                                                                              245,
                                                                              246,
                                                                              250,
                                                                              1),
                                                                          border: Border(
                                                                              bottom: BorderSide(width: 1, color: Color.fromRGBO(158, 170, 202, 1)),
                                                                              right: BorderSide(width: 1, color: Color.fromRGBO(158, 170, 202, 1)))),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "이름",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorSelect.textColor5,
                                                                            fontSize:
                                                                                width * 0.009,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                'SUIT',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                      decoration: const BoxDecoration(
                                                                          color: Color.fromRGBO(245, 246, 250, 1),
                                                                          border: Border(
                                                                            bottom:
                                                                                BorderSide(width: 1, color: Color.fromRGBO(158, 170, 202, 1)),
                                                                          )),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "연락처",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorSelect.textColor5,
                                                                            fontSize:
                                                                                width * 0.009,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                'SUIT',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Scrollbar(
                                                                thumbVisibility:
                                                                    true,
                                                                controller:
                                                                    _controller3,
                                                                child: ListView
                                                                    .builder(
                                                                  controller:
                                                                      _controller3,
                                                                  itemCount:
                                                                      workList
                                                                          .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child: Container(
                                                                              height: height * 0.065,
                                                                              decoration: const BoxDecoration(
                                                                                border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(202, 212, 236, 1)), right: BorderSide(width: 1, color: Color.fromRGBO(158, 170, 202, 1))),
                                                                              ),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  workList[index]['name'],
                                                                                  style: TextStyle(
                                                                                    fontSize: width * 0.009,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    fontFamily: 'SUIT',
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                        ),
                                                                        Expanded(
                                                                            flex:
                                                                                2,
                                                                            child: Container(
                                                                                height: height * 0.065,
                                                                                decoration: const BoxDecoration(
                                                                                  border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(202, 212, 236, 1))),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    workList[index]['tel'],
                                                                                    style: TextStyle(
                                                                                      fontSize: width * 0.009,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontFamily: 'SUIT',
                                                                                    ),
                                                                                  ),
                                                                                )))
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                              Container(
                                                height: height * 0.16,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "장비현황",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  height: height * 0.16,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Color.fromRGBO(
                                                                    202,
                                                                    212,
                                                                    236,
                                                                    1))),
                                                  ),
                                                  padding: editChecked
                                                      ? EdgeInsets.only(
                                                          left: width * 0.01,
                                                          right: width * 0.01,
                                                          top: height * 0.008,
                                                          bottom:
                                                              height * 0.008)
                                                      : EdgeInsets.zero,
                                                  child: editChecked
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  height:
                                                                      height *
                                                                          0.035,
                                                                  margin: EdgeInsets.only(
                                                                      bottom: height *
                                                                          0.01),
                                                                  decoration: BoxDecoration(
                                                                      color: Color.fromRGBO(
                                                                              225,
                                                                              234,
                                                                              254,
                                                                              1)
                                                                          .withOpacity(
                                                                              0.39),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border: Border.all(
                                                                          color:
                                                                              ColorSelect.textColor3)),
                                                                  child:
                                                                      TextButton
                                                                          .icon(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .file_download_outlined,
                                                                      size: width *
                                                                          0.012,
                                                                      color: ColorSelect
                                                                          .textColor5,
                                                                    ),
                                                                    label: Text(
                                                                      '장비 현황 불러오기',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ColorSelect
                                                                            .textColor5,
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                        fontSize:
                                                                            width *
                                                                                0.008,
                                                                        fontFamily:
                                                                            'SUIT',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  child:
                                                                      Container(
                                                                    width: width *
                                                                        0.022,
                                                                    height:
                                                                        height *
                                                                            0.035,
                                                                    margin: EdgeInsets.only(
                                                                        bottom: height *
                                                                            0.01),
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        color: Color.fromRGBO(
                                                                                225,
                                                                                234,
                                                                                254,
                                                                                1)
                                                                            .withOpacity(
                                                                                0.39),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        border: Border.all(
                                                                            color:
                                                                                ColorSelect.textColor3)),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      size: width *
                                                                          0.02,
                                                                      color: ColorSelect
                                                                          .textColor5,
                                                                    ),
                                                                  ),
                                                                  onTap: () {},
                                                                )
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: Scrollbar(
                                                                thumbVisibility:
                                                                    true,
                                                                controller:
                                                                    _controller3,
                                                                child: ListView
                                                                    .builder(
                                                                  controller:
                                                                      _controller3,
                                                                  itemCount: 3,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              height * 0.008),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                width * 0.1,
                                                                            height:
                                                                                height * 0.04,
                                                                            child:
                                                                                TextFormField(
                                                                              readOnly: true,
                                                                              initialValue: '장비',
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                contentPadding: EdgeInsets.all(width * 0.008),
                                                                                hintText: "장비명",
                                                                                hintStyle: TextStyle(color: ColorSelect.textColor3, fontSize: width * 0.009),
                                                                                fillColor: Colors.white,
                                                                                filled: true,
                                                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: ColorSelect.textColor3, width: 1)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: width * 0.01),
                                                                          SizedBox(
                                                                            width:
                                                                                width * 0.15,
                                                                            height:
                                                                                height * 0.04,
                                                                            child:
                                                                                TextFormField(
                                                                              readOnly: true,
                                                                              initialValue: '장비 번호',
                                                                              decoration: InputDecoration(
                                                                                isDense: true,
                                                                                contentPadding: EdgeInsets.all(width * 0.008),
                                                                                hintText: "장비 번호",
                                                                                hintStyle: TextStyle(color: ColorSelect.textColor3, fontSize: width * 0.009),
                                                                                fillColor: Colors.white,
                                                                                filled: true,
                                                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: ColorSelect.textColor3, width: 1)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                              width: width * 0.005),
                                                                          IconButton(
                                                                            icon:
                                                                                Icon(Icons.clear_sharp),
                                                                            color:
                                                                                Colors.red,
                                                                            iconSize:
                                                                                width * 0.016,
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {});
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Column(
                                                          children: [
                                                            SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                      decoration: BoxDecoration(
                                                                          color: Color.fromRGBO(
                                                                              245,
                                                                              246,
                                                                              250,
                                                                              1),
                                                                          border: Border(
                                                                              bottom: BorderSide(width: 1, color: Color.fromRGBO(158, 170, 202, 1)),
                                                                              right: BorderSide(width: 1, color: Color.fromRGBO(158, 170, 202, 1)))),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "장비구분",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorSelect.textColor5,
                                                                            fontSize:
                                                                                width * 0.009,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                'SUIT',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          height *
                                                                              0.03,
                                                                      decoration: BoxDecoration(
                                                                          color: Color.fromRGBO(245, 246, 250, 1),
                                                                          border: Border(
                                                                            bottom:
                                                                                BorderSide(width: 1, color: Color.fromRGBO(158, 170, 202, 1)),
                                                                          )),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "차량번호",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                ColorSelect.textColor5,
                                                                            fontSize:
                                                                                width * 0.009,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                'SUIT',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Scrollbar(
                                                                thumbVisibility:
                                                                    true,
                                                                controller:
                                                                    _controller2,
                                                                child: ListView
                                                                    .builder(
                                                                  controller:
                                                                      _controller2,
                                                                  itemCount: 3,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child: Container(
                                                                              height: height * 0.065,
                                                                              decoration: BoxDecoration(
                                                                                border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(202, 212, 236, 1)), right: BorderSide(width: 1, color: Color.fromRGBO(158, 170, 202, 1))),
                                                                              ),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "장비",
                                                                                  style: TextStyle(
                                                                                    fontSize: width * 0.009,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    fontFamily: 'SUIT',
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                        ),
                                                                        Expanded(
                                                                            flex:
                                                                                2,
                                                                            child: Container(
                                                                                height: height * 0.065,
                                                                                decoration: BoxDecoration(
                                                                                  border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(202, 212, 236, 1))),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "123456",
                                                                                    style: TextStyle(
                                                                                      fontSize: width * 0.009,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontFamily: 'SUIT',
                                                                                    ),
                                                                                  ),
                                                                                )))
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                            ]),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Table(
                                          border: const TableBorder(
                                            verticalInside: BorderSide(
                                                color: Color.fromRGBO(
                                                    158, 170, 202, 1),
                                                width: 1),
                                          ),
                                          columnWidths: const {
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(4),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(4),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: height * 0.14,
                                                decoration: const BoxDecoration(
                                                    color: ColorSelect
                                                        .tableColor4,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5))),
                                                child: Center(
                                                  child: Text(
                                                    "안전담당자",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.14,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromRGBO(
                                                              202,
                                                              212,
                                                              236,
                                                              1))),
                                                ),
                                                padding: editChecked
                                                    ? EdgeInsets.only(
                                                        left: width * 0.001,
                                                        right: width * 0.01,
                                                        top: height * 0.008,
                                                        bottom: height * 0.008)
                                                    : EdgeInsets.zero,
                                                child: editChecked
                                                    ? Column(
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: InkWell(
                                                                child:
                                                                    Container(
                                                                  width: width *
                                                                      0.022,
                                                                  height:
                                                                      height *
                                                                          0.035,
                                                                  margin: EdgeInsets.only(
                                                                      bottom: height *
                                                                          0.01),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      color: Color.fromRGBO(
                                                                              225,
                                                                              234,
                                                                              254,
                                                                              1)
                                                                          .withOpacity(
                                                                              0.39),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border: Border.all(
                                                                          color:
                                                                              ColorSelect.textColor3)),
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: width *
                                                                        0.02,
                                                                    color: ColorSelect
                                                                        .textColor5,
                                                                  ),
                                                                ),
                                                                onTap: () {},
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width: width *
                                                                    0.12,
                                                                child:
                                                                    DropdownButtonHideUnderline(
                                                                  child:
                                                                      DropdownButton2(
                                                                    isExpanded:
                                                                        true,
                                                                    hint: Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: width * 0.002),
                                                                          child:
                                                                              Text(
                                                                            '선택',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w300,
                                                                              fontSize: width * 0.009,
                                                                              color: ColorSelect.textColor3,
                                                                              fontFamily: 'SUIT',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    items: chkItems
                                                                        .map(
                                                                          (item) =>
                                                                              DropdownMenuItem<String>(
                                                                            value:
                                                                                item,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.only(left: width * 0.002),
                                                                              child: Text(
                                                                                item,
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.w300,
                                                                                  fontSize: width * 0.009,
                                                                                  fontFamily: 'SUIT',
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                        .toList(),
                                                                    value:
                                                                        chkItems[
                                                                            0],
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                        () {
                                                                          // chkItems =
                                                                          //     value as String;
                                                                        },
                                                                      );
                                                                    },
                                                                    buttonDecoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      border: Border.all(
                                                                          color:
                                                                              ColorSelect.textColor3),
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    dropdownPadding:
                                                                        null,
                                                                    dropdownDecoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: width *
                                                                      0.1,
                                                                  child:
                                                                      TextFormField(
                                                                    maxLines: 1,
                                                                    initialValue:
                                                                        '홍길동',
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          "이름",
                                                                      hintStyle: TextStyle(
                                                                          color: ColorSelect
                                                                              .textColor3,
                                                                          fontSize:
                                                                              width * 0.009),
                                                                      labelStyle:
                                                                          TextStyle(
                                                                              fontSize: width * 0.009),
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      filled:
                                                                          true,
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          borderSide: BorderSide(
                                                                              color: ColorSelect.textColor3,
                                                                              width: 1)),
                                                                    ),
                                                                  )),
                                                              SizedBox(
                                                                  width: width *
                                                                      0.11,
                                                                  child:
                                                                      TextFormField(
                                                                    maxLines: 1,
                                                                    initialValue:
                                                                        '010-1234-5678',
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          "전화번호",
                                                                      hintStyle: TextStyle(
                                                                          color: ColorSelect
                                                                              .textColor3,
                                                                          fontSize:
                                                                              width * 0.009),
                                                                      labelStyle:
                                                                          TextStyle(
                                                                              fontSize: width * 0.009),
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      filled:
                                                                          true,
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          borderSide: BorderSide(
                                                                              color: ColorSelect.textColor3,
                                                                              width: 1)),
                                                                    ),
                                                                  )),
                                                              IconButton(
                                                                icon: Icon(Icons
                                                                    .clear_sharp),
                                                                color:
                                                                    Colors.red,
                                                                iconSize:
                                                                    width *
                                                                        0.016,
                                                                onPressed: () {
                                                                  setState(
                                                                      () {});
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : Table(
                                                        columnWidths: const {
                                                          0: FlexColumnWidth(1),
                                                          1: FlexColumnWidth(1),
                                                          2: FlexColumnWidth(1),
                                                        },
                                                        children: [
                                                          TableRow(children: [
                                                            Container(
                                                              height:
                                                                  height * 0.03,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Color.fromRGBO(
                                                                          245,
                                                                          246,
                                                                          250,
                                                                          1),
                                                                      border:
                                                                          Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromRGBO(
                                                                                158,
                                                                                170,
                                                                                202,
                                                                                1)),
                                                                        right:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color: Color.fromRGBO(
                                                                              158,
                                                                              170,
                                                                              202,
                                                                              1),
                                                                        ),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  "선택",
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorSelect
                                                                        .textColor5,
                                                                    fontSize:
                                                                        width *
                                                                            0.009,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'SUIT',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height:
                                                                  height * 0.03,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Color.fromRGBO(
                                                                          245,
                                                                          246,
                                                                          250,
                                                                          1),
                                                                      border:
                                                                          Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromRGBO(
                                                                                158,
                                                                                170,
                                                                                202,
                                                                                1)),
                                                                        right:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color: Color.fromRGBO(
                                                                              158,
                                                                              170,
                                                                              202,
                                                                              1),
                                                                        ),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  "이름",
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorSelect
                                                                        .textColor5,
                                                                    fontSize:
                                                                        width *
                                                                            0.009,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'SUIT',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height:
                                                                  height * 0.03,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Color.fromRGBO(
                                                                          245,
                                                                          246,
                                                                          250,
                                                                          1),
                                                                      border:
                                                                          Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromRGBO(
                                                                                158,
                                                                                170,
                                                                                202,
                                                                                1)),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  "연락처",
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorSelect
                                                                        .textColor5,
                                                                    fontSize:
                                                                        width *
                                                                            0.009,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'SUIT',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                          TableRow(children: [
                                                            Container(
                                                              height:
                                                                  height * 0.11,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromRGBO(
                                                                                158,
                                                                                170,
                                                                                202,
                                                                                1)),
                                                                        right:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color: Color.fromRGBO(
                                                                              158,
                                                                              170,
                                                                              202,
                                                                              1),
                                                                        ),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  "선택",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.009,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'SUIT',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height:
                                                                  height * 0.11,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromRGBO(
                                                                                158,
                                                                                170,
                                                                                202,
                                                                                1)),
                                                                        right:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color: Color.fromRGBO(
                                                                              158,
                                                                              170,
                                                                              202,
                                                                              1),
                                                                        ),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  "홍길동",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.009,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'SUIT',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height:
                                                                  height * 0.11,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border(
                                                                        bottom: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromRGBO(
                                                                                158,
                                                                                170,
                                                                                202,
                                                                                1)),
                                                                      )),
                                                              child: Center(
                                                                child: Text(
                                                                  "010-1234-5678",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.009,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'SUIT',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ]),
                                                        ],
                                                      ),
                                              ),
                                              Container(
                                                height: height * 0.14,
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorSelect.tableColor4,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "감리자",
                                                    style: TextStyle(
                                                      color: ColorSelect
                                                          .textColor5,
                                                      fontSize: width * 0.009,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height * 0.14,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Color.fromRGBO(
                                                              202,
                                                              212,
                                                              236,
                                                              1))),
                                                ),
                                                child: editChecked
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                              width:
                                                                  width * 0.12,
                                                              child:
                                                                  TextFormField(
                                                                maxLines: 1,
                                                                initialValue:
                                                                    '업체명',
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "업체명",
                                                                  hintStyle: TextStyle(
                                                                      color: ColorSelect
                                                                          .textColor3,
                                                                      fontSize:
                                                                          width *
                                                                              0.009),
                                                                  labelStyle: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.009),
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  filled: true,
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      borderSide: BorderSide(
                                                                          color: ColorSelect
                                                                              .textColor3,
                                                                          width:
                                                                              1)),
                                                                ),
                                                              )),
                                                          SizedBox(
                                                              width:
                                                                  width * 0.1,
                                                              child:
                                                                  TextFormField(
                                                                maxLines: 1,
                                                                initialValue:
                                                                    '홍길동',
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "이름",
                                                                  hintStyle: TextStyle(
                                                                      color: ColorSelect
                                                                          .textColor3,
                                                                      fontSize:
                                                                          width *
                                                                              0.009),
                                                                  labelStyle: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.009),
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  filled: true,
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      borderSide: BorderSide(
                                                                          color: ColorSelect
                                                                              .textColor3,
                                                                          width:
                                                                              1)),
                                                                ),
                                                              )),
                                                          SizedBox(
                                                              width:
                                                                  width * 0.11,
                                                              child:
                                                                  TextFormField(
                                                                maxLines: 1,
                                                                initialValue:
                                                                    '010-1234-5678',
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "전화번호",
                                                                  hintStyle: TextStyle(
                                                                      color: ColorSelect
                                                                          .textColor3,
                                                                      fontSize:
                                                                          width *
                                                                              0.009),
                                                                  labelStyle: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.009),
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  filled: true,
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      borderSide: BorderSide(
                                                                          color: ColorSelect
                                                                              .textColor3,
                                                                          width:
                                                                              1)),
                                                                ),
                                                              ))
                                                        ],
                                                      )
                                                    : Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5))),
                                                        child: Table(
                                                          columnWidths: const {
                                                            0: FlexColumnWidth(
                                                                1),
                                                            1: FlexColumnWidth(
                                                                1),
                                                            2: FlexColumnWidth(
                                                                1),
                                                          },
                                                          children: [
                                                            TableRow(children: [
                                                              Container(
                                                                height: height *
                                                                    0.03,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: Color.fromRGBO(
                                                                            245,
                                                                            246,
                                                                            250,
                                                                            1),
                                                                        border:
                                                                            Border(
                                                                          bottom: BorderSide(
                                                                              width: 1,
                                                                              color: Color.fromRGBO(158, 170, 202, 1)),
                                                                          right:
                                                                              BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromRGBO(
                                                                                158,
                                                                                170,
                                                                                202,
                                                                                1),
                                                                          ),
                                                                        )),
                                                                child: Center(
                                                                  child: Text(
                                                                    "업체명",
                                                                    style:
                                                                        TextStyle(
                                                                      color: ColorSelect
                                                                          .textColor5,
                                                                      fontSize:
                                                                          width *
                                                                              0.009,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          'SUIT',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: height *
                                                                    0.03,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: Color.fromRGBO(
                                                                            245,
                                                                            246,
                                                                            250,
                                                                            1),
                                                                        border:
                                                                            Border(
                                                                          bottom: BorderSide(
                                                                              width: 1,
                                                                              color: Color.fromRGBO(158, 170, 202, 1)),
                                                                          right:
                                                                              BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromRGBO(
                                                                                158,
                                                                                170,
                                                                                202,
                                                                                1),
                                                                          ),
                                                                        )),
                                                                child: Center(
                                                                  child: Text(
                                                                    "이름",
                                                                    style:
                                                                        TextStyle(
                                                                      color: ColorSelect
                                                                          .textColor5,
                                                                      fontSize:
                                                                          width *
                                                                              0.009,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          'SUIT',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: height *
                                                                    0.03,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: Color.fromRGBO(
                                                                            245,
                                                                            246,
                                                                            250,
                                                                            1),
                                                                        border:
                                                                            Border(
                                                                          bottom: BorderSide(
                                                                              width: 1,
                                                                              color: Color.fromRGBO(158, 170, 202, 1)),
                                                                        )),
                                                                child: Center(
                                                                  child: Text(
                                                                    "연락처",
                                                                    style:
                                                                        TextStyle(
                                                                      color: ColorSelect
                                                                          .textColor5,
                                                                      fontSize:
                                                                          width *
                                                                              0.009,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          'SUIT',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                            TableRow(children: [
                                                              Container(
                                                                height: height *
                                                                    0.11,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border:
                                                                            Border(
                                                                          bottom: BorderSide(
                                                                              width: 1,
                                                                              color: Color.fromRGBO(158, 170, 202, 1)),
                                                                          right:
                                                                              BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromRGBO(
                                                                                158,
                                                                                170,
                                                                                202,
                                                                                1),
                                                                          ),
                                                                        )),
                                                                child: Center(
                                                                  child: Text(
                                                                    "업체명",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.009,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          'SUIT',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: height *
                                                                    0.11,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border:
                                                                            Border(
                                                                          bottom: BorderSide(
                                                                              width: 1,
                                                                              color: Color.fromRGBO(158, 170, 202, 1)),
                                                                          right:
                                                                              BorderSide(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromRGBO(
                                                                                158,
                                                                                170,
                                                                                202,
                                                                                1),
                                                                          ),
                                                                        )),
                                                                child: Center(
                                                                  child: Text(
                                                                    "홍길동",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.009,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          'SUIT',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: height *
                                                                    0.11,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border:
                                                                      Border(
                                                                    bottom: BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Color.fromRGBO(
                                                                            158,
                                                                            170,
                                                                            202,
                                                                            1)),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "010-1234-5678",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.009,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          'SUIT',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                          ],
                                                        ),
                                                      ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}

void popup(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: ((context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        content: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  children: const [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 45,
                      color: ColorSelect.blueColor,
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Center(
                      child: Text(
                        "저장 후 다시 시도해주세요.",
                        textScaleFactor: FontSize.h5,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              //확인버튼
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorSelect.blueColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    child: const Text(
                      "확인",
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
    }),
  );
}
