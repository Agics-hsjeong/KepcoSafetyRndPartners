// ignore_for_file: file_names
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/common/Layout.dart';
import 'package:kepco_safety_iot/widgets/_home/home.dart';
import 'package:kepco_safety_iot/widgets/common/PDFScreen.dart';

import 'package:http/http.dart' as http;

import 'SafePage.dart';
import 'WorkerPage.dart';
import 'EduPage.dart';
import 'WorkPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _controller.dispose();
    // _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Layout(
        title: TextModel.title,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              width * 0.008, width * 0.005, width * 0.008, width * 0.008),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => ShowDialog.serviseDialog(context),
                          child: const MenuArea(
                            titleMenu: "일일안전점검",
                            image: "assets/img/일일안전점검.png",
                            format: 'img',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkPage(),
                              ),
                            );
                          },
                          child: const MenuArea(
                            titleMenu: "공사현장관리",
                            image: "assets/img/공사현장관리.png",
                            format: 'img',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pathPDF = '';
                            getFileFromUrl(
                                    'http://106.255.245.242:28080/site/opert/report/252')
                                .then((f) {
                              setState(() {
                                pathPDF = f.path;
                                _isLoading = true;
                              });
                            });

                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext ctx) {
                                  return PDFScreen();
                                });
                          },
                          child: const MenuArea(
                            titleMenu: "근로자관리",
                            image: "assets/img/근로자관리.png",
                            format: 'img',
                          ),
                        ),
                        InkWell(
                          onTap: () => ShowDialog.serviseDialog(context),
                          child: const MenuArea(
                            titleMenu: "안전장비",
                            image: "assets/img/안전장비.png",
                            format: 'img',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(width * 0.008)),
                  Expanded(
                    flex: 8,
                    // height: MediaQuery.of(context).size.height / 2.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const ExterInfoArea(),
                            SizedBox(
                              height: height * 0.017,
                            ),
                            const EduInfoArea(),
                          ],
                        ),
                        const NoticeArea(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const JobStatArea(),
                            SizedBox(
                              height: height * 0.017,
                            ),
                            const NotifiStatArea(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
