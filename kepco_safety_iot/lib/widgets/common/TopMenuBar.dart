import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/designModel.dart';
import 'package:kepco_safety_iot/models/timerModel.dart';
import 'package:kepco_safety_iot/models/weatherModel.dart';
import 'package:kepco_safety_iot/models/statusModel.dart';
import 'package:kepco_safety_iot/pages/HomePage.dart';

class TopMenuBar extends StatefulWidget {
  const TopMenuBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<TopMenuBar> createState() => _TopMenuBarState();
}

class _TopMenuBarState extends State<TopMenuBar> {
  StreamController<String> streamController = StreamController<String>();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      streamController.add(WeatherData.locationTemp);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        width * 0.008,
        width * 0.01,
        width * 0.008,
        width * 0.008,
      ),
      child: AppBar(
        shadowColor: ColorSelect.shadowColor,
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 2.5,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        // leading: Builder(builder: (context) {
        //   return IconButton(
        //     icon: Icon(
        //       Icons.density_medium_rounded,
        //       size: width * 0.016,
        //     ),
        //     color: ColorSelect.blueColor,
        //     onPressed: () => Scaffold.of(context).openDrawer(),
        //   );
        // }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: width * 0.01, right: width * 0.008),
              child: Image.asset(
                "assets/img/logo.png",
                fit: BoxFit.fill,
                width: width * 0.018,
                height: height * 0.02,
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage())),
              child: Text(
                '${widget.title}',
                style: TextStyle(
                  color: ColorSelect.blueColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Wemakeprice',
                  fontSize: width * 0.012,
                ),
              ),
            ),
            const timerModel(),
            // Padding(padding: EdgeInsets.only(left: width * 0.01)),
            StreamBuilder(
              stream: streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: [
                      Icon(
                        Icons.place_rounded,
                        color: ColorSelect.skyColor,
                        size: width * 0.012,
                      ),
                      Text(
                        ' ${snapshot.data}',
                        // ' 광주광역시 서구 상무누리로 30 (김대중컨벤션센터)',
                        style: TextStyle(
                          color: ColorSelect.headTextColor,
                          fontWeight: FontWeight.normal,
                          fontSize: width * 0.01,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    // widthFactor: 5.0,
                    child: SizedBox(
                      // width: width * 0.08,
                      // height: height * 0.08,
                      child: CircularProgressIndicator(
                        color: ColorSelect.blueColor,
                        strokeWidth: 2.0,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "${Status.user["userNm"]} 님",
                        style: TextStyle(
                          color: ColorSelect.headTextColor,
                          fontSize: width * 0.009,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "안녕하세요.",
                      style: TextStyle(
                        color: ColorSelect.grayColor6,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.009,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.01),
                  child: Icon(
                    Icons.notifications_rounded,
                    color: ColorSelect.grayColor,
                    size: width * 0.015,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.01),
                  child: Icon(
                    Icons.settings,
                    color: ColorSelect.grayColor,
                    size: width * 0.015,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.01),
                  child: Icon(
                    Icons.person,
                    color: ColorSelect.grayColor,
                    size: width * 0.015,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.01, right: width * 0.01),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.logout_rounded,
                      color: ColorSelect.grayColor,
                      size: width * 0.015,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );
  }
}
