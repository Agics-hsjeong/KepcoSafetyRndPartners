import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/common/PDFScreen.dart';

import 'process/all.dart';

/// Created by Luciferx86 on 08/09/20.
// ignore: must_be_immutable
class ProgressTimeline extends StatefulWidget {
  /// a List of all states to be rendered
  final List<SingleState> states;

  /// height of the widget
  final double? height;

  /// Icon used to render a checked stage
  final Icon? checkedIcon;

  /// Icon used to render current stage
  final Icon? currentIcon;

  /// Icon used to render a failed stage
  final Icon? failedIcon;

  /// Icon used to render an unchecked stage
  final Icon? uncheckedIcon;

  /// Color of the connectors
  final Color? connectorColor;

  /// Length of the connectors
  final double? connectorLength;

  /// Width of the connectors
  final double? connectorWidth;

  ///Size of Icons rendered in each stage
  final double? iconSize;

  /// Style of text used to display stage title
  final TextStyle? textStyle;

  late bool isOpen = true;

  ProgressTimeline({
    Key? key,
    required this.states,
    this.height,
    this.checkedIcon,
    this.currentIcon,
    this.failedIcon,
    this.iconSize,
    this.textStyle,
    this.connectorLength,
    this.connectorWidth,
    this.connectorColor,
    this.uncheckedIcon,
  }) : super(key: key);

  var state = _ProgressTimelineState();

  void setOpen() {
    state.setOpen();
  }

  void gotoNextStage() {
    state.gotoNextStage();
  }

  void failCurrentStage() {
    state.failCurrentStage();
  }

  void gotoPreviousStage() {
    state.gotoPreviousStage();
  }

  void initStage() {
    print('===>states $states');

    state.initStage();
  }

  @override
  _ProgressTimelineState createState() => state;
}

class _ProgressTimelineState extends State<ProgressTimeline> {
  // late List<SingleState> states;

  final _controller = ItemScrollController();
  int currentStageIndex = 0;

  bool _isLoading = false;

  GwMQTTClient gwMQTTClient = GwMQTTClient();

  final FlutterTts tts = FlutterTts();

  _ProgressTimelineState() {
    tts.setLanguage('ko');
    tts.setSpeechRate(0.4);
  }

  @override
  void initState() {
    print('===>initState');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    gwMQTTClient.disconnect();
  }

  Future<void> setupGwMqttClient() async {
    await gwMQTTClient.connect();
    gwMQTTClient.subscribe(PL_TOPIC);
  }

