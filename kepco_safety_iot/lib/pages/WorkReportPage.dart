import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/widgets/common/Layout.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'RiskReportPage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkReportPage extends StatefulWidget {
  const WorkReportPage({Key? key, required this.cntwrkNo}) : super(key: key);
  final int cntwrkNo;

  @override
  State<WorkReportPage> createState() => _WorkReportPageState();
}

class _WorkReportPageState extends State<WorkReportPage> {
  List workList = [];
  List<CntWrk> cntwrkList = [];
  int dropSelectIndex = 0;
  Network network = Network();

  Future<dynamic> _getAllCntwrk() async {
    List result = await network.getWork();

    if (cntwrkList.isNotEmpty) cntwrkList.clear();

    result.forEach((json) {
      cntwrkList.add(CntWrk(json['cntwrkSeq'], json['cntwrkNm']));
    });

    if (result != null) {
      _getWork();
    } else {
      ShowDialog.errorDialog(context);
    }
  }

  Future<dynamic> _getWork() async {
    List result =
        await network.getWork(cntwrkSeq: cntwrkList[dropSelectIndex].cntwrkSeq);

    if (workList.isNotEmpty) workList.clear();

    setState(() {
      workList = result;

      print('===> $workList');
    });
  }

  @override
  void initState() {
    super.initState();

    _getAllCntwrk();
  }

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
              width * 0.01, width * 0.007, width * 0.007, width * 0.007),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "작업 이력관리 상세",
                  style: TextStyle(
                    fontSize: width * 0.011,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: width * 0.01),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.97,
                          height: height * 0.2,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(243, 247, 255, 1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 26, 156, 0.16),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset:
                                    Offset(1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width * 0.09,
                                height: height * 0.16,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "공사명",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    ),
                                    Text(
                                      "사업소",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    ),
                                    Text(
                                      "협력회사",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    ),
                                    Text(
                                      "공사개요",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width * 0.1),
                                width: 1,
                                height: height * 0.16,
                                color: ColorSelect.grayColor7,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.015),
                                child: SizedBox(
                                  width: width * 0.25,
                                  height: height * 0.16,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '주촌내삼 김해시장 도로확장 지장이설공사',
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.textColor),
                                      ),
                                      Text(
                                        "부산울산지역본부 김해지사",
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.textColor),
                                      ),
                                      Text(
                                        "코리아이엔지(주)",
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.textColor),
                                      ),
                                      Text(
                                        "전주이설",
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.textColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width * 0.1),
                                width: 1,
                                height: height * 0.16,
                                color: ColorSelect.grayColor7,
                              ),
                              SizedBox(
                                width: width * 0.09,
                                height: height * 0.16,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "공사번호",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    ),
                                    Text(
                                      "일자",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    ),
                                    Text(
                                      "연락처",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    ),
                                    Text(
                                      "현장책임자",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width * 0.1),
                                width: 1,
                                height: height * 0.16,
                                color: ColorSelect.grayColor7,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.015),
                                child: SizedBox(
                                  width: width * 0.2,
                                  height: height * 0.16,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '5611-2012-4255',
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.textColor),
                                      ),
                                      Text(
                                        "2013.10.21",
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.textColor),
                                      ),
                                      Text(
                                        "010-1234-5678",
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.textColor),
                                      ),
                                      Text(
                                        "담당자",
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.textColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width * 0.1),
                                width: 1,
                                height: height * 0.16,
                                color: ColorSelect.grayColor7,
                              ),
                              SizedBox(
                                width: width * 0.09,
                                height: height * 0.16,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "진행정보",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    ),
                                    Text(
                                      "전송여부",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    ),
                                    Text(
                                      "전송횟수",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    ),
                                    Text(
                                      "삭제횟수",
                                      style: TextStyle(
                                          fontSize: width * 0.011,
                                          fontWeight: FontWeight.w600,
                                          color: ColorSelect.toggleColor3),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width * 0.1),
                                width: 1,
                                height: height * 0.16,
                                color: ColorSelect.grayColor7,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.015),
                                child: SizedBox(
                                  width: width * 0.2,
                                  height: height * 0.16,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '시공중',
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.redColor3),
                                      ),
                                      Text(
                                        "확인요청",
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.redColor3),
                                      ),
                                      Text(
                                        "2",
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.textColor),
                                      ),
                                      Text(
                                        "0",
                                        style: TextStyle(
                                            fontSize: width * 0.011,
                                            fontWeight: FontWeight.w500,
                                            color: ColorSelect.textColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: width * 0.015),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: height * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: ColorSelect.toggleColor3,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 26, 156, 0.16),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  width: width * 0.97,
                                  child: Table(
                                    border: TableBorder.all(
                                        color: Colors.transparent,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15.0))),
                                    columnWidths: const {
                                      0: FlexColumnWidth(0.7),
                                      1: FlexColumnWidth(1.8),
                                      2: FlexColumnWidth(3.3),
                                      3: FlexColumnWidth(3.3),
                                      4: FlexColumnWidth(1.1),
                                      5: FlexColumnWidth(1.3),
                                    },
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow(
                                        children: [
                                          tableHeadTxt(title: '순번'),
                                          tableHeadTxt(
                                            title: '보고서명',
                                          ),
                                          tableHeadTxt(
                                            title: '작업공종',
                                          ),
                                          tableHeadTxt(
                                            title: '전송시간',
                                          ),
                                          tableHeadTxt(
                                            title: '사진수',
                                          ),
                                          tableHeadTxt(
                                            title: '전송번호',
                                          ),
                                          tableHeadTxt(
                                            title: '확인자',
                                          ),
                                          tableHeadTxt(
                                            title: '안전조치사항',
                                          ),
                                          tableHeadTxt(
                                            title: '보고서',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: workList
                                          .asMap()
                                          .entries
                                          .map((e) => WorkListManage(
                                                listNumb: '${e.key + 1}',
                                                listConst: e.value["cntwrkNo"]
                                                    .toString(),
                                                listName:
                                                    e.value["opertNm"] ?? "",
                                                listLocation:
                                                    e.value["addr2"] ?? "",
                                                listMark: e.value["cntwrkTyCd"],
                                                listDate: e.value["cntwrkDt"]
                                                    .toString(),
                                                listSuper:
                                                    e.value["userId"] ?? "",
                                                listInform:
                                                    e.value["opertStatus"],
                                              ))
                                          .toList(),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WorkListManage extends StatelessWidget {
  const WorkListManage({
    Key? key,
    required this.listNumb,
    required this.listConst,
    required this.listName,
    required this.listLocation,
    required this.listMark,
    required this.listDate,
    required this.listSuper,
    required this.listInform,
  }) : super(key: key);

  final String listNumb;
  final String listConst;
  final String listName;
  final String listLocation;
  final List listMark;
  final String listDate;
  final String listSuper;
  final int listInform;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SizedBox(
      width: width * 0.97,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(bottom: height * 0.02),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 26, 156, 0.16),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(0.7),
                1: FlexColumnWidth(1.8),
                2: FlexColumnWidth(3.3),
                3: FlexColumnWidth(3.3),
                4: FlexColumnWidth(1.1),
                5: FlexColumnWidth(1.3),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: <Widget>[
                    Center(
                        child: SizedBox(
                      child: Text(
                        listNumb,
                        style: TextStyle(
                          color: listInform == 0
                              ? Colors.black
                              : listInform == 1
                                  ? ColorSelect.redColor3
                                  : listInform == 2
                                      ? ColorSelect.redColor3
                                      : ColorSelect.greenColor3,
                          fontSize: width * 0.011,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )),
                    workBodyList(title: listName),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: listMark
                            .map((e) => workBodyList(title: e))
                            .toList(),
                      ),
                    ),
                    workBodyList(title: listLocation),
                    Center(child: workBodyList(title: listConst)),
                    Center(child: workBodyList(title: listDate)),
                    Center(child: workBodyList(title: listSuper)),
                    Center(
                        child: Text(
                      '자동승인',
                      style: TextStyle(
                        color: ColorSelect.redColor3,
                        fontSize: width * 0.011,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                    Center(
                      child: SizedBox(
                        height: height * 0.05,
                        child: SizedBox(
                          width: width * 0.012,
                          child: InkWell(
                            child: SvgPicture.asset(
                              'assets/svg/report.svg',
                              color: ColorSelect.toggleColor3,
                              width: width * 0.001,
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RiskReportPage(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class tableHeadTxt extends StatelessWidget {
  tableHeadTxt({Key? key, required this.title}) : super(key: key);

  final String title;

  List? workListPrev;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SizedBox(
      height: height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: width * 0.011,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// table_Body_Common_design
class workBodyList extends StatelessWidget {
  const workBodyList({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SizedBox(
      child: Text(
        title ?? '' as String,
        style: TextStyle(
          fontSize: width * 0.011,
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class CntWrk {
  final int cntwrkSeq;
  final String cntwrkNm;

  CntWrk(
    this.cntwrkSeq,
    this.cntwrkNm,
  );
}
