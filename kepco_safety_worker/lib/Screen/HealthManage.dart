import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/models.dart';

class HealthManage extends StatefulWidget {
  const HealthManage({Key? key}) : super(key: key);

  @override
  State<HealthManage> createState() => _HealthManageState();
}

class _HealthManageState extends State<HealthManage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "신체정보",
                    textScaleFactor: FontSize.h7,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: MediaQuery.of(context).size.height * 0.028,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(2),
                            minimumSize: Size.zero,
                            primary: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "정보변경",
                              textScaleFactor: FontSize.h8,
                              style: TextStyle(color: ColorSelect.greyolor),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 10,
                              color: ColorSelect.greyolor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: ColorSelect.lightGreyColor, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/신장.svg",
                              height: 13,
                              width: 30,
                              fit: BoxFit.scaleDown,
                            ),
                            Text(
                              " 신장",
                              textScaleFactor: FontSize.h8,
                              style: TextStyle(
                                  color: Color.fromRGBO(75, 76, 78, 1)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "183",
                              textScaleFactor: FontSize.h7,
                              style: TextStyle(
                                  color: Color.fromRGBO(75, 76, 78, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                " CM",
                                textScaleFactor: FontSize.h8,
                                style: TextStyle(
                                  color: Color.fromRGBO(75, 76, 78, 1),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: ColorSelect.lightGreyColor, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/체중.svg",
                              height: 13,
                              width: 30,
                              fit: BoxFit.scaleDown,
                            ),
                            Text(
                              " 체중",
                              textScaleFactor: FontSize.h8,
                              style: TextStyle(
                                  color: Color.fromRGBO(75, 76, 78, 1)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "92",
                              textScaleFactor: FontSize.h7,
                              style: TextStyle(
                                  color: Color.fromRGBO(75, 76, 78, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                " KG",
                                textScaleFactor: FontSize.h8,
                                style: TextStyle(
                                  color: Color.fromRGBO(75, 76, 78, 1),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: ColorSelect.lightGreyColor, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/bmi.svg",
                              height: 13,
                              width: 10,
                              fit: BoxFit.scaleDown,
                            ),
                            Text(
                              "BMI",
                              textScaleFactor: FontSize.h8,
                              style: TextStyle(
                                  color: Color.fromRGBO(75, 76, 78, 1)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "27.5",
                              textScaleFactor: FontSize.h7,
                              style: TextStyle(
                                  color: Color.fromRGBO(75, 76, 78, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                " BMI",
                                textScaleFactor: FontSize.h8,
                                style: TextStyle(
                                  color: Color.fromRGBO(75, 76, 78, 1),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "나의 건강 체크",
                    textScaleFactor: FontSize.h7,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: MediaQuery.of(context).size.height * 0.026,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: ColorSelect.lightGreyColor, width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "2022-10-01 13:55",
                        textScaleFactor: FontSize.h8,
                        style: TextStyle(color: ColorSelect.greyolor),
                      ),
                    ),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.all(15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 30, left: 20, right: 20),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: ColorSelect.pinkColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: ColorSelect.pinkColor.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "신장",
                          textScaleFactor: FontSize.h7,
                          style: TextStyle(
                              color: ColorSelect.pinkColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "183",
                              textScaleFactor: FontSize.h2,
                              style: TextStyle(
                                  color: ColorSelect.pinkColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Text(
                                " CM",
                                textScaleFactor: FontSize.h6,
                                style: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 1)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 10, left: 20, right: 20),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: ColorSelect.blueColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: ColorSelect.blueColor.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "혈압",
                          textScaleFactor: FontSize.h7,
                          style: TextStyle(
                              color: ColorSelect.blueColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "133",
                                  textScaleFactor: FontSize.h2,
                                  style: TextStyle(
                                      color: ColorSelect.blueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    " mmHg",
                                    textScaleFactor: FontSize.h6,
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(112, 112, 112, 1)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "86",
                                  textScaleFactor: FontSize.h2,
                                  style: TextStyle(
                                      color: ColorSelect.blueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    " mmHg",
                                    textScaleFactor: FontSize.h6,
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(112, 112, 112, 1)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 30, left: 20, right: 20),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: ColorSelect.lightGreenColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: ColorSelect.lightGreenColor.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "체온",
                          textScaleFactor: FontSize.h7,
                          style: TextStyle(
                              color: ColorSelect.lightGreenColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: const [
                            Text(
                              "36.6",
                              textScaleFactor: FontSize.h2,
                              style: TextStyle(
                                  color: ColorSelect.lightGreenColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                " ℃",
                                textScaleFactor: FontSize.h6,
                                style: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 1)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 30, left: 20, right: 20),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: ColorSelect.orangeColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: ColorSelect.orangeColor.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "혈중산소포화도",
                          textScaleFactor: FontSize.h7,
                          style: TextStyle(
                              color: ColorSelect.orangeColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: const [
                            Text(
                              "99",
                              textScaleFactor: FontSize.h2,
                              style: TextStyle(
                                  color: ColorSelect.orangeColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Text(
                                " %",
                                textScaleFactor: FontSize.h6,
                                style: TextStyle(
                                    color: Color.fromRGBO(112, 112, 112, 1)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
