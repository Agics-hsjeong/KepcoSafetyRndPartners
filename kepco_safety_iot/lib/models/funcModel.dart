import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:kepco_safety_iot/widgets/common/TableBox.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'package:kepco_safety_iot/widgets/common/WorkerBox.dart';

Future<void> stratProc(Map<dynamic, dynamic> state) async {
  Network network = Network();
  await network.putProc(state, 'S');
}

Future<void> endProc(Map<dynamic, dynamic> state) async {
  Network network = Network();
  await network.putProc(state, 'E');
}

Future<dynamic> lastProc(Map<dynamic, dynamic> state) async {
  Network network = Network();
  await network.putProc(state, 'F');
  // print('===> $res');
}

Future<void> resetProc(Map<dynamic, dynamic> state) async {
  Network network = Network();
  await network.putProc(state, 'R');
}

Future<void> pickImg(String type, Map<dynamic, dynamic> state) async {
  final ImagePicker _picker = ImagePicker();
  // final List<XFile>? images = await _picker.pickMultiImage();
  final XFile? images = await _picker.pickImage(source: ImageSource.camera);

  if (images != null) {
    pickedImgs.add(images);
  } else {
    print("===> 촬영취소");
  }
}

Future<void> putStatus(int eventType) async {
  RndNetwork network = RndNetwork();
  await network.putStatus(eventType);
}

Future<void> saveImg(String type, Map<dynamic, dynamic> state) async {
  ImageNetwork imageNet = ImageNetwork();

  imageNet.upload(pickedImgs, state, type).then(
    (value) {
      pickedImgs.clear();
      print("===> 이미지 업로드 완료");
    },
  ).catchError((e) {
    // print('===> Got error: $e');
  });
}

