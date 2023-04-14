import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/models/designModel.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';
import 'package:kepco_safety_iot/widgets/common/TableBox.dart';
import 'package:kepco_safety_iot/widgets/common/RiskCheckBox.dart';

class A11 extends StatefulWidget {
  const A11({
    Key? key,
    required this.progressTimeline,
    required this.stateTitle,
    required this.single,
  }) : super(key: key);

  final SingleState single;
  final ProgressTimeline progressTimeline;
  final String stateTitle;

  @override
  State<A11> createState() => _A11State();
}

class _A11State extends State<A11> {
  late TableBox tableBox;
  late RiskCheckBox riskCheck;
  List<SingleRowState> allStages = List.empty(growable: true);
  List<RowState> dangerCheck = List.empty(growable: true);
  late ProgressTimeline progressTimeline;

  Future<dynamic> startProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'S');

    print('===>startProc ${result}');
  }

  Future<dynamic> endProc() async {
    Network network = Network();
    // print('===>state ${widget.state}');
    dynamic result = await network.updateProc(
        widget.single.state['opertCntwrkTySeq'],
        widget.single.opertProcssCode,
        'E');

    print('===>endProc ${result}');
  }

  @override
  void initState() {
    progressTimeline = widget.progressTimeline;
    startProc();
    allStages = [
      SingleRowState(
          contents: "입상케이블 가지지 적정여부 (버킷에 거치 금지)", isChecked: [true, false]),
    ];

    tableBox = TableBox(title: "", list: allStages);

    dangerCheck = [
      RowState(
        contents: "입상케이블 가지지 적정여부 (버킷에 거치 금지)",
        warnCn: [RiskState(contents: "내용 넣기")],
      ),
    ];

    riskCheck =
        RiskCheckBox(list: dangerCheck, importance: 3, possibility: 3, risk: 6);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                "| ${widget.stateTitle}",
                style: const TextStyle(
                    fontSize: 20,
                    color: ColorSelect.blueColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  riskCheck,
                  Padding(padding: EdgeInsets.only(bottom: 15.0)),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorSelect.tableColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: double.infinity,
                    height: 450,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text("주요 작업에 속함\n 위험성 안내 및\n 내용 넣어주기 A11",
                            style: TextStyle(
                                color: ColorSelect.headTextColor,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  tableBox,
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        progressTimeline.gotoPreviousStage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: ColorSelect.blueColor,
                            ),
                          ),
                          Text(
                            "이전",
                            style: TextStyle(
                                fontSize: 20,
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        progressTimeline.failCurrentStage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "오류",
                            style: TextStyle(
                                fontSize: 20,
                                color: ColorSelect.redColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        progressTimeline.gotoNextStage();
                        endProc();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "다음",
                            style: TextStyle(
                                fontSize: 20,
                                color: ColorSelect.blueColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Icon(
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
            ],
          ),
        ),
      ],
    );
  }
}
