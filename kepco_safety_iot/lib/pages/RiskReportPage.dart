import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kepco_safety_iot/widgets/common/Layout.dart';
import 'package:kepco_safety_iot/models/models.dart';

class RiskReportPage extends StatefulWidget {
  const RiskReportPage({Key? key}) : super(key: key);

  @override
  State<RiskReportPage> createState() => _RiskReportPageState();
}

class _RiskReportPageState extends State<RiskReportPage> {
  bool editChecked = false;
  List<String> items = List.empty(growable: true);
  List<String> chkItems = List.empty(growable: true);
  List<String> mainItems = List.empty(growable: true);
  List<String> subItems = List.empty(growable: true);
  List<String> ynItems = List.empty(growable: true);
  List workOrder = List.empty(growable: true);
  List workList = List.empty(growable: true);
  List deviceList = List.empty(growable: true);
  List managerList = List.empty(growable: true);
  List<CheckRowState> CheckList = List.empty(growable: true);

  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;
  String? selectedValue4;
  String? chkValue;

  void contentsOfWork() {
    setState(() {
      items = [
        '발주 공사1',
        '발주 공사2',
      ];
    });
  }

  void checkOfManager() {
    setState(() {
      chkItems = [
        '선택값',
        '선택',
      ];
    });
  }

  void mainCategory() {
    setState(() {
      mainItems = [
        '변전',
        '전압',
      ];
    });
  }

  void subCategory() {
    setState(() {
      subItems = [
        '운영 (협력 및 전문회사)',
        '수련',
      ];
    });
  }

