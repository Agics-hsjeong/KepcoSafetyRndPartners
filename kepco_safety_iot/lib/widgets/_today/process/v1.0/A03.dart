// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/Signature.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:kepco_safety_iot/widgets/common/TableBox2.dart';

class A03 extends StatefulWidget {
  const A03(
      {Key? key,
      required this.progressTimeline,
      required this.stateTitle,
      required this.single})
      : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<A03> createState() => _A03State();
}

class _A03State extends State<A03> {
  late ProgressTimeline progressTimeline;
  List<riskState> riskStages = List.empty(growable: true);

  late TableBox2 SafetableBox1;
  late TableBox2 SafetableBox2;
  late TableBox2 SafetableBox3;
  late TableBox2 SafetableBox4;
  List<SingleRowState> SafeRow1 = List.empty(growable: true);
  List<SingleRowState> SafeRow2 = List.empty(growable: true);
  List<SingleRowState> SafeRow3 = List.empty(growable: true);
  List<SingleRowState> SafeRow4 = List.empty(growable: true);

  List workList = List.empty(growable: true);
  List<String> items = List.empty(growable: true);

  String? selectedValue;
  late List<bool> isSelected;

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

  void divisionOfWork() {
    setState(() {
      workList = [
        {
          'name': '임창정',
          'contents': '작업책임자',
          'imgUrl': 'assets/img/개인안전장구착용프로필사진.png'
        },
        {
          'name': '홍길동',
          'contents': '',
          'imgUrl': 'assets/img/개인안전장구착용프로필사진.png'
        },
        {
          'name': '성춘향',
          'contents': '',
          'imgUrl': 'assets/img/개인안전장구착용프로필사진.png'
        },
        {
          'name': '유관순',
          'contents': '',
          'imgUrl': 'assets/img/개인안전장구착용프로필사진.png'
        },
      ];
    });
  }

  void contentsOfWork() {
    setState(() {
      items = [
        '작업 내용 선택1',
        '작업 책임자',
        '작업 내용 선택2',
        '작업 내용 선택3',
      ];
    });
  }

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;
    startProc();

    riskStages = [
      riskState(subject: "사람", subContents: [
        RiskRowState(
          factor: "승주 및 주상작업시 추락",
          method: "안전대, 안전모 등 안전장구 착용",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        ),
        RiskRowState(
          factor: "고소작업시 공구 및 자제 추락",
          method: "지상감시자 배치 및 안전모 착용",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        )
      ]),
      riskState(subject: "장비", subContents: [
        RiskRowState(
          factor: "활선작업차 전력선 근절",
          method: "안전장구 착용, 충전부 방호",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        ),
        RiskRowState(
          factor: "활선작업자 불균형 (전도)",
          method: "아웃트리거 설치",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        )
      ]),
      riskState(subject: "환경", subContents: [
        RiskRowState(
          factor: "공사현장주변 교통 혼잡",
          method: "공사현장 주변 정리 후 확인",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        ),
        RiskRowState(
          factor: "공사작업 후 현장주변 정리",
          method: "공사현장 주변 정리 후 확인",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        ),
      ]),
      riskState(subject: "관리", subContents: [
        RiskRowState(
          factor: "무자격자전공 인원 작업 참여",
          method: "확선, 무정전 자격 이상유무 확인",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        ),
        RiskRowState(
          factor: "작업책임자 미상주",
          method: "작업책임자 위임",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        ),
      ]),
    ];

    SafeRow1 = [
      SingleRowState(
          contents: "분담작업 시행의지", isChecked: [true, false], type: "1"),
      SingleRowState(
          contents: "가정사 등 Stress 여부", isChecked: [true, false], type: "1"),
    ];

