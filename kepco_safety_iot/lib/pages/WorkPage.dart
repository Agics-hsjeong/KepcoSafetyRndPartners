import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/pages/WorkReportPage.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:kepco_safety_iot/widgets/common/Layout.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/common/WorkerBox.dart';

import 'TodaysPage.dart';
import 'WorkDetailPage.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  static const String TAB_1 = "공사 현장 관리";
  static const String TAB_2 = "작업 이력관리";

  String? selectedTab;
  List workToday = [];
  List? workPast;
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

    if (workToday.isNotEmpty) workToday.clear();

    setState(() {
      workToday = result;

      print('===> $workToday');
    });
  }

  @override
  void initState() {
    super.initState();

    _getAllCntwrk();

    selectedTab = "공사 현장 관리";
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
              width * 0.01, width * 0.003, width * 0.007, width * 0.007),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  width: width * 0.97,
                  child: Row(
                    children: [
                      // TAB1_금일현장관리 탭
                      GestureDetector(
                        onTap: () {
                          setState(() => selectedTab = TAB_1);
                          // workToday();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              width * 0.006, 0.0, width * 0.006, width * 0.006),
                          decoration: selectedTab == TAB_1
                              ? const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 4, color: ColorSelect.blueColor),
                                  ),
                                )
                              : null,
                          child: Text(
                            TAB_1, //h4
                            style: TextStyle(
                              fontSize: width * 0.011,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SUIT',
                              color: selectedTab == TAB_1
                                  ? ColorSelect.blueColor
                                  : ColorSelect.grayColor2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      // TAB2_작업이력관리 탭
                      GestureDetector(
                        onTap: () {
                          setState(() => selectedTab = TAB_2);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              width * 0.006, 0.0, width * 0.006, width * 0.006),
                          decoration: selectedTab == TAB_2
                              ? const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 3, color: ColorSelect.blueColor),
                                  ),
                                )
                              : null,
                          child: Text(
                            TAB_2, //h4
                            style: TextStyle(
                              fontSize: width * 0.011,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SUIT',
                              color: selectedTab == TAB_2
                                  ? ColorSelect.blueColor
                                  : ColorSelect.grayColor2,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),
                      SizedBox(
                        height: height * 0.04,
                        width: width * 0.15,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.002),
                                  child: Text(
                                    '작업 내용 선택',
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
                            items: cntwrkList
                                .asMap()
                                .entries
                                .map<DropdownMenuItem<int>>((list) {
                              return DropdownMenuItem<int>(
                                value: list.key,
                                child: Text(list.value.cntwrkNm),
                              );
                            }).toList(),
                            value: dropSelectIndex,
                            onChanged: (int? index) {
                              setState(() {
                                dropSelectIndex = index!;
                              });
                              _getWork();
                            },
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: ColorSelect.textColor3),
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
                    ],
                  ),
                ),
                if (workToday != null && selectedTab == TAB_1)
                  Padding(
                    padding: EdgeInsets.only(top: width * 0.006),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          workToday.length,
                          (index) => WorkCard(
                            widget: widget,
                            cnt: workToday[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (selectedTab == TAB_2)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: width * 0.006),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: height * 0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorSelect.toggleColor3,
                              boxShadow: const [
                                BoxShadow(
                                  color: ColorSelect.shadowColor3,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      1, 1), // changes position of shadow
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
                                    tableHeadTxt(title: '번호'),
                                    tableHeadTxt(
                                      title: '공사/용역번호',
                                    ),
                                    tableHeadTxt(
                                      title: '작업명',
                                    ),
                                    tableHeadTxt(
                                      title: '작업장소',
                                    ),
                                    tableHeadTxt(
                                      title: '위험공종표시',
                                    ),
                                    tableHeadTxt(
                                      title: '작업일시',
                                    ),
                                    tableHeadTxt(
                                      title: '감독관',
                                    ),
                                    tableHeadTxt(
                                      title: '진행정보',
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
                                children: workToday.asMap().entries.map((e) {
                                  return WorkListManage(
                                    listNumb: '${e.key + 1}',
                                    listConst: e.value["opertSeq"].toString(),
                                    listName: e.value["opertNm"] ?? "",
                                    listLocation: e.value["addr2"] ?? "",
                                    listMark: e.value["cntwrkTyCd"],
                                    listDate: e.value["opertDt"].toString(),
                                    listSuper: e.value["userId"] ?? "",
                                    listInform: e.value["opertStatus"],
                                  );
                                }).toList(),
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

// 금일현장관리_Commmon_Card
class WorkCard extends StatefulWidget {
  const WorkCard({
    Key? key,
    required this.widget,
    required this.cnt,
  }) : super(key: key);

  final WorkPage widget;
  final Map cnt;

  @override
  State<WorkCard> createState() => _WorkCardState();
}

class _WorkCardState extends State<WorkCard> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Padding(
      padding: EdgeInsets.only(right: width * 0.02),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 4.0,
        child: SizedBox(
          // padding: const EdgeInsets.all(8.0),
          width: width * 0.28,
          height: height * 0.7,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: width * 0.28,
                  height: height * 0.33,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: MapBox(cnt: widget.cnt),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                            opacity: 0.5,
                            child: Container(
                              width: width * 0.28,
                              height: height * 0.1,
                              color: Colors.white,
                            )),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: width * 0.28,
                          height: height * 0.101,
                          padding: EdgeInsets.only(
                            left: width * 0.015,
                            right: width * 0.015,
                            top: height * 0.015,
                            bottom: height * 0.01,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.cnt["opertNm"],
                                style: TextStyle(
                                  fontSize: width * 0.013,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "작업전 안전체크",
                                    style: TextStyle(
                                      fontSize: width * 0.011,
                                      color: ColorSelect.grayColor5,
                                    ),
                                  ),
                                  OutlinedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        backgroundColor:
                                            widget.cnt['safeChkBfOpertYn'] ==
                                                    'Y'
                                                ? Colors.blue
                                                : Colors.red,
                                      ),
                                      child: Text(
                                        widget.cnt['safeChkBfOpertYn'] == 'Y'
                                            ? "이행"
                                            : "미이행",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.008,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: height * 0.35,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: width * 0.017,
                      bottom: width * 0.007,
                      left: width * 0.018,
                      right: width * 0.018),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.25,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: width * 0.08,
                                    height: height * 0.05,
                                    child: Text(
                                      "공사번호",
                                      style: TextStyle(
                                        color: ColorSelect.grayColor5,
                                        fontSize: width * 0.01,
                                      ),
                                    )),
                                SizedBox(
                                    width: width * 0.1,
                                    height: height * 0.05,
                                    child: Text(
                                      "3994829432",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.01,
                                      ),
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: width * 0.08,
                                    height: height * 0.05,
                                    child: Text(
                                      "작업주소",
                                      style: TextStyle(
                                        color: ColorSelect.grayColor5,
                                        fontSize: width * 0.01,
                                      ),
                                    )),
                                SizedBox(
                                    width: width * 0.15,
                                    height: height * 0.05,
                                    child: Text(
                                      widget.cnt["addr2"],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.01,
                                      ),
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: width * 0.08,
                                    height: height * 0.05,
                                    child: Text(
                                      "작업날짜",
                                      style: TextStyle(
                                        color: ColorSelect.grayColor5,
                                        fontSize: width * 0.01,
                                      ),
                                    )),
                                SizedBox(
                                    width: width * 0.1,
                                    height: height * 0.05,
                                    child: Text(
                                      widget.cnt["opertDt"],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.01,
                                      ),
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: width * 0.08,
                                    height: height * 0.05,
                                    child: Text(
                                      "해당공종",
                                      style: TextStyle(
                                        color: ColorSelect.grayColor5,
                                        fontSize: width * 0.01,
                                      ),
                                    )),
                                SizedBox(
                                  width: width * 0.1,
                                  height: height * 0.05,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: widget.cnt["cntwrkTyCd"]
                                          .map<Widget>((e) => Text(
                                                e.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: width * 0.01,
                                                ),
                                              ))
                                          .toList()),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: width * 0.08,
                                    height: height * 0.05,
                                    child: Text(
                                      "안전담당자",
                                      style: TextStyle(
                                        color: ColorSelect.grayColor5,
                                        fontSize: width * 0.01,
                                      ),
                                    )),
                                SizedBox(
                                  width: width * 0.1,
                                  height: height * 0.05,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "홍길동",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width * 0.01,
                                          ),
                                        )
                                      ]),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.052,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: width * 0.01),
                                child: SizedBox(
                                  height: height * 0.052,
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WorkDetailPage(gateYn: true),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: const BorderSide(
                                            width: 1.0,
                                            color: Color.fromRGBO(
                                                167, 167, 167, 1))),
                                    child: Text(
                                      "상세보기",
                                      style: TextStyle(
                                        color: ColorSelect.grayColor5,
                                        fontSize: width * 0.01,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: width * 0.01,
                                ),
                                child: SizedBox(
                                  height: height * 0.052,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      userStages = [];
                                      isFinding = false;
                                      isFirst = false;

                                      widget.cnt['safeChkBfOpertYn'] == 'Y'
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TodaysPage(cnt: widget.cnt),
                                              ))
                                          : ShowDialog.testingDialog(context);
                                    },
                                    style: btnStateStyle(),
                                    child: btnStateText(),
                                  ),
                                ),
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
        ),
      ),
    );
  }

  Text btnStateText() {
    if (widget.cnt["opertStatus"] == 0) {
      return const Text(
        "작업 시작",
        textScaleFactor: 1.4, //h4
        style: TextStyle(),
      );
    } else if (widget.cnt["opertStatus"] == 1) {
      return const Text(
        "공사 진행중",
        textScaleFactor: 1.4, //h4
        style: TextStyle(),
      );
    } else if (widget.cnt["opertStatus"] == 2) {
      return const Text(
        "재진행",
        textScaleFactor: 1.4, //h4
        style: TextStyle(),
      );
    } else {
      return const Text(
        "작업완료 ",
        textScaleFactor: 1.4, //h4
        style: TextStyle(),
      );
    }
  }

  ButtonStyle btnStateStyle() {
    if (widget.cnt["opertStatus"] == 0) {
      return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorSelect.yellowColor),
      );
    } else if (widget.cnt["opertStatus"] == 1) {
      return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorSelect.greenColor),
      );
    } else if (widget.cnt["opertStatus"] == 2) {
      return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorSelect.redColor),
      );
    } else {
      return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorSelect.grayColor),
      );
    }
  }
}