  void wireWorkYn() {
    setState(() {
      ynItems = [
        '여',
        '부',
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
    contentsOfWork();
    mainCategory();
    subCategory();
    wireWorkYn();
    divisionOfWork();
    divisionOfDevice();
    divisionOfManager();

    workOrder = [
      {'num': '1', 'cnt': '교통안전 표지, 신호수 미배치'},
      {'num': '2', 'cnt': '배전센터 작업통보'},
      {'num': '3', 'cnt': '부하전류 측정'},
      {'num': '4', 'cnt': '중성선 방호'},
      {'num': '5', 'cnt': '공사현장 모니터링 시스템 전송'},
      {'num': '6', 'cnt': '공사용 개폐기 설치'},
      {'num': '7', 'cnt': '중간케이블 설치'},
      {'num': '8', 'cnt': '보조거치대 설치 (필요시)'},
      {'num': '9', 'cnt': '입상케이블 고정장치 설치'},
      {'num': '10', 'cnt': '특고압 입상케이블 설치'},
      {'num': '11', 'cnt': '검상확인 및 공사용 개폐기 투입'},
      {'num': '12', 'cnt': '특고압 입상케이블 설치 (분기선로)'},
      {'num': '13', 'cnt': '점퍼선 절단 (전원측, 부하측)'},
      {'num': '14', 'cnt': '작업구간 검전 및 단락접지 시행'},
      {'num': '15', 'cnt': '본(사선)작업 시행'},
      {'num': '16', 'cnt': '작업구간내 단락접지 철거'},
      {'num': '17', 'cnt': '검상'},
      {'num': '18', 'cnt': '점퍼선 압축 (전원측, 부하측)'},
      {'num': '19', 'cnt': '전원 및 부하측 공사용개폐기 개방'},
      {'num': '20', 'cnt': '특고압 입상케이블 분리'},
      {'num': '21', 'cnt': '입상케이블 잔류전하 방전'},
      {'num': '22', 'cnt': '입상케이블 접속부 절연커버 설치'},
      {'num': '23', 'cnt': '입상케이블 및 각종 부속자재 철거'},
      {'num': '24', 'cnt': '중성선 방호 철거'},
      {'num': '25', 'cnt': '배전센터 작업완료 통보'},
      {'num': '26', 'cnt': '작업장 정리"'},
    ];

    CheckList = [
      CheckRowState(
        step: "1.작업준비 및 안전회의",
        checkInfo: [
          RowState(
              contents: "○ 안전담당자 (현장소장) 지정", cameraYn: false, cameraCnt: ''),
          RowState(
              contents: "○ 표준작업절차서 휴대 및 이상유무 확인",
              cameraYn: false,
              cameraCnt: ''),
          RowState(
              contents: "작업인원 확인",
              cameraYn: true,
              cameraCnt: '- 안전대, 방염복, 안전모, 안전화, 활선경보기 (필요시) 고무소매·장갑 안전장구 착용'),
          RowState(
              contents: "공사안내판, 교통안전 표지판, 라바콘, 고임목 구획 로프 설치 및 신호수 배치",
              cameraYn: true,
              cameraCnt: ''),
          RowState(
              contents: "공정별 위험성 Check List 점검", cameraYn: true, cameraCnt: ''),
          RowState(
              contents: "○ 케이블 절연측정, 도통상태 확인 및 방전시행",
              cameraYn: false,
              cameraCnt: ''),
          RowState(
              contents: "○ 무정전변압기 투입·차단상태 등 정상여부 확인",
              cameraYn: false,
              cameraCnt: ''),
          RowState(
              contents: "○ 작업구간 통제 (보행통로 확보 및 안내자 배치)",
              cameraYn: false,
              cameraCnt: ''),
          RowState(
              contents: "○ 활선차량 및 중장비 수평유지 및 접지시행",
              cameraYn: false,
              cameraCnt: ''),
          RowState(
              contents: "안전대 고리는 버켓 조작부 안전띠용 로프걸이에 체결",
              cameraYn: true,
              cameraCnt: ''),
        ],
      ),
      CheckRowState(
        step: "2. 배전센터 작업통보",
        checkInfo: [
          RowState(
              contents: "○ 변전소, 보호기기 재폐로 동작기능 정지",
              cameraYn: false,
              cameraCnt: ''),
        ],
      ),
      CheckRowState(
        step: "3. 중성선 방호",
        checkInfo: [
          RowState(
              contents:
                  "중성선 방호, (필요시) COS, 전력선 (고압선, 저압선) 등 충전부 방호, 완전 덮개, 전주덮개 사용",
              cameraYn: true,
              cameraCnt: ''),
          RowState(
              contents: "○ 지상 감시자 배치 및 상·하부 동시작업 금지",
              cameraYn: false,
              cameraCnt: ''),
        ],
      ),
      CheckRowState(
        step: "10. 특고압 입상케이블 설치",
        checkInfo: [
          RowState(
              contents: "입상케이블 가지지 적정여부 (버킷에 거치 금지)",
              cameraYn: true,
              cameraCnt: ''),
        ],
      ),
      CheckRowState(
        step: "11. 검상확인 및 공사용 개폐기 투입",
        checkInfo: [
          RowState(
              contents: "공사용 개폐기 투입전 상일치 여부 확인", cameraYn: true, cameraCnt: ''),
        ],
      ),
      CheckRowState(
        step: "13. 점퍼선 절단 (전원측, 부하측)",
        checkInfo: [
          RowState(
              contents: "절분 전 점퍼선 절단대상 사전표식여부 확인",
              cameraYn: true,
              cameraCnt: ''),
        ],
      ),
      CheckRowState(
        step: "14. 작업구간내 검전 및 단락접지 시행",
        checkInfo: [
          RowState(
              contents: "○ 점퍼선 분리 후 검전을 시행하여 사선확인",
              cameraYn: false,
              cameraCnt: ''),
        ],
      ),
      CheckRowState(
        step: "16. 작업구간내 단락접지 철거",
        checkInfo: [
          RowState(
              contents: "○ 사전작업 종료 후 단락접지 철거", cameraYn: false, cameraCnt: ''),
        ],
      ),
      CheckRowState(
        step: "17. 검상",
        checkInfo: [
          RowState(
              contents: "점퍼선 연결 전 상일치 여부 확인", cameraYn: true, cameraCnt: ''),
        ],
      ),
      CheckRowState(
        step: "23. 입상케이블 및 각종 부속자재 철거",
        checkInfo: [
          RowState(
              contents: "○ 입상케이블 가지지 적정여부 (버킷에 거치 금지)",
              cameraYn: false,
              cameraCnt: ''),
          RowState(contents: "○ 케이블 방전 시행", cameraYn: false, cameraCnt: ''),
        ],
      ),
    ];

    super.initState();
  }

  @override
  void dispose() {
    // 세로 화면 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: WillPopScope(
                onWillPop: () {
                  return Future(() => false);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(width * 0.01, width * 0.007,
                      width * 0.007, width * 0.007),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox.shrink(),
                            Text(
                              "위험성 Check List",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: width * 0.019,
                                fontFamily: 'SUIT',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.logout_rounded,
                                color: ColorSelect.grayColor,
                                size: width * 0.02,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: height * 0.015),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(141, 140, 174, 1),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Table(
                                            border: TableBorder.symmetric(
                                              outside: BorderSide.none,
                                              inside: const BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      141, 140, 174, 1)),
                                            ),
                                            columnWidths: const {
                                              0: FlexColumnWidth(1),
                                              1: FlexColumnWidth(4),
                                              2: FlexColumnWidth(5),
                                            },
                                            children: [
                                              TableRow(children: [
                                                Container(
                                                  height: height * 0.02,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorSelect.blueColor2,
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Color.fromRGBO(
                                                                    141,
                                                                    140,
                                                                    174,
                                                                    1))),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "작업공종",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: height * 0.02,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Color.fromRGBO(
                                                                    141,
                                                                    140,
                                                                    174,
                                                                    1))),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      top: height * 0.006,
                                                      left: width * 0.01),
                                                  child: Text(
                                                    "D57",
                                                    style: TextStyle(
                                                        fontSize: width * 0.009,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                Container(
                                                  height: height * 0.02,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorSelect.blueColor2,
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Color.fromRGBO(
                                                                    141,
                                                                    140,
                                                                    174,
                                                                    1))),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "간접활선작업 (무정전 바이패스케이블 공종)",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
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
                                            border: TableBorder.symmetric(
                                              outside: BorderSide.none,
                                              inside: const BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      141, 140, 174, 1)),
                                            ),
                                            columnWidths: {
                                              0: FlexColumnWidth(1),
                                              1: FlexColumnWidth(4),
                                              2: FlexColumnWidth(1),
                                              3: FlexColumnWidth(4),
                                            },
                                            children: [
                                              TableRow(children: [
                                                Container(
                                                  height: height * 0.02,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorSelect.blueColor2,
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141, 140, 174, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "시공사",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: height * 0.02,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141, 140, 174, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      top: height * 0.006,
                                                      left: width * 0.01),
                                                  child: Text(
                                                    "시공사 작성",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: height * 0.02,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorSelect.blueColor2,
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141, 140, 174, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "공사명",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: height * 0.02,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141, 140, 174, 1),
                                                      ),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      top: height * 0.006,
                                                      left: width * 0.01),
                                                  child: Text(
                                                    "공사명 작성",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: width * 0.009,
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
                                    Container(
                                      height: height * 0.025,
                                      padding:
                                          EdgeInsets.only(left: width * 0.01),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                141, 140, 174, 1),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: height * 0.005),
                                            child: SizedBox(
                                              width: width * 0.08,
                                              child: Text(
                                                "※ 사진 전송방법 :",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'SUIT',
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "① 실적 등록 대상 ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.007,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    Text(
                                                      " 을 휴대폰으로 사진 촬영하여 공사번호 + Code번호 입력 후 #1230으로 전송 [한글 및 특수기호 입력 시 미연계 될 수 있으니 숫자와 영문자만 입력]",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.007,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "② 실적 등록 대상 ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.007,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    Text(
                                                      " 을 안드로이드용 모바일 기기에 설치된 전용 APP을 통하여 공사현장 모니터링 전송 [아이폰은 사용 불가]",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.007,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Table(
                                            border: TableBorder.symmetric(
                                              outside: BorderSide.none,
                                              inside: const BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      141, 140, 174, 1)),
                                            ),
                                            columnWidths: {
                                              0: FlexColumnWidth(5),
                                              1: FlexColumnWidth(5),
                                            },
                                            children: [
                                              TableRow(children: [
                                                Container(
                                                  height: height * 0.02,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorSelect.blueColor2,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "작업절차도",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: height * 0.02,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorSelect.blueColor2,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "위험요인",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                Container(
                                                  height: height * 0.545,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Table(
                                                      border:
                                                          TableBorder.symmetric(
                                                              outside:
                                                                  BorderSide
                                                                      .none,
                                                              inside: BorderSide
                                                                  .none),
                                                      columnWidths: {
                                                        0: FlexColumnWidth(2),
                                                        1: FlexColumnWidth(8),
                                                      },
                                                      children: workOrder
                                                          .asMap()
                                                          .entries
                                                          .map(
                                                            (e) => TableRow(
                                                                children: [
                                                                  Container(
                                                                    height: height *
                                                                        0.02095,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorSelect
                                                                          .tableColor3,
                                                                      border:
                                                                          Border(
                                                                        bottom:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color: Color.fromRGBO(
                                                                              141,
                                                                              140,
                                                                              174,
                                                                              1),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        e.value[
                                                                            'num'],
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              width * 0.009,
                                                                          fontFamily:
                                                                              'SUIT',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: height *
                                                                        0.02095,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                        bottom:
                                                                            BorderSide(
                                                                          width:
                                                                              1,
                                                                          color: Color.fromRGBO(
                                                                              141,
                                                                              140,
                                                                              174,
                                                                              1),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    padding: EdgeInsets.only(
                                                                        top: height *
                                                                            0.006,
                                                                        left: width *
                                                                            0.01),
                                                                    child: Text(
                                                                      e.value[
                                                                          'cnt'],
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontSize:
                                                                            width *
                                                                                0.009,
                                                                        fontFamily:
                                                                            'SUIT',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                          )
                                                          .toList()),
                                                ),
                                                Container(
                                                    height: height * 0.545,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: height * 0.02,
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: height *
                                                                      0.006,
                                                                  left: width *
                                                                      0.01),
                                                          decoration:
                                                              BoxDecoration(
                                                                  border:
                                                                      Border(
                                                            bottom: BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        141,
                                                                        140,
                                                                        174,
                                                                        1)),
                                                          )),
                                                          child: Text(
                                                            "○ 교통 → 교통안전 표지, 신호수 미배치",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  width * 0.007,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: height * 0.02,
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: height *
                                                                      0.006,
                                                                  left: width *
                                                                      0.01),
                                                          decoration:
                                                              BoxDecoration(
                                                                  border:
                                                                      Border(
                                                            bottom: BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        141,
                                                                        140,
                                                                        174,
                                                                        1)),
                                                          )),
                                                          child: Text(
                                                            "○ 낙하 → 바켓, 전주상부에서 공기구, 자재낙하",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  width * 0.007,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: height * 0.02,
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: height *
                                                                      0.006,
                                                                  left: width *
                                                                      0.01),
                                                          decoration:
                                                              BoxDecoration(
                                                                  border:
                                                                      Border(
                                                            bottom: BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        141,
                                                                        140,
                                                                        174,
                                                                        1)),
                                                          )),
                                                          child: Text(
                                                            "○ 추락 → 바켓, 전주승주 작업",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  width * 0.007,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: height * 0.02,
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: height *
                                                                      0.006,
                                                                  left: width *
                                                                      0.01),
                                                          decoration:
                                                              BoxDecoration(
                                                                  border:
                                                                      Border(
                                                            bottom: BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        141,
                                                                        140,
                                                                        174,
                                                                        1)),
                                                          )),
                                                          child: Text(
                                                            "○ 협착 → 바켓트럭, 크레인 차량 전복",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  width * 0.007,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: height * 0.02,
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: height *
                                                                      0.006,
                                                                  left: width *
                                                                      0.01),
                                                          decoration:
                                                              BoxDecoration(
                                                                  border:
                                                                      Border(
                                                            bottom: BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        141,
                                                                        140,
                                                                        174,
                                                                        1)),
                                                          )),
                                                          child: Text(
                                                            "○ 감전, 화상 → 활선부위 접촉, 보조 작업자와 접촉, 케이블 미방전, 아크, 상 착오, 바이패스 불안전, 부하절단",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  width * 0.007,
                                                              fontFamily:
                                                                  'SUIT',
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: width *
                                                                      0.3608,
                                                                  height:
                                                                      height *
                                                                          0.02,
                                                                  decoration: BoxDecoration(
                                                                      color: ColorSelect
                                                                          .blueColor2,
                                                                      border: Border(
                                                                          bottom: BorderSide(
                                                                              width: 1,
                                                                              color: Color.fromRGBO(141, 140, 174, 1)))),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "핵심 Check Point",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            width *
                                                                                0.01,
                                                                        fontFamily:
                                                                            'SUIT',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                    padding: EdgeInsets
                                                                        .all(width *
                                                                            0.1),
                                                                    width: 1,
                                                                    height:
                                                                        height *
                                                                            0.02,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            141,
                                                                            140,
                                                                            174,
                                                                            1)),
                                                                Container(
                                                                  width: width *
                                                                      0.064,
                                                                  height:
                                                                      height *
                                                                          0.02,
                                                                  decoration: BoxDecoration(
                                                                      color: ColorSelect
                                                                          .blueColor2,
                                                                      border: Border(
                                                                          bottom: BorderSide(
                                                                              width: 1,
                                                                              color: Color.fromRGBO(141, 140, 174, 1)))),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "확인",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            width *
                                                                                0.009,
                                                                        fontFamily:
                                                                            'SUIT',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                    padding: EdgeInsets
                                                                        .all(width *
                                                                            0.1),
                                                                    width: 1,
                                                                    height:
                                                                        height *
                                                                            0.02,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            141,
                                                                            140,
                                                                            174,
                                                                            1)),
                                                                Container(
                                                                  width: width *
                                                                      0.064,
                                                                  height:
                                                                      height *
                                                                          0.02,
                                                                  decoration: BoxDecoration(
                                                                      color: ColorSelect
                                                                          .blueColor2,
                                                                      border: Border(
                                                                          bottom: BorderSide(
                                                                              width: 1,
                                                                              color: Color.fromRGBO(141, 140, 174, 1)))),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "해당없음",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            width *
                                                                                0.009,
                                                                        fontFamily:
                                                                            'SUIT',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: CheckList
                                                                      .asMap()
                                                                  .entries
                                                                  .map((e) =>
                                                                      Column(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: width * 0.3608,
                                                                                  height: height * 0.0131,
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.only(left: width * 0.01, top: height * 0.003),
                                                                                    child: Text(
                                                                                      e.value.step,
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: width * 0.009,
                                                                                        fontFamily: 'SUIT',
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(width: 1, height: height * 0.0131, color: Color.fromRGBO(141, 140, 174, 1)),
                                                                                SizedBox(
                                                                                  width: width * 0.064,
                                                                                  height: height * 0.0131,
                                                                                ),
                                                                                Container(width: 1, height: height * 0.0131, color: Color.fromRGBO(141, 140, 174, 1)),
                                                                                SizedBox(
                                                                                  width: width * 0.064,
                                                                                  height: height * 0.0131,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: e.value.checkInfo
                                                                                  .asMap()
                                                                                  .entries
                                                                                  .map(
                                                                                    (e) => Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: width * 0.3608,
                                                                                          height: e.value.cameraCnt != '' ? height * 0.0262 : height * 0.0131,
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(left: width * 0.012),
                                                                                            child: e.value.cameraYn
                                                                                                ? Column(
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Icon(
                                                                                                            Icons.camera_alt_rounded,
                                                                                                            color: Color.fromRGBO(81, 88, 224, 1),
                                                                                                            size: width * 0.01,
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            width: width * 0.006,
                                                                                                          ),
                                                                                                          Text(
                                                                                                            e.value.contents,
                                                                                                            style: TextStyle(
                                                                                                              color: ColorSelect.checkBox,
                                                                                                              fontWeight: FontWeight.w400,
                                                                                                              fontSize: width * 0.008,
                                                                                                              fontFamily: 'SUIT',
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      e.value.cameraCnt != ''
                                                                                                          ? SizedBox(
                                                                                                              width: width * 0.3608,
                                                                                                              height: height * 0.0131,
                                                                                                              child: Padding(
                                                                                                                padding: EdgeInsets.only(top: height * 0.006),
                                                                                                                child: Text(
                                                                                                                  e.value.cameraCnt,
                                                                                                                  style: TextStyle(
                                                                                                                    fontWeight: FontWeight.w400,
                                                                                                                    fontSize: width * 0.008,
                                                                                                                    fontFamily: 'SUIT',
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            )
                                                                                                          : SizedBox.shrink()
                                                                                                    ],
                                                                                                  )
                                                                                                : Text(
                                                                                                    e.value.contents,
                                                                                                    style: TextStyle(
                                                                                                      fontWeight: FontWeight.w400,
                                                                                                      fontSize: width * 0.008,
                                                                                                      fontFamily: 'SUIT',
                                                                                                    ),
                                                                                                  ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(width: 1, height: e.value.cameraCnt != '' ? height * 0.0262 : height * 0.0131, color: Color.fromRGBO(141, 140, 174, 1)),
                                                                                        SizedBox(
                                                                                          width: width * 0.064,
                                                                                          height: e.value.cameraCnt != '' ? height * 0.0262 : height * 0.0131,
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(bottom: height * 0.006),
                                                                                            child: Icon(
                                                                                              Icons.check_box_rounded,
                                                                                              size: width * 0.014,
                                                                                              color: ColorSelect.checkBox,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Container(width: 1, height: e.value.cameraCnt != '' ? height * 0.0262 : height * 0.0131, color: Color.fromRGBO(141, 140, 174, 1)),
                                                                                        SizedBox(
                                                                                          width: width * 0.064,
                                                                                          height: e.value.cameraCnt != '' ? height * 0.0262 : height * 0.0131,
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.only(bottom: height * 0.006),
                                                                                            child: Icon(
                                                                                              Icons.check_box_outline_blank_rounded,
                                                                                              size: width * 0.014,
                                                                                              color: Color.fromRGBO(141, 140, 174, 1),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                  .toList(),
                                                                            ),
                                                                            Container(
                                                                                width: double.infinity,
                                                                                height: 1,
                                                                                color: Color.fromRGBO(141, 140, 174, 1)),
                                                                          ]))
                                                                  .toList(),
                                                            )
                                                          ],
                                                        )),
                                                      ],
                                                    )),
                                              ]),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: height * 0.02,
                                      decoration: BoxDecoration(
                                        color: ColorSelect.blueColor2,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "핵심 Check Point 실적 등록",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: width * 0.01,
                                            fontFamily: 'SUIT',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Table(
                                      border: TableBorder.symmetric(
                                        outside: BorderSide.none,
                                        inside: BorderSide.none,
                                      ),
                                      columnWidths: {
                                        0: FlexColumnWidth(9.2),
                                        1: FlexColumnWidth(0.72),
                                        2: FlexColumnWidth(0.72),
                                      },
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.016,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141, 140, 174, 1)),
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            padding: EdgeInsets.only(
                                                top: height * 0.004,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 핵심모니터링공정 : 1작업준비, 3충전부방호작업, 8입상케이블 설치, 9 검상, 10점퍼선절단, 14검상",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: height * 0.016,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141, 140, 174, 1)),
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            child: Center(
                                              child: Text(
                                                "확인",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'SUIT',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: height * 0.016,
                                            decoration: BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Color.fromRGBO(
                                                      141, 140, 174, 1)),
                                            )),
                                            child: Center(
                                              child: Text(
                                                "해당없음",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'SUIT',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 사진 촬영 대상 공정",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                          ),
                                          SizedBox(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Color.fromRGBO(
                                                      81, 88, 224, 1),
                                                  size: width * 0.01,
                                                ),
                                                SizedBox(
                                                  width: width * 0.006,
                                                ),
                                                Text(
                                                  "작업인원 확인 (안전장구 착용상태 포함), ",
                                                  style: TextStyle(
                                                    color: ColorSelect.checkBox,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Color.fromRGBO(
                                                      81, 88, 224, 1),
                                                  size: width * 0.01,
                                                ),
                                                SizedBox(
                                                  width: width * 0.006,
                                                ),
                                                Text(
                                                  "작업전 안전회의록, ",
                                                  style: TextStyle(
                                                    color: ColorSelect.checkBox,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Color.fromRGBO(
                                                      81, 88, 224, 1),
                                                  size: width * 0.01,
                                                ),
                                                SizedBox(
                                                  width: width * 0.006,
                                                ),
                                                Text(
                                                  "위험성 체크리스트,",
                                                  style: TextStyle(
                                                    color: ColorSelect.checkBox,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: height * 0.006),
                                              child: Icon(
                                                Icons.check_box_rounded,
                                                size: width * 0.014,
                                                color: ColorSelect.checkBox,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: height * 0.006),
                                              child: Icon(
                                                Icons
                                                    .check_box_outline_blank_rounded,
                                                size: width * 0.014,
                                                color: Color.fromRGBO(
                                                    141, 140, 174, 1),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Color.fromRGBO(
                                                      81, 88, 224, 1),
                                                  size: width * 0.01,
                                                ),
                                                SizedBox(
                                                  width: width * 0.006,
                                                ),
                                                Text(
                                                  "공사안내판, 교통안전 표지판, 라바콘, 차량고임목, 구획 로프 설치 및 신로수(조끼착용) 배치 : 작업장소별",
                                                  style: TextStyle(
                                                    color: ColorSelect.checkBox,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: height * 0.006),
                                              child: Icon(
                                                Icons.check_box_rounded,
                                                size: width * 0.014,
                                                color: ColorSelect.checkBox,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: height * 0.006),
                                              child: Icon(
                                                Icons
                                                    .check_box_outline_blank_rounded,
                                                size: width * 0.014,
                                                color: Color.fromRGBO(
                                                    141, 140, 174, 1),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Color.fromRGBO(
                                                      81, 88, 224, 1),
                                                  size: width * 0.01,
                                                ),
                                                SizedBox(
                                                  width: width * 0.006,
                                                ),
                                                Text(
                                                  "작업 전 방호시행, ",
                                                  style: TextStyle(
                                                    color: ColorSelect.checkBox,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Color.fromRGBO(
                                                      81, 88, 224, 1),
                                                  size: width * 0.01,
                                                ),
                                                SizedBox(
                                                  width: width * 0.006,
                                                ),
                                                Text(
                                                  "입상케이블 가지지 적정여부(버킷에 거치금지), ",
                                                  style: TextStyle(
                                                    color: ColorSelect.checkBox,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Color.fromRGBO(
                                                      81, 88, 224, 1),
                                                  size: width * 0.01,
                                                ),
                                                SizedBox(
                                                  width: width * 0.006,
                                                ),
                                                Text(
                                                  "안전대 고리는 버켓 조작부 안전띠용 로프걸이에 체결",
                                                  style: TextStyle(
                                                    color: ColorSelect.checkBox,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: height * 0.006),
                                              child: Icon(
                                                Icons.check_box_rounded,
                                                size: width * 0.014,
                                                color: ColorSelect.checkBox,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: height * 0.006),
                                              child: Icon(
                                                Icons
                                                    .check_box_outline_blank_rounded,
                                                size: width * 0.014,
                                                color: Color.fromRGBO(
                                                    141, 140, 174, 1),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Color.fromRGBO(
                                                      81, 88, 224, 1),
                                                  size: width * 0.01,
                                                ),
                                                SizedBox(
                                                  width: width * 0.006,
                                                ),
                                                Text(
                                                  "공사용 개폐기 투입전 검상기 활용 상일치 확인 ",
                                                  style: TextStyle(
                                                    color: ColorSelect.checkBox,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Color.fromRGBO(
                                                      81, 88, 224, 1),
                                                  size: width * 0.01,
                                                ),
                                                SizedBox(
                                                  width: width * 0.006,
                                                ),
                                                Text(
                                                  "절단대상 사전표식여부 확인 ",
                                                  style: TextStyle(
                                                    color: ColorSelect.checkBox,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: height * 0.006),
                                              child: Icon(
                                                Icons.check_box_rounded,
                                                size: width * 0.014,
                                                color: ColorSelect.checkBox,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: height * 0.006),
                                              child: Icon(
                                                Icons
                                                    .check_box_outline_blank_rounded,
                                                size: width * 0.014,
                                                color: Color.fromRGBO(
                                                    141, 140, 174, 1),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Color.fromRGBO(
                                                      81, 88, 224, 1),
                                                  size: width * 0.01,
                                                ),
                                                SizedBox(
                                                  width: width * 0.006,
                                                ),
                                                Text(
                                                  "점퍼선 연결 전 검상기 활용 상일치 여부 확인",
                                                  style: TextStyle(
                                                    color: ColorSelect.checkBox,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            141,
                                                            140,
                                                            174,
                                                            1)))),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: height * 0.006),
                                              child: Icon(
                                                Icons.check_box_rounded,
                                                size: width * 0.014,
                                                color: ColorSelect.checkBox,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.064,
                                            height: height * 0.014,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: height * 0.006),
                                              child: Icon(
                                                Icons
                                                    .check_box_outline_blank_rounded,
                                                size: width * 0.014,
                                                color: Color.fromRGBO(
                                                    141, 140, 174, 1),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Table(
                                      border: TableBorder.symmetric(
                                        outside: BorderSide.none,
                                        inside: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                141, 140, 174, 1)),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                              color: ColorSelect.blueColor2,
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          141, 140, 174, 1))),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height * 0.003,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 핵심모니터링공정 : 1작업준비, 3충전부방호작업, 8입상케이블 설치, 9 검상, 10점퍼선절단, 14검상",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.028,
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "○ 사진 촬영 대상 공정",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.003,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                    Text(
                                                      "작업인원 확인 (안전장구 착용상태 포함)",
                                                      style: TextStyle(
                                                        color: ColorSelect
                                                            .checkBox,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/개인안전장구착용프로필사진.png",
                                                  height: height * 0.18,
                                                ),
                                                SizedBox(
                                                  width: width * 0.18,
                                                  child: Text(
                                                    "2022-09-09 / 17 : 54",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Table(
                                      border: TableBorder.symmetric(
                                        outside: BorderSide.none,
                                        inside: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                141, 140, 174, 1)),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                              color: ColorSelect.blueColor2,
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          141, 140, 174, 1))),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height * 0.003,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 핵심모니터링공정 : 1작업준비, 3충전부방호작업, 8입상케이블 설치, 9 검상, 10점퍼선절단, 14검상",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.028,
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "○ 사진 촬영 대상 공정",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.003,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                    Text(
                                                      "작업전 안전회의록",
                                                      style: TextStyle(
                                                        color: ColorSelect
                                                            .checkBox,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/개인안전장구착용프로필사진.png",
                                                  height: height * 0.18,
                                                ),
                                                SizedBox(
                                                  width: width * 0.18,
                                                  child: Text(
                                                    "2022-09-09 / 17 : 54",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                                Image.asset(
                                                  "assets/img/개인안전장구착용프로필사진.png",
                                                  height: height * 0.18,
                                                ),
                                                SizedBox(
                                                  width: width * 0.18,
                                                  child: Text(
                                                    "2022-09-09 / 17 : 54",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Table(
                                      border: TableBorder.symmetric(
                                        outside: BorderSide.none,
                                        inside: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                141, 140, 174, 1)),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                              color: ColorSelect.blueColor2,
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          141, 140, 174, 1))),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height * 0.003,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 핵심모니터링공정 : 1작업준비, 3충전부방호작업, 8입상케이블 설치, 9 검상, 10점퍼선절단, 14검상",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.028,
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "○ 사진 촬영 대상 공정",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.003,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                    Text(
                                                      "위험성 체크리스트",
                                                      style: TextStyle(
                                                        color: ColorSelect
                                                            .checkBox,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/개인안전장구착용프로필사진.png",
                                                  height: height * 0.18,
                                                ),
                                                SizedBox(
                                                  width: width * 0.3,
                                                  child: Text(
                                                    "2022-09-09 / 17 : 54",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Table(
                                      border: TableBorder.symmetric(
                                        outside: BorderSide.none,
                                        inside: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                141, 140, 174, 1)),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                              color: ColorSelect.blueColor2,
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          141, 140, 174, 1))),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height * 0.003,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 핵심모니터링공정 : 1작업준비, 3충전부방호작업, 8입상케이블 설치, 9 검상, 10점퍼선절단, 14검상",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.028,
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "○ 사진 촬영 대상 공정",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.003,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                    Text(
                                                      "공사안내판, 교통안전 표지판, 라바콘, 차량고임목, 구획 로프 설치 및 신로수(조끼착용) 배치 : 작업장소별",
                                                      style: TextStyle(
                                                        color: ColorSelect
                                                            .checkBox,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/개인안전장구착용프로필사진.png",
                                                  height: height * 0.18,
                                                ),
                                                SizedBox(
                                                  width: width * 0.3,
                                                  child: Text(
                                                    "2022-09-09 / 17 : 54",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Table(
                                      border: TableBorder.symmetric(
                                        outside: BorderSide.none,
                                        inside: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                141, 140, 174, 1)),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                              color: ColorSelect.blueColor2,
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          141, 140, 174, 1))),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height * 0.003,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 핵심모니터링공정 : 1작업준비, 3충전부방호작업, 8입상케이블 설치, 9 검상, 10점퍼선절단, 14검상",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.028,
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "○ 사진 촬영 대상 공정",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.003,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                    Text(
                                                      "작업 전 방호시행",
                                                      style: TextStyle(
                                                        color: ColorSelect
                                                            .checkBox,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/개인안전장구착용프로필사진.png",
                                                  height: height * 0.18,
                                                ),
                                                SizedBox(
                                                  width: width * 0.3,
                                                  child: Text(
                                                    "2022-09-09 / 17 : 54",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Table(
                                      border: TableBorder.symmetric(
                                        outside: BorderSide.none,
                                        inside: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                141, 140, 174, 1)),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                              color: ColorSelect.blueColor2,
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          141, 140, 174, 1))),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height * 0.003,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 핵심모니터링공정 : 1작업준비, 3충전부방호작업, 8입상케이블 설치, 9 검상, 10점퍼선절단, 14검상",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.028,
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "○ 사진 촬영 대상 공정",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.003,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                    Text(
                                                      "입상케이블 가지지 적정여부(버킷에 거치금지)",
                                                      style: TextStyle(
                                                        color: ColorSelect
                                                            .checkBox,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/개인안전장구착용프로필사진.png",
                                                  height: height * 0.18,
                                                ),
                                                SizedBox(
                                                  width: width * 0.3,
                                                  child: Text(
                                                    "2022-09-09 / 17 : 54",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Table(
                                      border: TableBorder.symmetric(
                                        outside: BorderSide.none,
                                        inside: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                141, 140, 174, 1)),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                              color: ColorSelect.blueColor2,
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          141, 140, 174, 1))),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height * 0.003,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 핵심모니터링공정 : 1작업준비, 3충전부방호작업, 8입상케이블 설치, 9 검상, 10점퍼선절단, 14검상",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.028,
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "○ 사진 촬영 대상 공정",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.003,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                    Text(
                                                      "안전대 고리는 버켓 조작부 안전띠용 로프걸이에 체결",
                                                      style: TextStyle(
                                                        color: ColorSelect
                                                            .checkBox,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/개인안전장구착용프로필사진.png",
                                                  height: height * 0.18,
                                                ),
                                                SizedBox(
                                                  width: width * 0.3,
                                                  child: Text(
                                                    "2022-09-09 / 17 : 54",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Table(
                                      border: TableBorder.symmetric(
                                        outside: BorderSide.none,
                                        inside: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                141, 140, 174, 1)),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                              color: ColorSelect.blueColor2,
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          141, 140, 174, 1))),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height * 0.003,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 핵심모니터링공정 : 1작업준비, 3충전부방호작업, 8입상케이블 설치, 9 검상, 10점퍼선절단, 14검상",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.028,
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "○ 사진 촬영 대상 공정",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.003,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                    Text(
                                                      "공사용 개폐기 투입전 검상기 활용 상일치 확인",
                                                      style: TextStyle(
                                                        color: ColorSelect
                                                            .checkBox,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/개인안전장구착용프로필사진.png",
                                                  height: height * 0.18,
                                                ),
                                                SizedBox(
                                                  width: width * 0.3,
                                                  child: Text(
                                                    "2022-09-09 / 17 : 54",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Table(
                                      border: TableBorder.symmetric(
                                        outside: BorderSide.none,
                                        inside: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                141, 140, 174, 1)),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                              color: ColorSelect.blueColor2,
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          141, 140, 174, 1))),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height * 0.003,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 핵심모니터링공정 : 1작업준비, 3충전부방호작업, 8입상케이블 설치, 9 검상, 10점퍼선절단, 14검상",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.028,
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "○ 사진 촬영 대상 공정",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.003,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                    Text(
                                                      "절단대상 사전표식여부 확인",
                                                      style: TextStyle(
                                                        color: ColorSelect
                                                            .checkBox,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/개인안전장구착용프로필사진.png",
                                                  height: height * 0.18,
                                                ),
                                                SizedBox(
                                                  width: width * 0.3,
                                                  child: Text(
                                                    "2022-09-09 / 17 : 54",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    Table(
                                      border: TableBorder.symmetric(
                                        outside: BorderSide.none,
                                        inside: const BorderSide(
                                            width: 1,
                                            color: Color.fromRGBO(
                                                141, 140, 174, 1)),
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.014,
                                            decoration: BoxDecoration(
                                              color: ColorSelect.blueColor2,
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Color.fromRGBO(
                                                          141, 140, 174, 1))),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height * 0.003,
                                                left: width * 0.01),
                                            child: Text(
                                              "○ 핵심모니터링공정 : 1작업준비, 3충전부방호작업, 8입상케이블 설치, 9 검상, 10점퍼선절단, 14검상",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            height: height * 0.028,
                                            padding: EdgeInsets.only(
                                                top: height * 0.006,
                                                left: width * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "○ 사진 촬영 대상 공정",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: width * 0.009,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.003,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Color.fromRGBO(
                                                          81, 88, 224, 1),
                                                      size: width * 0.01,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                    Text(
                                                      "절단대상 사전표식여부 확인",
                                                      style: TextStyle(
                                                        color: ColorSelect
                                                            .checkBox,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * 0.009,
                                                        fontFamily: 'SUIT',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(),
                                            padding:
                                                EdgeInsets.all(width * 0.01),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/개인안전장구착용프로필사진.png",
                                                  height: height * 0.18,
                                                ),
                                                SizedBox(
                                                  width: width * 0.3,
                                                  child: Text(
                                                    "2022-09-09 / 17 : 54",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: width * 0.009,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
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
                ))));
  }
}

class CheckRowState {
  String step;
  List<RowState> checkInfo;

  CheckRowState({
    required this.step,
    required this.checkInfo,
  });
}

class RowState {
  String contents;
  bool cameraYn;
  String cameraCnt;

  RowState({
    required this.contents,
    required this.cameraYn,
    required this.cameraCnt,
  });
}
