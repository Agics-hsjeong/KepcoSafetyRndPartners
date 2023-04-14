import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:kepco_safety_iot/models/models.dart';

import '../_today/ProgressTimeline.dart';

class GridToShoot extends StatefulWidget {
  const GridToShoot({
    Key? key,
    required this.single,
  }) : super(key: key);
  final SingleState single;

  @override
  State<GridToShoot> createState() => _GridToShootState();
}

class _GridToShootState extends State<GridToShoot> {
  bool isImage = false;
  bool isLoding = false;

  Future<void> _show(String type) async {
    await getValueList();

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // icon: Icon(Icons.abc),
            titleTextStyle: textStyle(context, color: ColorSelect.blueColor),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    type == 'OPT'
                        ? Text(
                            "대상 공종 촬영",
                          )
                        : Text(
                            "검측 촬영",
                          ),
                    IconButton(
                        onPressed: () {
                          pickedImgs.clear();
                          Navigator.pop(context);
                        },
                        iconSize: 40,
                        icon: Icon(
                          Icons.close_rounded,
                          color: ColorSelect.blueColor,
                        ))
                  ],
                ),
                Divider(thickness: 2),
              ],
            ),
            elevation: 0.0,
            content: Container(
                width: 400,
                height: 800,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    type == 'OPT' ? SizedBox.shrink() : InspectDropdown(),
                    const SizedBox(height: 10),
                    Flexible(
                      child: ImageGridView(
                        state: widget.single.state,
                        type: type,
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () async {
                            await saveImg(type, widget.single.state);

                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: ColorSelect.blueColor),
                          child: Text(
                            "완료",
                            style: textStyle(context, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          );
        });
  }

  TextStyle textStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: MediaQuery.of(context).size.width * 0.015,
      fontFamily: 'SUIT',
    );
  }

  TextStyle textSubStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w400,
      fontSize: MediaQuery.of(context).size.width * 0.01,
      fontFamily: 'SUIT',
    );
  }

  ButtonStyle buttonStyle(BuildContext context, {Color? color}) {
    return TextButton.styleFrom(
      backgroundColor: const Color.fromRGBO(226, 230, 255, 0.3),
      minimumSize: Size(
        MediaQuery.of(context).size.width * 0.175,
        MediaQuery.of(context).size.height * 0.3,
      ),
    );
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

    return SizedBox(
      width: double.infinity,
      height: height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: width * 0.07,
            height: height * 0.04,
            child: OutlinedButton(
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
                // minimumSize: Size(width * 0.01, height * 0.01)
                // shape: OutlinedBorder(side: BorderSide(color: Colors.black)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_rounded,
                    color: ColorSelect.blueColor,
                    size: width * 0.013,
                  ),
                  Text(
                    '사진확인',
                    style: TextStyle(
                      color: ColorSelect.blueColor,
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.01,
                      fontFamily: 'SUIT',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, height * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _show('OPT'),
                  style: buttonStyle(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: width * 0.025,
                        backgroundColor: const Color.fromRGBO(226, 230, 255, 1),
                        child: Icon(
                          Icons.camera_alt,
                          color: ColorSelect.blueColor,
                          size: width * 0.023,
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size(0, height * 0.03),
                      ),
                      Text(
                        '대상 공종 촬영',
                        style: TextStyle(
                          color: ColorSelect.blueColor,
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.01,
                          fontFamily: 'SUIT',
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => _show('ISP'),
                  style: buttonStyle(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: width * 0.025,
                        backgroundColor: const Color.fromRGBO(226, 230, 255, 1),
                        child: Icon(
                          Icons.camera_alt,
                          color: ColorSelect.blueColor,
                          size: width * 0.023,
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size(0, height * 0.03),
                      ),
                      Text(
                        '검측 촬영',
                        style: TextStyle(
                          color: ColorSelect.blueColor,
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.01,
                          fontFamily: 'SUIT',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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

class ImageGridView extends StatefulWidget {
  const ImageGridView({Key? key, required this.type, required this.state})
      : super(key: key);
  final String type;
  final Map<dynamic, dynamic> state;

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pickedImgs.length + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, //1 개의 행에 보여줄 item 개수
        // childAspectRatio: 1 / 2, //item 의 가로 1, 세로 2 의 비율
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: pickedImgs.length == index
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: ColorSelect.backgroundColor),
                  child: IconButton(
                      onPressed: () async {
                        await pickImg(widget.type, widget.state);
                        setState(() {
                          pickedImgs;
                        });
                      },
                      icon: Icon(Icons.add_circle_rounded)),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: FileImage(
                        File(pickedImgs[index].path),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -10,
                        right: -10,
                        child: IconButton(
                          onPressed: () {
                            pickedImgs.removeAt(index);
                            setState(() {
                              pickedImgs;
                            });
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: ColorSelect.redColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class InspectDropdown extends StatefulWidget {
  const InspectDropdown({Key? key}) : super(key: key);

  @override
  State<InspectDropdown> createState() => _InspectDropdownState();
}

class _InspectDropdownState extends State<InspectDropdown> {
  TextStyle textStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: MediaQuery.of(context).size.width * 0.015,
      fontFamily: 'SUIT',
    );
  }

  TextStyle textSubStyle(BuildContext context, {Color? color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w400,
      fontSize: MediaQuery.of(context).size.width * 0.01,
      fontFamily: 'SUIT',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "공사 분야",
                style: textStyle(context),
              ),
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: selectedValue1,
              items: inspectList.map(
                (value) {
                  return DropdownMenuItem(
                    value: value.prcsNm,
                    child: Text(value.prcsNm, style: textSubStyle(context)),
                  );
                },
              ).toList(),
              onChanged: (value) async {
                setState(() {
                  selectedValue1 = value.toString();
                });
                await getValueList2(selectedValue1);
                setState(() {
                  selectedValue1;
                });
              },
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "세부 공종",
                style: textStyle(context),
              ),
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: selectedValue2,
              items: inspectList2.map(
                (value) {
                  return DropdownMenuItem(
                    value: value.prcsNm,
                    child: Text(value.prcsNm, style: textSubStyle(context)),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue2 = value.toString();
                });
              },
            )
          ],
        )
      ],
    );
  }
}
