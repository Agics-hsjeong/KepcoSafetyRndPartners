import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kepco_safety_iot/models/models.dart';

import '../_today/ProgressTimeline.dart';

class ToShoot extends StatefulWidget {
  const ToShoot({
    Key? key,
    required this.single,
  }) : super(key: key);
  final SingleState single;

  @override
  State<ToShoot> createState() => _ToShootState();
}

class _ToShootState extends State<ToShoot> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _pickedImgs = [];

  bool isImage = false;
  bool isLoding = false;
  Future<void> _pickImg(String type) async {
    ImageNetwork imageNet = ImageNetwork();
    // final List<XFile>? images = await _picker.pickMultiImage();
    final XFile? images = await _picker.pickImage(source: ImageSource.camera);

    if (images != null) {
      setState(() {
        _pickedImgs.add(images);
        isLoding = true;
      });

      imageNet.upload(_pickedImgs, widget.single.state, type).then(
        (value) {
          print("===> 이미지 업로드 완료");
        },
      ).catchError((e) {
        // print('===> Got error: $e');
      });

      setState(() {
        _pickedImgs.clear();
        isLoding = false;
      });
    } else {
      // print("===> 촬영취소");
    }
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

    return Positioned(
      right: width * 0.005,
      top: -5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => _pickImg('ISP'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(width * 0.005, 0, width * 0.005, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: ColorSelect.blueColor,
                    size: width * 0.013,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.005),
                    child: Text(
                      '검측 촬영',
                      style: TextStyle(
                        color: ColorSelect.blueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.01,
                        fontFamily: 'SUIT',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () => _pickImg('OPT'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(width * 0.005, 0, width * 0.005, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: ColorSelect.blueColor,
                    size: width * 0.013,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.005),
                    child: Text(
                      '관리 촬영',
                      style: TextStyle(
                        color: ColorSelect.blueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.01,
                        fontFamily: 'SUIT',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.002),
            child: TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return ShowImageGallery(
                    state: widget.single.state,
                  );
                },
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(width * 0.005, 0, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_rounded,
                      color: ColorSelect.blueColor,
                      size: width * 0.013,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.005),
                      child: Text(
                        '사진확인',
                        style: TextStyle(
                          color: ColorSelect.blueColor,
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.01,
                          fontFamily: 'SUIT',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowImageGallery extends StatefulWidget {
  const ShowImageGallery({
    Key? key,
    required this.state,
  }) : super(key: key);

  final Map<dynamic, dynamic> state;

  @override
  State<ShowImageGallery> createState() => _ShowImageGalleryState();
}

class _ShowImageGalleryState extends State<ShowImageGallery> {
  ImageNetwork imageNet = ImageNetwork();
  List imageList = [];
  var imageView;

  @override
  void initState() {
    // TODO: implement initState
    imageNet.search(widget.state).then((value) {
      var data = jsonDecode(value.toString());
      print('===>data ${data}');
      setState(() {
        if (data[widget.state['code']] != null) {
          imageList = data[widget.state['code']];
          imageView = imageList[0]['img'];
        } else {
          imageList = [];
          imageView = null;
        }
      });
    });
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
      content: Stack(children: [
        Container(
          width: width * 0.83,
          height: height * 0.8,
          padding: EdgeInsets.all(width * 0.005),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.001, bottom: height * 0.005),
                child: Text(
                  "촬영된 사진 확인",
                  textScaleFactor: FontSize.h4,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 13,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            width: width * 0.55,
                            height: height * 0.635,
                            child: imageView != null
                                ? Image.network(
                                    "$url/image/$imageView",
                                    fit: BoxFit.fill,
                                    headers: {'Authorization': Header.token},
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                    // VerticalDivider(color: ColorSelect.dividerColor),
                    Padding(padding: EdgeInsets.all(width * 0.005)),
                    Expanded(
                      child: GridView.builder(
                        itemCount: imageList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.7 / 2,
                        ),
                        itemBuilder: (context, int index) {
                          // return Text("${userStages[index].name}");
                          return Stack(
                            children: [
                              Container(
                                width: width * 0.28,
                                height: height * 0.42,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      imageView = imageList[index]['img'];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: imageView ==
                                                    imageList[index]['img']
                                                ? Colors.orange
                                                : Colors.transparent,
                                            width: 5)),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ClipRRect(
                                          child: Image.network(
                                            "$url/image/${imageList[index]['img']}",
                                            headers: {
                                              'Authorization': Header.token
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          imageList[index]['type'] == 'OPT'
                                              ? '관리촬영'
                                              : '검측촬영',
                                          style: TextStyle(
                                              background: Paint()
                                                ..color = imageList[index]
                                                            ['type'] ==
                                                        'OPT'
                                                    ? Colors.orange
                                                    : Colors.blue,
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 7,
                                child: InkWell(
                                  onTap: () {
                                    imageNet.delete(imageView).then((value) {
                                      imageNet
                                          .search(widget.state)
                                          .then((value) {
                                        var data = jsonDecode(value.toString());
                                        setState(() {
                                          if (data[widget.state['code']] !=
                                              null) {
                                            imageList =
                                                data[widget.state['code']];
                                            imageView = imageList[0];
                                          } else {
                                            imageList = [];
                                            imageView = null;
                                          }
                                        });
                                      });
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: width * 0.03,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //
              // Divider(color: ColorSelect.dividerColor),
              // Expanded(
              //   child: SizedBox(
              //     width: 100,
              //     height: 30,
              //     child: Center(
              //       child: ElevatedButton(
              //         style: ButtonStyle(
              //             backgroundColor:
              //                 MaterialStateProperty.all(ColorSelect.grayColor)),
              //         child: Text(
              //           "삭제",
              //           style: TextStyle(fontSize: 20),
              //         ),
              //         onPressed: () {
              //           imageNet
              //               .delete(imageView, widget.opertCntwrkTySeq,
              //                   widget.cntwrkTyProcdrCd)
              //               .then((value) {
              //             imageNet
              //                 .search(widget.opertCntwrkTySeq,
              //                     widget.cntwrkTyProcdrCd)
              //                 .then((value) {
              //               var data = jsonDecode(value.toString());
              //               setState(() {
              //                 if (data[widget.cntwrkTyProcdrCd].toString() !=
              //                     "[]") {
              //                   imageList = data[widget.cntwrkTyProcdrCd];
              //                   imageView = imageList[0];
              //                 } else {
              //                   imageList = [];
              //                   imageView = null;
              //                 }
              //               });
              //             });
              //           });
              //         },
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 5,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              size: 50,
              color: ColorSelect.blueColor,
            ),
          ),
        ),
      ]),
    );
  }
}