  void setupGwUpdatesListener() async {
    gwMQTTClient
        .getMessagesStream()
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      print('MQTTClient:: $recMess');
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');

      if (c[0].topic == PL_TOPIC) {
        // widget.cnt()
        if (jsonDecode(pt)["data"]['step1'] == 0) {
          if (!FadeIn.status) {
            setState(() {
              FadeIn.status = true;
            });

            showRiskPop(context, 0);
            putStatus(2);
            tts.speak('위험감지가 확인되었습니다. 알림을 확인해주세요!');
            gwMQTTClient.disconnect();

            AiNetwork().BiDetectStop();
            AiNetwork().OdWorkDetectStop();

            setupAiMqttClient();
            setupAiUpdatesListener(context);
          }
          print('MQTTClient::Message error');
        }
      }
    });
  }

  void setOpen() {
    setState(() {
      Status.isOpen;
    });
  }

  void initStage() {
    // print('===>initStage ${currentStageIndex}');
    // print('===>initStage ${widget.states}');
    // setState(() {
    //   currentStageIndex = 0;
    //   widget.states;
    // });
    currentStageIndex = 0;
    gotoPreviousStage();
  }

  void gotoNextStage() {
    // print('===>initStage ${currentStageIndex}');
    setState(() {
      if (widget.states[currentStageIndex].isFailed == true) {
      } else {
        if (currentStageIndex < widget.states.length - 1) {
          currentStageIndex++;

          _controller.scrollTo(
              index: currentStageIndex - 1,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn);
        }
        stratProc(widget.states[currentStageIndex].state);
        checkPoint(widget.states[currentStageIndex].titleNumber);

        if (widget.states[currentStageIndex].titleNumber == '1.3') {
          print('MQTTClient:: odconsetup');
          AiNetwork().OdConSetup();
        } else if (widget.states[currentStageIndex].titleNumber == '4') {
          AiNetwork().OdWorkDetect();
          AiNetwork().BiDetect();
          setupGwMqttClient();
          setupGwUpdatesListener();
        } else if (widget.states[currentStageIndex].titleNumber == '6') {
          AiNetwork().OdWorkDetect();
          // AiNetwork().OdWorkDetectStop();
        } else if (widget.states[currentStageIndex].titleNumber == '7') {
          AiNetwork().OdWorkDetectStop();

          lastProc(widget.states[currentStageIndex].state);
        } else if (widget.states[currentStageIndex].titleNumber == '11') {
          pathPDF = '';
          Timer(Duration(seconds: 5), () {
            getFileFromUrl(
                    '$url/site/report/${widget.states[currentStageIndex].state['cntwrkTySeq']}')
                .then((f) {
              setState(() {
                pathPDF = f.path;
                _isLoading = true;
                putStatus(4);
              });
            });
          });

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext ctx) {
                return PDFScreen();
              });
        }
      }
    });

    Status.currentStage =
        Process.fromJson(widget.states[currentStageIndex].toJson()).toJson();

    // print('===> ${Status.currentStage}');
  }

  void gotoPreviousStage() {
    print('===>initStage ${currentStageIndex}');

    setState(() {
      if (widget.states[currentStageIndex].isFailed == true) {
      } else {
        if (currentStageIndex >= 0) {
          if (currentStageIndex > 0) currentStageIndex--;
          widget.states[currentStageIndex].isFailed = false;
        }

        if (currentStageIndex > 0) {
          _controller.scrollTo(
              index: currentStageIndex - 1 >= 0
                  ? currentStageIndex - 1
                  : currentStageIndex,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn);
        } else {
          _controller.scrollTo(
              index: currentStageIndex,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn);
        }
        // stratProc(widget.states[currentStageIndex].state);
        checkPoint(widget.states[currentStageIndex].titleNumber);
      }
    });
    Status.currentStage =
        Process.fromJson(widget.states[currentStageIndex].toJson()).toJson();
    // print('===> ${Status.currentStage}');
  }

  void failCurrentStage() {
    setState(() {
      if (widget.states[currentStageIndex].isFailed == true) {
        widget.states[currentStageIndex].isFailed = false;
      } else {
        widget.states[currentStageIndex].isFailed = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    // print('===>1111 ${widget.states[currentStageIndex]}');
    return Row(
      children: [
        Flexible(
          flex: 4,
          child: Container(
            padding: EdgeInsets.all(width * 0.008),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: ColorSelect.shadowColor,
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ]),
            child: ScrollablePositionedList.builder(
              itemCount: buildStates().length,
              itemScrollController: _controller,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return buildStates()[index];
              },
            ),
          ),
        ),
        if (Status.isOpen)
          Flexible(
            flex: 8,
            child: Container(
              padding: EdgeInsets.only(
                  top: width * 0.016,
                  left: width * 0.016,
                  right: width * 0.016,
                  bottom: width * 0.008),
              child: ProcessAll(
                state: widget.states[currentStageIndex],
                stateTitle: widget.states[currentStageIndex].stateTitle,
                opertProcssCode:
                    widget.states[currentStageIndex].opertProcssCode,
                widget: widget,
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> buildStates() {
    List<Widget> allStates = [];
    int len = widget.states.length;
    for (var i = 0; i < widget.states.length; i++) {
      allStates.add(_RenderedState(
        textStyle: widget.textStyle,
        connectorLength: widget.connectorLength,
        connectorWidth: widget.connectorWidth,
        connectorColor: widget.connectorColor,
        iconSize: widget.iconSize,
        checkedIcon: widget.checkedIcon,
        failedIcon: widget.failedIcon,
        currentIcon: widget.currentIcon,
        uncheckedIcon: widget.uncheckedIcon,
        stateNumber: i + 1,
        isCurrent: i == currentStageIndex,
        isFailed: widget.states[i].isFailed,
        isChecked: i < currentStageIndex,
        stateTitle: widget.states[i].stateTitle,
        titleNumber: widget.states[i].titleNumber,
        depthLevel: widget.states[i].depthLevel,
        isLeading: i == 0,
        isTrailing: i == widget.states.length - 1,
      ));
    }

    return allStates;
  }
}

class _RenderedState extends StatelessWidget {
  final Icon? checkedIcon;
  final Icon? currentIcon;
  final Icon? failedIcon;
  final Icon? uncheckedIcon;
  final bool isChecked;
  final String stateTitle;
  final String titleNumber;
  final int? depthLevel;
  final TextStyle textStyle;
  final bool isLeading;
  final bool isTrailing;
  final int stateNumber;
  final bool? isFailed;
  final bool? isCurrent;
  final double iconSize;
  final Color connectorColor;
  final double connectorLength;
  final double connectorWidth;
  final Color decoColor;

  const _RenderedState({
    required this.isChecked,
    required this.stateTitle,
    required this.titleNumber,
    required this.depthLevel,
    required this.stateNumber,
    double? iconSize,
    Color? connectorColor,
    double? connectorLength,
    double? connectorWidth,
    TextStyle? textStyle,
    Color? decoColor,
    this.failedIcon,
    this.currentIcon,
    this.checkedIcon,
    this.uncheckedIcon,
    this.isFailed = false,
    this.isCurrent,
    this.isLeading = false,
    this.isTrailing = false,
  })  : iconSize = iconSize ?? 25,
        connectorColor = connectorColor ?? Colors.transparent,
        connectorLength = connectorLength ?? 5,
        connectorWidth = connectorWidth != null ? connectorWidth / 2 : 20,
        textStyle = textStyle ?? const TextStyle(color: Colors.white38),
        decoColor = decoColor ?? Colors.white24;

  Widget line() {
    return Container(
      color: connectorColor,
      height: connectorWidth,
      width: connectorLength,
    );
  }

  Widget spacer() {
    return Container(
      width: 3.0,
    );
  }

  Widget getCheckedIcon() {
    if (titleNumber == '1.1' ||
        titleNumber == '1.3' ||
        titleNumber == '4' ||
        titleNumber == '6' ||
        titleNumber == '11') {
      return checkedIcon != null
          ? Icon(
              checkedIcon!.icon,
              color: checkedIcon!.color,
              size: iconSize,
            )
          : Icon(
              Icons.check_rounded,
              color: ColorSelect.blueColor,
              size: iconSize,
            );
    } else {
      return checkedIcon != null
          ? Icon(
              checkedIcon!.icon,
              color: checkedIcon!.color,
              size: iconSize,
            )
          : Icon(
              Icons.check_rounded,
              color: ColorSelect.grayColor,
              size: iconSize,
            );
    }
  }

  Widget getFailedIcon() {
    if (titleNumber == '1.1' ||
        titleNumber == '1.3' ||
        titleNumber == '4' ||
        titleNumber == '6' ||
        titleNumber == '11') {
      return failedIcon != null
          ? Icon(
              failedIcon!.icon,
              color: failedIcon!.color,
              size: iconSize,
            )
          : Icon(
              Icons.motion_photos_off_outlined,
              color: Colors.white,
              size: iconSize,
            );
    } else {
      return failedIcon != null
          ? Icon(
              failedIcon!.icon,
              color: failedIcon!.color,
              size: iconSize,
            )
          : Icon(
              Icons.motion_photos_off_outlined,
              color: Colors.white,
              size: iconSize,
            );
    }
  }

  Widget getCurrentIcon() {
    if (titleNumber == '1.1' ||
        titleNumber == '1.3' ||
        titleNumber == '4' ||
        titleNumber == '6' ||
        titleNumber == '11') {
      return currentIcon != null
          ? Icon(
              currentIcon!.icon,
              color: currentIcon!.color,
              size: iconSize,
            )
          : Icon(
              Icons.trip_origin_rounded,
              color: Colors.white,
              size: iconSize,
            );
    } else {
      return currentIcon != null
          ? Icon(
              currentIcon!.icon,
              color: currentIcon!.color,
              size: iconSize,
            )
          : Icon(
              Icons.trip_origin_rounded,
              color: Colors.white,
              size: iconSize,
            );
    }
  }

  Widget getUnCheckedIcon() {
    if (titleNumber == '1.1' ||
        titleNumber == '1.3' ||
        titleNumber == '4' ||
        titleNumber == '6' ||
        titleNumber == '11') {
      return uncheckedIcon != null
          ? Icon(
              uncheckedIcon!.icon,
              color: uncheckedIcon!.color,
              size: iconSize,
            )
          : Icon(
              Icons.circle_outlined,
              color: ColorSelect.blueColor,
              size: iconSize,
            );
    } else {
      return uncheckedIcon != null
          ? Icon(
              uncheckedIcon!.icon,
              color: uncheckedIcon!.color,
              size: iconSize,
            )
          : Icon(
              Icons.circle_outlined,
              color: ColorSelect.grayColor,
              size: iconSize,
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: renderDecoState(),
      child: Padding(
        padding: depthLevel == null
            ? const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0)
            : depthLevel == 0
                ? const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0)
                : const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Column(
                children: [
                  // if (!isLeading) line(),
                  renderCurrentState(),
                  // if (!isTrailing) line(),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 8.0),
                width: depthLevel == null
                    ? MediaQuery.of(context).size.width / 6.67
                    : depthLevel == 0
                        ? MediaQuery.of(context).size.width / 6.67
                        : MediaQuery.of(context).size.width / 7.15 - 8,
                child: Flexible(
                  child: RichText(
                    textScaleFactor: FontSize.h5,
                    overflow: TextOverflow.ellipsis,
                    // maxLines: 5,
                    text: TextSpan(
                      text: '$titleNumber. $stateTitle',
                      style: renderTextState(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle renderTextState() {
    // print('===> $titleNumber');
    if (isFailed != null && isFailed!) {
      return TextStyle(
        color: Colors.white,
      );
    } else if (isChecked != null && isChecked) {
      if (titleNumber == '1.1' ||
          titleNumber == '1.3' ||
          titleNumber == '4' ||
          titleNumber == '6' ||
          titleNumber == '11') {
        return TextStyle(
          color: ColorSelect.blueColor,
          fontWeight: FontWeight.bold,
        );
      } else {
        return TextStyle(
          color: ColorSelect.grayColor,
          fontWeight: FontWeight.bold,
        );
      }
    } else if (isCurrent != null && isCurrent!) {
      return TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    }

    if (titleNumber == '1.1' ||
        titleNumber == '1.3' ||
        titleNumber == '4' ||
        titleNumber == '6' ||
        titleNumber == '11') {
      return TextStyle(
        color: ColorSelect.blueColor,
      );
    } else {
      return TextStyle(
        color: ColorSelect.grayColor,
      );
    }
  }

  BoxDecoration renderDecoState() {
    if (isFailed != null && isFailed!) {
      return const BoxDecoration(color: Colors.red);
    } else if (isChecked != null && isChecked) {
      return const BoxDecoration(color: Colors.transparent);
    } else if (isCurrent != null && isCurrent!) {
      if (titleNumber == '1.1' ||
          titleNumber == '1.3' ||
          titleNumber == '4' ||
          titleNumber == '6' ||
          titleNumber == '11') {
        return const BoxDecoration(
            color: ColorSelect.blueColor,
            borderRadius: BorderRadius.all(Radius.circular(13)));
      } else {
        return const BoxDecoration(
            color: ColorSelect.grayColor,
            borderRadius: BorderRadius.all(Radius.circular(13)));
      }
    }
    return const BoxDecoration(color: Colors.transparent);
  }

  Widget renderCurrentState() {
    if (isFailed != null && isFailed!) {
      return getFailedIcon();
    } else if (isChecked != null && isChecked) {
      return getCheckedIcon();
    } else if (isCurrent != null && isCurrent!) {
      return getCurrentIcon();
    }
    return getUnCheckedIcon();
  }
}

class SingleState {
  /// Do not use this explicitly(in most cases)
  bool? isFailed;

  /// Title of a state
  String stateTitle;
  String titleNumber;

  String opertProcssCode;

  List<String> type;

  Map state;

  int? depthLevel;

  SingleState(
      {required this.state,
      required this.stateTitle,
      required this.depthLevel,
      required this.titleNumber,
      required this.opertProcssCode,
      required this.type,
      this.isFailed});

  Map<String, dynamic> toJson() => {
        "stateTitle": stateTitle,
        "depthLevel": depthLevel,
        "titleNumber": titleNumber,
        "opertProcssCode": opertProcssCode,
        "type": type,
        "isFailed": isFailed,
      };
}
