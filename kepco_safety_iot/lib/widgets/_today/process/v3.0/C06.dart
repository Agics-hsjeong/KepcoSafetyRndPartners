import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:kepco_safety_iot/widgets/common/TableBox2.dart';
import 'package:kepco_safety_iot/widgets/common/Signature.dart';
import 'package:kepco_safety_iot/widgets/common/Qrcodescan.dart';

class C06 extends StatefulWidget {
  C06({
    Key? key,
    required this.progressTimeline,
    required this.stateTitle,
    required this.single,
  }) : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;
  final _C06State C06state = _C06State();

  void onSelectWorker(int index) {
    C06state.onSelectWorker(index);
  }

  void gotoNextWorker() {
    C06state.gotoNextWorker();
  }

  void gotoPrevWorker() {
    C06state.gotoPrevWorker();
  }

  @override
  State<C06> createState() => C06state;
}

class _C06State extends State<C06> with TickerProviderStateMixin {
  late ProgressTimeline progressTimeline;
  List<cRiskState> riskStages = List.empty(growable: true);
  final _controller = ScrollController();
  int selectedNum = 0;
  String qrResult = '';

  late TableBox2 SafetableBox1;
  late TableBox2 SafetableBox2;
  late TableBox2 SafetableBox3;
  late TableBox2 SafetableBox4;
  List<SingleRowState> SafeRow1 = List.empty(growable: true);
  List<SingleRowState> SafeRow2 = List.empty(growable: true);
  List<SingleRowState> SafeRow3 = List.empty(growable: true);
  List<SingleRowState> SafeRow4 = List.empty(growable: true);

  List workList = List.empty(growable: true);
  List<String> workerList = List.empty(growable: true);
  List<String> items = List.empty(growable: true);
  List<String> health1 = List.empty(growable: true);
  List<String> health2 = List.empty(growable: true);
  List<String> health3 = List.empty(growable: true);
  List<String> health4 = List.empty(growable: true);
  List<String> health5 = List.empty(growable: true);

  String? selectedValue;
  late List<bool> isSelected;

  void onSelectWorker(int index) {
    setState(() {
      selectedNum = index;
      _controller.animateTo(100.0 * selectedNum,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn);
    });
  }

