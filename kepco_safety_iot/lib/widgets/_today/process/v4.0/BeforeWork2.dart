import 'dart:math';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/WorkerBox.dart';

class BeforeWork2 extends StatefulWidget {
  const BeforeWork2({
    Key? key,
    required this.progressTimeline,
    required this.stateTitle,
    required this.single,
  }) : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<BeforeWork2> createState() => _BeforeWork2State();
}

class _BeforeWork2State extends State<BeforeWork2>
    with TickerProviderStateMixin {
  late ProgressTimeline progressTimeline;
  Timer? _timer;

  int count = 0;

  // List<UserState> userStages = List.empty(growable: true);

  Future<void> getWorker() async {
    print("MQTTClient:: getWorker");
    await AiNetwork().FrRecognize();

    // if (count == 0) {
    //   var rendom1 = Random().nextInt(2);
    //   var rendom2 = Random().nextInt(2);
    //   var rendom3 = Random().nextInt(2);
    //   setState(() {
    //     userStages.add(
    //       UserState(
    //         name: "홍길동",
    //         age: "48",
    //         sex: "남",
    //         depart: "(주)금광전기",
    //         operatorNo: "GRM-201255446",
    //         career: "12",
    //         qualification: "N",
    //         deadline: "10",
    //         imgUrl: "assets/img/사용자 아이콘.png",
    //         equi: [
    //           EquipState(
    //             equipName: "안전모",
    //             isCheck: rendom1 == 0 ? false : true,
    //             analyze: rendom1 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "방염복",
    //             isCheck: rendom2 == 0 ? false : true,
    //             analyze: rendom2 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "안전화",
    //             isCheck: rendom3 == 0 ? false : true,
    //             analyze: rendom3 == 0 ? false : true,
    //           ),
    //         ],
    //       ),
    //     );
    //   });
    // } else if (count == 1) {
    //   var rendom1 = Random().nextInt(2);
    //   var rendom2 = Random().nextInt(2);
    //   var rendom3 = Random().nextInt(2);
    //   setState(() {
    //     userStages.add(
    //       UserState(
    //         name: "성춘향",
    //         age: "52",
    //         sex: "여",
    //         depart: "(주)금광전기",
    //         operatorNo: "GRM-201255445",
    //         career: "15",
    //         qualification: "N",
    //         deadline: "35",
    //         imgUrl: "",
    //         equi: [
    //           EquipState(
    //             equipName: "안전모",
    //             isCheck: rendom1 == 0 ? false : true,
    //             analyze: rendom1 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "방염복",
    //             isCheck: rendom2 == 0 ? false : true,
    //             analyze: rendom2 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "안전화",
    //             isCheck: rendom3 == 0 ? false : true,
    //             analyze: rendom3 == 0 ? false : true,
    //           ),
    //         ],
    //       ),
    //     );
    //   });
    // } else if (count == 2) {
    //   var rendom1 = Random().nextInt(2);
    //   var rendom2 = Random().nextInt(2);
    //   var rendom3 = Random().nextInt(2);
    //   setState(() {
    //     userStages.add(
    //       UserState(
    //         name: "이몽룡",
    //         age: "54",
    //         sex: "남",
    //         depart: "(주)금광전기",
    //         operatorNo: "GRM-201255447",
    //         career: "17",
    //         qualification: "N",
    //         deadline: "0",
    //         imgUrl: "assets/img/사용자 아이콘.png",
    //         equi: [
    //           EquipState(
    //             equipName: "안전모",
    //             isCheck: rendom1 == 0 ? false : true,
    //             analyze: rendom1 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "방염복",
    //             isCheck: rendom2 == 0 ? false : true,
    //             analyze: rendom2 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "안전화",
    //             isCheck: rendom3 == 0 ? false : true,
    //             analyze: rendom3 == 0 ? false : true,
    //           ),
    //         ],
    //       ),
    //     );
    //   });
    // } else if (count == 3) {
    //   var rendom1 = Random().nextInt(2);
    //   var rendom2 = Random().nextInt(2);
    //   var rendom3 = Random().nextInt(2);
    //   setState(() {
    //     userStages.add(
    //       UserState(
    //         name: "유관순",
    //         age: "30",
    //         sex: "여",
    //         depart: "(주)금광전기",
    //         operatorNo: "GRM-201255448",
    //         career: "3",
    //         qualification: "N",
    //         deadline: "0",
    //         imgUrl: "assets/img/사용자 아이콘.png",
    //         equi: [
    //           EquipState(
    //             equipName: "안전모",
    //             isCheck: rendom1 == 0 ? false : true,
    //             analyze: rendom1 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "방염복",
    //             isCheck: rendom2 == 0 ? false : true,
    //             analyze: rendom2 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "안전화",
    //             isCheck: rendom3 == 0 ? false : true,
    //             analyze: rendom3 == 0 ? false : true,
    //           ),
    //         ],
    //       ),
    //     );
    //   });
    // } else if (count == 4) {
    //   var rendom1 = Random().nextInt(2);
    //   var rendom2 = Random().nextInt(2);
    //   var rendom3 = Random().nextInt(2);
    //   setState(() {
    //     userStages.add(
    //       UserState(
    //         name: "유관순",
    //         age: "30",
    //         sex: "여",
    //         depart: "(주)금광전기",
    //         operatorNo: "GRM-201255448",
    //         career: "3",
    //         qualification: "N",
    //         deadline: "0",
    //         imgUrl: "assets/img/사용자 아이콘.png",
    //         equi: [
    //           EquipState(
    //             equipName: "안전모",
    //             isCheck: rendom1 == 0 ? false : true,
    //             analyze: rendom1 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "방염복",
    //             isCheck: rendom2 == 0 ? false : true,
    //             analyze: rendom2 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "안전화",
    //             isCheck: rendom3 == 0 ? false : true,
    //             analyze: rendom3 == 0 ? false : true,
    //           ),
    //         ],
    //       ),
    //     );
    //   });
    // } else if (count == 5) {
    //   var rendom1 = Random().nextInt(2);
    //   var rendom2 = Random().nextInt(2);
    //   var rendom3 = Random().nextInt(2);
    //   setState(() {
    //     userStages.add(
    //       UserState(
    //         name: "유관순",
    //         age: "30",
    //         sex: "여",
    //         depart: "(주)금광전기",
    //         operatorNo: "GRM-201255448",
    //         career: "3",
    //         qualification: "N",
    //         deadline: "0",
    //         imgUrl: "assets/img/사용자 아이콘.png",
    //         equi: [
    //           EquipState(
    //             equipName: "안전모",
    //             isCheck: rendom1 == 0 ? false : true,
    //             analyze: rendom1 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "방염복",
    //             isCheck: rendom2 == 0 ? false : true,
    //             analyze: rendom2 == 0 ? false : true,
    //           ),
    //           EquipState(
    //             equipName: "안전화",
    //             isCheck: rendom3 == 0 ? false : true,
    //             analyze: rendom3 == 0 ? false : true,
    //           ),
    //         ],
    //       ),
    //     );
    //   });
    // } else {
    //   _timer!.cancel();
    //   setState(() {
    //     isFinding = false;
    //     isFirst = true;
    //     isNext = true;
    //   });
    // }

    // print(count);
    // count++;
  }

  void findWorker() {
    setState(() {
      isFinding = true;
    });
    getWorker();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        userStages;
      });
    });
  }

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;

    // stratProc(widget.single.state);
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "| ${widget.stateTitle}",
              style: TextStyle(
                color: ColorSelect.blueColor,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.012,
                fontFamily: 'SUIT',
              ),
            ),
            // isFirst
            //     ? count >= 6
            //         ? const Text("")
            //         : InkWell(
            //             onTap: () {
            //               setState(() {
            //                 isFirst = false;
            //               });
            //               findWorker();
            //             },
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.cached_rounded,
            //                   color: ColorSelect.toggleColor3,
            //                   size: width * 0.015,
            //                 ),
            //                 Text(
            //                   " 인식 재시작",
            //                   style: TextStyle(
            //                       fontSize: width * 0.01,
            //                       color: ColorSelect.toggleColor3),
            //                 ),
            //               ],
            //             ),
            //           )
            //     : Text(""),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: GridView.builder(
                    itemCount: userStages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.9 / 0.63),
                    itemBuilder: (context, int index) {
                      return WorkerBox(
                        userState: userStages[index],
                        index: index,
                        allList: userStages,
                      );
                    },
                  ),
                ),
              ),
              isFirst
                  ? const Text("")
                  : ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Color.fromRGBO(255, 255, 255, 0.6),
                        ),
                      ),
                    ),
              isFirst
                  ? const Text("")
                  : Center(
                      child: Padding(
                        padding: isFinding
                            ? EdgeInsets.only(top: height * 0.01)
                            : EdgeInsets.only(top: 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: ColorSelect.toggleColor3,
                                    primary: isFinding
                                        ? Colors.white
                                        : ColorSelect.toggleColor3,
                                    fixedSize:
                                        Size(width * 0.11, height * 0.11),
                                    shape: const CircleBorder(),
                                  ),
                                  child: Icon(
                                    isFinding
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    size: width * 0.05,
                                    color: isFinding
                                        ? ColorSelect.toggleColor3
                                        : null,
                                  ),
                                  onPressed: () {
                                    findWorker();
                                  },
                                ),
                                isFinding
                                    ? TextButton(
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                vertical: height * 0.001,
                                                horizontal: width * 0.02)),
                                        child: SizedBox(
                                          width: width * 0.07,
                                          height: height * 0.108,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            backgroundColor:
                                                ColorSelect.toggleColor3,
                                            strokeWidth: 10,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _timer!.cancel();
                                            isFinding = false;
                                            isFirst = true;
                                          });
                                        },
                                      )
                                    : const Text(""),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.03),
                              child: Text(
                                isFinding ? '인식중 입니다.' : '인식 시작',
                                style: TextStyle(
                                    fontSize: width * 0.02,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.04),
                              child: isFinding
                                  ? Text("")
                                  : RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontSize: width * 0.016,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                          children: [
                                            TextSpan(text: '제대로 된 인식을 위해 \n'),
                                            TextSpan(
                                                text: '카메라 위치 조정',
                                                style: TextStyle(
                                                    color: ColorSelect
                                                        .toggleTextColor)),
                                            TextSpan(text: '을 해주세요'),
                                          ])),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      progressTimeline.gotoPreviousStage();
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: width * 0.003),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: ColorSelect.textColor3,
                          ),
                        ),
                        Text(
                          "이전",
                          style: TextStyle(
                              fontSize: width * 0.01,
                              fontFamily: 'SUIT',
                              color: ColorSelect.textColor3,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.008, bottom: height * 0.008),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        progressTimeline.gotoNextStage();
                        endProc(widget.single.state);
                        isNext = false;
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "다음",
                            style: TextStyle(
                                fontSize: width * 0.01,
                                fontFamily: 'SUIT',
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.003),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: ColorSelect.blueColor,
                            ),
                          ),
                        ],
                      ),
                    )
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
