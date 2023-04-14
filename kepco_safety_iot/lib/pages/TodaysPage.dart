// ignore_for_file: file_names, avoid_print, prefer_const_constructors, avoid_unnecessary_containers
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:kepco_safety_iot/widgets/common/Layout.dart';
import 'package:kepco_safety_iot/widgets/_today/today.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/common/WorkerBox.dart';

class TodaysPage extends StatefulWidget {
  const TodaysPage({Key? key, required this.cnt}) : super(key: key);
  final Map cnt;

  @override
  State<TodaysPage> createState() => _TodaysPageState();
}

class _TodaysPageState extends State<TodaysPage> with TickerProviderStateMixin {
  ProgressArea? progressArea;

  late Animation<double> animation;
  late AnimationController controller;
  // ScrollController _scrollController = ScrollController();
  late Timer _timer;

  int _counter = 0;

  final FlutterTts tts = FlutterTts();

  _TodaysPageState() {
    tts.setLanguage('ko');
    tts.setSpeechRate(0.4);
  }
  GwMQTTClient gwMQTTClient = GwMQTTClient();
  // final String pubTopic = "/AI_KEPCO/AI_FACE_RECOGNIZE";

  // void scrollDown() {
  //   _timer = Timer(Duration(seconds: 1), () {
  //     scrollController.animateTo(
  //       scrollController.position.maxScrollExtent,
  //       duration: Duration(seconds: 18),
  //       curve: Curves.fastOutSlowIn,
  //     );
  //   });
  // }

  Future<void> setupGwMqttClient() async {
    await gwMQTTClient.connect();
    gwMQTTClient.subscribe(PL_TOPIC);
  }

  // void showRiskPop(BuildContext context, int numCheck) {
  //   Size screenSize = MediaQuery.of(context).size;
  //   double width = screenSize.width;
  //   double height = screenSize.height;
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.transparent,
  //         elevation: 0.0,
  //         titlePadding: EdgeInsets.only(left: 10.0, right: 10.0),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: [
  //               Center(
  //                 child: Container(
  //                   width: width * 0.4,
  //                   height: height * 0.4,
  //                   child: Stack(
  //                     children: [
  //                       Align(
  //                         alignment: Alignment.center,
  //                         child: Container(
  //                             padding: EdgeInsets.only(
  //                                 top: 15, bottom: 20, left: 20, right: 20),
  //                             width: 420,
  //                             height: 300,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(13),
  //                               boxShadow: const [
  //                                 BoxShadow(
  //                                   color: ColorSelect.redColor,
  //                                   spreadRadius: 1,
  //                                   blurRadius: 20,
  //                                 ),
  //                               ],
  //                               color: Colors.white,
  //                             ),
  //                             child: Column(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Row(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.center,
  //                                   children: [
  //                                     Text(
  //                                       numCheck == 1 ? "안전장구미착용" : "낙상주의",
  //                                       textScaleFactor: FontSize.h4,
  //                                       style: TextStyle(
  //                                           fontWeight: FontWeight.w600,
  //                                           color: ColorSelect.redColor),
  //                                     ),
  //                                     Padding(
  //                                       padding:
  //                                           const EdgeInsets.only(bottom: 7.0),
  //                                       child: IconButton(
  //                                         padding: EdgeInsets.zero,
  //                                         constraints: BoxConstraints(),
  //                                         onPressed: () {
  //                                           Navigator.pop(context);
  //                                         },
  //                                         icon: Icon(
  //                                           Icons.close_rounded,
  //                                           color: ColorSelect.redColor,
  //                                           size: 33,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SvgPicture.asset(
  //                                   numCheck == 1
  //                                       ? 'assets/svg/안정장구미착용.svg'
  //                                       : 'assets/svg/낙상주의.svg',
  //                                   color: ColorSelect.redColor,
  //                                   width: 90,
  //                                 ),
  //                                 // Padding(
  //                                 //   padding: const EdgeInsets.symmetric(
  //                                 //       vertical: 10.0),
  //                                 //   child: Row(
  //                                 //     mainAxisAlignment:
  //                                 //         MainAxisAlignment.center,
  //                                 //     children: [
  //                                 //       Text(
  //                                 //         '작업자3',
  //                                 //         textScaleFactor: FontSize.h4_5,
  //                                 //         style: TextStyle(
  //                                 //             fontWeight: FontWeight.w600),
  //                                 //       ),
  //                                 //       Padding(
  //                                 //         padding:
  //                                 //             const EdgeInsets.only(left: 10.0),
  //                                 //         child: Text(
  //                                 //           '홍길동',
  //                                 //           textScaleFactor: FontSize.h4_5,
  //                                 //           style: TextStyle(
  //                                 //               fontWeight: FontWeight.w500),
  //                                 //         ),
  //                                 //       ),
  //                                 //     ],
  //                                 //   ),
  //                                 // ),
  //                                 SizedBox(
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.center,
  //                                     children: [
  //                                       // Flexible(
  //                                       //     flex: 10, child: Dropdownwork()),
  //                                       Padding(
  //                                         padding:
  //                                             const EdgeInsets.only(left: 10.0),
  //                                         child: Flexible(
  //                                           flex: 2,
  //                                           child: SizedBox(
  //                                             height: 50,
  //                                             child: TextButton(
  //                                               style: ButtonStyle(
  //                                                   shape: MaterialStateProperty
  //                                                       .all(
  //                                                     RoundedRectangleBorder(
  //                                                       borderRadius:
  //                                                           BorderRadius
  //                                                               .circular(10),
  //                                                     ),
  //                                                   ),
  //                                                   foregroundColor:
  //                                                       MaterialStateProperty
  //                                                           .all(Colors.black),
  //                                                   backgroundColor:
  //                                                       MaterialStateProperty
  //                                                           .all(ColorSelect
  //                                                               .redColor)),
  //                                               child: Text("확인",
  //                                                   textScaleFactor:
  //                                                       FontSize.h5,
  //                                                   style: TextStyle(
  //                                                       fontWeight:
  //                                                           FontWeight.w500,
  //                                                       color: Colors.white)),
  //                                               onPressed: () {
  //                                                 setState(() {
  //                                                   FadeIn.status = false;
  //                                                 });

