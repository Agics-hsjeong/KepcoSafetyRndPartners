import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:kepco_safety_iot/models/designModel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:kepco_safety_iot/models/models.dart';
import '../common/CameraPlayer.dart';

class VideoArea extends StatefulWidget {
  const VideoArea({
    Key? key,
  }) : super(key: key);

  @override
  State<VideoArea> createState() => _VideoAreaState();
}

class _VideoAreaState extends State<VideoArea> {
  int _selectedIndex = 0;

  late String cameraUrl;

  //rtsp://211.185.157.191:50554/cam/0
  //rtsp://211.185.157.191:50554/cam/0/low
  List<String> rtsp = [
    '',
    '',
    '',
    '',
  ];

  List<String> video = [
    'CAM_1',
    'CAM_2',
    'CAM_3',
  ];

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      cameraUrl = 'http://106.255.245.242:39104/video/1.작업신원확인_5s.mp4';
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 타이틀 , 카메라위치조정버튼
        Padding(
          padding: EdgeInsets.only(left: width * 0.01, right: width * 0.01),
          child: SizedBox(
            width: Status.isOpen ? width * 0.39 : width * 0.5,
            height: height * 0.045,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "메인 작업 영상",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.012,
                    fontFamily: 'SUIT',
                  ),
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     elevation: 11,
                //     backgroundColor: ColorSelect.toggleColor3,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10)),
                //     shadowColor: ColorSelect.toggleColor3,
                //   ),
                //   onPressed: () {
                //     setState(() {
                //       showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return AdjustCamera(
                //             rtsp: rtsp,
                //           );
                //         },
                //       );
                //     });
                //   },
                //   child: Text(
                //     '카메라 위치 조정',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: width * 0.008,
                //       fontFamily: 'SUIT',
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        // 카메라
        Container(
          width: Status.isOpen ? width * 0.378 : width * 0.51,
          height: Status.isOpen ? height * 0.456 : height * 0.45,
          decoration: BoxDecoration(
            color: ColorSelect.tableColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CameraPlayer(),
                    // Stack(
                    //   children: [
                    //     CameraPlayer(),
                    //     // const Positioned(
                    //     //   top: 15,
                    //     //   left: 15,
                    //     //   child: Dropdown2(),
                    //     // ),
                    //   ],
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // 타이틀
        // SizedBox(
        //   width: Status.isOpen
        //       ? MediaQuery.of(context).size.width * 0.39
        //       : MediaQuery.of(context).size.width * 0.5,
        //   height: MediaQuery.of(context).size.height * 0.06,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(left: 6.0),
        //         child: Text(
        //           "작업자 작업 영상",
        //           textScaleFactor: FontSize.h5,
        //           textAlign: TextAlign.center,
        //           style: TextStyle(fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // // 카메라
        // Status.isOpen
        //     ? Column(
        //         children: [
        //           //videoslider
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.38,
        //             height: MediaQuery.of(context).size.height * 0.3,
        //             decoration: BoxDecoration(
        //               color: ColorSelect.tableColor,
        //               borderRadius: BorderRadius.circular(15),
        //             ),
        //             child: PageView.builder(
        //               itemCount: video.length,
        //               onPageChanged: (index) {
        //                 setState(() {
        //                   _selectedIndex = index;
        //                 });
        //               },
        //               scrollDirection: Axis.horizontal,
        //               itemBuilder: (context, index) {
        //                 return Container(
        //                   width: MediaQuery.of(context).size.width * 0.38,
        //                   height: MediaQuery.of(context).size.height * 0.33,
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(15),
        //                     // color: Colors.white,
        //                   ),
        //                   child: Stack(
        //                     children: [
        //                       ClipRRect(
        //                         borderRadius: const BorderRadius.only(
        //                           topLeft: Radius.circular(15),
        //                           topRight: Radius.circular(15),
        //                           bottomLeft: Radius.circular(10),
        //                           bottomRight: Radius.circular(10),
        //                         ),
        //                         child: CameraPlayer(
        //                           name: "",
        //                           url: rtsp[index + 1],
        //                           aspectRatio: 48 / 21,
        //                         ),
        //                       ),
        //                       Positioned(
        //                         top: 12,
        //                         left: 12,
        //                         child: Container(
        //                           width:
        //                               MediaQuery.of(context).size.width * 0.06,
        //                           height: 30,
        //                           decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(5),
        //                             color: Color.fromRGBO(0, 0, 0, 0.5),
        //                           ),
        //                           child: Row(
        //                             mainAxisAlignment: MainAxisAlignment.center,
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.center,
        //                             children: [
        //                               Text(
        //                                 video[index],
        //                                 textScaleFactor: FontSize.h5,
        //                                 textAlign: TextAlign.center,
        //                                 style: TextStyle(
        //                                     fontWeight: FontWeight.bold,
        //                                     color: Colors.white),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 );
        //               },
        //             ),
        //           ),
        //           //pagedots
        //           Padding(
        //             padding: const EdgeInsets.only(top: 12.0),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 ...List.generate(
        //                   video.length,
        //                   (index) => Indicator(
        //                       isActive: _selectedIndex == index ? true : false),
        //                 )
        //               ],
        //             ),
        //           )
        //         ],
        //       )
        //     : Row(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.24,
        //             height: MediaQuery.of(context).size.height * 0.3,
        //             decoration: BoxDecoration(
        //               color: ColorSelect.tableColor,
        //               borderRadius: BorderRadius.circular(15),
        //             ),
        //             child: Container(
        //               width: MediaQuery.of(context).size.width * 0.38,
        //               height: MediaQuery.of(context).size.height * 0.33,
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(15),
        //                 // color: Colors.white,
        //               ),
        //               child: Stack(
        //                 children: [
        //                   ClipRRect(
        //                     borderRadius: const BorderRadius.only(
        //                       bottomLeft: Radius.circular(10),
        //                     ),
        //                     child: CameraPlayer(
        //                       name: "",
        //                       url: rtsp[1],
        //                       aspectRatio: 5 / 4,
        //                     ),
        //                   ),
        //                   Positioned(
        //                     top: 18,
        //                     left: 10,
        //                     child: Container(
        //                       width: MediaQuery.of(context).size.width * 0.06,
        //                       height:
        //                           MediaQuery.of(context).size.height * 0.048,
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(10),
        //                         color: Color.fromRGBO(0, 0, 0, 0.5),
        //                       ),
        //                       child: Padding(
        //                         padding: const EdgeInsets.all(6.0),
        //                         child: Text(
        //                           video[0],
        //                           textScaleFactor: FontSize.h5,
        //                           textAlign: TextAlign.center,
        //                           style: TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               color: Colors.white),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //           Padding(padding: EdgeInsets.only(right: 30)),
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.24,
        //             height: MediaQuery.of(context).size.height * 0.3,
        //             decoration: BoxDecoration(
        //               color: ColorSelect.tableColor,
        //               borderRadius: BorderRadius.circular(15),
        //             ),
        //             child: Container(
        //               width: MediaQuery.of(context).size.width * 0.38,
        //               height: MediaQuery.of(context).size.height * 0.33,
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(15),
        //                 // color: Colors.white,
        //               ),
        //               child: Stack(
        //                 children: [
        //                   ClipRRect(
        //                     borderRadius: const BorderRadius.only(
        //                       bottomLeft: Radius.circular(10),
        //                     ),
        //                     child: CameraPlayer(
        //                       name: "",
        //                       url: rtsp[2],
        //                       aspectRatio: 5 / 4,
        //                     ),
        //                   ),
        //                   Positioned(
        //                     top: 18,
        //                     left: 10,
        //                     child: Container(
        //                       width: MediaQuery.of(context).size.width * 0.06,
        //                       height:
        //                           MediaQuery.of(context).size.height * 0.048,
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(10),
        //                         color: Color.fromRGBO(0, 0, 0, 0.5),
        //                       ),
        //                       child: Padding(
        //                         padding: const EdgeInsets.all(6.0),
        //                         child: Text(
        //                           video[1],
        //                           textScaleFactor: FontSize.h5,
        //                           textAlign: TextAlign.center,
        //                           style: TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               color: Colors.white),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
      ],
    );
  }
}

