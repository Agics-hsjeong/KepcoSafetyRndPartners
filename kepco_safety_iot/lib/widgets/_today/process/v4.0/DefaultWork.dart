import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/GridToShoot.dart';
import 'package:kepco_safety_iot/widgets/common/TableBox.dart';
import 'package:kepco_safety_iot/pages/HomePage.dart';
import 'package:kepco_safety_iot/widgets/common/PDFScreen.dart';

class DefaultWork extends StatefulWidget {
  const DefaultWork({
    Key? key,
    required this.progressTimeline,
    required this.stateTitle,
    required this.single,
  }) : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<DefaultWork> createState() => _DefaultWorkState();
}

class _DefaultWorkState extends State<DefaultWork>
    with TickerProviderStateMixin {
  late ProgressTimeline progressTimeline;
  // late TableBox tableBox;
  bool _isLoading = false;

  bool cameraYn = false;

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;

    // print('===>32323232');

    cameraYn = true;
    super.initState();
  }

  @override
  void dispose() {
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.03),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.stateTitle.contains('마무리')
                      ? const SizedBox.shrink()
                      : const RiskIndex(),
                  widget.stateTitle.contains('마무리')
                      ? const SizedBox.shrink()
                      : TableBox(list: allStages),
                  widget.stateTitle.contains('마무리')
                      ? OutlinedButton(
                          onPressed: () {
                            pathPDF = '';
                            getFileFromUrl(
                                    '$url/site/report/${widget.single.state['cntwrkTySeq']}')
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
                          child: const Text("보고서",
                              style: TextStyle(
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.bold,
                                // fontSize: width * 0.012,
                                fontFamily: 'SUIT',
                              )))
                      : Container(
                          decoration: BoxDecoration(
                              color: ColorSelect.tableColor,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: imageStages, fit: BoxFit.fill)),
                          width: double.infinity,
                          height: height * 0.5,
                          // child: const Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Text("이미지 넣어주기",
                          //         style: TextStyle(
                          //             color: ColorSelect.headTextColor,
                          //             fontSize: 35,
                          //             fontWeight: FontWeight.bold),
                          //         textAlign: TextAlign.center),
                          //   ],
                          // ),
                        ),
                  // cameraYn && !widget.stateTitle.contains('마무리')
                  //     ? GridToShoot(single: widget.single)
                  //     : const SizedBox.shrink(),
                  // Padding(padding: EdgeInsets.only(bottom: height * 0.02)),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          child: const Icon(
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
                        // if (widget.stateTitle.contains('마무리')) putStatus(0);

                        widget.stateTitle.contains('마무리')
                            ? resetProc(widget.single.state)
                            : endProc(widget.single.state);

                        widget.stateTitle.contains('마무리')
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()))
                            : progressTimeline.gotoNextStage();
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
                            widget.stateTitle.contains('마무리') ? "작업종료" : "다음",
                            style: TextStyle(
                                fontSize: width * 0.01,
                                fontFamily: 'SUIT',
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.003),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: ColorSelect.blueColor,
                            ),
                          ),
                        ],
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

class RiskIndex extends StatelessWidget {
  const RiskIndex({Key? key}) : super(key: key);

  TextStyle textStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w500,
      fontSize: MediaQuery.of(context).size.width * 0.01,
      fontFamily: 'SUIT',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: MediaQuery.of(context).size.height * 0.08,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "작업 위험도 측정",
            style: textStyle(context),
          ),
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '가능성',
                      style: textStyle(
                        context,
                        color: const Color.fromRGBO(71, 106, 23, 1),
                      ),
                    ),
                    Text(
                      '3',
                      style: textStyle(
                        context,
                        color: const Color.fromRGBO(71, 106, 23, 1),
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(
                    thickness: 1, color: Color.fromRGBO(188, 188, 188, 1)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '중대성',
                      style: textStyle(
                        context,
                        color: const Color.fromRGBO(35, 47, 119, 1),
                      ),
                    ),
                    Text(
                      '3',
                      style: textStyle(
                        context,
                        color: const Color.fromRGBO(35, 47, 119, 1),
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(
                    thickness: 1, color: Color.fromRGBO(188, 188, 188, 1)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '위험성',
                      style: textStyle(
                        context,
                        color: const Color.fromRGBO(227, 6, 0, 1),
                      ),
                    ),
                    Text(
                      '3',
                      style: textStyle(
                        context,
                        color: const Color.fromRGBO(227, 6, 0, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: 8, color: Color.fromRGBO(241, 243, 248, 1)),
        ],
      ),
    );
  }
}
