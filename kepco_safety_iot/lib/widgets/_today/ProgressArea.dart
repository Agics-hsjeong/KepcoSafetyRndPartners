import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/designModel.dart';
import 'dart:math' as math;
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/pages/HomePage.dart';

import 'ProgressTimeline.dart';

class ProgressArea extends StatefulWidget {
  ProgressArea({
    Key? key,
    required this.cnt,
  }) : super(key: key);

  final Map cnt;

  // final int stepCount;
  final _ProgressAreaState state = _ProgressAreaState();

  void setOpen() {
    state.setOpen();
  }

  @override
  _ProgressAreaState createState() => state;
}

class _ProgressAreaState extends State<ProgressArea>
    with SingleTickerProviderStateMixin {
  ProgressTimeline? screenProgress;
  Network network = Network();
  late TabController tabController;
  List worksData = [];
  bool isStop = false;
  int selectedTab = 0;

  List<bool> _selected = [];

  List<SingleState> allStages = List.empty(growable: true);
  List<Tab> _tabs = [];

  Future<dynamic> _getSingleStage() async {
    if (screenProgress != null) {
      setState(() {
        allStages.clear();
        screenProgress = null;
      });
    }

    // print('===>selectedTab ${selectedTab}');
    // print('===>selectedTab ${worksData[selectedTab]}');

    for (var data in worksData[selectedTab]['cntwrkTyLst']) {
      // print('===>323232 ${widget.cnt['cntwrkTyCd'][selectedTab]}');
      Map state = {
        'cntwrkSeq': widget.cnt['cntwrkSeq'],
        'cntwrkTySeq': worksData[selectedTab]['cntwrkTySeq'],
        'opertSeq': widget.cnt['opertSeq'],
        'cntwrkTyCd': widget.cnt['cntwrkTyCd'][selectedTab],
        'order': data['ORDER'],
        'code': data['CODE'],
      };
      allStages.add(SingleState(
        state: state,
        stateTitle: data['NM'],
        titleNumber: data['ORDER'].toString(),
        depthLevel: data['DEPTH'],
        opertProcssCode: data['CODE'],
        type: [data['type'].toString()],
      ));
    }

    setState(() {
      screenProgress = ProgressTimeline(
        states: allStages,
      );
    });
    // screenProgress!.initStage();
  }

  Future<dynamic> _getAllStages() async {
    // print('===> ${widget.cnt}');
    Map result = await network.getProc(widget.cnt['opertSeq']);

    // print('===> $result');
    // print('===> ${result['cntwrkTyList'].length}');

    setState(() {
      worksData = result['cntwrkTyList'];
      _tabs = List.generate(
          worksData.length,
          (int index) => Tab(
                  child: Text(
                worksData[index]['cntwrkTyNm'],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.012,
                ),
              )));
      tabController = TabController(length: _tabs.length, vsync: this);
    });

    _getSingleStage();
  }

  void setOpen() {
    setState(() {
      Status.isOpen;
    });
    screenProgress!.setOpen();
  }

  @override
  void initState() {
    _getAllStages();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Status.isOpen ? width * 0.595 : width * 0.20,
          height: height * 0.03,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "현재 공종 진행 상황",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.012,
                        fontFamily: 'SUIT',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.38,
                height: height * 0.03,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '작업별 체크 포인트',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.012,
                        fontFamily: 'SUIT',
                      ),
                    ),
                    SizedBox(
                      width: width * 0.14,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              elevation: 11,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              shadowColor: Color.fromRGBO(135, 135, 135, 0.4),
                            ),
                            onPressed: () {
                              setState(() {
                                isStop = !isStop;
                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return AlertDialog(
                                //       backgroundColor: Colors.transparent,
                                //       elevation: 0.0,
                                //       titlePadding: EdgeInsets.only(
                                //           left: 10.0, right: 10.0),
                                //       content: Center(
                                //         child: SizedBox(
                                //           width: width * 0.3,
                                //           height: height * 0.4,
                                //           child: Stack(
                                //             children: [
                                //               Positioned(
                                //                   left: width * 0.05,
                                //                   top: height * 0.09,
                                //                   child: Container(
                                //                     width: width * 0.2,
                                //                     height: height * 0.25,
                                //                     decoration: BoxDecoration(
                                //                         borderRadius:
                                //                             BorderRadius
                                //                                 .circular(10),
                                //                         color: ColorSelect
                                //                             .redColor2),
                                //                   )),
                                //               Align(
                                //                 alignment: Alignment.center,
                                //                 child: Container(
                                //                     padding: EdgeInsets.all(
                                //                         width * 0.01),
                                //                     width: width * 0.22,
                                //                     height: height * 0.25,
                                //                     decoration: BoxDecoration(
                                //                       borderRadius:
                                //                           BorderRadius.circular(
                                //                               10),
                                //                       boxShadow: const [],
                                //                       color: Colors.white,
                                //                     ),
                                //                     child: Column(
                                //                       mainAxisAlignment:
                                //                           MainAxisAlignment
                                //                               .center,
                                //                       crossAxisAlignment:
                                //                           CrossAxisAlignment
                                //                               .center,
                                //                       children: [
                                //                         Padding(
                                //                           padding:
                                //                               EdgeInsets.only(
                                //                                   top: height *
                                //                                       0.05,
                                //                                   bottom:
                                //                                       height *
                                //                                           0.02),
                                //                           child: Text(
                                //                             '근로자 작업 중지 요청',
                                //                             style: TextStyle(
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .w600,
                                //                               fontSize:
                                //                                   width * 0.013,
                                //                               fontFamily:
                                //                                   'SUIT',
                                //                             ),
                                //                           ),
                                //                         ),
                                //                         Padding(
                                //                           padding:
                                //                               EdgeInsets.only(
                                //                                   bottom:
                                //                                       height *
                                //                                           0.01),
                                //                           child: Row(
                                //                             mainAxisAlignment:
                                //                                 MainAxisAlignment
                                //                                     .center,
                                //                             children: [
                                //                               Text(
                                //                                 '작업자3',
                                //                                 style:
                                //                                     TextStyle(
                                //                                   color: Color
                                //                                       .fromRGBO(
                                //                                           103,
                                //                                           103,
                                //                                           103,
                                //                                           1),
                                //                                   fontWeight:
                                //                                       FontWeight
                                //                                           .w500,
                                //                                   fontSize:
                                //                                       width *
                                //                                           0.011,
                                //                                   fontFamily:
                                //                                       'SUIT',
                                //                                 ),
                                //                               ),
                                //                               Padding(
                                //                                 padding:
                                //                                     const EdgeInsets
                                //                                             .only(
                                //                                         left:
                                //                                             10.0),
                                //                                 child: Text(
                                //                                   '홍길동',
                                //                                   style:
                                //                                       TextStyle(
                                //                                     color: Color
                                //                                         .fromRGBO(
                                //                                             103,
                                //                                             103,
                                //                                             103,
                                //                                             1),
                                //                                     fontWeight:
                                //                                         FontWeight
                                //                                             .w300,
                                //                                     fontSize:
                                //                                         width *
                                //                                             0.011,
                                //                                     fontFamily:
                                //                                         'SUIT',
                                //                                   ),
                                //                                 ),
                                //                               ),
                                //                             ],
                                //                           ),
                                //                         ),
                                //                         Spacer(),
                                //                         SizedBox(
                                //                           height: 50,
                                //                           child: TextButton(
                                //                             style: ButtonStyle(
                                //                                 shape:
                                //                                     MaterialStateProperty
                                //                                         .all(
                                //                                   RoundedRectangleBorder(
                                //                                     borderRadius:
                                //                                         BorderRadius.circular(
                                //                                             10),
                                //                                   ),
                                //                                 ),
                                //                                 foregroundColor:
                                //                                     MaterialStateProperty
                                //                                         .all(Colors
                                //                                             .black),
                                //                                 backgroundColor:
                                //                                     MaterialStateProperty.all(
                                //                                         ColorSelect
                                //                                             .redColor)),
                                //                             child: Text(
                                //                               "확인",
                                //                               style: TextStyle(
                                //                                 color: Colors
                                //                                     .white,
                                //                                 fontWeight:
                                //                                     FontWeight
                                //                                         .w600,
                                //                                 fontSize:
                                //                                     width *
                                //                                         0.011,
                                //                                 fontFamily:
                                //                                     'SUIT',
                                //                               ),
                                //                             ),
                                //                             onPressed: () {
                                //                               Navigator.of(
                                //                                       context)
                                //                                   .pop();
                                //                             },
                                //                           ),
                                //                         ),
                                //                       ],
                                //                     )),
                                //               ),
                                //               Positioned(
                                //                   top: height * 0.015,
                                //                   left: width * 0.1,
                                //                   child: Container(
                                //                     width: width * 0.1,
                                //                     height: height * 0.1,
                                //                     padding: EdgeInsets.all(
                                //                         width * 0.004),
                                //                     decoration: BoxDecoration(
                                //                         color: Colors.white,
                                //                         shape: BoxShape.circle),
                                //                     child: Container(
                                //                       width: width * 0.08,
                                //                       height: height * 0.08,
                                //                       decoration: BoxDecoration(
                                //                         color: ColorSelect
                                //                             .redColor2,
                                //                         shape: BoxShape.circle,
                                //                         boxShadow: [
                                //                           BoxShadow(
                                //                             color: Color
                                //                                     .fromRGBO(
                                //                                         255,
                                //                                         0,
                                //                                         0,
                                //                                         0.3)
                                //                                 .withOpacity(1),
                                //                             spreadRadius: 1,
                                //                             blurRadius: 1,
                                //                           ),
                                //                         ],
                                //                       ),
                                //                       child: Icon(
                                //                         Icons
                                //                             .front_hand_rounded,
                                //                         size: width * 0.03,
                                //                         color: Colors.white,
                                //                       ),
                                //                     ),
                                //                   ))
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // );
                              });
                            },
                            icon: Icon(
                              isStop ? Icons.play_arrow : Icons.pause,
                              color: ColorSelect.textredColor,
                              size: width * 0.013,
                            ),
                            label: Text(
                              isStop ? '다시시작' : '일시정지',
                              style: TextStyle(
                                color: ColorSelect.textredColor,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.008,
                                fontFamily: 'SUIT',
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              elevation: 11,
                              backgroundColor: ColorSelect.redColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              shadowColor: Color.fromRGBO(135, 135, 135, 0.4),
                            ),
                            onPressed: () {
                              setState(() {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      elevation: 0.0,
                                      // titlePadding: EdgeInsets.only(left: 10.0, right: 10.0),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            child: SizedBox(
                                              width: width * 0.11,
                                              height: height * 0.14,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: height * 0.02),
                                                    width: width * 0.08,
                                                    height: height * 0.08,
                                                    decoration: BoxDecoration(
                                                        color: ColorSelect
                                                            .backgroundColor2,
                                                        shape: BoxShape.circle),
                                                    child: Transform(
                                                      alignment:
                                                          Alignment.center,
                                                      transform:
                                                          Matrix4.rotationY(
                                                              math.pi),
                                                      child: Icon(
                                                        Icons.logout_rounded,
                                                        color: ColorSelect
                                                            .redColor,
                                                        size: width * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "홈으로 이동",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: width * 0.008,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomePage()));
                                            },
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.all(width * 0.1),
                                            width: 1,
                                            height: height * 0.1,
                                            color: ColorSelect.grayColor7,
                                          ),
                                          InkWell(
                                            child: SizedBox(
                                              width: width * 0.11,
                                              height: height * 0.14,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: height * 0.02),
                                                    width: width * 0.08,
                                                    height: height * 0.08,
                                                    decoration: BoxDecoration(
                                                        color: ColorSelect
                                                            .backgroundColor3,
                                                        shape: BoxShape.circle),
                                                    child: Icon(
                                                      Icons.call,
                                                      color: ColorSelect
                                                          .greenColor,
                                                      size: width * 0.02,
                                                    ),
                                                  ),
                                                  Text(
                                                    "관리자 전화 연결",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: width * 0.008,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "취소",
                                              style: TextStyle(
                                                color: ColorSelect.grayColor7,
                                                fontWeight: FontWeight.w300,
                                                fontSize: width * 0.009,
                                                fontFamily: 'SUIT',
                                              ),
                                            ))
                                      ],
                                    );
                                  },
                                );
                              });
                            },
                            icon: Icon(
                              Icons.power_settings_new,
                              color: Colors.white,
                              size: width * 0.013,
                            ),
                            label: Text(
                              '작업중지권',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.008,
                                fontFamily: 'SUIT',
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: height * 0.85,
          child: Stack(
            children: [
              Positioned(
                // top: 0,
                child: worksData.isNotEmpty
                    ? Container(
                        height: height * 0.06,
                        decoration: const BoxDecoration(
                          color: ColorSelect.grayColor8,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                        ),
                        child: TabBar(
                          controller: tabController,
                          indicator: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                              color: ColorSelect.blueColor),
                          labelColor: Colors.white,
                          unselectedLabelColor: ColorSelect.grayColor2,
                          tabs: _tabs,
                          onTap: (value) {
                            setState(() {
                              selectedTab = value;
                            });
                            _getSingleStage();
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Positioned(
                top: height * 0.05,
                child: Container(
                  width: Status.isOpen ? width * 0.59 : width * 0.20,
                  height: height * 0.79,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: ColorSelect.shadowColor2,
                            spreadRadius: 1,
                            blurRadius: 6),
                      ],
                      color: Colors.white),
                  child: screenProgress,
                ),
              ),
            ],
          ),
        ),

        //left content
      ],
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    var firstControlPoint = Offset(0, size.height);
    var firstPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    path.lineTo(size.width - 20, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
