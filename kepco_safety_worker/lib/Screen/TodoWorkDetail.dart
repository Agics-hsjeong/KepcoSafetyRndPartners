import 'package:flutter/material.dart';
import '../models/models.dart';

class TodoWorkDetail extends StatefulWidget {
  const TodoWorkDetail({Key? key, required this.list}) : super(key: key);
  final list;

  @override
  State<TodoWorkDetail> createState() => _TodoWorkDetailState();
}

class _TodoWorkDetailState extends State<TodoWorkDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: ColorSelect.greyolor,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              Container(
                child: Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.list.workNm,
                        textScaleFactor: FontSize.h7,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.height * 0.028,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorSelect.lightblueColor2),
                            child: Center(
                              child: Text(
                                widget.list.type + " 작업",
                                textScaleFactor: FontSize.h8,
                                style: TextStyle(
                                  color: ColorSelect.blueColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.028,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorSelect.backgroundColor),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                    text: "작업 위험도 ",
                                    style: TextStyle(
                                        color: ColorSelect.greyolor,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.list.risk,
                                          style: TextStyle(color: Colors.red))
                                    ]),
                                textScaleFactor: FontSize.h8,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "작업 위치",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(
                            color: ColorSelect.greyolor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          widget.list.location,
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Divider(
                          thickness: 1.0,
                          color: ColorSelect.backgroundColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "작업 예정 일시",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(
                            color: ColorSelect.greyolor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          widget.list.date,
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Divider(
                          thickness: 1.0,
                          color: ColorSelect.backgroundColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "작업 공종",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(
                            color: ColorSelect.greyolor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          widget.list.workType,
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Divider(
                          thickness: 1.0,
                          color: ColorSelect.backgroundColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "작업 위험도",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(
                            color: ColorSelect.greyolor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          widget.list.risk,
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Divider(
                          thickness: 1.0,
                          color: ColorSelect.backgroundColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "작업 내용",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(
                            color: ColorSelect.greyolor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "방황하였으며, 불어 설산에서 있음으로써 인도하겠다는 대한 청춘이 이것이다. 미인을 못할 전인 운다. 창공에 못할 만천하의 아니한 이상의 봄바람이다. 설레는 유소년에게서 무엇을 그들은 원질이 커다란 얼음이 능히 피다.",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Divider(
                          thickness: 1.0,
                          color: ColorSelect.backgroundColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "안전담당자",
                                  textScaleFactor: FontSize.h8,
                                  style: TextStyle(
                                    color: ColorSelect.greyolor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "김*인",
                                  textScaleFactor: FontSize.h8,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.07,
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                              decoration: BoxDecoration(
                                  color: ColorSelect.lightblueColor2,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Icon(
                                Icons.local_phone_rounded,
                                size: 18,
                                color: ColorSelect.blueColor,
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Divider(
                          thickness: 1.0,
                          color: ColorSelect.backgroundColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "작업자 명단",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(
                            color: ColorSelect.greyolor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "김*인 (작업책임자)",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "박*인",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "이*인",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "오*인",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "황*인",
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Divider(
                          thickness: 1.0,
                          color: ColorSelect.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