  void gotoNextWorker() {
    setState(() {
      if (selectedNum < workerList.length - 1) {
        selectedNum++;
        _controller.animateTo(100.0 * selectedNum,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      }
    });
  }

  void gotoPrevWorker() {
    setState(() {
      if (selectedNum > 0) {
        selectedNum--;
        _controller.animateTo(100.0 * selectedNum,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      }
    });
  }

  void divisionOfWork() {
    List<bool> isChecked = [true, false];
    setState(() {
      workList = [
        {
          'name': '임창정',
          'contents': '작업책임자',
          'sbp': '',
          'dbp': '',
          'temper': '',
          'heartbeat': '',
          'bloodLevel': '',
          'signCnt': '',
          'isChecked': isChecked,
          'helmatId': '',
          'imgUrl': 'assets/img/개인안전장구착용프로필사진.png'
        },
        {
          'name': '홍길동',
          'contents': '',
          'sbp': '',
          'dbp': '',
          'temper': '',
          'heartbeat': '',
          'bloodLevel': '',
          'signCnt': '',
          'isChecked': isChecked,
          'helmatId': '',
          'imgUrl': 'assets/img/개인안전장구착용프로필사진.png'
        },
        {
          'name': '성춘향',
          'contents': '',
          'sbp': '',
          'dbp': '',
          'temper': '',
          'heartbeat': '',
          'bloodLevel': '',
          'signCnt': '',
          'isChecked': isChecked,
          'helmatId': '',
          'imgUrl': 'assets/img/개인안전장구착용프로필사진.png'
        },
        {
          'name': '유관순',
          'contents': '',
          'sbp': '',
          'dbp': '',
          'temper': '',
          'heartbeat': '',
          'bloodLevel': '',
          'signCnt': '',
          'isChecked': isChecked,
          'helmatId': '',
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
      health1 = [
        '120 미만',
        '120~129',
        '130~139',
        '140~159',
        '160 이상',
      ];
      health2 = [
        '80 미만',
        '80~84',
        '85~89',
        '90~99',
        '100 이상',
      ];
      health3 = [
        '26 이하',
        '27~29',
        '30~33',
        '34~36',
        '37 이상',
      ];
      health4 = [
        '80 이하',
        '81~89',
        '90~99',
        '100~109',
        '110 이상',
      ];
      health5 = [
        '80 이하',
        '95 이하',
        '95~99',
      ];
    });
  }

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;

    workerList = [
      '임창정',
      '홍길동',
      '성춘향',
      '유관순',
    ];

    stratProc(widget.single.state);

    riskStages = [
      cRiskState(subject: "사람", subContents: [
        CRiskRowState(
          factor: "승주 및 주상작업시 추락",
          method: "안전대, 안전모 등 안전장구 착용",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        ),
        CRiskRowState(
          factor: "고소작업시 공구 및 자제 추락",
          method: "지상감시자 배치 및 안전모 착용",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        )
      ]),
      cRiskState(subject: "장비", subContents: [
        CRiskRowState(
          factor: "활선작업차 전력선 근절",
          method: "안전장구 착용, 충전부 방호",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        ),
        CRiskRowState(
          factor: "활선작업자 불균형 (전도)",
          method: "아웃트리거 설치",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        )
      ]),
      cRiskState(subject: "환경", subContents: [
        CRiskRowState(
          factor: "공사현장주변 교통 혼잡",
          method: "신호수 배치, 라바콘 설치",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        ),
        CRiskRowState(
          factor: "공사작업 후 현장주변 정리",
          method: "신호수 배치, 라바콘 설치",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        ),
      ]),
      cRiskState(subject: "관리", subContents: [
        CRiskRowState(
          factor: "무자격자전공 인원 작업 참여",
          method: "확선, 무정전 자격 이상유무 확인",
          factorRisk: [false, false, false],
          actionRisk: [false, false, false],
          workYN: [true, false],
        ),
        CRiskRowState(
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
          contents: "분담작업 시행의지", isChecked: [true, false], type: "1"),
      SingleRowState(
          contents: "가정사 등 Stress 여부", isChecked: [true, false], type: "1"),
    ];
    SafeRow3 = [
      SingleRowState(
          contents: "음주 및 약물복용", isChecked: [true, false], type: "1"),
      SingleRowState(
          contents: "신체상태 (혈색 등) 이상", isChecked: [true, false], type: "1"),
    ];
    SafeRow4 = [
      SingleRowState(
          contents: "음주 및 약물복용", isChecked: [true, false], type: "1"),
      SingleRowState(
          contents: "신체상태 (혈색 등) 이상", isChecked: [true, false], type: "1"),
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "| ${widget.stateTitle}",
              style: TextStyle(
                color: ColorSelect.blueColor,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.012,
                fontFamily: 'SUIT',
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.03),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: SizedBox(
                      height: height * 0.04,
                      child: Center(
                        child: Text("작업전 안전회의 및 위험성 평가표",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: width * 0.012,
                              fontFamily: 'SUIT',
                            )),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: ColorSelect.borderColor2,
                  ),
                  WorkTableRow(
                    title: "공사명",
                    cont: "주촌내삼 김해시장 도로확장 지장이설 공사",
                  ),
                  WorkTableRow(
                    title: "일시",
                    cont: "2022-01-01",
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.015, bottom: height * 0.03),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.04,
                          child: Center(
                            child: Text("업무분담",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: width * 0.012,
                                  fontFamily: 'SUIT',
                                )),
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
                                          height: height * 0.05,
                                          child: Center(
                                            child: Text(
                                              "작업자",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: width * 0.01,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.05,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "작업내용",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: width * 0.01,
                                                  fontFamily: 'SUIT',
                                                ),
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
                                                      vertical: height * 0.01),
                                                  height: height * 0.04,
                                                  child: Center(
                                                    child: Text(
                                                      e['name'].toString(),
                                                      style: TextStyle(
                                                        color: ColorSelect
                                                            .textColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.01,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: height * 0.01,
                                                      bottom: height * 0.01,
                                                      right: width * 0.05),
                                                  height: height * 0.04,
                                                  child: e['contents']
                                                              .toString() ==
                                                          "작업책임자"
                                                      ? Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            e['contents']
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: ColorSelect
                                                                  .textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  width * 0.01,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        )
                                                      : DropdownButtonHideUnderline(
                                                          child:
                                                              DropdownButton2(
                                                            isExpanded: true,
                                                            hint: Row(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: width *
                                                                          0.002),
                                                                  child: Text(
                                                                    '작업 내용 선택',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      fontSize:
                                                                          width *
                                                                              0.009,
                                                                      color: ColorSelect
                                                                          .textColor3,
                                                                      fontFamily:
                                                                          'SUIT',
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
                                                                      padding: EdgeInsets.only(
                                                                          left: width *
                                                                              0.002),
                                                                      child:
                                                                          Text(
                                                                        item,
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          fontSize:
                                                                              width * 0.009,
                                                                          fontFamily:
                                                                              'SUIT',
                                                                        ),
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
                                                            buttonDecoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: Border.all(
                                                                  color: ColorSelect
                                                                      .textColor3),
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
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: ColorSelect.borderColor2,
                  ),
                  // 건강체크
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.03, bottom: height * 0.025),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("건강체크",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.012,
                            fontFamily: 'SUIT',
                          )),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.79,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.042,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: height * 0.45,
                                child: IconButton(
                                  padding: EdgeInsets.zero, // 패딩 설정
                                  constraints: BoxConstraints(), // constraints
                                  splashRadius: 20.0,
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: ColorSelect.blueColor,
                                    size: width * 0.015,
                                  ),
                                  onPressed: () {
                                    gotoPrevWorker();
                                  },
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  controller: _controller,
                                  itemCount: buildStates().length,
                                  itemBuilder: (context, index) =>
                                      buildStates()[index],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.45,
                                child: IconButton(
                                  padding: EdgeInsets.zero, // 패딩 설정
                                  constraints: BoxConstraints(), // constraints
                                  splashRadius: 20.0,
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: ColorSelect.blueColor,
                                    size: width * 0.015,
                                  ),
                                  onPressed: () {
                                    gotoNextWorker();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: height * 0.03)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: height * 0.012),
                              child: SizedBox(
                                height: height * 0.11,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: height * 0.01),
                                      child: Text("혈압",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: width * 0.01,
                                            fontFamily: 'SUIT',
                                          )),
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: height * 0.04,
                                              width: width * 0.1,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2(
                                                  isExpanded: true,
                                                  hint: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: width *
                                                                    0.002),
                                                        child: Text(
                                                          '수축기 혈압 선택',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize:
                                                                width * 0.009,
                                                            color: ColorSelect
                                                                .textColor3,
                                                            fontFamily: 'SUIT',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  items: health1
                                                      .map(
                                                        (item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                          value: item,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.002),
                                                            child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize:
                                                                    width *
                                                                        0.009,
                                                                fontFamily:
                                                                    'SUIT',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  value: workList[selectedNum]
                                                                  ['sbp']
                                                              .toString() ==
                                                          ""
                                                      ? null
                                                      : workList[selectedNum]
                                                              ['sbp']
                                                          .toString(),
                                                  onChanged: (value) {
                                                    setState(
                                                      () {
                                                        workList[selectedNum]
                                                                ['sbp'] =
                                                            value as String;
                                                      },
                                                    );
                                                  },
                                                  buttonDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textColor3),
                                                    color: Colors.white,
                                                  ),
                                                  dropdownPadding: null,
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.01),
                                              child: Text("mmHg",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.01,
                                                    fontFamily: 'SUIT',
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: height * 0.04,
                                              width: width * 0.1,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2(
                                                  isExpanded: true,
                                                  hint: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: width *
                                                                    0.002),
                                                        child: Text(
                                                          '확장기 혈압 선택',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize:
                                                                width * 0.009,
                                                            color: ColorSelect
                                                                .textColor3,
                                                            fontFamily: 'SUIT',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  items: health2
                                                      .map(
                                                        (item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                          value: item,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: width *
                                                                        0.002),
                                                            child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize:
                                                                    width *
                                                                        0.009,
                                                                fontFamily:
                                                                    'SUIT',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  value: workList[selectedNum]
                                                                  ['dbp']
                                                              .toString() ==
                                                          ""
                                                      ? null
                                                      : workList[selectedNum]
                                                              ['dbp']
                                                          .toString(),
                                                  onChanged: (value) {
                                                    setState(
                                                      () {
                                                        workList[selectedNum]
                                                                ['dbp'] =
                                                            value as String;
                                                      },
                                                    );
                                                  },
                                                  buttonDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textColor3),
                                                    color: Colors.white,
                                                  ),
                                                  dropdownPadding: null,
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.01),
                                              child: Text("mmHg",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.01,
                                                    fontFamily: 'SUIT',
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.08,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("체온",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: width * 0.01,
                                        fontFamily: 'SUIT',
                                      )),
                                  SizedBox(
                                    width: width * 0.05,
                                  ),
                                  SizedBox(
                                    height: height * 0.04,
                                    width: width * 0.1,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.002),
                                              child: Text(
                                                '체온 선택',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: width * 0.009,
                                                  color: ColorSelect.textColor3,
                                                  fontFamily: 'SUIT',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: health3
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.002),
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        value: workList[selectedNum]['temper']
                                                    .toString() ==
                                                ""
                                            ? null
                                            : workList[selectedNum]['temper']
                                                .toString(),
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              workList[selectedNum]['temper'] =
                                                  value as String;
                                            },
                                          );
                                        },
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: ColorSelect.textColor3),
                                          color: Colors.white,
                                        ),
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.01),
                                    child: Text("℃",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: width * 0.01,
                                          fontFamily: 'SUIT',
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.08,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("심박수",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: width * 0.01,
                                        fontFamily: 'SUIT',
                                      )),
                                  SizedBox(
                                    width: width * 0.042,
                                  ),
                                  SizedBox(
                                    height: height * 0.04,
                                    width: width * 0.1,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.002),
                                              child: Text(
                                                '심박수 선택',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: width * 0.009,
                                                  color: ColorSelect.textColor3,
                                                  fontFamily: 'SUIT',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: health3
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.002),
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        value: workList[selectedNum]
                                                        ['heartbeat']
                                                    .toString() ==
                                                ""
                                            ? null
                                            : workList[selectedNum]['heartbeat']
                                                .toString(),
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              workList[selectedNum]
                                                      ['heartbeat'] =
                                                  value as String;
                                            },
                                          );
                                        },
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: ColorSelect.textColor3),
                                          color: Colors.white,
                                        ),
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.01),
                                    child: Text("bpm",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: width * 0.01,
                                          fontFamily: 'SUIT',
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.08,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("숙취",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: width * 0.01,
                                        fontFamily: 'SUIT',
                                      )),
                                  SizedBox(
                                    width: width * 0.05,
                                  ),
                                  SizedBox(
                                    height: height * 0.04,
                                    width: width * 0.1,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.002),
                                              child: Text(
                                                '수축기 혈압 선택',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: width * 0.009,
                                                  color: ColorSelect.textColor3,
                                                  fontFamily: 'SUIT',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: health1
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.002),
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        value: workList[selectedNum]
                                                        ['heartbeat']
                                                    .toString() ==
                                                ""
                                            ? null
                                            : workList[selectedNum]['heartbeat']
                                                .toString(),
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              workList[selectedNum]
                                                      ['heartbeat'] =
                                                  value as String;
                                            },
                                          );
                                        },
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: ColorSelect.textColor3),
                                          color: Colors.white,
                                        ),
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.01),
                                    child: Text("mmHg",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: width * 0.01,
                                          fontFamily: 'SUIT',
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.08,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("혈중산소농도",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: width * 0.01,
                                        fontFamily: 'SUIT',
                                      )),
                                  SizedBox(
                                    width: width * 0.013,
                                  ),
                                  SizedBox(
                                    height: height * 0.04,
                                    width: width * 0.1,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.002),
                                              child: Text(
                                                '혈중산소농도 선택',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: width * 0.009,
                                                  color: ColorSelect.textColor3,
                                                  fontFamily: 'SUIT',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: health5
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.002),
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        value: workList[selectedNum]
                                                        ['bloodLevel']
                                                    .toString() ==
                                                ""
                                            ? null
                                            : workList[selectedNum]
                                                    ['bloodLevel']
                                                .toString(),
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              workList[selectedNum]
                                                      ['bloodLevel'] =
                                                  value as String;
                                            },
                                          );
                                        },
                                        buttonDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: ColorSelect.textColor3),
                                          color: Colors.white,
                                        ),
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.01),
                                    child: Text("% SpO²",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: width * 0.01,
                                          fontFamily: 'SUIT',
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.015, bottom: height * 0.02),
                              child: Text(
                                "수면부족",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: width * 0.01,
                                  fontFamily: 'SUIT',
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: ColorSelect.toggleColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              margin: EdgeInsets.only(bottom: height * 0.01),
                              width: double.infinity,
                              height: height * 0.05,
                              child: ToggleButtons(
                                borderRadius: BorderRadius.circular(30.0),
                                borderColor: ColorSelect.borderColor3,
                                fillColor: ColorSelect.blueColor2,
                                selectedColor: ColorSelect.toggleColor3,
                                selectedBorderColor: ColorSelect.toggleColor3,
                                color: ColorSelect.textColor2,
                                constraints: BoxConstraints.expand(
                                    width: width * 0.1795),
                                children: <Widget>[
                                  Text('해당없음',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: width * 0.011,
                                        fontFamily: 'SUIT',
                                      )),
                                  Text('해당있음',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: width * 0.011,
                                        fontFamily: 'SUIT',
                                      )),
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    for (int i = 0;
                                        i <
                                            workList[selectedNum]['isChecked']
                                                .length;
                                        i++) {
                                      if (i == index) {
                                        if (workList[selectedNum]['isChecked']
                                                [i] !=
                                            true) {
                                          workList[selectedNum]['isChecked']
                                                  [i] =
                                              !workList[selectedNum]
                                                  ['isChecked'][i];
                                        }
                                      } else {
                                        workList[selectedNum]['isChecked'][i] =
                                            false;
                                      }
                                    }
                                  });
                                },
                                isSelected: workList[selectedNum]['isChecked'],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.02, bottom: height * 0.02),
                              child: Text(
                                "특이사항",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: width * 0.01,
                                  fontFamily: 'SUIT',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                initialValue: workList[selectedNum]['signCnt'],
                                decoration: InputDecoration(
                                  hintText: "특이사항 없음",
                                  labelStyle: TextStyle(
                                    color: ColorSelect.textColor3,
                                    fontWeight: FontWeight.w300,
                                    fontSize: width * 0.009,
                                    fontFamily: 'SUIT',
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorSelect.textColor3,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: ColorSelect.borderColor2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.005),
                    child: Column(children: [
                      //TableBox2 위젯
                      SafetableBox1,
                      SafetableBox2,
                      SafetableBox3,
                      SafetableBox4
                    ]),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: ColorSelect.borderColor2,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.03),
                    child: SizedBox(
                      height: height * 0.05,
                      child: Center(
                        child: Text(
                          "근로자 참여 위험성평가 교육",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.012,
                            fontFamily: 'SUIT',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: ColorSelect.borderColor2,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: Column(
                        children: riskStages
                            .map(
                              (e) => Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.022),
                                    child: Center(
                                      child: Text(
                                        e.subject,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: width * 0.012,
                                          fontFamily: 'SUIT',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    height: 1,
                                    color: ColorSelect.borderColor2,
                                  ),
                                  Column(
                                    children: e.subContents
                                        .map(
                                          (e) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //유해,위험요인
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * 0.04),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "유해·위험 요인",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                width * 0.01,
                                                            fontFamily: 'SUIT',
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: width *
                                                                      0.01),
                                                          child: Text(
                                                            e.factor,
                                                            style: TextStyle(
                                                              color: ColorSelect
                                                                  .textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  width * 0.01,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.03,
                                                          bottom:
                                                              height * 0.013),
                                                      child: Center(
                                                          child: Text(
                                                        "위험성",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              width * 0.009,
                                                          fontFamily: 'SUIT',
                                                        ),
                                                      )),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: ColorSelect
                                                            .toggleColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          bottom:
                                                              height * 0.01),
                                                      width: double.infinity,
                                                      height: height * 0.05,
                                                      child: ToggleButtons(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderColor: ColorSelect
                                                            .borderColor3,
                                                        fillColor: ColorSelect
                                                            .blueColor2,
                                                        selectedColor:
                                                            ColorSelect
                                                                .toggleColor3,
                                                        selectedBorderColor:
                                                            ColorSelect
                                                                .toggleColor3,
                                                        color: ColorSelect
                                                            .textColor2,
                                                        constraints:
                                                            BoxConstraints.expand(
                                                                width: width *
                                                                    0.1197),
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
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize:
                                                                width * 0.01,
                                                            fontFamily: 'SUIT',
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 25.0),
                                                          child: Text(
                                                            e.method,
                                                            style: TextStyle(
                                                              color: ColorSelect
                                                                  .textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  width * 0.01,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.03,
                                                          bottom:
                                                              height * 0.013),
                                                      child: Center(
                                                          child: Text(
                                                        "위험성",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              width * 0.009,
                                                          fontFamily: 'SUIT',
                                                        ),
                                                      )),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: ColorSelect
                                                            .toggleColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          bottom:
                                                              height * 0.01),
                                                      width: double.infinity,
                                                      height: height * 0.05,
                                                      child: ToggleButtons(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderColor: ColorSelect
                                                            .borderColor3,
                                                        fillColor: ColorSelect
                                                            .blueColor2,
                                                        selectedColor:
                                                            ColorSelect
                                                                .toggleColor3,
                                                        selectedBorderColor:
                                                            ColorSelect
                                                                .toggleColor3,
                                                        color: ColorSelect
                                                            .textColor2,
                                                        constraints:
                                                            BoxConstraints.expand(
                                                                width: width *
                                                                    0.1197),
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
                                                padding: EdgeInsets.only(
                                                  top: height * 0.02,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              height * 0.02),
                                                      child: Center(
                                                          child: Text(
                                                        "작업 가능 여부",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize:
                                                              width * 0.009,
                                                          fontFamily: 'SUIT',
                                                        ),
                                                      )),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: ColorSelect
                                                            .toggleColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          bottom:
                                                              height * 0.01),
                                                      width: double.infinity,
                                                      height: height * 0.05,
                                                      child: ToggleButtons(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderColor: ColorSelect
                                                            .borderColor3,
                                                        fillColor: ColorSelect
                                                            .blueColor2,
                                                        selectedColor:
                                                            ColorSelect
                                                                .toggleColor3,
                                                        selectedBorderColor:
                                                            ColorSelect
                                                                .toggleColor3,
                                                        color: ColorSelect
                                                            .textColor2,
                                                        constraints:
                                                            BoxConstraints.expand(
                                                                width: width *
                                                                    0.1795),
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
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      width *
                                                                          0.011,
                                                                  fontFamily:
                                                                      'SUIT')),
                                                          Text('작업 불가능',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      width *
                                                                          0.011,
                                                                  fontFamily:
                                                                      'SUIT')),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * 0.03),
                                                child: Divider(
                                                  thickness: 1,
                                                  height: 1,
                                                  color:
                                                      ColorSelect.borderColor2,
                                                ),
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
                      padding: EdgeInsets.only(
                          top: height * 0.035, bottom: height * 0.03),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "안전모 연동",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: width * 0.012,
                                    fontFamily: 'SUIT'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
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
                                            padding: EdgeInsets.only(
                                                bottom: height * 0.02),
                                            child: Center(
                                              child: Text(
                                                "작업자",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.01,
                                                    fontFamily: 'SUIT'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: height * 0.02),
                                            child: Center(
                                              child: Text(
                                                "안전모 연동",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.01,
                                                    fontFamily: 'SUIT'),
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
                                                        top: height * 0.03),
                                                    child: Center(
                                                      child: Text(
                                                        e['name'].toString(),
                                                        style: TextStyle(
                                                            color: ColorSelect
                                                                .textColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                width * 0.01,
                                                            fontFamily: 'SUIT'),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.02),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Center(
                                                          child:
                                                              e['helmatId'] !=
                                                                      ''
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Stack(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          children: [
                                                                            Container(
                                                                              width: width * 0.08,
                                                                              height: height * 0.05,
                                                                              decoration: BoxDecoration(
                                                                                  border: Border(
                                                                                      bottom: BorderSide(
                                                                                width: 1,
                                                                                color: ColorSelect.borderColor2,
                                                                              ))),
                                                                            ),
                                                                            InkWell(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  SizedBox(width: width * 0.07, height: height * 0.042, child: Text(e['helmatId'])),
                                                                                  Icon(
                                                                                    Icons.replay,
                                                                                    size: width * 0.013,
                                                                                    color: ColorSelect.toggleColor3,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  _onPressed(workList.indexOf(e));
                                                                                });
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : InkWell(
                                                                      child:
                                                                          SizedBox(
                                                                        child: Center(
                                                                            child: Icon(
                                                                          Icons
                                                                              .qr_code_outlined,
                                                                          size: width *
                                                                              0.015,
                                                                          color:
                                                                              ColorSelect.toggleColor3,
                                                                        )),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        _onPressed(
                                                                            workList.indexOf(e));
                                                                      },
                                                                    )))
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
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: ColorSelect.borderColor2,
                  ),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          top: height * 0.035, bottom: height * 0.03),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "위험성평가 후 교육 서명란",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: width * 0.012,
                                    fontFamily: 'SUIT'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
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
                                            padding: EdgeInsets.only(
                                                bottom: height * 0.02),
                                            child: Center(
                                              child: Text(
                                                "작업자",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.01,
                                                    fontFamily: 'SUIT'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: height * 0.02),
                                            child: Center(
                                              child: Text(
                                                "서명",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.01,
                                                    fontFamily: 'SUIT'),
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
                                                        top: height * 0.03),
                                                    child: Center(
                                                      child: Text(
                                                        e['name'].toString(),
                                                        style: TextStyle(
                                                            color: ColorSelect
                                                                .textColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                width * 0.01,
                                                            fontFamily: 'SUIT'),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.02),
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

                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.02, bottom: height * 0.02),
                    child: InkWell(
                      child: Container(
                        width: width * 0.11,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                            color: ColorSelect.toggleColor3,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "전송",
                            style: TextStyle(
                                fontSize: width * 0.013,
                                fontFamily: 'SUIT',
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      progressTimeline.gotoPreviousStage();
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.003),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: ColorSelect.textColor3,
                          ),
                        ),
                        Text(
                          "이전",
                          style: TextStyle(
                              fontSize: width * 0.01,
                              fontFamily: 'SUIT',
                              color: ColorSelect.textColor3,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.008, bottom: height * 0.008),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        progressTimeline.gotoNextStage();
                        endProc(widget.single.state);
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "다음",
                            style: TextStyle(
                                fontSize: width * 0.01,
                                fontFamily: 'SUIT',
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.003),
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
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> buildStates() {
    List<Widget> allStates = [];
    int len = workerList.length;

    for (var i = 0; i < len; i++) {
      allStates.add(_RenderedState(
        name: workerList[i],
        isCurrent: i == selectedNum,
        index: i,
        widget: widget,
      ));
    }

    return allStates;
  }

  void _onPressed(dynamic num) async {
    dynamic result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Qrcodescan();
    }));

    if (result != null) {
      setState(() {
        //qr스캐너에서 받은 결과값

        workList[num]['helmatId'] = qrResult;
        qrResult = result.toString();
      });
    }
  }
}