List<SingleRowState> allStages = List.empty(growable: true);
AssetImage imageStages = AssetImage('assets/img/1.작업준비.png');
Future<void> checkPoint(String titleNumber) async {
  switch (titleNumber) {
    case '1.3':
      allStages = [
        SingleRowState(
            contents: "변전소, 보호기기 재폐로 동작기능 정지", isChecked: [true, false]),
      ];
      imageStages = AssetImage('assets/img/1.작업준비.png');
      break;
    case '2':
      allStages = [
        SingleRowState(
            contents: "변전소, 보호기기 재폐로 동작기능 정지", isChecked: [true, false]),
      ];
      imageStages = AssetImage('assets/img/2.배전센터 통보.png');
      break;
    case '3':
      allStages = [
        SingleRowState(
            contents: "지상 감시자 배치 및 상․하부 동시작업 금지", isChecked: [true, false]),
      ];
      imageStages = AssetImage('assets/img/3.충전부방호작업.png');

      break;
    case '4':
      allStages = [];
      imageStages = AssetImage('assets/img/8.특고압입상케이블설치.png');

      break;
    case '5':
      allStages = [];
      imageStages = AssetImage('assets/img/9.검상및공사용개폐기투입.png');

      break;
    case '6':
      allStages = [];
      imageStages = AssetImage('assets/img/10.점퍼선절단.png');

      break;
    case '7':
      allStages = [
        SingleRowState(
            contents: "점퍼선 분리 후 검전을 시행하여 사선확인", isChecked: [true, false]),
      ];
      imageStages = AssetImage('assets/img/11.작업구간검전및단락접지시행.png');

      break;
    case '8':
      allStages = [
        SingleRowState(contents: "사선작업 종료 후 단락접지 철거", isChecked: [true, false]),
      ];
      imageStages = AssetImage('assets/img/13.작업구간내 단락접지 철거.png');

      break;
    case '9':
      allStages = [];
      imageStages = AssetImage('assets/img/14.검상.png');

      break;
    case '10':
      allStages = [
        SingleRowState(
            contents: "입상케이블 가지지 적정여부(버킷에 거치 금지)", isChecked: [true, false]),
        SingleRowState(contents: "케이블 방전 시행", isChecked: [true, false]),
      ];
      imageStages = AssetImage('assets/img/20.케이블철거.png');

      break;
    // case '저압보수공사/인입공사 시행':
    //   allStages = [
    //     SingleRowState(
    //         contents: "지상감시자 배치 및 상․하부 동시작업 금지", isChecked: [true, false]),
    //   ];
    //   break;
    // case '전원측 전원연결':
    //   allStages = [
    //     SingleRowState(
    //         contents: "개폐장치 투입전 작업자 완전 철수 확인", isChecked: [true, false]),
    //   ];
    //   break;
    // case '배전센터 통보':
    //   allStages = [
    //     SingleRowState(
    //         contents: "변전소, 보호기기 재폐로 동작기능 정지", isChecked: [true, false]),
    //   ];
    //   break;
    // case '충전부 방호(필요시)':
    //   allStages = [
    //     SingleRowState(
    //         contents: "지상 감시자 배치 및 상․하부 동시작업 금지", isChecked: [true, false]),
    //   ];
    //   break;
    // case '활선용 완철 설치':
    //   allStages = [
    //     SingleRowState(
    //         contents: "활선작업차 윈치 보조암에 활선용 완철을 설치", isChecked: [true, false]),
    //     SingleRowState(
    //         contents: "보조암에 전선을 이선할 장주형태 및 전선 간격에 맞게 절연로라 설치",
    //         isChecked: [true, false]),
    //   ];
    //   break;
    // case '전선이선(상승)':
    //   allStages = [
    //     SingleRowState(
    //         contents: "전선상향이선시 전주 및 부속물등에 전선 접촉여부 감시",
    //         isChecked: [true, false]),
    //   ];
    //   break;
    // case '본작업':
    //   allStages = [
    //     SingleRowState(
    //         contents: "전선이 이선된 상태에서 활선작업차 붐 조작 금지", isChecked: [true, false]),
    //   ];
    //   break;
    // case '중성선 방호':
    //   allStages = [
    //     SingleRowState(
    //         contents: "지상 감시자 배치 및 상․하부 동시작업 금지", isChecked: [true, false]),
    //   ];
    //   break;
    // case '검상 및 저압차단기 투입':
    //   allStages = [
    //     SingleRowState(
    //         contents: "무정전변압기차 상별, 전압 확인 및 상시험", isChecked: [true, false]),
    //   ];
    //   break;
    // case '주상변압기 2차인하선 검상 및 연결':
    //   allStages = [
    //     SingleRowState(
    //         contents: "변압기 상별, 전압 확인 및 상시험", isChecked: [true, false]),
    //   ];
    //   break;
    // case '입상케이블 잔류전하 방전':
    //   allStages = [
    //     SingleRowState(
    //         contents: "입상케이블 클램프를 중성선에 접촉", isChecked: [true, false]),
    //     SingleRowState(
    //         contents: "입상케이블 가지지 적정여부(버킷에 거치금지)", isChecked: [true, false]),
    //   ];
    //   break;
    // case '입상케이블 철거(저,특고압 고정장치 포함)':
    //   allStages = [
    //     SingleRowState(
    //         contents: "입상케이블 클램프를 중성선에 접촉", isChecked: [true, false]),
    //     SingleRowState(
    //         contents: "입상케이블 가지지 적정여부(버킷에 거치금지)", isChecked: [true, false]),
    //   ];
    //   break;
    default:
      allStages = [];
  }
}

Future<void> getValueList() async {
  Network network = Network();
  await network.getInspect().then((res) {
    inspectList.clear();
    List.generate(res.length, (index) {
      inspectList.add(InspectState(
          prcsCd: res[index]['prcsCd'], prcsNm: res[index]['prcsNm']));
    });

    selectedValue1 = inspectList[0].prcsNm;
  });
  await getValueList2(selectedValue1);
}

Future<void> getValueList2(String value) async {
  String prcsCd = '';
  List.generate(inspectList.length, (index) {
    if (inspectList[index].prcsNm == value) prcsCd = inspectList[index].prcsCd;
  });

  Network network = Network();
  await network.getInspect(prcsCd: prcsCd).then((res) {
    inspectList2.clear();
    List.generate(res.length, (index) {
      inspectList2.add(InspectState(
          prcsCd: res[index]['detailPrcsCd'],
          prcsNm: res[index]['detailPrcsNm']));
    });

    selectedValue2 = inspectList2[0].prcsNm;
  });
}

Future<File> getFileFromUrl(String url, {name}) async {
  var fileName = 'testonline';
  if (name != null) {
    fileName = name;
  }
  try {
    var data = await http
        .get(Uri.parse(url), headers: {'Authorization': Header.token});
    print('===>data ${data}');
    var bytes = data.bodyBytes;
    var dir = await getApplicationDocumentsDirectory();
    print(dir);
    File file = File("${dir.path}/" + fileName + ".pdf");
    print('===>dir ${dir.path}');
    File urlFile = await file.writeAsBytes(bytes);
    return urlFile;
  } catch (e) {
    throw Exception("Error opening url file");
  }
}