  //                                                 Navigator.of(context).pop();
  //                                               },
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ],
  //                             )),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void setupAiUpdatesListener() {
  //   aiMQTTClient
  //       .getMessagesStream()
  //       .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
  //     final recMess = c![0].payload as MqttPublishMessage;
  //     print('MQTTClient:: $recMess');
  //     final pt =
  //         MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  //     print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');

  //     if (c[0].topic == FR_TOPIC) {
  //       print('MQTTClient:: ${jsonDecode(pt)["status"]}');
  //       if (jsonDecode(pt)["status"] == 'complete') {
  //         print(jsonDecode(pt)["result"]);

  //         String imgUrl = '';

  //         switch (jsonDecode(pt)["result"][0]) {
  //           case 'no000001':
  //             imgUrl = "assets/img/work/no000001.jpg";
  //             break;
  //           case 'no000002':
  //             imgUrl = "assets/img/work/no000002.jpg";
  //             break;
  //           case 'no000003':
  //             imgUrl = "assets/img/work/no000003.jpg";
  //             break;
  //           case 'no000004':
  //             imgUrl = "assets/img/work/no000004.jpg";
  //             break;
  //           case 'no000005':
  //             imgUrl = "assets/img/work/no000005.jpg";
  //             break;
  //           case 'no000006':
  //             imgUrl = "assets/img/work/no000006.jpg";
  //             break;
  //           case 'no000007':
  //             imgUrl = "assets/img/work/no000007.jpg";
  //             break;
  //           default:
  //         }

  //         RndNetwork()
  //             .getOpertor(target: jsonDecode(pt)["result"][0])
  //             .then((res) {
  //           print('MQTTClient:: $res');
  //           setState(() {
  //             userStages.add(
  //               UserState(
  //                 name: res['opertorNm'],
  //                 age: '${res['age'].round()}',
  //                 sex: res['opertorSex'] == 'M' ? '남' : '여',
  //                 depart: "(주)금광전기",
  //                 operatorNo: '${res['etc']}',
  //                 career: '${res['opertorCareer']}',
  //                 qualification: "N",
  //                 deadline: "10",
  //                 imgUrl: imgUrl,
  //                 equi: [
  //                   EquipState(
  //                     equipName: "안전모",
  //                     isCheck: true,
  //                     analyze: true,
  //                   ),
  //                   EquipState(
  //                     equipName: "안전장갑",
  //                     isCheck: true,
  //                     analyze: true,
  //                   ),
  //                   EquipState(
  //                     equipName: "안전화",
  //                     isCheck: true,
  //                     analyze: true,
  //                   ),
  //                 ],
  //               ),
  //             );
  //             isFinding = false;
  //             isFirst = true;
  //             isNext = true;
  //           });
  //         });

  //         AiNetwork().OdPpeDetect();
  //       }
  //     } else if (c[0].topic == PPE_TOPIC) {
  //       print('MQTTClient:: ${jsonDecode(pt)["status"]}');
  //       if (jsonDecode(pt)["status"] == 'complete') {}
  //     } else if (c[0].topic == WORK_TOPIC) {
  //       print('MQTTClient:: ${jsonDecode(pt)["status"]}');
  //       if (jsonDecode(pt)["status"] == 'detect') {
  //         List.generate(jsonDecode(pt)["result"]['detect_list'].length,
  //             (index) {
  //           print(
  //               'MQTTClient:: ${jsonDecode(pt)["result"]['detect_list'][index]['name']}');
  //           if (jsonDecode(pt)["result"]['detect_list'][index]['name'] ==
  //               'safety_gloves_off') {
  //             if (!FadeIn.status) {
  //               setState(() {
  //                 FadeIn.status = true;
  //               });

  //               showRiskPop(context, 1);

  //               putStatus(3);

  //               tts.speak('위험감지가 확인되었습니다. 알림을 확인해주세요!');
  //             }
  //           } else if (jsonDecode(pt)["result"]['detect_list'][index]['name'] ==
  //               'safety_helmet_off') {
  //             // showRiskPop(2);
  //           }
  //         });
  //         // if (jsonDecode(pt)["result"] == 'detect_list') {
  //         //   setState(() {
  //         //     FadeIn.status = true;
  //         //   });
  //         // }

  //         // showRiskPop(1);
  //       }
  //     } else if (c[0].topic == CON_TOPIC) {
  //       print('MQTTClient:: ${jsonDecode(pt)["status"]}');
  //       if (jsonDecode(pt)["status"] == 'complete' ||
  //           jsonDecode(pt)["status"] == 'new') {
  //         List.generate(jsonDecode(pt)["result"].length, (index) {
  //           print('MQTTClient:: ${jsonDecode(pt)["result"][index]['name']}');
  //           if (jsonDecode(pt)["result"][index]['name'] == 'signalman') {
  //             setState(() {
  //               gearList[1].isChecked[0] = true;
  //             });
  //           }

  //           if (jsonDecode(pt)["result"][index]['name'] ==
  //               'sign_traffic_cone') {
  //             setState(() {
  //               gearList[0].isChecked[0] = true;
  //             });
  //           }
  //         });
  //       }
  //     }
  //   });
  // }

  // void setupGwUpdatesListener() {
  //   gwMQTTClient
  //       .getMessagesStream()
  //       .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
  //     final recMess = c![0].payload as MqttPublishMessage;
  //     print('MQTTClient:: $recMess');
  //     final pt =
  //         MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  //     print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');

  //     if (c[0].topic == PL_TOPIC) {
  //       // widget.cnt()
  //       if (jsonDecode(pt)["data"]['step1'] == 0) {
  //         if (!FadeIn.status) {
  //           setState(() {
  //             FadeIn.status = true;
  //           });

  //           showRiskPop(0);
  //           putStatus(2);
  //         }
  //         print('MQTTClient::Message error');
  //       }
  //     }
  //   });
  // }

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //     mqttClientManager.publishMessage(
  //         FR_TOPIC, "Increment button pushed ${_counter.toString()} times.");
  //   });
  // }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    setupAiMqttClient();
    // setupGwMqttClient();
    setupAiUpdatesListener(context);
    // setupGwUpdatesListener();

    FadeIn.status = false;
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat(reverse: true);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 0.4).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    // controller.forward();
    // controller.reverse();

    print('===> ${widget.cnt}');
    progressArea = ProgressArea(cnt: widget.cnt);
  }

  @override
  void dispose() {
    controller.dispose();
    aiMQTTClient.disconnect();
    // gwMQTTClient.disconnect();
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Layout(
        title: TextModel.title,
        body: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //left body content('현재공종상황')
                Flexible(
                  flex: Status.isOpen ? 3 : 3,
                  child: Container(
                    margin: EdgeInsets.only(left: width * 0.01),
                    // color: Colors.pink,
                    child: Stack(
                      children: [
                        Container(child: progressArea),
                        // 펼침 기능
                        // Align(
                        //   alignment: Status.isOpen
                        //       ? Alignment.centerRight
                        //       : Alignment(1.13, 0.0),
                        //   child: Container(
                        //     width: 25,
                        //     height: 70,
                        //     decoration: BoxDecoration(
                        //       borderRadius: Status.isOpen
                        //           ? BorderRadius.horizontal(
                        //               left: Radius.circular(10))
                        //           : BorderRadius.horizontal(
                        //               right: Radius.circular(10)),
                        //       color: ColorSelect.blueColor,
                        //     ),
                        //     child: Expanded(
                        //       child: Container(
                        //         child: IconButton(
                        //           padding: EdgeInsets.zero, // 패딩 설정
                        //           constraints: BoxConstraints(), // constraints
                        //           onPressed: () {
                        //             setState(() {
                        //               Status.isOpen = !Status.isOpen;
                        //               progressArea!.setOpen();
                        //             });
                        //           },
                        //           icon: Icon(
                        //             Status.isOpen
                        //                 ? Icons.arrow_left
                        //                 : Icons.arrow_right,
                        //             color: Colors.white,
                        //             size: 25,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                //right body content('실시간작업영상 / 알림 / 실시간작업자BIO')
                Flexible(
                  flex: Status.isOpen ? 2 : 11,
                  child: Container(
                      // margin: Status.isOpen
                      //     ? EdgeInsets.symmetric(horizontal: width * 0.005)
                      //     : EdgeInsets.only(
                      //         left: width * 0.01, right: width * 0.05),
                      // color: Colors.green,
                      child: Status.isOpen
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                VideoArea(),
                                // CareNotice(),
                                WorkerArea(),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                VideoArea(),
                                CareNotice(),
                              ],
                            )),
                ),
              ],
            ),
            FadeIn.status
                ? FadeTransition(
                    opacity: animation,
                    child: InkWell(
                      // onDoubleTap: () => FadeIn.status = false,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 96, 96, 0.5),
                        ),
                      ),
                    ),
                  )
                : Text(""),
            isRisk
                ? AlertDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    content: Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorSelect.blueColor, width: 2),
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.white),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 15, bottom: 10),
                              child: Column(
                                children: [
                                  Image.asset('assets/img/위험성평가1.png'),
                                  Image.asset('assets/img/위험성평가2.png'),
                                  Image.asset('assets/img/위험성평가3.png'),
                                  Image.asset('assets/img/위험성평가4.png'),
                                ],
                              ),
                            ),
                            //확인버튼
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: ColorSelect.blueColor,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  child: const Text(
                                    "확인",
                                    textScaleFactor: FontSize.h6,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      // Navigator.of(context).pop();
                                      isRisk = false;
                                      scrollController = ScrollController();
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            //접기/펼치기 버튼
          ],
        ),
      ),
    );
  }
}
