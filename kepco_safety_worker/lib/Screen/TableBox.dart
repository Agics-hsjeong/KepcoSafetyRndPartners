import 'package:flutter/material.dart';
import 'package:kepco_safety_worker/models/models.dart';

class TableBox extends StatefulWidget {
  const TableBox({Key? key, required this.title, required this.list})
      : super(key: key);
  final String title;
  final List<SingleRowState> list;

  @override
  State<TableBox> createState() => _TableBoxState();
}

class _TableBoxState extends State<TableBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 30.0),
        //title + 무/유 버튼 박스
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${widget.title}',
              textScaleFactor: FontSize.h6,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: widget.list
                .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 15.0),
                          child: Text(
                            e.contents,
                            textScaleFactor: FontSize.h7,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
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
                                    child: Text("있음",
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: e.isChecked
                                              ? ColorSelect.blueColor
                                              : Color.fromRGBO(
                                                  112, 112, 112, 1),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
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
                                      "없음",
                                      textScaleFactor: FontSize.h5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
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
        ]));
  }
}

class SingleRowState {
  String contents;
  String type;
  bool isChecked;

  SingleRowState({
    required this.contents,
    required this.type,
    required this.isChecked,
  });
}
