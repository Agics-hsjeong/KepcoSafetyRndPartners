import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';

import 'CareCard.dart';

class CareNotice extends StatefulWidget {
  const CareNotice({
    Key? key,
  }) : super(key: key);

  @override
  State<CareNotice> createState() => _CareNoticeState();
}

class _CareNoticeState extends State<CareNotice> {
  List<SingleRowState> workerRickList = List.empty(growable: true);
  List<SingleRowState> noticeList = List.empty(growable: true);

  void notice() {
    setState(() {
      noticeList = [
        SingleRowState(
          state: '조치완료',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '장비 접지 상태 불량 확인 요망',
          managtCnt: '통신오류로 인한 오작동',
        ),
        SingleRowState(
          state: '조치완료',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '장비 접지 상태 불량 확인 요망',
          managtCnt: '통신오류로 인한 오작동',
        ),
        SingleRowState(
          state: '조치완료',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '장비 접지 상태 불량 확인 요망',
          managtCnt: '통신오류로 인한 오작동',
        ),
        SingleRowState(
          state: '조치완료',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '장비 접지 상태 불량 확인 요망',
          managtCnt: '통신오류로 인한 오작동',
        ),
        SingleRowState(
          state: '오류',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '장비 접지 상태 불량 확인 요망',
          managtCnt: '통신오류로 인한 오작동',
        ),
        SingleRowState(
          state: '특이사항',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '장비 접지 상태 불량 확인 요망',
          managtCnt: '통신오류로 인한 오작동',
        ),
      ];

      workerRickList = [
        SingleRowState(
          state: '조치완료',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '작업자1',
          managtCnt: '체온이상',
        ),
        SingleRowState(
          state: '오류',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '작업자2',
          managtCnt: '체온이상',
        ),
        SingleRowState(
          state: '오류',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '작업자3',
          managtCnt: '체온이상',
        ),
        SingleRowState(
          state: '조치완료',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '작업자2',
          managtCnt: '체온이상',
        ),
        SingleRowState(
          state: '조치완료',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '작업자3',
          managtCnt: '체온이상',
        ),
        SingleRowState(
          state: '특이사항',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '작업자1',
          managtCnt: '체온이상',
        ),
        SingleRowState(
          state: '특이사항',
          occrrncDt: '2022-06-29',
          occrrncPnttm: '16 : 42 : 38',
          endDt: '2022-06-29',
          endPnttm: '16 : 45 : 13',
          atentCnt: '작업자2',
          managtCnt: '체온이상',
        ),
      ];
    });
  }

