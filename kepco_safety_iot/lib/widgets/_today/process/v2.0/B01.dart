import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';

import 'package:vibration/vibration.dart';

import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import 'package:kepco_safety_iot/pages/HomePage.dart';
import 'package:kepco_safety_iot/widgets/common/CameraPlayer.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/_today/VideoArea.dart';

class B01 extends StatefulWidget {
  B01({
    Key? key,
    required this.progressTimeline,
    required this.stateTitle,
    required this.single,
  }) : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<B01> createState() => _B01State();
}

class _B01State extends State<B01> with TickerProviderStateMixin {
  late ProgressTimeline progressTimeline;
  List<SingleRowState> workerList = List.empty(growable: true);

  Future<dynamic> startProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'S');

    // print('===>startProc ${result}');
  }

  Future<dynamic> endProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'E');

    // print('===>endProc ${result}');
  }

  final FlutterTts tts = FlutterTts();
  final TextEditingController controller =
      TextEditingController(text: '위험합니다..');

  _B01State() {
    tts.setLanguage('ko');
    tts.setSpeechRate(0.4);
  }

  // CameraPlayer _cameraPlayer = CameraPlayer();

  late Timer _timer;

  int fadeCnt = 0;

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;
    HealthStatus.bodyStatus = 1;
    HealthStatus.stressStatus = 0;
    workerList = [
      SingleRowState(
          workerNm: "작업자A", contents: "안전별 모든 작업 총괄", isChecked: [true, false]),
      SingleRowState(
          workerNm: "작업자B", contents: "주상작업_변압기 교체", isChecked: [true, false]),
    ];

    startProc();
    super.initState();

    // Vibration.vibrate(
    //   pattern: [500, 1000, 500, 2000, 500, 3000, 500, 500],
    //   intensities: [0, 128, 0, 255, 0, 64, 0, 255],
    // );

    _timer = Timer.periodic(Duration(milliseconds: 700), (timer) {
      setState(() {
        fadeCnt++;
        // controller.reverse();
        // print(fadeCnt);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    Vibration.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "| ${widget.stateTitle}",
              textScaleFactor: FontSize.h4_5,
              style: const TextStyle(
                  color: ColorSelect.blueColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Column(children: [
                      // TextField(
                      //   controller: controller,
                      // ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       tts.speak(controller.text);
                      //     },
                      //     child: Text('Speak')),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '작업자',
                                textScaleFactor: FontSize.h5,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            fadeCnt >= 1
                                ? Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: fadeCnt == 1
                                          ? BoxDecoration(
                                              // border: Border.all(),
                                              color: Colors.red[50])
                                          : null,
                                      child: Text(
                                        '작업자 A',
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(81, 81, 81, 1)),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '작업내용',
                                textScaleFactor: FontSize.h5,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            fadeCnt >= 2
                                ? Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: fadeCnt == 2
                                          ? BoxDecoration(
                                              // border: Border.all(),
                                              color: Colors.red[50])
                                          : null,
                                      child: Text(
                                        "안전별 모든 작업 총괄",
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(81, 81, 81, 1)),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Center(
                                child: Text(
                              "이상유무",
                              textScaleFactor: FontSize.h5,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xfff9f9f9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            margin: EdgeInsets.only(right: 8),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: ToggleButtons(
                              borderRadius: BorderRadius.circular(30.0),
                              borderColor: Color(0xffb7b7b7),
                              fillColor: fadeCnt == 3
                                  ? Colors.red[50]
                                  : Color(0xffe2e6ff),
                              selectedColor: ColorSelect.blueColor,
                              selectedBorderColor: ColorSelect.blueColor,
                              color: Color(0xffb7b7b7),
                              constraints: BoxConstraints.expand(
                                  width:
                                      MediaQuery.of(context).size.width / 5.88),
                              children: <Widget>[
                                Text('무',
                                    textScaleFactor: FontSize.h5,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                Text('유',
                                    textScaleFactor: FontSize.h5,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              ],
                              onPressed: (index) {},
                              isSelected: [fadeCnt >= 3 ? true : false, false],
                            ),
                          ),
                        ],
                      ),

                      Divider(
                        thickness: 1,
                        height: 50,
                        color: Color.fromRGBO(183, 183, 183, 1),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '작업자',
                                textScaleFactor: FontSize.h5,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            fadeCnt >= 4
                                ? Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: fadeCnt == 4
                                          ? BoxDecoration(
                                              // border: Border.all(),
                                              color: Colors.red[50])
                                          : null,
                                      child: Text(
                                        '작업자 B',
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(81, 81, 81, 1)),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                '작업내용',
                                textScaleFactor: FontSize.h5,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            fadeCnt >= 5
                                ? Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: fadeCnt == 5
                                          ? BoxDecoration(
                                              // border: Border.all(),
                                              color: Colors.red[50])
                                          : null,
                                      child: Text(
                                        "주상작업 변압기 교체",
                                        textScaleFactor: FontSize.h5,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(81, 81, 81, 1)),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Center(
                                child: Text(
                              "이상유무",
                              textScaleFactor: FontSize.h5,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xfff9f9f9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            margin: EdgeInsets.only(right: 8),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: ToggleButtons(
                              borderRadius: BorderRadius.circular(30.0),
                              borderColor: Color(0xffb7b7b7),
                              fillColor: fadeCnt == 6
                                  ? Colors.red[50]
                                  : Color(0xffe2e6ff),
                              selectedColor: ColorSelect.blueColor,
                              selectedBorderColor: ColorSelect.blueColor,
                              color: Color(0xffb7b7b7),
                              constraints: BoxConstraints.expand(
                                  width:
                                      MediaQuery.of(context).size.width / 5.88),
                              children: <Widget>[
                                Text('무',
                                    textScaleFactor: FontSize.h5,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                Text('유',
                                    textScaleFactor: FontSize.h5,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              ],
                              onPressed: (index) {},
                              isSelected: [fadeCnt >= 6 ? true : false, false],
                            ),
                          ),
                        ],
                      ),
                    ]),
                    // child: Column(
                    //   children: workerList
                    //       .map((e) => Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               FadeTransition(
                    //                 opacity: animation,
                    //                 alwaysIncludeSemantics: true,
                    //                 child: Padding(
                    //                   padding: EdgeInsets.only(bottom: 20),
                    //                   child: Row(
                    //                     children: [
                    //                       Expanded(
                    //                         flex: 1,
                    //                         child: Text(
                    //                           '작업자',
                    //                           textScaleFactor: FontSize.h5,
                    //                           style: const TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ),
                    //                       Expanded(
                    //                         flex: 3,
                    //                         child: Text(
                    //                           e.workerNm,
                    //                           textScaleFactor: FontSize.h5,
                    //                           style: TextStyle(
                    //                               color: Color.fromRGBO(
                    //                                   81, 81, 81, 1)),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //               FadeTransition(
                    //                 opacity: animation,
                    //                 alwaysIncludeSemantics: true,
                    //                 child: Padding(
                    //                   padding: EdgeInsets.only(bottom: 40),
                    //                   child: Row(
                    //                     children: [
                    //                       Expanded(
                    //                         flex: 1,
                    //                         child: Text(
                    //                           '작업내용',
                    //                           textScaleFactor: FontSize.h5,
                    //                           style: const TextStyle(
                    //                               fontWeight:
                    //                                   FontWeight.bold),
                    //                         ),
                    //                       ),
                    //                       Expanded(
                    //                         flex: 3,
                    //                         child: Text(
                    //                           e.contents,
                    //                           textScaleFactor: FontSize.h5,
                    //                           style: TextStyle(
                    //                               color: Color.fromRGBO(
                    //                                   81, 81, 81, 1)),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: EdgeInsets.only(bottom: 15),
                    //                 child: Center(
                    //                     child: Text(
                    //                   "이상유무",
                    //                   textScaleFactor: FontSize.h5,
                    //                   style: const TextStyle(
                    //                       fontWeight: FontWeight.bold),
                    //                 )),
                    //               ),
                    //               Container(
                    //                 decoration: BoxDecoration(
                    //                   color: Color(0xfff9f9f9),
                    //                   borderRadius: BorderRadius.all(
                    //                       Radius.circular(30.0)),
                    //                 ),
                    //                 margin: EdgeInsets.only(right: 8),
                    //                 width: double.infinity,
                    //                 height:
                    //                     MediaQuery.of(context).size.height *
                    //                         0.06,
                    //                 child: ToggleButtons(
                    //                   borderRadius:
                    //                       BorderRadius.circular(30.0),
                    //                   borderColor: Color(0xffb7b7b7),
                    //                   fillColor: Color(0xffe2e6ff),
                    //                   selectedColor: ColorSelect.blueColor,
                    //                   selectedBorderColor:
                    //                       ColorSelect.blueColor,
                    //                   color: Color(0xffb7b7b7),
                    //                   constraints: BoxConstraints.expand(
                    //                       width: MediaQuery.of(context)
                    //                               .size
                    //                               .width /
                    //                           5.88),
                    //                   children: <Widget>[
                    //                     Text('무',
                    //                         textScaleFactor: FontSize.h5,
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.w600)),
                    //                     Text('유',
                    //                         textScaleFactor: FontSize.h5,
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.w600)),
                    //                   ],
                    //                   onPressed: (int index) {
                    //                     setState(() {
                    //                       for (int i = 0;
                    //                           i < e.isChecked.length;
                    //                           i++) {
                    //                         if (i == index) {
                    //                           if (e.isChecked[i] != true) {
                    //                             e.isChecked[i] =
                    //                                 !e.isChecked[i];
                    //                           }
                    //                         } else {
                    //                           e.isChecked[i] = false;
                    //                         }
                    //                       }
                    //                     });
                    //                   },
                    //                   isSelected: e.isChecked,
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: EdgeInsets.only(
                    //                     top: 30.0, bottom: 40),
                    //                 child: workerList.indexOf(e) + 1 ==
                    //                         workerList.length
                    //                     ? SizedBox.shrink()
                    //                     : Divider(
                    //                         thickness: 1,
                    //                         height: 1,
                    //                         color: Color.fromRGBO(
                    //                             183, 183, 183, 1),
                    //                       ),
                    //               ),
                    //             ],
                    //           ))
                    //       .toList(),
                  )
                ],
              ),
            ),
          ),
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // SizedBox(
            //   child: Row(
            //     children: [
            //       TextButton(
            //         style: TextButton.styleFrom(
            //           textStyle: const TextStyle(fontSize: 20),
            //         ),
            //         onPressed: () {
            //           progressTimeline.gotoPreviousStage();
            //         },
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: const [
            //             Padding(
            //               padding: EdgeInsets.only(right: 5.0),
            //               child: Icon(
            //                 Icons.arrow_back_ios_new_rounded,
            //                 color: ColorSelect.blueColor,
            //               ),
            //             ),
            //             Text(
            //               "이전",
            //               style: TextStyle(
            //                   fontSize: 20,
            //                   color: ColorSelect.blueColor,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        progressTimeline.gotoNextStage();
                        endProc();

                        VideoStatus.controller.setMediaFromNetwork(
                            'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s-converted.mp4',
                            autoPlay: true);

                        // VideoStatus.videoPlayerController =
                        //     VideoPlayerController.network(
                        //   'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV',
                        // );
                        // VideoStatus.chewieController = ChewieController(
                        //   videoPlayerController:
                        //       VideoStatus.videoPlayerController,
                        //   aspectRatio: VideoStatus
                        //           .videoPlayerController.value.aspectRatio *
                        //       2,
                        //   autoInitialize: true,
                        //   autoPlay: true,
                        //   showOptions: false,
                        //   showControls: true,
                        //   looping: true,
                        // );

                        // VideoStatus.setVideoCheing(
                        // 'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');

                        // VideoStatus.chewieController.dispose();
                        // setState(() {
                        //   VideoStatus.videoPlayerController =
                        //       VideoPlayerController.network(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV',
                        //   );

                        //   VideoStatus.chewieController = ChewieController(
                        //     videoPlayerController:
                        //         VideoStatus.videoPlayerController,
                        //     aspectRatio: VideoStatus
                        //             .videoPlayerController.value.aspectRatio *
                        //         2,
                        //     autoInitialize: true,
                        //     autoPlay: true,
                        //     showOptions: false,
                        //     showControls: true,
                        //     looping: true,
                        //   );
                        //   // chewieController.allowMuting;
                        //   VideoStatus.chewieController.setVolume(0);
                        // });

                        // CameraPlayer().setVideoChenging(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                        // VideoStatus.videoPlayerController =
                        //     VideoPlayerController.network(
                        //   'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV',
                        // );

                        // print('===> ${VideoStatus.controller.getVolume()}');
                        // VideoStatus.videoPlayerController =
                        //     VideoPlayerController.network(
                        //   'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV',
                        // );

                        // VideoStatus.chewieController = ChewieController(
                        //   videoPlayerController:
                        //       VideoStatus.videoPlayerController,
                        //   aspectRatio: 21 / 12,
                        //   // fullScreenByDefault: true,
                        //   autoPlay: true,
                        //   looping: true,
                        // );
                        // VideoStatus.controller.setMediaFromNetwork(
                        //     'http://106.255.245.242:39104/video/2.작업자PMISCheck(응답)_6s.MOV');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "다음",
                            textScaleFactor: FontSize.h4_5,
                            style: TextStyle(
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: ColorSelect.blueColor,
                            ),
                          ),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SingleRowState {
  String workerNm;
  String contents;
  List<bool> isChecked;

  SingleRowState({
    required this.workerNm,
    required this.contents,
    required this.isChecked,
  });
}
