import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';

class RiskCheckBox extends StatefulWidget {
  const RiskCheckBox(
      {Key? key,
      required this.list,
      required this.possibility,
      required this.importance,
      required this.risk})
      : super(key: key);
  final List<RowState> list;
  final int possibility;
  final int importance;
  final int risk;

  @override
  State<RiskCheckBox> createState() => _RiskCheckBoxState();
}

class _RiskCheckBoxState extends State<RiskCheckBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.006),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "작업 위험도 측정",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.012,
                        fontFamily: 'SUIT',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.008, bottom: height * 0.008),
                child: SizedBox(
                  height: height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "가능성",
                            style: TextStyle(
                              color: Color.fromRGBO(71, 106, 23, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: width * 0.01,
                              fontFamily: 'SUIT',
                            ),
                          ),
                          Text(
                            widget.possibility.toString(),
                            style: TextStyle(
                              color: Color.fromRGBO(71, 106, 23, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.013,
                              fontFamily: 'SUIT',
                            ),
                          )
                        ],
                      ),
                      const VerticalDivider(
                          color: ColorSelect.borderColor2, thickness: 1),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "중대성",
                            style: TextStyle(
                              color: Color.fromRGBO(35, 47, 119, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: width * 0.01,
                              fontFamily: 'SUIT',
                            ),
                          ),
                          Text(
                            widget.importance.toString(),
                            style: TextStyle(
                              color: Color.fromRGBO(35, 47, 119, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.013,
                              fontFamily: 'SUIT',
                            ),
                          )
                        ],
                      ),
                      const VerticalDivider(
                          color: Color.fromRGBO(212, 212, 212, 1),
                          thickness: 1),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "위험성",
                            style: TextStyle(
                              color: Color.fromRGBO(227, 6, 0, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: width * 0.01,
                              fontFamily: 'SUIT',
                            ),
                          ),
                          Text(
                            widget.risk.toString(),
                            style: TextStyle(
                              color: Color.fromRGBO(227, 6, 0, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.013,
                              fontFamily: 'SUIT',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.015),
          child: Divider(
            thickness: 8,
            height: 1,
            color: Color.fromRGBO(241, 243, 248, 1),
          ),
        ),
        widget.list.length > 0
            ? Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "위험사항 체크",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.012,
                        fontFamily: 'SUIT',
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: height * 0.02)),
                    Column(
                        children: widget.list
                            .map(
                              (e) => Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: width * 0.002,
                                            right: width * 0.007),
                                        width: width * 0.0155,
                                        height: height * 0.027,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  232, 233, 255, 1),
                                              width: 1),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  22, 25, 127, 0.3),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            (widget.list.indexOf(e) + 1)
                                                .toString(),
                                            style: TextStyle(
                                              color: ColorSelect.textColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: width * 0.008,
                                              fontFamily: 'SUIT',
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.33,
                                        child: Text(
                                          e.contents,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            height: 1.4,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: width * 0.01,
                                            fontFamily: 'SUIT',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: e.warnCn
                                        .map((e) => e.contents == ""
                                            ? Text("")
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * 0.01,
                                                    bottom: height * 0.005,
                                                    left: width * 0.018),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right:
                                                                width * 0.006),
                                                        child: Icon(
                                                          Icons
                                                              .report_problem_rounded,
                                                          size: width * 0.01,
                                                          color: Color.fromRGBO(
                                                              255, 141, 141, 1),
                                                        )),
                                                    SizedBox(
                                                      width: width * 0.32,
                                                      child: Text(
                                                        e.contents,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize:
                                                              width * 0.009,
                                                          fontFamily: 'SUIT',
                                                          color: Color.fromRGBO(
                                                              114, 114, 114, 1),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ))
                                        .toList(),
                                  )
                                ],
                              ),
                            )
                            .toList())
                  ],
                ),
              )
            : SizedBox.shrink(),
        widget.list.length > 0
            ? Padding(
                padding:
                    EdgeInsets.only(top: height * 0.01, bottom: height * 0.01),
                child: Divider(
                  thickness: 8,
                  height: 1,
                  color: Color.fromRGBO(241, 243, 248, 1),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

class RowState {
  String contents;
  List<RiskState> warnCn;

  RowState({
    required this.contents,
    required this.warnCn,
  });
}

class RiskState {
  String contents;

  RiskState({required this.contents});
}