Future<File> fromAsset(String asset, String filename) async {
  // To open from assets, you can copy them to the app storage folder, and the access them "locally"
  Completer<File> completer = Completer();

  try {
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$filename");
    var data = await rootBundle.load(asset);
    var bytes = data.buffer.asUint8List();
    await file.writeAsBytes(bytes, flush: true);
    completer.complete(file);
  } catch (e) {
    throw Exception('Error parsing asset file!');
  }

  return completer.future;
}

void requestPersmission() async {
  await Permission.storage.request();
}

// Future<void> deleteImg(Map<dynamic, dynamic> state, String imageView) async {
//   ImageNetwork imageNet = ImageNetwork();

//   imageNet.delete(imageView).then((value) {
//     imageNet.search(state).then((value) {
//       var data = jsonDecode(value.toString());

//       if (data[state['code']] != null) {
//       } else {}
//     });
//   });
// }

// Future<void> searchImg(Map<dynamic, dynamic> state, String imageView) async {
//   ImageNetwork imageNet = ImageNetwork();

//   imageNet.search(state).then((value) {
//     var data = jsonDecode(value.toString());
//     if (data[state['code']] != null) {
//       imageList = data[state['code']];
//       imageView = imageList[0]['img'];
//     } else {
//       imageList = [];
//       imageView = null;
//     }
//   });
// }

AiMQTTClient aiMQTTClient = AiMQTTClient();
final FlutterTts tts = FlutterTts();

Future<void> setupAiMqttClient() async {
  await aiMQTTClient.connect();

  aiMQTTClient.subscribe(FR_TOPIC);
  aiMQTTClient.subscribe(PPE_TOPIC);
  aiMQTTClient.subscribe(WORK_TOPIC);
  aiMQTTClient.subscribe(BI_TOPIC);
  aiMQTTClient.subscribe(CON_TOPIC);
}