//테이블 공통사항 Row
class WorkTableRow extends StatelessWidget {
  const WorkTableRow({
    Key? key,
    required this.title,
    required this.cont,
  }) : super(key: key);

  final String title;
  final String cont;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.04,
            child: Center(
              child: Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.012,
                    fontFamily: 'SUIT',
                  )),
            ),
          ),
          SizedBox(
            height: height * 0.03,
            child: Center(
              child: Text(cont,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: width * 0.01,
                    fontFamily: 'SUIT',
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.02),
            child: Divider(
              thickness: 1,
              height: 1,
              color: ColorSelect.borderColor2,
            ),
          ),
        ],
      ),
    );
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

  final C06 widget;

  Color getBackColor() {
    return isCurrent ? ColorSelect.toggleColor3 : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Container(
      width: width * 0.073,
      margin: EdgeInsets.only(
          top: height * 0.005,
          bottom: height * 0.005,
          left: width * 0.005,
          right: width * 0.005),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isCurrent
                ? Color.fromRGBO(0, 25, 255, 0.5)
                : Color.fromRGBO(0, 0, 0, 0.16),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(1, 1),
          ),
        ],
        color: getBackColor(),
      ),
      child: OutlinedButton(
        child: Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: width * 0.009,
              fontFamily: 'SUIT',
              color: isCurrent ? Colors.white : ColorSelect.grayColor7),
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

class cRiskState {
  String subject;
  List<CRiskRowState> subContents;

  cRiskState({
    required this.subject,
    required this.subContents,
  });
}

class CRiskRowState {
  String factor;
  String method;
  List<bool> factorRisk;
  List<bool> actionRisk;
  List<bool> workYN;

  CRiskRowState({
    required this.factor,
    required this.method,
    required this.factorRisk,
    required this.actionRisk,
    required this.workYN,
  });
}
