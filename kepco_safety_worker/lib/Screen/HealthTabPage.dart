import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:kepco_safety_worker/Screen/HealthManage.dart';
import 'package:kepco_safety_worker/Screen/selfDiagnosisManage.dart';

class HealthTabPage extends StatefulWidget {
  const HealthTabPage({Key? key}) : super(key: key);

  @override
  State<HealthTabPage> createState() => _HealthTabPageState();
}

class _HealthTabPageState extends State<HealthTabPage> {
  String Tab = "1";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          Tab = "1";
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: MediaQuery.of(context).size.height * 0.038,
                        decoration: BoxDecoration(
                            color: Tab == "1"
                                ? ColorSelect.blueColor
                                : ColorSelect.lightGreyColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: Tab == "1"
                                ? [
                                    BoxShadow(
                                      color: ColorSelect.blueColor,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 1.5), // changes position of shadow
                                    ),
                                  ]
                                : []),
                        child: Center(
                          child: Text(
                            "건강관리",
                            textScaleFactor: FontSize.h7,
                            style: TextStyle(
                                color: Tab == "1"
                                    ? Colors.white
                                    : Color.fromRGBO(112, 112, 112, 1),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Tab = "2";
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: MediaQuery.of(context).size.height * 0.038,
                        decoration: BoxDecoration(
                            color: Tab == "2"
                                ? ColorSelect.blueColor
                                : ColorSelect.lightGreyColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: Tab == "2"
                                ? [
                                    BoxShadow(
                                      color: ColorSelect.blueColor,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 1.5), // changes position of shadow
                                    ),
                                  ]
                                : []),
                        child: Center(
                          child: Text(
                            "자가진단",
                            textScaleFactor: FontSize.h7,
                            style: TextStyle(
                                color: Tab == "2"
                                    ? Colors.white
                                    : Color.fromRGBO(112, 112, 112, 1),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Tab == "1" ? HealthManage() : selfDiagnosisManage()
            ],
          )),
    );
  }
}