  @override
  void initState() {
    notice();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Status.isOpen
        ? SizedBox(
            width: width * 0.38,
            height: height * 0.09,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, width * 0.01, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return CareNoticePopup(
                              title: "장비 주의 알림 (RI)", list: noticeList);
                        },
                      );
                    },
                    child: CareCard(
                      title: "장비 주의 알림",
                      img: "assets/img/알림_장비주의.png",
                      ribi: "RI",
                      alarmdata: "11",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return CareNoticePopup(
                              title: "작업자 건강 알림 (BI)", list: workerRickList);
                        },
                      );
                    },
                    child: CareCard(
                      title: "작업자 건강 알림",
                      img: "assets/img/알림_작업자건강주의.png",
                      ribi: "BI",
                      alarmdata: "12",
                    ),
                  ),
                ],
              ),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "RI 장비 주의 알림",
                      textScaleFactor: FontSize.h4,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.22,
                height: MediaQuery.of(context).size.height * 0.37,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: ColorSelect.shadowColor,
                      spreadRadius: 1,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: ListView.separated(
                  controller: ScrollController(initialScrollOffset: 1.0),
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  itemCount: noticeList.length,
                  itemBuilder: (context, index) => ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: 1),
                    minLeadingWidth: 10,
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.03,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1,
                                  color: noticeList[index].state == "조치완료"
                                      ? Color.fromRGBO(106, 209, 129, 1)
                                      : noticeList[index].state == "오류"
                                          ? Color.fromRGBO(255, 128, 128, 1)
                                          : Color.fromRGBO(250, 203, 97, 1)),
                              color: noticeList[index].state == "조치완료"
                                  ? Color.fromRGBO(151, 223, 167, 1)
                                  : noticeList[index].state == "오류"
                                      ? Color.fromRGBO(255, 167, 167, 1)
                                      : Color.fromRGBO(252, 217, 137, 1)),
                          child: Icon(
                            noticeList[index].state == "조치완료"
                                ? Icons.check_rounded
                                : noticeList[index].state == "오류"
                                    ? Icons.report_problem_rounded
                                    : Icons.question_mark,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      noticeList[index].atentCnt,
                      textScaleFactor: FontSize.h5,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      noticeList[index].occrrncDt +
                          "   " +
                          noticeList[index].occrrncPnttm,
                      textScaleFactor: FontSize.h5,
                    ),
                  ),
                  separatorBuilder: ((context, index) {
                    return const Divider(
                        height: 1.0, color: ColorSelect.grayColor);
                  }),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "BI 작업자 위험 예측 알림",
                      textScaleFactor: FontSize.h4,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.22,
                height: MediaQuery.of(context).size.height * 0.37,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: ColorSelect.shadowColor,
                      spreadRadius: 1,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: ListView.separated(
                  controller: ScrollController(initialScrollOffset: 1.0),
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  itemCount: workerRickList.length,
                  itemBuilder: (context, index) => ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: 1),
                    minLeadingWidth: 10,
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.03,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1,
                                  color: workerRickList[index].state == "조치완료"
                                      ? Color.fromRGBO(106, 209, 129, 1)
                                      : workerRickList[index].state == "오류"
                                          ? Color.fromRGBO(255, 128, 128, 1)
                                          : Color.fromRGBO(250, 203, 97, 1)),
                              color: workerRickList[index].state == "조치완료"
                                  ? Color.fromRGBO(151, 223, 167, 1)
                                  : workerRickList[index].state == "오류"
                                      ? Color.fromRGBO(255, 167, 167, 1)
                                      : Color.fromRGBO(252, 217, 137, 1)),
                          child: Icon(
                            workerRickList[index].state == "조치완료"
                                ? Icons.check_rounded
                                : workerRickList[index].state == "오류"
                                    ? Icons.report_problem_rounded
                                    : Icons.question_mark,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        Text(workerRickList[index].atentCnt,
                            textScaleFactor: FontSize.h5,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        Text(workerRickList[index].managtCnt,
                            textScaleFactor: FontSize.h5,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                    subtitle: Text(
                      workerRickList[index].occrrncDt +
                          "   " +
                          workerRickList[index].occrrncPnttm,
                      textScaleFactor: FontSize.h5,
                    ),
                  ),
                  separatorBuilder: ((context, index) {
                    return const Divider(
                        height: 1.0, color: ColorSelect.grayColor);
                  }),
                ),
              )
            ],
          );
  }
}

// -------------주의 알림_팝업--------------------
class CareNoticePopup extends StatefulWidget {
  const CareNoticePopup({
    Key? key,
    required this.title,
    required this.list,
  }) : super(key: key);
  final String title;
  final List<SingleRowState> list;

  @override
  State<CareNoticePopup> createState() => _CareNoticePopupState();
}