// -------------카메라위치조정_팝업 시작--------------------
class AdjustCamera extends StatefulWidget {
  const AdjustCamera({
    Key? key,
    required this.rtsp,
  }) : super(key: key);

  final List rtsp;

  @override
  State<AdjustCamera> createState() => _AdjustCameraState();
}

class _AdjustCameraState extends State<AdjustCamera> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      titlePadding: EdgeInsets.only(left: width * 0.01, right: width * 0.01),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Column(
              children: [
                Container(
                  width: width * 0.7,
                  height: height * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 1,
                        blurRadius: 20,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                          children: [
                            const TopBar(),
                            BodyContainer(rtsp: widget.rtsp),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// --------팝업top-bar 시작
class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.circle,
                      size: 12,
                      color: Color.fromRGBO(69, 94, 238, 1),
                    ),
                  ),
                  Text(
                    'CAM 1',
                    textScaleFactor: FontSize.h5,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff455eee),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: const Dropdown(),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close_rounded,
              color: Color.fromRGBO(69, 94, 238, 1),
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}

// 팝업드롭다운
class Dropdown extends StatefulWidget {
  const Dropdown({Key? key}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  final List<String> items = [
    'CAM_1',
    'CAM_2',
    'CAM_3',
    'CAM_4',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Icon(
                Icons.search,
                size: 26,
                color: Colors.white,
              ),
              Text(
                '카메라선택',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(
            () {
              selectedValue = value as String;
            },
          );
        },
        buttonHeight: 40,
        buttonWidth: 200,
        itemHeight: 40,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xff455EEE),
        ),
        iconEnabledColor: Colors.white,
        iconSize: 35,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xff455EEE),
        ),
      ),
    );
  }
}

