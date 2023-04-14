import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/models.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kepco_safety_worker/Screen/TodoWorkList.dart';

class HomepageList extends StatefulWidget {
  const HomepageList({
    Key? key,
    required this.user,
  }) : super(key: key);

  final String user;

  @override
  State<HomepageList> createState() => _HomepageListState();
}

class _HomepageListState extends State<HomepageList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 0, bottom: 10, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //반갑습니다text
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${widget.user}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '님, 반갑습니다.',
                          style: TextStyle(color: Color(0xff4B4C4D)),
                        ),
                      ],
                    ),
                    Text(
                      '오늘도 안전근무하세요.',
                      style: TextStyle(
                        color: Color(0xff4B4C4D),
                      ),
                    ),
                  ],
                ),
              ),
              //나의 건강 체크
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '나의 건강 체크',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      healthItem(
                        title: '심박수',
                        numb: 74,
                        unit: 'bpm',
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      healthItem(
                        title: '혈압',
                        numb: '133 / 86',
                        unit: 'mmHg',
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Row(
                    children: [
                      healthItem(
                        title: '체온',
                        numb: 36.6,
                        unit: '℃',
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      healthItem(
                        title: '혈중산소포화도',
                        numb: 99,
                        unit: '%',
                      ),
                    ],
                  ),
                ],
              ),
              //오늘의 작업
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '오늘의 작업',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 6, right: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border:
                                Border.all(color: Color(0xffeeeeee), width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('더보기',
                                textScaleFactor: 0.7,
                                style: TextStyle(
                                  color: Color(0xff707070),
                                )),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 9,
                              color: Color(0xff707070),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        DefaultTabController.of(context)?.animateTo(1);
                      },
                    ),
                  ],
                ),
              ),
              //list타일
              Container(
                width: double.infinity,
                height: 75,
                child: Center(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListItem(
                        tit: '배전',
                        subtxt: '강동구 변동5거리 간접활선 공법 (바이패스케이블 공…',
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Color(0xffeeeeee),
              ),
              //공지사항
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '공지사항',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 4, bottom: 4, left: 6, right: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border:
                              Border.all(color: Color(0xffeeeeee), width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('더보기',
                              textScaleFactor: 0.7,
                              style: TextStyle(
                                color: Color(0xff707070),
                              )),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 9,
                            color: Color(0xff707070),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
                child: Center(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListItem(
                        tit: '교육',
                        subtxt: '강동구 변동5거리 간접활선 공법 (바이패스케이블 공…',
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 70,
                child: Center(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListItem(
                        tit: '알림',
                        subtxt: '강동구 변동5거리 간접활선 공법 (바이패스케이블 공…',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.tit,
    required this.subtxt,
  }) : super(key: key);

  final String tit;
  final String subtxt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      dense: true,
      visualDensity: VisualDensity(vertical: 2),
      // leading: SvgPicture.asset(
      //   "assets/svg/$tit.svg",
      //   fit: BoxFit.scaleDown,
      // ),
      leading: Transform.translate(
        offset: Offset(-12, 0),
        child: SvgPicture.asset(
          "assets/svg/$tit.svg",
          fit: BoxFit.scaleDown,
        ),
      ),
      title: Text(
        tit,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtxt,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

//나의건강체크 아이템
// ignore: camel_case_types
class healthItem extends StatelessWidget {
  const healthItem(
      {Key? key, required this.title, required this.numb, required this.unit})
      : super(key: key);

  final String title;
  final dynamic numb;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: title == '심박수'
                  ? ColorSelect.redColor
                  : title == '혈압'
                      ? ColorSelect.blueColor
                      : title == '체온'
                          ? ColorSelect.greenColor
                          : title == '혈중산소포화도'
                              ? ColorSelect.orangeColor
                              : Colors.grey,
              width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: title == '심박수'
                  ? ColorSelect.redColor.withOpacity(0.5)
                  : title == '혈압'
                      ? ColorSelect.blueColor.withOpacity(0.5)
                      : title == '체온'
                          ? ColorSelect.greenColor.withOpacity(0.5)
                          : title == '혈중산소포화도'
                              ? ColorSelect.orangeColor.withOpacity(0.5)
                              : Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  SpinKitPumpingHeart(
                    // color: Colors.red,
                    itemBuilder: (BuildContext context, int index) {
                      return SvgPicture.asset(
                        "assets/svg/$title.svg",
                        fit: BoxFit.scaleDown,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      title,
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: title == '심박수'
                              ? ColorSelect.redColor
                              : title == '혈압'
                                  ? ColorSelect.blueColor
                                  : title == '체온'
                                      ? ColorSelect.greenColor
                                      : title == '혈중산소포화도'
                                          ? ColorSelect.orangeColor
                                          : Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  '$numb',
                  textScaleFactor: FontSize.h4,
                  style: TextStyle(
                      color: title == '심박수'
                          ? ColorSelect.redColor
                          : title == '혈압'
                              ? ColorSelect.blueColor
                              : title == '체온'
                                  ? ColorSelect.greenColor
                                  : title == '혈중산소포화도'
                                      ? ColorSelect.orangeColor
                                      : Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                Padding(padding: EdgeInsets.all(2.5)),
                Text(
                  unit,
                  textScaleFactor: 0.95,
                  style: TextStyle(
                      color: Color(0xff4B4C4D), fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
