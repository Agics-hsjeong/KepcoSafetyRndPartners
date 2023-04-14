import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

import 'package:kepco_safety_iot/models/models.dart';

class Signature extends StatefulWidget {
  const Signature({Key? key}) : super(key: key);

  @override
  State<Signature> createState() => _SignatureState();
}

class _SignatureState extends State<Signature> {
  bool _finished = false;
  late PainterController _controller = _newController();
  late PictureDetails picture;

  static PainterController _newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.white;
    return controller;
  }

  void _complete() {
    setState(() {
      _finished = true;
      picture = _controller.finish();
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return _finished
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: width * 0.08,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      width: 1,
                      color: ColorSelect.borderColor2,
                    ))),
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.07,
                          height: height * 0.042,
                          child: FutureBuilder<Uint8List>(
                            future: picture.toPNG(),
                            builder: (BuildContext context,
                                AsyncSnapshot<Uint8List> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.done:
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Image.memory(snapshot.data!);
                                  }
                                default:
                                  return Container(
                                      child: FractionallySizedBox(
                                    widthFactor: 0.1,
                                    child: AspectRatio(
                                        aspectRatio: 1.0,
                                        child: CircularProgressIndicator()),
                                    alignment: Alignment.center,
                                  ));
                              }
                            },
                          ),
                        ),
                        Icon(
                          Icons.border_color,
                          size: width * 0.013,
                          color: ColorSelect.toggleColor3,
                        )
                      ],
                    ),
                    onTap: () {
                      _controller = _newController();

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                            // titlePadding: EdgeInsets.only(left: 10.0, right: 10.0),
                            content: Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: width * 0.3,
                                        width: height * 0.6,
                                        child: AspectRatio(
                                            aspectRatio: 1.0,
                                            child: Painter(_controller)),
                                      ),
                                      Text(
                                        "서 명",
                                        style: TextStyle(
                                            fontSize: width * 0.12,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'SUIT',
                                            color: ColorSelect.shadowColor),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                      onTap: () => _complete(),
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(top: height * 0.01),
                                        decoration: BoxDecoration(
                                            color: ColorSelect.borderColor4,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        width: width * 0.1,
                                        height: height * 0.05,
                                        child: Center(
                                          child: Text(
                                            "완료",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.012,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'SUIT',
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          )
        : _btnSign(context);
  }

  Widget _btnSign(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    setState(() {
      _controller = _newController();
    });
    return InkWell(
      child: Container(
          width: width * 0.08,
          height: height * 0.035,
          decoration: BoxDecoration(
              color: ColorSelect.blueColor2,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Icon(
            Icons.border_color,
            size: width * 0.013,
            color: ColorSelect.toggleColor3,
          ))),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              // titlePadding: EdgeInsets.only(left: 10.0, right: 10.0),
              content: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: width * 0.3,
                          width: height * 0.6,
                          child: AspectRatio(
                              aspectRatio: 1.0, child: Painter(_controller)),
                        ),
                        Text(
                          "서 명",
                          style: TextStyle(
                              fontSize: width * 0.12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SUIT',
                              color: ColorSelect.shadowColor),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () => _complete(),
                        child: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          decoration: BoxDecoration(
                              color: ColorSelect.borderColor4,
                              borderRadius: BorderRadius.circular(10)),
                          width: width * 0.1,
                          height: height * 0.05,
                          child: Center(
                            child: Text(
                              "완료",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.012,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SUIT',
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