void setupAiUpdatesListener(BuildContext context) {
  aiMQTTClient
      .getMessagesStream()
      .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
    final recMess = c![0].payload as MqttPublishMessage;
    print('MQTTClient:: $recMess');
    final pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');

    if (c[0].topic == FR_TOPIC) {
      print('MQTTClient:: ${jsonDecode(pt)["status"]}');
      if (jsonDecode(pt)["status"] == 'complete') {
        print(jsonDecode(pt)["result"]);

        String imgUrl = '';

        switch (jsonDecode(pt)["result"][0]) {
          case 'no000001':
            imgUrl = "assets/img/work/no000001.jpg";
            break;
          case 'no000002':
            imgUrl = "assets/img/work/no000002.jpg";
            break;
          case 'no000003':
            imgUrl = "assets/img/work/no000003.jpg";
            break;
          case 'no000004':
            imgUrl = "assets/img/work/no000004.jpg";
            break;
          case 'no000005':
            imgUrl = "assets/img/work/no000005.jpg";
            break;
          case 'no000006':
            imgUrl = "assets/img/work/no000006.jpg";
            break;
          case 'no000007':
            imgUrl = "assets/img/work/no000007.jpg";
            break;
          case 'no000008':
            imgUrl = "assets/img/work/no000008.jpg";
            break;
          case 'no000009':
            imgUrl = "assets/img/work/no000009.jpg";
            break;
          case 'no000010':
            imgUrl = "assets/img/work/no000010.jpg";
            break;
          default:
        }

        RndNetwork()
            .getOpertor(target: jsonDecode(pt)["result"][0])
            .then((res) {
          print('MQTTClient:: $res');

          userStages.add(
            UserState(
              name: res['opertorNm'],
              age: '${res['age'].round()}',
              sex: res['opertorSex'] == 'M' ? '남' : '여',
              depart: "(주)금광전기",
              operatorNo: '${res['etc']}',
              career: '${res['opertorCareer']}',
              qualification: "N",
              deadline: "10",
              imgUrl: imgUrl,
              equi: [
                EquipState(
                  equipName: "안전모",
                  isCheck: false,
                  analyze: false,
                ),
                EquipState(
                  equipName: "안전장갑",
                  isCheck: false,
                  analyze: false,
                ),
                EquipState(
                  equipName: "안전화",
                  isCheck: false,
                  analyze: false,
                ),
              ],
            ),
          );
          isFinding = false;
          isFirst = true;
          isNext = true;
        });
      }
    }

    if (c[0].topic == WORK_TOPIC) {
      print('MQTTClient:: ${jsonDecode(pt)["status"]}');
      if (jsonDecode(pt)["status"] == 'detect') {
        List.generate(jsonDecode(pt)["result"]['detect_list'].length, (index) {
          print(
              'MQTTClient:: ${jsonDecode(pt)["result"]['detect_list'][index]['name']}');
          if (jsonDecode(pt)["result"]['detect_list'][index]['name'] ==
              'safety_gloves_off') {
            if (!FadeIn.status) {
              FadeIn.status = true;

              showRiskPop(context, 1);

              putStatus(3);

              tts.speak('위험감지가 확인되었습니다. 알림을 확인해주세요!');
            }
          } else if (jsonDecode(pt)["result"]['detect_list'][index]['name'] ==
              'safety_helmet_off') {
            if (!FadeIn.status) {
              FadeIn.status = true;

              showRiskPop(context, 1);

              putStatus(3);

              tts.speak('위험감지가 확인되었습니다. 알림을 확인해주세요!');
            }
          } else if (jsonDecode(pt)["result"]['detect_list'][index]['name'] ==
              'safety_suit_bottom_off') {
            if (!FadeIn.status) {
              FadeIn.status = true;

              showRiskPop(context, 1);

              putStatus(3);

              tts.speak('위험감지가 확인되었습니다. 알림을 확인해주세요!');
            }
          }
        });
      }
    }

    if (c[0].topic == PPE_TOPIC) {
      print('MQTTClient:: ${jsonDecode(pt)["status"]}');
      if (jsonDecode(pt)["status"] == 'new') {
        List.generate(jsonDecode(pt)["result"].length, (index) {
          print('MQTTClient:: ${jsonDecode(pt)["result"][index]}');

          if (jsonDecode(pt)["result"][index] != null) {
            if (jsonDecode(pt)["result"][index]['name'] == 'safety_helmet_on') {
              print('MQTTClient:: ${jsonDecode(pt)["result"][0]['name']}');
              userStages[0].equi[0].isCheck = true;
              userStages[0].equi[0].analyze = true;
            }
            if (jsonDecode(pt)["result"][index]['name'] ==
                'safety_gloves_work_on') {
              print('MQTTClient:: ${jsonDecode(pt)["result"][1]['name']}');

              userStages[0].equi[1].isCheck = true;
              userStages[0].equi[1].analyze = true;
            }
            if (jsonDecode(pt)["result"][index]['name'] == 'safety_boots_on') {
              print('MQTTClient:: ${jsonDecode(pt)["result"][2]['name']}');

              userStages[0].equi[2].isCheck = true;
              userStages[0].equi[2].analyze = true;
            }
          }
        });
        //
      }
      if (jsonDecode(pt)["status"] == 'complete') {
        List.generate(jsonDecode(pt)["result"].length, (index) {
          print('MQTTClient:: ${jsonDecode(pt)["result"][index]}');

          if (jsonDecode(pt)["result"][index] != null) {
            if (jsonDecode(pt)["result"][index]['name'] == 'safety_helmet_on') {
              print('MQTTClient:: ${jsonDecode(pt)["result"][0]['name']}');
              userStages[0].equi[0].isCheck = true;
              userStages[0].equi[0].analyze = true;
            }
            if (jsonDecode(pt)["result"][index]['name'] ==
                'safety_gloves_work_on') {
              print('MQTTClient:: ${jsonDecode(pt)["result"][1]['name']}');

              userStages[0].equi[1].isCheck = true;
              userStages[0].equi[1].analyze = true;
            }
            if (jsonDecode(pt)["result"][index]['name'] == 'safety_boots_on') {
              print('MQTTClient:: ${jsonDecode(pt)["result"][2]['name']}');

              userStages[0].equi[2].isCheck = true;
              userStages[0].equi[2].analyze = true;
            }
          }
        });
        //
      }
    }

    if (c[0].topic == CON_TOPIC) {
      print('MQTTClient:: ${jsonDecode(pt)["status"]}');
      if (jsonDecode(pt)["status"] == 'complete' ||
          jsonDecode(pt)["status"] == 'new') {
        if (jsonDecode(pt)["result"] != null) {
          List.generate(jsonDecode(pt)["result"].length, (index) {
            // print('MQTTClient:: ${jsonDecode(pt)["result"][index]['name']}');
            if (jsonDecode(pt)["result"][index] != null) {
              if (jsonDecode(pt)["result"][index]['name'] == 'signalman') {
                gearList[1].isChecked[0] = true;
              }

              if (jsonDecode(pt)["result"][index]['name'] ==
                  'sign_traffic_cone') {
                gearList[0].isChecked[0] = true;
              }
            }
          });
        }
      }
    }
  });
}
