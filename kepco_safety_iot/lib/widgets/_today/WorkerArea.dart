import 'package:flutter/material.dart';

import 'package:kepco_safety_iot/widgets/_today/WorkerStatus.dart';

class WorkerArea extends StatefulWidget {
  const WorkerArea({Key? key}) : super(key: key);

  @override
  State<WorkerArea> createState() => _WorkerAreaState();
}

class _WorkerAreaState extends State<WorkerArea> {
  late WorkerStatus workerStatus;

  Future<void> _getAllStages() async {
    List<SingleState> allStages = List.empty(growable: true);

    allStages = [
      SingleState(name: "작업자A"),
      // SingleState(name: "작업자B"),
      // SingleState(name: "작업자C"),
      // SingleState(name: "작업자D"),
      // SingleState(name: "작업자E"),
      // SingleState(name: "작업자F"),
      // SingleState(name: "작업자G"),
      // SingleState(name: "작업자H"),
      // SingleState(name: "작업자I"),
      // SingleState(name: "작업자J"),
      // SingleState(name: "작업자K"),
    ];

    setState(() {
      workerStatus = WorkerStatus(
        states: allStages,
      );
    });
  }

  @override
  void initState() {
    _getAllStages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return workerStatus;
  }
}