    SafeRow2 = [
      SingleRowState(
          contents: "음주 및 약물복용 (수면제 등)", isChecked: [true, false], type: "1"),
      SingleRowState(
          contents: "신체상태 (혈색 등)", isChecked: [true, false], type: "1"),
    ];
    SafeRow3 = [
      SingleRowState(
          contents: "음주 및 약물복용", isChecked: [true, false], type: "1"),
      SingleRowState(
          contents: "가정사 등 Stress 여부", isChecked: [true, false], type: "1"),
    ];
    SafeRow4 = [
      SingleRowState(
          contents: "분담작업 시행의지", isChecked: [true, false], type: "1"),
      SingleRowState(
          contents: "가정사 등 Stress 여부", isChecked: [true, false], type: "1"),
    ];

    SafetableBox1 = TableBox2(title: "신체 (Physical)", list: SafeRow1);
    SafetableBox2 = TableBox2(title: "정신 (Mental)", list: SafeRow2);
    SafetableBox3 = TableBox2(title: "지성 (Inteligent)", list: SafeRow3);
    SafetableBox4 = TableBox2(title: "감성 (Sensible)", list: SafeRow4);

    divisionOfWork();
    contentsOfWork();
    super.initState();
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
            Text(
              "| ${widget.stateTitle}",
              textScaleFactor: FontSize.h4,
              style: const TextStyle(
                  color: ColorSelect.blueColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text("작업전 안전회의 및 위험성 평가표",
                            textScaleFactor: FontSize.h4,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  line(),
                  SafeTableRow(
                    title: "공사명",
                    cont: "주촌내삼 김해시장 도로확장 지장이설 공사",
                  ),
                  line(),
                  SafeTableRow(
                    title: "일시",
                    cont: "2022-01-01",
                  ),
                  line(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Center(
                            child: Text("업무분담",
                                textScaleFactor: FontSize.h4,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Table(
                                    children: [
                                      TableRow(children: [
                                        SizedBox(
                                          height: 60,
                                          child: Center(
                                            child: Text(
                                              "작업자",
                                              textScaleFactor: FontSize.h4,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 60,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "작업내용",
                                                textScaleFactor: FontSize.h4,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: workList
                                  .map(
                                    (e) => Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          //업무분담 작업자 작업내용
                                          child: Table(
                                            children: [
                                              TableRow(children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  height: 40,
                                                  child: Center(
                                                    child: Text(
                                                      e['name'].toString(),
                                                      textScaleFactor:
                                                          FontSize.h5,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 5,
                                                      bottom: 5,
                                                      right: 20),
                                                  height: 40,
                                                  child: e['contents']
                                                              .toString() ==
                                                          "작업책임자"
                                                      ? Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            e['contents']
                                                                .toString(),
                                                            textScaleFactor:
                                                                FontSize.h5,
                                                          ),
                                                        )
                                                      : DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2(
                                                            isExpanded: true,
                                                            hint: Row(
                                                              children: const [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10),
                                                                  child: Text(
                                                                    '작업 내용 선택',
                                                                    textScaleFactor:
                                                                        FontSize
                                                                            .h6,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            items: items
                                                                .map(
                                                                  (item) =>
                                                                      DropdownMenuItem<
                                                                          String>(
                                                                    value: item,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10.0),
                                                                      child:
                                                                          Text(
                                                                        item,
                                                                        textScaleFactor:
                                                                            FontSize.h6,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                            value: e['contents']
                                                                        .toString() ==
                                                                    ""
                                                                ? null
                                                                : e['contents']
                                                                    .toString(),
                                                            onChanged: (value) {
                                                              setState(
                                                                () {
                                                                  e['contents'] =
                                                                      value
                                                                          as String;
                                                                },
                                                              );
                                                            },
                                                            // buttonHeight: 30,
                                                            // buttonWidth: 100,
                                                            // itemHeight: 30,
                                                            buttonDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xffa5b2c3)),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            dropdownPadding:
                                                                null,
                                                            dropdownDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                )
                                              ]),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                  .toList(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  line(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(children: [
                      //TableBox2 위젯
                      SafetableBox1,
                      SafetableBox2,
                      SafetableBox3,
                      SafetableBox4
                    ]),
                  ),
                  line(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text("근로자 참여 위험성평가 교육",
                            textScaleFactor: FontSize.h4,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  line(),
                  Container(
                    width: double.infinity,
                    child: Column(
                        children: riskStages
                            .map(
                              (e) => Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 25),
                                    child: Center(
                                      child: Text(
                                        e.subject,
                                        textScaleFactor: FontSize.h4,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  line(),
                                  Column(
                                    children: e.subContents
                                        .map(
                                          (e) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //유해,위험요인
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 45),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "유해·위험 요인",
                                                          textScaleFactor:
                                                              FontSize.h4,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 25.0),
                                                          child: Text(
                                                            e.factor,
                                                            textScaleFactor:
                                                                FontSize.h4,
                                                            style: TextStyle(
                                                                color: ColorSelect
                                                                    .grayColor2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 45.0,
                                                              bottom: 15.0),
                                                      child: Center(
                                                          child: Text(
                                                        "위험성",
                                                        textScaleFactor:
                                                            FontSize.h4,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff9f9f9),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          bottom: 10.0,
                                                          right: 8),
                                                      width: double.infinity,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.06,
                                                      child: ToggleButtons(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderColor:
                                                            Color(0xffb7b7b7),
                                                        fillColor:
                                                            Color(0xffe2e6ff),
                                                        selectedBorderColor:
                                                            ColorSelect
                                                                .blueColor,
                                                        selectedColor:
                                                            ColorSelect
                                                                .blueColor,
                                                        color:
                                                            Color(0xffb7b7b7),
                                                        constraints: BoxConstraints.expand(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                8.6,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.06),
                                                        onPressed: (int index) {
                                                          setState(() {
                                                            for (int i = 0;
                                                                i <
                                                                    e.factorRisk
                                                                        .length;
                                                                i++) {
                                                              if (i == index) {
                                                                if (e.factorRisk[
                                                                        i] !=
                                                                    true) {
                                                                  e.factorRisk[
                                                                          i] =
                                                                      !e.factorRisk[
                                                                          i];
                                                                }
                                                              } else {
                                                                e.factorRisk[
                                                                    i] = false;
                                                              }
                                                            }
                                                          });
                                                        },
                                                        isSelected:
                                                            e.factorRisk,
                                                        children: <Widget>[
                                                          Text('상',
                                                              textScaleFactor:
                                                                  FontSize.h4,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Text('중',
                                                              textScaleFactor:
                                                                  FontSize.h4,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Text('하',
                                                              textScaleFactor:
                                                                  FontSize.h4,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //위험감소 조치
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 45),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "위험감소 조치",
                                                          textScaleFactor:
                                                              FontSize.h4,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 25.0),
                                                          child: Text(
                                                            e.method,
                                                            textScaleFactor:
                                                                FontSize.h4,
                                                            style: TextStyle(
                                                                color: ColorSelect
                                                                    .grayColor2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 45.0,
                                                              bottom: 15.0),
                                                      child: Center(
                                                          child: Text(
                                                        "위험성",
                                                        textScaleFactor:
                                                            FontSize.h4,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff9f9f9),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          bottom: 10.0,
                                                          right: 8),
                                                      width: double.infinity,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.06,
                                                      child: ToggleButtons(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderColor:
                                                            Color(0xffb7b7b7),
                                                        fillColor:
                                                            Color(0xffe2e6ff),
                                                        selectedBorderColor:
                                                            ColorSelect
                                                                .blueColor,
                                                        selectedColor:
                                                            ColorSelect
                                                                .blueColor,
                                                        color:
                                                            Color(0xffb7b7b7),
                                                        constraints: BoxConstraints.expand(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                8.6,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05),
                                                        onPressed: (int index) {
                                                          setState(() {
                                                            for (int i = 0;
                                                                i <
                                                                    e.actionRisk
                                                                        .length;
                                                                i++) {
                                                              if (i == index) {
                                                                if (e.actionRisk[
                                                                        i] !=
                                                                    true) {
                                                                  e.actionRisk[
                                                                          i] =
                                                                      !e.actionRisk[
                                                                          i];
                                                                }
                                                              } else {
                                                                e.actionRisk[
                                                                    i] = false;
                                                              }
                                                            }
                                                          });
                                                        },
                                                        isSelected:
                                                            e.actionRisk,
                                                        children: <Widget>[
                                                          Text('상',
                                                              textScaleFactor:
                                                                  FontSize.h4,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                          Text('중',
                                                              textScaleFactor:
                                                                  FontSize.h4,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                          Text('하',
                                                              textScaleFactor:
                                                                  FontSize.h4,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //작업가능여부
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 45),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 15.0),
                                                      child: Center(
                                                          child: Text(
                                                        "작업 가능 여부",
                                                        textScaleFactor:
                                                            FontSize.h4,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff9f9f9),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          bottom: 10.0,
                                                          right: 8),
                                                      width: double.infinity,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.06,
                                                      child: ToggleButtons(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderColor:
                                                            Color(0xffb7b7b7),
                                                        fillColor:
                                                            Color(0xffe2e6ff),
                                                        selectedBorderColor:
                                                            ColorSelect
                                                                .blueColor,
                                                        selectedColor:
                                                            ColorSelect
                                                                .blueColor,
                                                        color:
                                                            Color(0xffb7b7b7),
                                                        constraints: BoxConstraints.expand(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                5.8,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05),
                                                        onPressed: (int index) {
                                                          setState(() {
                                                            for (int i = 0;
                                                                i <
                                                                    e.workYN
                                                                        .length;
                                                                i++) {
                                                              if (i == index) {
                                                                if (e.workYN[
                                                                        i] !=
                                                                    true) {
                                                                  e.workYN[i] =
                                                                      !e.workYN[
                                                                          i];
                                                                }
                                                              } else {
                                                                e.workYN[i] =
                                                                    false;
                                                              }
                                                            }
                                                          });
                                                        },
                                                        isSelected: e.workYN,
                                                        children: <Widget>[
                                                          Text('작업 가능',
                                                              textScaleFactor:
                                                                  FontSize.h4,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                          Text('작업 불가능',
                                                              textScaleFactor:
                                                                  FontSize.h4,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 45.0),
                                                child: line(),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            )
                            .toList()),
                  ),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 45.0, bottom: 45.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "서명",
                              textScaleFactor: FontSize.h4,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Table(
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 20.0),
                                            child: Center(
                                              child: Text(
                                                "작업자",
                                                textScaleFactor: FontSize.h4,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 20.0),
                                            child: Center(
                                              child: Text(
                                                "서명",
                                                textScaleFactor: FontSize.h4,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          )
                                        ]),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: workList
                                    .map(
                                      (e) => Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Table(
                                              children: [
                                                TableRow(children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0),
                                                    child: Center(
                                                      child: Text(
                                                        e['name'].toString(),
                                                        textScaleFactor:
                                                            FontSize.h4,
                                                        style: TextStyle(),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Center(
                                                          child: Signature()))
                                                ]),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                    .toList(),
                              )
                            ],
                          ),
                        ],
                      )),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 45.0, bottom: 45.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "작업자 사진",
                            textScaleFactor: FontSize.h4,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 30.0)),
                          Column(
                            children: workList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Image.asset(e['imgUrl'].toString(),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width),
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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

// 라인공통
class line extends StatelessWidget {
  const line({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
    );
  }
}

//테이블 공통사항 Row
class SafeTableRow extends StatelessWidget {
  const SafeTableRow({
    Key? key,
    required this.title,
    required this.cont,
  }) : super(key: key);

  final String title;
  final String cont;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Center(
              child: Text(title,
                  textScaleFactor: FontSize.h4,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                cont,
                textScaleFactor: FontSize.h5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class riskState {
  String subject;
  List<RiskRowState> subContents;

  riskState({
    required this.subject,
    required this.subContents,
  });
}

class RiskRowState {
  String factor;
  String method;
  List<bool> factorRisk;
  List<bool> actionRisk;
  List<bool> workYN;

  RiskRowState({
    required this.factor,
    required this.method,
    required this.factorRisk,
    required this.actionRisk,
    required this.workYN,
  });
}
