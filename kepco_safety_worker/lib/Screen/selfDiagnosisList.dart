import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:kepco_safety_worker/Screen/selfDiagnosisResult.dart';
import '../models/models.dart';

class selfDiagnosisList extends StatefulWidget {
  const selfDiagnosisList({Key? key}) : super(key: key);

  @override
  State<selfDiagnosisList> createState() => _selfDiagnosisListState();
}

class _selfDiagnosisListState extends State<selfDiagnosisList> {
  List<SingleRowState2> PmisRow5 = List.empty(growable: true);
  @override
  void initState() {
    PmisRow5 = [
      SingleRowState2(
          contents: "오늘 아침 전과 다르게 몸 상태가 좋지 않다고 느낀다.",
          isChecked: false,
          type: "1"),
      SingleRowState2(
          contents: "최근 활동 후 쉬었으나 몸의 열이 식지 않는다고 느낀다.",
          isChecked: false,
          type: "1"),
      SingleRowState2(
          contents: "아래의 질환이 있거나, 약을 복용하였다.", isChecked: false, type: "1"),
      SingleRowState2(
          contents: "어젯밤 설사, 음주로 인한 숙취, 근심걱정 등으로 인해 잠을 잘 이루지 못하였다.",
          isChecked: false,
          type: "1"),
      SingleRowState2(
          contents: "평소 에어컨을 틀어두어도 땀이 흐를 정도로 더위를 쉽게 느낀다.",
          isChecked: false,
          type: "1"),
      SingleRowState2(
          contents: "최근 힘든일이 있어 심신이 지쳐있다.", isChecked: false, type: "1"),
      SingleRowState2(
          contents: "평소 에어컨을 틀어두어도 땀이 흐를 정도로 더위를 쉽게 느낀다.",
          isChecked: false,
          type: "1"),
      SingleRowState2(
          contents: "온열질환으로 인한 증상 (어지러움, 두통, 열 등)을 경험한 적이 없다.",
          isChecked: false,
          type: "1"),
      SingleRowState2(
          contents: "나는 일을 시작하게 되면 쉴새 없이 전념하게 된다.",
          isChecked: false,
          type: "1"),
      SingleRowState2(
          contents: "폭염기간이라도 계획대로 반드시 외부작업 혹은 활동을 진행하려 한다.",
          isChecked: false,
          type: "1"),
      SingleRowState2(
          contents: "나에게 맡겨진 일을 가급적 스스로 하며, 일일이 챙겨 끝까지 처리하려 한다.",
          isChecked: false,
          type: "1"),
    ];

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(top: 30.0, bottom: 15.0, left: 18),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Color(0xff707070),
                    size: 30,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Column(
                children: [
                  SizedBox(
                      child: Text(
                    '야외근로자용 온열질환 특성',
                    style: TextStyle(color: Color(0xff707070)),
                  )),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '자가진단표',
                      textScaleFactor: FontSize.h3,
                      style: TextStyle(
                          color: ColorSelect.blueColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 6.0),
                          child: Icon(
                            Icons.check,
                            color: Color(0xffED6451),
                            size: 18,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '본 진단표는 폭염으로부터 공사장 등 ',
                                  style: TextStyle(
                                      color: Color(0xff4B4C4D),
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                ),
                                Text(
                                  '야외근로자의',
                                  style: TextStyle(
                                      color: Color(0xffED6451),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '온열질환 취약도',
                                  style: TextStyle(
                                      color: Color(0xffED6451),
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '를 선제적으로 편별하기 위한',
                                  style: TextStyle(
                                      color: Color(0xff4B4C4D),
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            Text(
                              '도움을 주는데 목적이 있음.',
                              style: TextStyle(
                                  color: Color(0xff4B4C4D),
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xffeeeeee),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 21, right: 21, bottom: 25),
                    child: Column(
                      children: [
                        TableBox2(list: PmisRow5),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 21),
                margin: EdgeInsets.only(top: 15, bottom: 30),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorSelect.blueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(14),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => selfDiagnosisResult()),
                    );
                  },
                  child: Text(
                    "저장",
                    textScaleFactor: FontSize.h7,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TableBox2 extends StatefulWidget {
  const TableBox2({Key? key, required this.list}) : super(key: key);
  final List<SingleRowState2> list;

  @override
  State<TableBox2> createState() => _TableBoxState();
}

class _TableBoxState extends State<TableBox2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        children: widget.list
            .map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.contents,
                            textScaleFactor: FontSize.h7,
                          ),
                          e.contents == "아래의 질환이 있거나, 약을 복용하였다."
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Column(
                                    children: [
                                      tableBoxCont(
                                        txt: '질환',
                                        cont: '당뇨, 고혈압, 심장병, 신장병, 피부질환, 정신질환',
                                      ),
                                      Padding(padding: EdgeInsets.all(2)),
                                      tableBoxCont(
                                        txt: '약',
                                        cont:
                                            '감기약, 멀미약, 수면유도제, 혈압약, 이뇨제, 신경·정신질환약',
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                color: e.isChecked
                                    ? ColorSelect.lightblueColor2
                                    : Color.fromRGBO(238, 238, 238, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                    color: e.isChecked
                                        ? ColorSelect.blueColor
                                        : Color.fromRGBO(238, 238, 238, 1),
                                    width: 1),
                              ),
                              child: Center(
                                child: Text("예",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: e.isChecked
                                          ? ColorSelect.blueColor
                                          : Color.fromRGBO(112, 112, 112, 1),
                                    )),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                e.isChecked = !e.isChecked;
                              });
                            },
                          ),
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                color: e.isChecked
                                    ? Color.fromRGBO(238, 238, 238, 1)
                                    : ColorSelect.lightblueColor2,
                                border: Border.all(
                                    color: e.isChecked
                                        ? Color.fromRGBO(238, 238, 238, 1)
                                        : ColorSelect.blueColor,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Center(
                                child: Text(
                                  "아니요",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: e.isChecked
                                        ? Color.fromRGBO(112, 112, 112, 1)
                                        : ColorSelect.blueColor,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                e.isChecked = !e.isChecked;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
            .toList(),
      )
    ]);
  }
}

class tableBoxCont extends StatelessWidget {
  const tableBoxCont({Key? key, required this.txt, required this.cont})
      : super(key: key);
  final String txt;
  final String cont;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$txt : ',
              textScaleFactor: 0.85,
            ),
            Text(
              '$cont',
              textScaleFactor: 0.85,
              style: TextStyle(color: ColorSelect.blueColor),
            ),
          ],
        )
      ],
    );
  }
}

class SingleRowState2 {
  String contents;
  String type;
  bool isChecked;

  SingleRowState2({
    required this.contents,
    required this.type,
    required this.isChecked,
  });
}
