import 'package:flutter/material.dart';
import 'package:kepco_safety_worker/Screen/TodoWorkList.dart';
import 'package:kepco_safety_worker/Screen/Access.dart';
import 'package:kepco_safety_worker/Screen/HealthTabPage.dart';
import 'package:kepco_safety_worker/Screen/educationPage.dart';

import '../Constant/Constant.dart';
import '../models/models.dart';
import 'HomepageList.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      routes: <String, WidgetBuilder>{
        HOME_SCREEN: (BuildContext context) => const HomeScreen(),
      },
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String TAB_1 = "홈";
  static const String TAB_2 = "작업";
  static const String TAB_3 = "출입";
  static const String TAB_4 = "건강";
  static const String TAB_5 = "교육";

  String? selectedTab;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Logo",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
            )
          ],
          bottom: TabBar(tabs: [
            Tab(
              icon: Text(
                "홈",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Tab(
              icon: Text(
                "작업",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Tab(
              icon: Text(
                "출입",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Tab(
              icon: Text(
                "건강",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Tab(
              icon: Text(
                "교육",
                style: TextStyle(color: Colors.black87),
              ),
            )
          ]),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: TabBarView(
          children: [
            HomepageList(user: '홍길동'),
            TodoWorkList(),
            Access(),
            HealthTabPage(),
            EducationPage(),
          ],
        ),
        // body: Column(
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         GestureDetector(
        //           onTap: () {
        //             setState(() => selectedTab = TAB_1);
        //             // workToday();
        //           },
        //           child: Container(
        //             // padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        //             decoration: selectedTab == TAB_1
        //                 ? BoxDecoration(
        //                     border: Border(
        //                       bottom: BorderSide(
        //                           width: 3,
        //                           color: Color.fromRGBO(69, 94, 238, 1)),
        //                     ),
        //                   )
        //                 : null,
        //             child: Text(
        //               TAB_1,
        //               style: TextStyle(
        //                 fontSize: 12,
        //                 fontWeight: selectedTab == TAB_1 ? FontWeight.bold : null,
        //                 color:
        //                     selectedTab == TAB_1 ? Colors.black : Colors.black87,
        //               ),
        //             ),
        //           ),
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             setState(() => selectedTab = TAB_2);
        //             // workToday();
        //           },
        //           child: Container(
        //             // padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        //             decoration: selectedTab == TAB_2
        //                 ? BoxDecoration(
        //                     border: Border(
        //                       bottom: BorderSide(
        //                           width: 3,
        //                           color: Color.fromRGBO(69, 94, 238, 1)),
        //                     ),
        //                   )
        //                 : null,
        //             child: Text(
        //               TAB_2,
        //               style: TextStyle(
        //                 fontSize: 12,
        //                 fontWeight: selectedTab == TAB_2 ? FontWeight.bold : null,
        //                 color:
        //                     selectedTab == TAB_2 ? Colors.black : Colors.black87,
        //               ),
        //             ),
        //           ),
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             setState(() => selectedTab = TAB_3);
        //             // workToday();
        //           },
        //           child: Container(
        //             // padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        //             decoration: selectedTab == TAB_3
        //                 ? BoxDecoration(
        //                     border: Border(
        //                       bottom: BorderSide(
        //                           width: 3,
        //                           color: Color.fromRGBO(69, 94, 238, 1)),
        //                     ),
        //                   )
        //                 : null,
        //             child: Text(
        //               TAB_3,
        //               style: TextStyle(
        //                 fontSize: 12,
        //                 fontWeight: selectedTab == TAB_3 ? FontWeight.bold : null,
        //                 color:
        //                     selectedTab == TAB_3 ? Colors.black : Colors.black87,
        //               ),
        //             ),
        //           ),
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             setState(() => selectedTab = TAB_4);
        //             // workToday();
        //           },
        //           child: Container(
        //             // padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        //             decoration: selectedTab == TAB_4
        //                 ? BoxDecoration(
        //                     border: Border(
        //                       bottom: BorderSide(
        //                           width: 3,
        //                           color: Color.fromRGBO(69, 94, 238, 1)),
        //                     ),
        //                   )
        //                 : null,
        //             child: Text(
        //               TAB_4,
        //               style: TextStyle(
        //                 fontSize: 12,
        //                 fontWeight: selectedTab == TAB_4 ? FontWeight.bold : null,
        //                 color:
        //                     selectedTab == TAB_4 ? Colors.black : Colors.black87,
        //               ),
        //             ),
        //           ),
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             setState(() => selectedTab = TAB_5);
        //             // workToday();
        //           },
        //           child: Container(
        //             // padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        //             decoration: selectedTab == TAB_5
        //                 ? BoxDecoration(
        //                     border: Border(
        //                       bottom: BorderSide(
        //                           width: 3,
        //                           color: Color.fromRGBO(69, 94, 238, 1)),
        //                     ),
        //                   )
        //                 : null,
        //             child: Text(
        //               TAB_5,
        //               style: TextStyle(
        //                 fontSize: 12,
        //                 fontWeight: selectedTab == TAB_5 ? FontWeight.bold : null,
        //                 color:
        //                     selectedTab == TAB_5 ? Colors.black : Colors.black87,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
