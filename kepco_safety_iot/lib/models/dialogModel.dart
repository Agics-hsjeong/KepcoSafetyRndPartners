import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/models.dart';

import 'package:flutter_svg/flutter_svg.dart';

class ShowDialog {
  static void serviseDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.23,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 45,
                        color: ColorSelect.blueColor,
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Center(
                        child: Text(
                          TextModel.devService,
                          textScaleFactor: FontSize.h5,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                //확인버튼
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorSelect.blueColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      child: const Text(
                        TextModel.checkMessage,
                        textScaleFactor: FontSize.h6,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  static void testingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.23,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 45,
                        color: ColorSelect.blueColor,
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Center(
                        child: Text(
                          TextModel.workWaitMessage,
                          textScaleFactor: FontSize.h5,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                //확인버튼
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: ColorSelect.blueColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      child: const Text(
                        TextModel.checkMessage,
                        textScaleFactor: FontSize.h6,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  static void errorDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.23,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 45,
                        color: ColorSelect.redColor,
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Center(
                        child: Text(
                          TextModel.errorMessage,
                          textScaleFactor: FontSize.h5,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                //확인버튼
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorSelect.redColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      child: const Text(
                        TextModel.checkMessage,
                        textScaleFactor: FontSize.h6,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  static void quitDialog(
      BuildContext context, String title, dynamic Function()? onPressed) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            content: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 45,
                          color: ColorSelect.blueColor,
                        ),
                        Padding(padding: EdgeInsets.all(7)),
                        Center(
                          child: Text(
                            TextModel.workEndMessage,
                            textScaleFactor: FontSize.h5,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //확인버튼
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorSelect.blueColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: onPressed,
                          child: const Text(
                            TextModel.checkMessage,
                            textScaleFactor: FontSize.h6,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorSelect.grayColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            TextModel.cancelMessage,
                            textScaleFactor: FontSize.h6,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

void showRiskPop(BuildContext context, int numCheck) {
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
                  width: width * 0.4,
                  height: height * 0.4,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      numCheck == 1 ? "안전장구미착용" : "낙상주의",
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
                                  numCheck == 1
                                      ? 'assets/svg/스트레스위험.svg'
                                      : 'assets/svg/낙상주의.svg',
                                  color: ColorSelect.redColor,
                                  width: 90,
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       vertical: 10.0),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Text(
                                //         '작업자1',
                                //         textScaleFactor: FontSize.h4_5,
                                //         style: TextStyle(
                                //             fontWeight: FontWeight.w600),
                                //       ),
                                //       Padding(
                                //         padding:
                                //             const EdgeInsets.only(left: 10.0),
                                //         child: Text(
                                //           '홍길동',
                                //           textScaleFactor: FontSize.h4_5,
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.w500),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Flexible(
                                      //     flex: 10, child: Dropdownwork()),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Flexible(
                                          flex: 2,
                                          child: SizedBox(
                                            height: 50,
                                            child: TextButton(
                                              style: ButtonStyle(
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          ColorSelect
                                                              .redColor)),
                                              child: Text("확인",
                                                  textScaleFactor: FontSize.h5,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white)),
                                              onPressed: () {
                                                FadeIn.status = false;
                                                putStatus(1);
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
