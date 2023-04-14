import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:kepco_safety_iot/models/models.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class WorkerStatus extends StatefulWidget {
  WorkerStatus({Key? key, required this.states}) : super(key: key);

  final List<SingleState> states;

  final _WorkerStatusState state = _WorkerStatusState();

  void onSelectWorker(int index) {
    state.onSelectWorker(index);
  }

  void gotoNextWorker() {
    state.gotoNextWorker();
  }

  void gotoPrevWorker() {
    state.gotoPrevWorker();
  }

  void onRendom() {
    state.onRendom();
  }

  @override
  State<WorkerStatus> createState() => state;
}

class _WorkerStatusState extends State<WorkerStatus> {
  late List<SingleState> states;

  late Timer _timer;

  final _controller = ScrollController();

  int systolic = 90 + Random().nextInt(120 - 90);
  int diastolic = 60 + Random().nextInt(70 - 60);

  bool isFunction = false;

  void showRiskPop(bool state) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          titlePadding: EdgeInsets.only(left: 10.0, right: 10.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Center(
                  child: Container(
                    width: width * 0.1,
                    height: height * 0.1,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 15, bottom: 20, left: 20, right: 20),
                              width: 420,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: const [
                                  BoxShadow(
                                    color: ColorSelect.redColor,
                                    spreadRadius: 1,
                                    blurRadius: 20,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "체온 이상 주의요망",
                                        textScaleFactor: FontSize.h4,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: ColorSelect.redColor),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 7.0),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.close_rounded,
                                            color: ColorSelect.redColor,
                                            size: 33,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    'assets/svg/체온이상팝업.svg',
                                    color: ColorSelect.redColor,
                                    width: 90,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '작업자3',
                                          textScaleFactor: FontSize.h4_5,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            '홍길동',
                                            textScaleFactor: FontSize.h4_5,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                            flex: 10, child: Dropdownwork()),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Flexible(
                                            flex: 2,
                                            child: SizedBox(
                                              height: 50,
                                              child: TextButton(
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.black),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(ColorSelect
                                                                .redColor)),
                                                child: Text("확인",
                                                    textScaleFactor:
                                                        FontSize.h5,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        // Container(
                        //   alignment: FractionalOffset(0.5, 0.17),
                        //   child: FractionallySizedBox(
                        //     widthFactor: 1 / 4,
                        //     heightFactor: 1 / 4,
                        //     child: Image.asset(
                        //       "assets/img/그룹 20783.png",
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void onRendom() {
    if (_timer.isActive) {
      _timer.cancel();
    }

    systolic = 90 + Random().nextInt(120 - 90);
    diastolic = 60 + Random().nextInt(70 - 60);

    toTimer();
  }

  void onSelectWorker(int index) {
    setState(() {
      selectedIndex = index;
      _controller.animateTo(100.0 * selectedIndex,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn);
    });
  }

  void gotoNextWorker() {
    setState(() {
      if (selectedIndex < states.length - 1) {
        selectedIndex++;
        _controller.animateTo(100.0 * selectedIndex,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      }
    });
  }

  void gotoPrevWorker() {
    setState(() {
      if (selectedIndex > 0) {
        selectedIndex--;
        _controller.animateTo(100.0 * selectedIndex,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      }
    });
  }

  void toTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (systolic >= 130 || diastolic >= 80) {
        // print('===> 높음');
        if (systolic >= 130) systolic = systolic - 10;
        if (diastolic >= 80) diastolic = diastolic - 5;
        if (isFunction) {
          showRiskPop(true);
        }
      } else if (systolic <= 80 || diastolic <= 50) {
        // print('===> 낮음');
        if (systolic <= 80) systolic = systolic + 10;
        if (diastolic <= 50) diastolic = diastolic + 5;
        if (isFunction) {
          showRiskPop(false);
        }
      }

      var random;

      setState(() {
        random = Random().nextInt(10) + 1;
        // print(random);
        if (random > 2 && random < 9) {
          if (systolic < diastolic + 20) {
            systolic++;
          }
        } else if (random > 8) {
          if (systolic < diastolic + 20) {
            systolic++;
          } else if (systolic >= 220) {
            systolic--;
          } else {
            systolic++;
          }
        } else {
          if (systolic < diastolic + 20) {
            systolic++;
          } else if (systolic <= 60) {
            systolic++;
          } else {
            systolic--;
          }
        }
        random = Random().nextInt(10) + 1;
        if (random > 2 && random < 9) {
          if (systolic < diastolic + 20) {
            systolic++;
          }
        } else if (random > 8) {
          if (systolic < diastolic + 20) {
            systolic++;
          } else if (diastolic >= 140) {
            diastolic--;
          } else {
            diastolic++;
          }
        } else {
          if (systolic < diastolic + 20) {
            systolic++;
          } else if (systolic <= 40) {
            systolic++;
          } else {
            systolic--;
          }
        }
      });
    });
  }

  @override
  void initState() {
    states = widget.states;
    toTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SizedBox(
      width: width * 0.38,
      height: height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // SizedBox(
          //   width: double.infinity,
          //   height: height * 0.045,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //         height: height * 0.45,
          //         padding: EdgeInsets.symmetric(horizontal: width * 0.001),
          //         child: IconButton(
          //           padding: EdgeInsets.zero, // 패딩 설정
          //           constraints: BoxConstraints(), // constraints
          //           splashRadius: 20.0,
          //           icon: const Icon(
          //             Icons.arrow_back_ios_new_rounded,
          //             color: ColorSelect.blueColor,
          //           ),
          //           onPressed: () {
          //             gotoPrevWorker();
          //             onRendom();
          //           },
          //         ),
          //       ),
          //       Expanded(
          //         child: ListView.builder(
          //           shrinkWrap: true,
          //           scrollDirection: Axis.horizontal,
          //           controller: _controller,
          //           itemCount: buildStates().length,
          //           itemBuilder: (context, index) => buildStates()[index],
          //         ),
          //       ),
          //       Container(
          //         height: height * 0.45,
          //         padding: EdgeInsets.symmetric(horizontal: width * 0.001),
          //         child: IconButton(
          //           padding: EdgeInsets.zero, // 패딩 설정
          //           constraints: BoxConstraints(), // constraints
          //           splashRadius: 20.0,
          //           icon: const Icon(
          //             Icons.arrow_forward_ios_rounded,
          //             color: ColorSelect.blueColor,
          //           ),
          //           onPressed: () {
          //             gotoNextWorker();
          //             onRendom();
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          //신체이상,스트레스 상태
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Container(
                  width: width * 0.185,
                  height: height * 0.37,
                  padding: EdgeInsets.all(width * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: ColorSelect.shadowColor,
                        spreadRadius: 1,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "신체이상 상태",
                        style: TextStyle(
                            fontSize: width * 0.011,
                            fontFamily: 'SUIT',
                            color: ColorSelect.grayColor2,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        width: width * 0.07,
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedIndex != 1
                                ? HealthStatus.bodyStatus == 2
                                    ? Color.fromRGBO(255, 96, 96, 1.0)
                                    : HealthStatus.bodyStatus == 1
                                        ? Color.fromRGBO(255, 196, 0, 1.0)
                                        : Color.fromRGBO(106, 219, 132, 1.0)
                                : Color.fromRGBO(106, 219, 132, 1.0),
                            width: 4,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SpinKitPumpingHeart(
                              // color: Colors.red,
                              itemBuilder: (BuildContext context, int index) {
                                return SvgPicture.asset(
                                  'assets/svg/신체이상상태_2.svg',
                                  color: selectedIndex != 1
                                      ? HealthStatus.bodyStatus == 2
                                          ? Color.fromRGBO(255, 96, 96, 1.0)
                                          : HealthStatus.bodyStatus == 1
                                              ? Color.fromRGBO(255, 196, 0, 1.0)
                                              : Color.fromRGBO(
                                                  106, 219, 132, 1.0)
                                      : Color.fromRGBO(106, 219, 132, 1.0),
                                  width: width * 0.023,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: width * 0.04,
                                height: height * 0.062,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedIndex != 1
                                      ? HealthStatus.bodyStatus == 2
                                          ? Color.fromRGBO(255, 223, 223, 1.0)
                                          : Color.fromRGBO(234, 237, 240, 1.0)
                                      : Color.fromRGBO(234, 237, 240, 1.0),
                                ),
                                child: SvgPicture.asset(
                                  'assets/svg/신체이상_위험.svg',
                                  fit: BoxFit.contain,
                                  color: selectedIndex != 1
                                      ? HealthStatus.bodyStatus == 2
                                          ? Color.fromRGBO(255, 96, 96, 1.0)
                                          : Color.fromRGBO(149, 164, 180, 1.0)
                                      : Color.fromRGBO(149, 164, 180, 1.0),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(5.0)),
                              Text(
                                "위험",
                                style: TextStyle(
                                    fontSize: width * 0.01,
                                    fontFamily: 'SUIT',
                                    color: selectedIndex != 1
                                        ? HealthStatus.bodyStatus == 2
                                            ? Color.fromRGBO(255, 96, 96, 1.0)
                                            : Color.fromRGBO(149, 164, 180, 1.0)
                                        : Color.fromRGBO(149, 164, 180, 1.0),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: width * 0.04,
                                height: height * 0.062,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedIndex != 1
                                      ? HealthStatus.bodyStatus == 1
                                          ? Color.fromRGBO(255, 243, 204, 1.0)
                                          : Color.fromRGBO(234, 237, 240, 1.0)
                                      : Color.fromRGBO(234, 237, 240, 1.0),
                                ),
                                child: SvgPicture.asset(
                                    'assets/svg/신체이상_주의.svg',
                                    color: selectedIndex != 1
                                        ? HealthStatus.bodyStatus == 1
                                            ? Color.fromRGBO(255, 196, 0, 1.0)
                                            : Color.fromRGBO(149, 164, 180, 1.0)
                                        : Color.fromRGBO(149, 164, 180, 1.0),
                                    fit: BoxFit.contain),
                              ),
                              Padding(padding: EdgeInsets.all(5.0)),
                              Text(
                                "주의",
                                style: TextStyle(
                                    fontSize: width * 0.01,
                                    fontFamily: 'SUIT',
                                    color: selectedIndex != 1
                                        ? HealthStatus.bodyStatus == 1
                                            ? Color.fromRGBO(255, 196, 0, 1.0)
                                            : Color.fromRGBO(149, 164, 180, 1.0)
                                        : Color.fromRGBO(149, 164, 180, 1.0),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: width * 0.04,
                                height: height * 0.062,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedIndex != 1
                                      ? HealthStatus.bodyStatus == 0
                                          ? Color.fromRGBO(225, 248, 230, 1.0)
                                          : Color.fromRGBO(234, 237, 240, 1.0)
                                      : Color.fromRGBO(225, 248, 230, 1.0),
                                ),
                                child: SvgPicture.asset(
                                    'assets/svg/신체이상_정상.svg',
                                    color: selectedIndex != 1
                                        ? HealthStatus.bodyStatus == 0
                                            ? Color.fromRGBO(106, 219, 132, 1.0)
                                            : Color.fromRGBO(149, 164, 180, 1.0)
                                        : Color.fromRGBO(106, 219, 132, 1.0),
                                    fit: BoxFit.contain),
                              ),
                              Padding(padding: EdgeInsets.all(5.0)),
                              Text(
                                "정상",
                                style: TextStyle(
                                  fontSize: width * 0.01,
                                  fontFamily: 'SUIT',
                                  color: selectedIndex != 1
                                      ? HealthStatus.bodyStatus == 0
                                          ? Color.fromRGBO(106, 219, 132, 1.0)
                                          : Color.fromRGBO(149, 164, 180, 1.0)
                                      : Color.fromRGBO(106, 219, 132, 1.0),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return WorkerStatusPopup(list: states);
                    },
                  );
                },
              ),
              InkWell(
                child: Container(
                  width: width * 0.185,
                  height: height * 0.37,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: ColorSelect.shadowColor,
                        spreadRadius: 1,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "스트레스 상태",
                        style: TextStyle(
                            fontSize: width * 0.011,
                            fontFamily: 'SUIT',
                            color: ColorSelect.grayColor2,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        width: width * 0.07,
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedIndex != 1
                                ? HealthStatus.stressStatus == 2
                                    ? Color.fromRGBO(255, 96, 96, 1.0)
                                    : HealthStatus.stressStatus == 1
                                        ? Color.fromRGBO(255, 196, 0, 1.0)
                                        : Color.fromRGBO(106, 219, 132, 1.0)
                                : Color.fromRGBO(106, 219, 132, 1.0),
                            width: 4,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SpinKitPumpingHeart(
                              // color: Colors.red,
                              itemBuilder: (BuildContext context, int index) {
                                return SvgPicture.asset(
                                  'assets/svg/스트레스정상.svg',
                                  color: selectedIndex != 1
                                      ? HealthStatus.stressStatus == 2
                                          ? Color.fromRGBO(255, 96, 96, 1.0)
                                          : HealthStatus.stressStatus == 1
                                              ? Color.fromRGBO(255, 196, 0, 1.0)
                                              : Color.fromRGBO(
                                                  106, 219, 132, 1.0)
                                      : Color.fromRGBO(106, 219, 132, 1.0),
                                  width: width * 0.018,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: width * 0.04,
                                height: height * 0.062,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedIndex != 1
                                      ? HealthStatus.stressStatus == 2
                                          ? Color.fromRGBO(255, 223, 223, 1.0)
                                          : Color.fromRGBO(234, 237, 240, 1.0)
                                      : Color.fromRGBO(234, 237, 240, 1.0),
                                ),
                                child: SvgPicture.asset('assets/svg/스트레스위험.svg',
                                    color: selectedIndex != 1
                                        ? HealthStatus.stressStatus == 2
                                            ? Color.fromRGBO(255, 96, 96, 1.0)
                                            : Color.fromRGBO(149, 164, 180, 1.0)
                                        : Color.fromRGBO(149, 164, 180, 1.0),
                                    fit: BoxFit.scaleDown),
                              ),
                              Padding(padding: EdgeInsets.all(5.0)),
                              Text(
                                "위험",
                                style: TextStyle(
                                    fontSize: width * 0.01,
                                    fontFamily: 'SUIT',
                                    color: selectedIndex != 1
                                        ? HealthStatus.stressStatus == 2
                                            ? Color.fromRGBO(255, 96, 96, 1.0)
                                            : Color.fromRGBO(149, 164, 180, 1.0)
                                        : Color.fromRGBO(149, 164, 180, 1.0),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: width * 0.04,
                                height: height * 0.062,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedIndex != 1
                                      ? HealthStatus.stressStatus == 1
                                          ? Color.fromRGBO(255, 243, 204, 1.0)
                                          : Color.fromRGBO(234, 237, 240, 1.0)
                                      : Color.fromRGBO(234, 237, 240, 1.0),
                                ),
                                child: SvgPicture.asset('assets/svg/스트레스주의.svg',
                                    color: selectedIndex != 1
                                        ? HealthStatus.stressStatus == 1
                                            ? Color.fromRGBO(255, 196, 0, 1.0)
                                            : Color.fromRGBO(149, 164, 180, 1.0)
                                        : Color.fromRGBO(149, 164, 180, 1.0),
                                    fit: BoxFit.scaleDown),
                              ),
                              Padding(padding: EdgeInsets.all(5.0)),
                              Text(
                                "주의",
                                style: TextStyle(
                                    fontSize: width * 0.01,
                                    fontFamily: 'SUIT',
                                    color: selectedIndex != 1
                                        ? HealthStatus.stressStatus == 1
                                            ? Color.fromRGBO(255, 196, 0, 1.0)
                                            : Color.fromRGBO(149, 164, 180, 1.0)
                                        : Color.fromRGBO(149, 164, 180, 1.0),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: width * 0.04,
                                height: height * 0.062,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedIndex != 1
                                      ? HealthStatus.stressStatus == 0
                                          ? Color.fromRGBO(225, 248, 230, 1.0)
                                          : Color.fromRGBO(234, 237, 240, 1.0)
                                      : Color.fromRGBO(225, 248, 230, 1.0),
                                ),
                                child: SvgPicture.asset('assets/svg/스트레스정상.svg',
                                    color: selectedIndex != 1
                                        ? HealthStatus.stressStatus == 0
                                            ? Color.fromRGBO(106, 219, 132, 1.0)
                                            : Color.fromRGBO(149, 164, 180, 1.0)
                                        : Color.fromRGBO(106, 219, 132, 1.0),
                                    fit: BoxFit.scaleDown),
                              ),
                              Padding(padding: EdgeInsets.all(5.0)),
                              Text(
                                "정상",
                                style: TextStyle(
                                    fontSize: width * 0.01,
                                    fontFamily: 'SUIT',
                                    color: selectedIndex != 1
                                        ? HealthStatus.stressStatus == 0
                                            ? Color.fromRGBO(106, 219, 132, 1.0)
                                            : Color.fromRGBO(149, 164, 180, 1.0)
                                        : Color.fromRGBO(106, 219, 132, 1.0),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return WorkerStatusPopup(list: states);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width * 0.38,
  //     child: Column(
  //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.04,
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               const Text(
  //                 "실시간 작업자 BIO",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //               ),
  //               isFunction
  //                   ? Text("")
  //                   : IconButton(
  //                       onPressed: () => showRiskPop(true),
  //                       icon: Icon(Icons.access_alarm))
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           width: double.infinity,
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 width: double.infinity,
  //                 height: MediaQuery.of(context).size.height * 0.06,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     IconButton(
  //                       padding: EdgeInsets.zero,
  //                       icon: const Icon(
  //                         Icons.arrow_back_ios_new_rounded,
  //                         color: ColorSelect.blueColor,
  //                       ),
  //                       onPressed: () {
  //                         gotoPrevWorker();
  //                         onRendom();
  //                       },
  //                     ),
  //                     SizedBox(
  //                       width: MediaQuery.of(context).size.width * 0.3,
  //                       child: ListView.builder(
  //                         scrollDirection: Axis.horizontal,
  //                         controller: _controller,
  //                         itemCount: buildStates().length,
  //                         itemBuilder: (context, index) => buildStates()[index],
  //                       ),
  //                     ),
  //                     IconButton(
  //                       padding: EdgeInsets.zero,
  //                       icon: Icon(
  //                         Icons.arrow_forward_ios_rounded,
  //                         color: ColorSelect.blueColor,
  //                       ),
  //                       onPressed: () {
  //                         gotoNextWorker();
  //                         onRendom();
  //                       },
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               Container(
  //                 width: double.infinity,
  //                 height: MediaQuery.of(context).size.height * 0.18,
  //                 padding: EdgeInsets.all(10.0),
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   color: Colors.white,
  //                   boxShadow: const [
  //                     BoxShadow(
  //                       color: ColorSelect.shadowColor,
  //                       spreadRadius: 1,
  //                       blurRadius: 6,
  //                     ),
  //                   ],
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Expanded(
  //                       flex: 3,
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: SizedBox(
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                             children: [
  //                               Stack(
  //                                 children: const [
  //                                   Align(
  //                                     alignment: Alignment.topLeft,
  //                                     child: Text(
  //                                       '혈압',
  //                                       textScaleFactor: FontSize.h6,
  //                                       style: TextStyle(
  //                                           fontWeight: FontWeight.w600,
  //                                           color: Colors.black),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceEvenly,
  //                                 children: [
  //                                   BioCircle(
  //                                     size: MediaQuery.of(context).size.width *
  //                                         0.06,
  //                                     color: ColorSelect.skyColor,
  //                                     title: "수축기",
  //                                     variable: systolic,
  //                                   ),
  //                                   BioCircle(
  //                                     size: MediaQuery.of(context).size.width *
  //                                         0.06,
  //                                     color: ColorSelect.redColor,
  //                                     title: "이완기",
  //                                     variable: diastolic,
  //                                   ),
  //                                   BioCircle(
  //                                     size: MediaQuery.of(context).size.width *
  //                                         0.06,
  //                                     color: ColorSelect.greenColor,
  //                                     title: "평균",
  //                                     variable:
  //                                         ((systolic + diastolic) / 2).round(),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     const VerticalDivider(
  //                         color: ColorSelect.dividerColor, thickness: 1),
  //                     Expanded(
  //                       flex: 2,
  //                       child: SizedBox(
  //                         child: Column(
  //                           children: [
  //                             Expanded(
  //                               flex: 1,
  //                               child: Column(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceEvenly,
  //                                 children: [
  //                                   Stack(
  //                                     children: const [
  //                                       Align(
  //                                         alignment: Alignment.topLeft,
  //                                         child: Text(
  //                                           '체온',
  //                                           textScaleFactor: FontSize.h6,
  //                                           style: TextStyle(
  //                                             fontWeight: FontWeight.bold,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.spaceBetween,
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.end,
  //                                     children: const [
  //                                       Text(
  //                                         "정상",
  //                                         textScaleFactor: FontSize.h4,
  //                                         style: TextStyle(
  //                                             fontWeight: FontWeight.w600,
  //                                             color: ColorSelect.greenColor),
  //                                       ),
  //                                       Padding(
  //                                         padding: EdgeInsets.only(
  //                                             left: 18.0, right: 12.0),
  //                                         child: Text(
  //                                           "36.5",
  //                                           textScaleFactor: 2,
  //                                           style: TextStyle(
  //                                             height: 1,
  //                                             color: ColorSelect.greenColor,
  //                                             fontWeight: FontWeight.bold,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       Text(
  //                                         "°C",
  //                                         textScaleFactor: FontSize.h3,
  //                                         style: TextStyle(
  //                                             height: 1,
  //                                             fontWeight: FontWeight.w600,
  //                                             color: ColorSelect.greenColor),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             const Divider(
  //                                 color: ColorSelect.dividerColor,
  //                                 thickness: 1),
  //                             Expanded(
  //                               flex: 1,
  //                               child: Column(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceEvenly,
  //                                 children: [
  //                                   Stack(
  //                                     children: [
  //                                       Align(
  //                                         alignment: Alignment.topLeft,
  //                                         child: Text(
  //                                           '산소포화도',
  //                                           textScaleFactor: FontSize.h6,
  //                                           style: TextStyle(
  //                                             fontWeight: FontWeight.bold,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.spaceBetween,
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.end,
  //                                     children: [
  //                                       Text(
  //                                         "이상",
  //                                         style: TextStyle(
  //                                             fontWeight: FontWeight.w600,
  //                                             fontSize: 20,
  //                                             color: ColorSelect.redColor),
  //                                       ),
  //                                       Padding(
  //                                         padding: EdgeInsets.only(
  //                                             left: 18.0, right: 12.0),
  //                                         child: Text(
  //                                           "120",
  //                                           textScaleFactor: 2,
  //                                           style: TextStyle(
  //                                             height: 1,
  //                                             color: ColorSelect.redColor,
  //                                             fontWeight: FontWeight.bold,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       Text("bpm",
  //                                           textScaleFactor: FontSize.h3,
  //                                           style: TextStyle(
  //                                               height: 1,
  //                                               fontWeight: FontWeight.w600,
  //                                               color: ColorSelect.redColor)),
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  List<Widget> buildStates() {
    List<Widget> allStates = [];
    int len = states.length;

    for (var i = 0; i < len; i++) {
      allStates.add(_RenderedState(
        name: states[i].name,
        isCurrent: i == selectedIndex,
        index: i,
        widget: widget,
      ));
    }

    return allStates;
  }
}

class BioCircle extends StatelessWidget {
  const BioCircle({
    Key? key,
    required this.size,
    required this.color,
    required this.title,
    required this.variable,
  }) : super(key: key);

  final double size;
  final Color color;
  final String title;
  final int variable;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          width: 6,
          color: color,
        ),
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "$title",
            textScaleFactor: FontSize.h5,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: ColorSelect.moregrayColor),
          ),
          Text(
            "$variable",
            textScaleFactor: FontSize.h2,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _RenderedState extends StatelessWidget {
  const _RenderedState({
    Key? key,
    required this.name,
    required this.isCurrent,
    required this.index,
    required this.widget,
  }) : super(key: key);

  final String name;
  final bool isCurrent;
  final int index;

  final WorkerStatus widget;

  Color getBackColor() {
    return isCurrent ? ColorSelect.blueColor : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Container(
      width: width * 0.1,
      margin: EdgeInsets.only(
          top: height * 0.005, bottom: height * 0.005, right: width * 0.008),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isCurrent
                ? Color.fromRGBO(69, 94, 238, 0.5)
                : Color.fromRGBO(160, 160, 160, 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(3, 3),
          ),
        ],
        color: getBackColor(),
      ),
      child: OutlinedButton(
        child: Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: width * 0.01,
              fontFamily: 'SUIT',
              color: isCurrent ? Colors.white : ColorSelect.grayColor),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 0.0, color: Colors.transparent),
        ),
        onPressed: () {
          widget.onSelectWorker(index);
          widget.onRendom();
        },
      ),
    );
  }
}

class SingleState {
  SingleState({required this.name});

  String name;
}

class Dropdownwork extends StatefulWidget {
  const Dropdownwork({Key? key}) : super(key: key);

  @override
  State<Dropdownwork> createState() => _DropdownworkState();
}

class _DropdownworkState extends State<Dropdownwork> {
  final List<String> items = [
    '조치완료',
    '오류',
    '특이사항 입력',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: ColorSelect.grayColor,
                width: 1,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8)),
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.search,
                size: 26,
                color: Colors.white,
              ),
              Text(
                '조치상태',
                style: TextStyle(
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w500,
                  color: ColorSelect.grayColor,
                ),
              ),
            ],
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          iconEnabledColor: Color(0xffd5d5d5),
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
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// -------------주의 알림_팝업--------------------
class WorkerStatusPopup extends StatefulWidget {
  const WorkerStatusPopup({
    Key? key,
    required this.list,
  }) : super(key: key);
  final List list;

  @override
  State<WorkerStatusPopup> createState() => _WorkerStatusPopupState();
}

class _WorkerStatusPopupState extends State<WorkerStatusPopup> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(children: [
            Container(
                width: width * 0.8,
                height: height * 0.75,
                padding: EdgeInsets.only(
                    left: width * 0.013,
                    right: width * 0.013,
                    top: width * 0.015,
                    bottom: width * 0.01),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.012, bottom: width * 0.015),
                      child: Text(
                        "근로자 상태 (상세 팝업)",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.016,
                          fontFamily: 'SUIT',
                        ),
                      ),
                    ),
                    Expanded(
                        child: GridView.builder(
                      itemCount: 6,
                      padding: EdgeInsets.all(width * 0.01),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: width * 0.025,
                        crossAxisSpacing: width * 0.025,
                        crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                        childAspectRatio: 1 / 0.7, //item 의 가로 1, 세로 2 의 비율
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: width * 0.006,
                          height: height * 0.004,
                          padding: EdgeInsets.all(width * 0.01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(
                                color: Color.fromRGBO(234, 237, 240, 1),
                                width: 1),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.16),
                                spreadRadius: 1,
                                blurRadius: 10,
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.0025,
                                height: height * 0.22,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: height * 0.01),
                                child: SizedBox(
                                  width: width * 0.2,
                                  height: height * 0.3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width * 0.2,
                                        height: height * 0.1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: width * 0.1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "작업 책임자 A",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: width * 0.013,
                                                      fontFamily: 'SUIT',
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.person,
                                                        size: width * 0.011,
                                                        color: ColorSelect
                                                            .grayColor7,
                                                      ),
                                                      SizedBox(
                                                          width: width * 0.008),
                                                      Text(
                                                        "1987, 여성",
                                                        style: TextStyle(
                                                          color: ColorSelect
                                                              .grayColor7,
                                                          fontSize:
                                                              width * 0.009,
                                                          fontFamily: 'SUIT',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.phone,
                                                        size: width * 0.011,
                                                        color: ColorSelect
                                                            .grayColor7,
                                                      ),
                                                      SizedBox(
                                                          width: width * 0.008),
                                                      Text(
                                                        "010-1234-5678",
                                                        style: TextStyle(
                                                          color: ColorSelect
                                                              .grayColor7,
                                                          fontSize:
                                                              width * 0.009,
                                                          fontFamily: 'SUIT',
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.08,
                                              height: height * 0.085,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    ColorSelect.grayColor9,
                                                child: Icon(
                                                  Icons.person,
                                                  size: width * 0.04,
                                                  color: ColorSelect.grayColor6,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                        color: ColorSelect.grayColor7,
                                      ),
                                      SizedBox(
                                        width: width * 0.2,
                                        height: height * 0.1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "심박수",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: width * 0.01,
                                                    fontFamily: 'SUIT',
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  "134",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: width * 0.01,
                                                    color: Colors.red,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "체온",
                                                  style: TextStyle(
                                                    color:
                                                        ColorSelect.grayColor5,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: width * 0.01,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                                Text(
                                                  "36.2",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: width * 0.01,
                                                    color:
                                                        ColorSelect.grayColor5,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "스트레스 지수",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: width * 0.01,
                                                    fontFamily: 'SUIT',
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  "높음",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: width * 0.01,
                                                    color: Colors.red,
                                                    fontFamily: 'SUIT',
                                                  ),
                                                ),
                                              ],
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
                        );
                      },
                    )),
                  ],
                )),
            Positioned(
              right: width * 0.02,
              top: height * 0.02,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: width * 0.03,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(241, 245, 249, 1),
                      borderRadius: BorderRadius.circular(13)),
                  child: Icon(
                    Icons.close_rounded,
                    size: width * 0.03,
                    color: ColorSelect.grayColor,
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
