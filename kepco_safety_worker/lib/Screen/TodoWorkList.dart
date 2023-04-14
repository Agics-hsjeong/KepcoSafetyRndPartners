import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kepco_safety_worker/Screen/TodoWorkDetail.dart';

class TodoWorkList extends StatefulWidget {
  const TodoWorkList({Key? key}) : super(key: key);

  @override
  State<TodoWorkList> createState() => _TodoWorkListState();
}

class _TodoWorkListState extends State<TodoWorkList> {
  List<SingleRowState> workList = List.empty(growable: true);

  @override
  void initState() {
    workList = [
      SingleRowState(
          type: "배전",
          workNm: "강동구 변동5거리 간접활선 공법 (바이패스케이블)",
          risk: "중",
          location: "서울시 강동구 변동555로 3-1",
          date: "2022-01-01",
          workType: "D54 D53 D52"),
      SingleRowState(
          type: "배전",
          workNm: "강동구 변동5거리 간접활선 공법 (바이패스케이블)",
          risk: "중",
          location: "서울시 강동구 변동555로 3-1",
          date: "2022-01-01",
          workType: "D54 D53 D52"),
      SingleRowState(
          type: "배전",
          workNm: "강동구 변동5거리 간접활선 공법 (바이패스케이블)",
          risk: "중",
          location: "서울시 강동구 변동555로 3-1",
          date: "2022-01-01",
          workType: "D54 D53 D52"),
      SingleRowState(
          type: "배전",
          workNm: "강동구 변동5거리 간접활선 공법 (바이패스케이블)",
          risk: "중",
          location: "서울시 강동구 변동555로 3-1",
          date: "2022-01-01",
          workType: "D54 D53 D52"),
      SingleRowState(
          type: "배전",
          workNm: "강동구 변동5거리 간접활선 공법 (바이패스케이블)",
          risk: "중",
          location: "서울시 강동구 변동555로 3-1",
          date: "2022-01-01",
          workType: "D54 D53 D52"),
      SingleRowState(
          type: "배전",
          workNm: "강동구 변동5거리 간접활선 공법 (바이패스케이블)",
          risk: "중",
          location: "서울시 강동구 변동555로 3-1",
          date: "2022-01-01",
          workType: "D54 D53 D52"),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "오늘의 작업",
            textScaleFactor: FontSize.h7,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: workList
                      .map((e) => InkWell(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: ColorSelect.boxColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorSelect.shadowColor,
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.064,
                                        child: Center(
                                          child: Transform.translate(
                                            offset: Offset(-12, 0),
                                            child: SvgPicture.asset(
                                              "assets/svg/배전.svg",
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.type,
                                            textScaleFactor: FontSize.h7,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.66,
                                            padding: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: Text(
                                              e.workNm,
                                              textScaleFactor: FontSize.h8,
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                text: "작업 위험도   ",
                                                style: TextStyle(
                                                    color:
                                                        ColorSelect.greyolor),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: e.risk,
                                                      style: TextStyle(
                                                          color: Colors.red))
                                                ]),
                                            textScaleFactor: FontSize.h8,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.all(5)),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.fmd_good_rounded,
                                        size: 15,
                                        color: ColorSelect.lightblueColor,
                                      ),
                                      Padding(padding: EdgeInsets.all(3)),
                                      Text(
                                        "주소",
                                        textScaleFactor: FontSize.h8,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(right: 30)),
                                      Text(
                                        e.location,
                                        textScaleFactor: FontSize.h8,
                                        style: TextStyle(
                                            color: ColorSelect.greyolor),
                                      )
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.all(4)),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_rounded,
                                        size: 15,
                                        color: ColorSelect.lightblueColor,
                                      ),
                                      Padding(padding: EdgeInsets.all(3)),
                                      Text(
                                        "날짜",
                                        textScaleFactor: FontSize.h8,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(right: 30)),
                                      Text(
                                        e.date,
                                        textScaleFactor: FontSize.h8,
                                        style: TextStyle(
                                            color: ColorSelect.greyolor),
                                      )
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.all(4)),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.push_pin_rounded,
                                        size: 15,
                                        color: ColorSelect.lightblueColor,
                                      ),
                                      Padding(padding: EdgeInsets.all(3)),
                                      Text(
                                        "작업공종",
                                        textScaleFactor: FontSize.h8,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(right: 10)),
                                      Text(
                                        e.workType,
                                        textScaleFactor: FontSize.h8,
                                        style: TextStyle(
                                            color: ColorSelect.greyolor),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TodoWorkDetail(
                                          list: e,
                                        )),
                              );
                            },
                          ))
                      .toList()),
            )),
          )
        ],
      ),
    );
  }
}

class SingleRowState {
  String type;
  String workNm;
  String risk;
  String location;
  String date;
  String workType;

  SingleRowState({
    required this.type,
    required this.workNm,
    required this.risk,
    required this.location,
    required this.date,
    required this.workType,
  });
}
