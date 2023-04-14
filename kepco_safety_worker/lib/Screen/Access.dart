import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kepco_safety_worker/Screen/Qrview.dart';
import '../models/models.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Access extends StatefulWidget {
  const Access({Key? key}) : super(key: key);

  @override
  State<Access> createState() => _AccessState();
}

class _AccessState extends State<Access> {
  String qrResult = '';
  List<String> chkItems = List.empty(growable: true);
  List<String> empty = List.empty(growable: true);
  String? chkValue;
  bool isChk = false;
  bool workOn = false;
  bool workOff = false;
  var now;

  @override
  void initState() {
    chkItems = [
      '대전시 대덕구 중리동 25-2 간접활선 D58 공정',
      '대전시 유성구 지족로 2-1 배전 D56 공정',
      '대전시 유성구 지족로 355 간접활선 D57 공정',
      '대전시 유성구 지족로 355 배전 D56 공정',
    ];
    empty = [
      '',
    ];

    now = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.05,
      height: MediaQuery.of(context).size.height * 0.05,
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.png"),
          isChk == false
              ? Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  width: MediaQuery.of(context).size.width * 0.53,
                  height: MediaQuery.of(context).size.height * 0.035,
                  decoration: BoxDecoration(
                      color: ColorSelect.babyPinkColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "QR코드로 안전모 연동 필요",
                      textScaleFactor: FontSize.h7,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: MediaQuery.of(context).size.height * 0.04,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: ColorSelect.lightblueColor2,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/버튼_안전모.svg",
                        height: 15,
                        fit: BoxFit.scaleDown,
                      ),
                      Text(
                        qrResult + " 연동완료",
                        textScaleFactor: FontSize.h7,
                        style: TextStyle(
                            color: ColorSelect.blueColor,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        child: SvgPicture.asset(
                          "assets/svg/다시하기.svg",
                          height: 25,
                          fit: BoxFit.scaleDown,
                        ),
                        onTap: () {
                          setState(() {
                            isChk = !isChk;
                          });
                        },
                      ),
                    ],
                  ),
                ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.05,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                hint: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Text(
                          '공사명을 선택해주세요.',
                          textScaleFactor: FontSize.h8,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                items: isChk
                    ? chkItems
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                item,
                                textScaleFactor: FontSize.h8,
                                style: const TextStyle(),
                              ),
                            ),
                          ),
                        )
                        .toList()
                    : empty
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: null,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                item,
                                textScaleFactor: FontSize.h8,
                                style: const TextStyle(),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                value: isChk ? chkValue : null,
                onChanged: isChk
                    ? (value) {
                        setState(
                          () {
                            chkValue = value as String;
                          },
                        );
                      }
                    : null,
                focusColor: Color.fromRGBO(218, 223, 252, 1),
                buttonHeight: 60,
                buttonWidth: 80,
                itemHeight: 40,
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                ),
                dropdownPadding: null,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          isChk
              ? Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.06,
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: workOn
                                ? Colors.white
                                : ColorSelect.backgroundColor,
                            border: Border.all(
                                color: workOn
                                    ? ColorSelect.blueColor
                                    : ColorSelect.backgroundColor)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "출입",
                                textScaleFactor: FontSize.h7,
                                style: TextStyle(
                                    color: workOn
                                        ? ColorSelect.blueColor
                                        : ColorSelect.greyolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              workOn
                                  ? Text(
                                      DateFormat('yyy-MM-d    HH:mm:s')
                                          .format(now),
                                      textScaleFactor: FontSize.h7,
                                    )
                                  : Text("")
                            ]),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.06,
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: workOff
                                ? Colors.white
                                : ColorSelect.backgroundColor,
                            border: Border.all(
                                color: workOff
                                    ? Colors.red
                                    : ColorSelect.backgroundColor)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "퇴장",
                                textScaleFactor: FontSize.h7,
                                style: TextStyle(
                                    color: workOff
                                        ? Colors.red
                                        : ColorSelect.greyolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              workOff
                                  ? Text(
                                      DateFormat('yyy-MM-dd    HH:mm:s')
                                          .format(now),
                                      textScaleFactor: FontSize.h7,
                                    )
                                  : Text("")
                            ]),
                      )
                    ],
                  ),
                )
              : Container(),
          Spacer(),
          isChk
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.06,
                      margin: EdgeInsets.only(bottom: 15),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: ColorSelect.blueColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            setState(() {
                              workOn = !workOn;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/출입.svg",
                                height: 20,
                                fit: BoxFit.scaleDown,
                              ),
                              Text(
                                "  출입",
                                textScaleFactor: FontSize.h8,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.06,
                      margin: EdgeInsets.only(bottom: 15),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.red)))),
                          onPressed: () {
                            setState(() {
                              workOff = !workOff;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/퇴장.svg",
                                height: 20,
                                fit: BoxFit.scaleDown,
                              ),
                              Text(
                                "  퇴장",
                                textScaleFactor: FontSize.h8,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ],
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.06,
                    margin: EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: ColorSelect.blueColor),
                        onPressed: _onPressed,
                        child: Text(
                          "안전모 연동하기",
                          textScaleFactor: FontSize.h7,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                )
        ],
      ),
    );
  }

  void _onPressed() async {
    dynamic result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Qrview();
    }));

    if (result != null) {
      setState(() {
        //qr스캐너에서 받은 결과값
        qrResult = result.toString();
        isChk = !isChk;
      });
    }
  }
}