class _CareNoticePopupState extends State<CareNoticePopup> {
  bool completion = true;
  bool error = false;
  bool special = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.6,
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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      widget.title,
                      textScaleFactor: FontSize.h4,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  completion = !completion;
                                });
                              },
                              child: Text(
                                "조치완료",
                                textScaleFactor: FontSize.h4,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: completion
                                      ? Color.fromRGBO(49, 193, 82, 1)
                                      : Colors.grey,
                                  fixedSize: const Size(130, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  error = !error;
                                });
                              },
                              child: Text(
                                "오류",
                                textScaleFactor: FontSize.h4,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: error ? Colors.red : Colors.grey,
                                  fixedSize: const Size(130, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                special = !special;
                              });
                            },
                            child: Text(
                              "특이사항",
                              textScaleFactor: FontSize.h4,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary:
                                    special ? Colors.orangeAccent : Colors.grey,
                                fixedSize: const Size(130, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          )
                        ]),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                          width: 1, color: Color.fromRGBO(202, 212, 236, 1)),
                    )),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(202, 212, 236, 1)),
                            )),
                            child: const Center(
                              child: Text(
                                "상태",
                                textScaleFactor: FontSize.h6,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromRGBO(202, 212, 236, 1)))),
                            child: const Center(
                              child: Text(
                                "발생일시",
                                textScaleFactor: FontSize.h6,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromRGBO(202, 212, 236, 1)))),
                            child: const Center(
                              child: Text(
                                "종료일시",
                                textScaleFactor: FontSize.h6,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromRGBO(202, 212, 236, 1)))),
                            child: const Center(
                              child: Text(
                                "주의내용",
                                textScaleFactor: FontSize.h6,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromRGBO(202, 212, 236, 1)))),
                            child: const Center(
                              child: Text(
                                "조치내용",
                                textScaleFactor: FontSize.h6,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (completion && widget.list[index].state == '조치완료') {
                          return NoticeList(list: widget.list, index: index);
                        }
                        if (error && widget.list[index].state == '오류') {
                          return NoticeList(list: widget.list, index: index);
                        }
                        if (special && widget.list[index].state == '특이사항') {
                          return NoticeList(list: widget.list, index: index);
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 8,
              top: 5,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close_rounded,
                  size: 50,
                  color: ColorSelect.blueColor,
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class NoticeList extends StatelessWidget {
  const NoticeList({
    Key? key,
    required this.list,
    required this.index,
  }) : super(key: key);

  final List<SingleRowState> list;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Color.fromRGBO(202, 212, 236, 1))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.height * 0.10,
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: list[index].state == "조치완료"
                            ? Color.fromRGBO(49, 193, 82, 1)
                            : list[index].state == "오류"
                                ? Colors.red
                                : Colors.orange),
                    child: Center(
                      child: Text(
                        list[index].state,
                        textScaleFactor: FontSize.h6,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        Expanded(
            flex: 2,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromRGBO(202, 212, 236, 1))),
                ),
                child: Center(
                  child: Text(
                    list[index].occrrncDt + "\n  " + list[index].occrrncPnttm,
                    textScaleFactor: FontSize.h6,
                  ),
                ))),
        Expanded(
            flex: 2,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromRGBO(202, 212, 236, 1))),
                ),
                child: Center(
                  child: Text(
                    list[index].endDt + "\n  " + list[index].endPnttm,
                    textScaleFactor: FontSize.h6,
                  ),
                ))),
        Expanded(
            flex: 2,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromRGBO(202, 212, 236, 1))),
                ),
                child: Center(
                  child: Text(
                    list[index].atentCnt,
                    textScaleFactor: FontSize.h6,
                  ),
                ))),
        Expanded(
            flex: 2,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromRGBO(202, 212, 236, 1))),
                ),
                child: Center(
                  child: Text(
                    list[index].managtCnt,
                    textScaleFactor: FontSize.h6,
                  ),
                )))
      ],
    );
  }
}

class SingleRowState {
  String state;
  String occrrncDt;
  String occrrncPnttm;
  String endDt;
  String endPnttm;
  String atentCnt;
  String managtCnt;

  SingleRowState({
    required this.state,
    required this.occrrncDt,
    required this.occrrncPnttm,
    required this.endDt,
    required this.endPnttm,
    required this.atentCnt,
    required this.managtCnt,
  });
}
