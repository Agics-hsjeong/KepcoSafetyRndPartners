import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';

class TableBox2 extends StatefulWidget {
  const TableBox2({Key? key, required this.title, required this.list})
      : super(key: key);
  final String title;
  final List<SingleRowState> list;

  @override
  State<TableBox2> createState() => _TableBox2State();
}

class _TableBox2State extends State<TableBox2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Container(
        margin: EdgeInsets.only(top: height * 0.03, bottom: height * 0.01),
        //title + 무/유 버튼 박스
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${widget.title}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: width * 0.012,
                fontFamily: 'SUIT',
              ),
            ),
          ),
          Column(
            children: widget.list
                .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.02, bottom: height * 0.015),
                          child: Text(
                            e.contents,
                            style: TextStyle(
                              color: ColorSelect.textColor,
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
                            constraints:
                                BoxConstraints.expand(width: width * 0.1795),
                            children: <Widget>[
                              Text(e.type == "1" ? "무" : "양",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width * 0.011,
                                    fontFamily: 'SUIT',
                                  )),
                              Text(e.type == "1" ? "유" : "불",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width * 0.011,
                                    fontFamily: 'SUIT',
                                  )),
                            ],
                            onPressed: (int index) {
                              setState(() {
                                for (int i = 0; i < e.isChecked.length; i++) {
                                  if (i == index) {
                                    if (e.isChecked[i] != true) {
                                      e.isChecked[i] = !e.isChecked[i];
                                    }
                                  } else {
                                    e.isChecked[i] = false;
                                  }
                                }
                              });
                            },
                            isSelected: e.isChecked,
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
  List<bool> isChecked;

  SingleRowState({
    required this.contents,
    required this.type,
    required this.isChecked,
  });
}
