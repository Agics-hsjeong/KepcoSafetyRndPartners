// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/models/models.dart';

class NoticeArea extends StatefulWidget {
  const NoticeArea({
    Key? key,
  }) : super(key: key);

  @override
  State<NoticeArea> createState() => _NoticeAreaState();
}

class _NoticeAreaState extends State<NoticeArea> {
  List? dataList;

  Network network = Network();

  Future<dynamic> getNotics() async {
    // print("getNotics");
    dynamic result = await network.getNotics();

    if (result != null) {
      setState(() {
        dataList = result;
      });
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getNotics();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: width * 0.01),
          child: Row(
            children: [
              Text(
                "공지사항",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * 0.01),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.005),
                child: SizedBox(
                  width: width * 0.02,
                  height: height * 0.02,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: ColorSelect.redColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '10',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.008,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: width * 0.35,
            height: height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                boxShadow: const [
                  BoxShadow(
                    color: ColorSelect.shadowColor,
                    spreadRadius: 0,
                    blurRadius: 2,
                  ),
                ],
                color: Colors.white),
            child: dataList != null
                ? ListView.separated(
                    controller: ScrollController(initialScrollOffset: 1.0),
                    // scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.fromLTRB(
                        width * 0.008, width * 0.003, width * 0.008, 0),
                    itemCount: dataList!.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        "${dataList![index]['title']}",
                        style: TextStyle(
                            fontSize: width * 0.01,
                            color: ColorSelect.grayColor,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        "${dataList![index]['createDate']}",
                        style: TextStyle(
                            fontSize: width * 0.01,
                            color: ColorSelect.grayColor,
                            fontWeight: FontWeight.w600),
                      ),
                      dense: true,
                      visualDensity: VisualDensity(vertical: 0),
                    ),
                    separatorBuilder: ((context, index) {
                      return const Divider(
                          height: 1.0, color: ColorSelect.grayColor);
                    }),
                  )
                : ListView.separated(
                    controller: ScrollController(initialScrollOffset: 1.0),
                    // scrollDirection: Axis.horizontal,
                    padding:
                        EdgeInsets.fromLTRB(width * 0.005, 0, width * 0.008, 0),
                    itemCount: 10,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        "중간점검표 및 안전보건일지 일간 출력 $index",
                        style: TextStyle(
                            fontSize: width * 0.01,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        "2022-04-26",
                        style: TextStyle(
                            fontSize: width * 0.01,
                            fontWeight: FontWeight.w600),
                      ),
                      dense: true,
                      visualDensity: VisualDensity(vertical: 0),
                    ),
                    separatorBuilder: ((context, index) {
                      return const Divider(
                          height: 1.0, color: ColorSelect.grayColor);
                    }),
                  ),
          ),
        ),
      ],
    );
  }
}