// 실시간작업영상드롭다운
class Dropdown2 extends StatefulWidget {
  const Dropdown2({Key? key}) : super(key: key);

  @override
  State<Dropdown2> createState() => _Dropdown2State();
}

class _Dropdown2State extends State<Dropdown2> {
  final List<String> items = [
    'CAM_1',
    'CAM_2',
    'CAM_3',
    'CAM_4',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Icon(
                Icons.search,
                size: 26,
                color: Colors.white,
              ),
              Text(
                '카메라선택',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(
            () {
              selectedValue = value as String;
            },
          );
        },
        buttonHeight: 40,
        buttonWidth: 160,
        itemHeight: 40,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromRGBO(0, 0, 0, 0.5),
        ),
        iconEnabledColor: Colors.white,
        iconSize: 35,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                spreadRadius: 0,
                blurRadius: 0,
                color: Color.fromRGBO(255, 193, 7, 0))
          ],
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(0, 0, 0, 0.5),
        ),
      ),
    );
  }
}
// ---------팝업top-bar 끝

// ----------팝업body 시작
class BodyContainer extends StatefulWidget {
  const BodyContainer({
    Key? key,
    required this.rtsp,
  }) : super(key: key);

  final List rtsp;

  @override
  State<BodyContainer> createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.42,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CameraPlayer(),
              ),
            ),
            const Expanded(
              flex: 2,
              child: Joypad(),
            ),
          ],
        ),
      ),
    );
  }
}

// 팝업_카메라
// ignore: must_be_immutable

// 팝업_카메라조정버튼
class Joypad extends StatefulWidget {
  const Joypad({
    Key? key,
  }) : super(key: key);

  JoypadState createState() => JoypadState();
}

class JoypadState extends State {
  Offset delta = Offset.zero;

  bool isBorder = false;

  void updateDelta(Offset newDelta) {
    setState(() {
      delta = newDelta;
    });
    // print(delta);
  }

  void calculateDelta(Offset offset) {
    Offset newDelta = offset - Offset(165, 210);
    updateDelta(
      Offset.fromDirection(
        newDelta.direction,
        min(180, newDelta.distance),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 260,
            height: 260,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Color(0xffECEEFE),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(
                        0xff455EEE), //                   <--- border color
                    width: 1.5,
                  )),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onPanDown: onDragDown,
            onPanUpdate: onDragUpdate,
            onPanEnd: onDragEnd,
            child: Center(
              child: Transform.translate(
                offset: delta,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff455EEE),
                      borderRadius: BorderRadius.circular(50),
                      border: isBorder
                          ? Border.all(
                              width: 0.5,
                            )
                          : null,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.arrow_left_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_right_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Icon(
                            Icons.arrow_drop_up_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onDragDown(DragDownDetails d) {
    setState(() {
      isBorder = true;
    });

    calculateDelta(d.localPosition);
  }

  void onDragUpdate(DragUpdateDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragEnd(DragEndDetails d) {
    setState(() {
      isBorder = false;
    });
    updateDelta(Offset.zero);
  }
}
// -----------팝업body 끝

// -----------카메라위치조정_팝업 끝--------------------

//Indicator 시작
class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: MediaQuery.of(context).size.width * 0.006,
      height: MediaQuery.of(context).size.height * 0.012,
      decoration: BoxDecoration(
          color: isActive ? ColorSelect.blueColor : ColorSelect.grayColor,
          borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
