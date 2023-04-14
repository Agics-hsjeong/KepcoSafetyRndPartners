import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/models.dart';

class selfDiagnosisResult extends StatelessWidget {
  const selfDiagnosisResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
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
                  ],
                ),
                Padding(padding: EdgeInsets.all(20)),
                Row(
                  children: [
                    Text(
                      '온열질환 취약도',
                      style: TextStyle(
                          color: ColorSelect.blueColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '판별',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Column(
                  children: [
                    resultItem(
                      number: '0 ~ 2',
                    ),
                    resultItem2(
                      tit: '낮음',
                      cont: '온열질환 발생 가능성 적음',
                    )
                  ],
                ),
                Column(
                  children: [
                    resultItem(
                      number: '3 ~ 6',
                    ),
                    resultItem2(
                      tit: '보통',
                      cont: '보통 정도의 주의',
                    )
                  ],
                ),
                Column(
                  children: [
                    resultItem(
                      number: '7',
                    ),
                    resultItem2(
                      tit: '높음',
                      cont: '폭염 시기 높은 주의가 필요함',
                    )
                  ],
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
                onPressed: () {},
                child: Text(
                  "확인",
                  textScaleFactor: FontSize.h7,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class resultItem extends StatelessWidget {
  const resultItem({Key? key, required this.number}) : super(key: key);
  final dynamic number;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '\'예\'의 갯수 : ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xff4B4C4D),
          ),
        ),
        Text(
          '$number',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: number == '0 ~ 2'
                  ? ColorSelect.greenColor
                  : number == '3 ~ 6'
                      ? ColorSelect.blueColor
                      : number == '7'
                          ? ColorSelect.redColor
                          : Colors.black),
        ),
        Text(
          '개',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xff4B4C4D),
          ),
        ),
        number == '7'
            ? Text(
                ' 이상',
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            : Container()
      ],
    );
  }
}

class resultItem2 extends StatelessWidget {
  const resultItem2({Key? key, required this.tit, required this.cont})
      : super(key: key);
  final String tit;
  final String cont;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 30),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color(0xffF7F7F7),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/$tit.svg",
                  fit: BoxFit.scaleDown,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '$tit',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: tit == '낮음'
                            ? ColorSelect.greenColor
                            : tit == '보통'
                                ? ColorSelect.blueColor
                                : tit == '높음'
                                    ? ColorSelect.redColor
                                    : Colors.black),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Text('$cont'),
            )
          ],
        ),
      ),
    );
  }
}