class MapBox extends StatelessWidget {
  const MapBox({
    Key? key,
    required this.cnt,
  }) : super(key: key);

  final Map cnt;

  @override
  Widget build(BuildContext context) {
    return SfMaps(
      layers: [
        MapTileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          initialFocalLatLng: MapLatLng(cnt["latitude"], cnt["longitude"]),
          initialZoomLevel: 15,
          initialMarkersCount: 1,
          markerBuilder: (BuildContext context, int index) {
            return MapMarker(
              latitude: cnt["latitude"],
              longitude: cnt["longitude"],
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 50,
              ),
            );
          },
        ),
      ],
    );
  }
}

// 작업이력관리_Table_Commmon_List
class WorkListManage extends StatelessWidget {
  const WorkListManage(
      {Key? key,
      required this.listNumb,
      required this.listConst,
      required this.listName,
      required this.listLocation,
      required this.listMark,
      required this.listDate,
      required this.listSuper,
      required this.listInform})
      : super(key: key);

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

    return InkWell(
      child: SizedBox(
        width: width * 0.97,
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
                    Center(child: workBodyList(title: listConst)),
                    Center(child: workBodyList(title: listName)),
                    Center(child: workBodyList(title: listLocation)),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: listMark
                            .map((e) => workBodyList(title: e))
                            .toList(),
                      ),
                    ),
                    Center(child: workBodyList(title: listDate)),
                    Center(child: workBodyList(title: listSuper)),
                    Center(
                        child: Text(
                      listInform == 0
                          ? '공사대기'
                          : listInform == 1
                              ? '공사진행'
                              : listInform == 2
                                  ? '공사중지'
                                  : '공사종료',
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
                      ),
                    )),
                    Center(
                      child: SizedBox(
                          height: height * 0.05,
                          child:
                              // SizedBox(
                              //   width: width * 0.04,
                              //   child: TextButton(
                              //     style: TextButton.styleFrom(
                              //       backgroundColor: ColorSelect.workListbtn4,
                              //       padding:
                              //           const EdgeInsets.fromLTRB(20, 7, 20, 7),
                              //       textStyle: const TextStyle(fontSize: 14),
                              //       primary: Colors.black,
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(20.0),
                              //       ),
                              //     ),
                              //     onPressed: () => Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => WorkDetailPage(
                              //             title: title, gateYn: false),
                              //       ),
                              //     ),
                              //     child: const Text(
                              //       '조회',
                              //       textScaleFactor: 1,
                              //       style: TextStyle(fontWeight: FontWeight.w500),
                              //     ),
                              //   ),
                              // ),
                              SvgPicture.asset(
                            'assets/svg/report.svg',
                            color: ColorSelect.toggleColor3,
                            width: width * 0.01,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WorkReportPage(
                    cntwrkNo: 232323232323,
                  )),
        );
      },
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
