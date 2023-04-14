import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/models/models.dart';

class DrawerBox extends StatefulWidget {
  const DrawerBox({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerBox> createState() => _DrawerBoxState();
}

class _DrawerBoxState extends State<DrawerBox> {
  bool tileExpanded1 = false;
  bool tileExpanded2 = false;
  bool tileExpanded3 = false;
  bool tileExpanded4 = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 450,
      backgroundColor: ColorSelect.blueColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 50, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/로고_흰색.png",
                  fit: BoxFit.fill,
                  width: 40,
                  height: 25,
                ),
                const Text(
                  "  공사현장 위험성평가솔루션",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/img/사용자 아이콘.png'),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    "홍길동",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    "현장 안전관리자",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      color: Color.fromARGB(235, 150, 165, 249),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Container(
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading: Image.asset(
                      "assets/img/메뉴_대쉬보드.png",
                      height: 30,
                    ),
                    title: Text(
                      "대쉬 보드",
                      style: TextStyle(
                        fontSize: 21,
                        color: Color.fromARGB(235, 150, 165, 249),
                      ),
                    ),
                  ),
                  ExpansionTile(
                    backgroundColor: Colors.white,
                    leading: Image.asset(
                      tileExpanded1
                          ? "assets/img/메뉴_관리_선택됨.png"
                          : "assets/img/메뉴_관리.png",
                      height: 30,
                    ),
                    title: Text(
                      "관리",
                      style: TextStyle(
                        fontSize: 21,
                        color: tileExpanded1
                            ? ColorSelect.blueColor
                            : Color.fromARGB(235, 150, 165, 249),
                      ),
                    ),
                    trailing: Icon(
                      tileExpanded1 ? Icons.arrow_drop_up_rounded : null,
                      size: 40.0,
                      color: ColorSelect.blueColor,
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "공정 관리",
                          style: TextStyle(
                            fontSize: 21,
                            color: ColorSelect.blueColor,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "작업 관리",
                          style: TextStyle(
                            fontSize: 21,
                            color: ColorSelect.blueColor,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "근로자 관리",
                          style: TextStyle(
                            fontSize: 21,
                            color: ColorSelect.blueColor,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "장애이력 관리",
                          style: TextStyle(
                            fontSize: 21,
                            color: ColorSelect.blueColor,
                          ),
                        ),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() => tileExpanded1 = expanded);
                    },
                  ),
                  ExpansionTile(
                    backgroundColor: Colors.white,
                    leading: Image.asset(
                      tileExpanded2
                          ? "assets/img/메뉴_보고서_선택됨.png"
                          : "assets/img/메뉴_보고서.png",
                      height: 30,
                    ),
                    title: Text(
                      "보고서",
                      style: TextStyle(
                        fontSize: 21,
                        color: tileExpanded2
                            ? ColorSelect.blueColor
                            : Color.fromARGB(235, 150, 165, 249),
                      ),
                    ),
                    trailing: Icon(
                      tileExpanded2 ? Icons.arrow_drop_up_rounded : null,
                      size: 40.0,
                      color: ColorSelect.blueColor,
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "보고서 관리",
                          style: TextStyle(
                            fontSize: 21,
                            color: ColorSelect.blueColor,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "일일안전점검",
                          style: TextStyle(
                            fontSize: 21,
                            color: ColorSelect.blueColor,
                          ),
                        ),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() => tileExpanded2 = expanded);
                    },
                  ),
                  ExpansionTile(
                      leading: Image.asset(
                        "assets/img/메뉴_통계분석.png",
                        height: 30,
                      ),
                      title: Text(
                        "통계 분석",
                        style: TextStyle(
                          fontSize: 21,
                          color: Color.fromARGB(235, 150, 165, 249),
                        ),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text("data"),
                        ),
                      ]),
                  ExpansionTile(
                      leading: Image.asset(
                        "assets/img/메뉴_설정.png",
                        height: 30,
                      ),
                      title: Text(
                        "설정",
                        style: TextStyle(
                          fontSize: 21,
                          color: Color.fromARGB(235, 150, 165, 249),
                        ),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text("data"),
                        ),
                      ]),
                  ListTile(
                    leading: Image.asset(
                      "assets/img/메뉴_로그아웃.png",
                      height: 30,
                    ),
                    title: Text(
                      "로그아웃",
                      style: TextStyle(
                        fontSize: 21,
                        color: Color.fromARGB(235, 150, 165, 249),
                      ),
                    ),
                    onTap: () {
                      // print("object");
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
