import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';

class TableBox extends StatefulWidget {
  const TableBox({Key? key, this.title = '', required this.list})
      : super(key: key);
  final String title;
  final List<SingleRowState> list;

  @override
  State<TableBox> createState() => _TableBoxState();
}

class _TableBoxState extends State<TableBox> {
  void isCheck() {
    List.generate(widget.list.length, (index) {
      if (!widget.list[index].isChecked[0]) {
        setState(() {
          isNext = false;
        });
      }
    });
  }

  @override
  void initState() {
    isCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Column(children: [
      widget.title != ''
          ? Padding(
              padding:
                  EdgeInsets.only(top: height * 0.006, bottom: height * 0.01),
              child: Align(
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
            )
          : SizedBox.shrink(),
      Column(
        children: widget.list
            .map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.03, bottom: height * 0.03),
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
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
                          Text('확인',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.011,
                                fontFamily: 'SUIT',
                              )),
                          Text('해당없음',
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
                          isCheck();
                        },
                        isSelected: e.isChecked,
                      ),
                    ),
                  ],
                ))
            .toList(),
      )
    ]);
  }
}

class SingleRowState {
  String contents;
  List<bool> isChecked;

  SingleRowState({
    required this.contents,
    required this.isChecked,
  });
}
