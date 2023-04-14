import 'package:flutter/material.dart';
import 'package:kepco_safety_iot/widgets/_today/ProgressTimeline.dart';

import 'process.dart';

class ProcessAll extends StatelessWidget {
  const ProcessAll({
    Key? key,
    required this.opertProcssCode,
    required this.widget,
    required this.stateTitle,
    required this.state,
  }) : super(key: key);

  final SingleState state;
  final String stateTitle;
  final String opertProcssCode;
  final ProgressTimeline widget;

  @override
  Widget build(BuildContext context) {
    Widget getProcess;

    switch (opertProcssCode) {
      ///////////////////////////////////////////////v1.0
      case 'A01':
        getProcess = A01(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A02':
        getProcess = A02(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A03':
        getProcess = A03(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A04':
        getProcess = A04(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A05':
        getProcess = A05(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A06':
        getProcess = A06(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A07':
        getProcess = A07(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A08':
        getProcess = A08(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A09':
        getProcess = A09(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A10':
        getProcess = A10(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A11':
        getProcess = A11(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A12':
        getProcess = A12(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A13':
        getProcess = A13(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A14':
        getProcess = A14(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A15':
        getProcess = A15(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A16':
        getProcess = A16(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A17':
        getProcess = A17(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A18':
        getProcess = A18(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A19':
        getProcess = A19(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A20':
        getProcess = A20(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A21':
        getProcess = A21(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A22':
        getProcess = A22(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A23':
        getProcess = A23(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A24':
        getProcess = A24(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A25':
        getProcess = A25(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'A26':
        getProcess = A26(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      ///////////////////////////////////////////////v2.0
      case 'B01':
        getProcess = B01(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'B02':
        getProcess = B02(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'B03':
        getProcess = B03(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'B04':
        getProcess = B04(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'B05':
        getProcess = B05(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'B06':
        getProcess = B06(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'B07':
        getProcess = B07(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'B08':
        getProcess = B08(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C01':
        getProcess = C01(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C0101':
        getProcess = C0101(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      ///////////////////////////////////////////////v3.0
      case 'C0102':
        getProcess = C0102(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C0103':
        getProcess = C0103(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C02':
        getProcess = C02(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C03':
        getProcess = C03(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C04':
        getProcess = C04(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C05':
        getProcess = C05(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C06':
        getProcess = C06(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C07':
        getProcess = C07(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C08':
        getProcess = C08(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C09':
        getProcess = C09(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C10':
        getProcess = C10(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C11':
        getProcess = C11(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C12':
        getProcess = C12(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C13':
        getProcess = C13(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C14':
        getProcess = C14(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C15':
        getProcess = C15(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C16':
        getProcess = C16(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C17':
        getProcess = C17(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C18':
        getProcess = C18(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C19':
        getProcess = C19(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C20':
        getProcess = C20(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C21':
        getProcess = C21(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C22':
        getProcess = C22(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C23':
        getProcess = C23(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C24':
        getProcess = C24(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C25':
        getProcess = C25(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C26':
        getProcess = C26(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C27':
        getProcess = C27(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'C28':
        getProcess = C28(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      ///////////////////////////////////////////////v1.0
      case 'D01':
        getProcess = BeforeWork(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'D0101':
        getProcess = BeforeWork2(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      case 'D0103':
        getProcess = BeforeWork3(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
      // case 'D0103':
      //   getProcess = BeforeWork4(
      //       single: state, progressTimeline: widget, stateTitle: stateTitle);
      //   break;
      default:
        getProcess = DefaultWork(
            single: state, progressTimeline: widget, stateTitle: stateTitle);
        break;
    }
    return getProcess;
  }
}
