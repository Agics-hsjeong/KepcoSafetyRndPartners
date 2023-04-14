// ignore_for_file: depend_on_referenced_packages, file_names, avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'statusModel.dart';

// const String url = 'http://219.250.188.206:28080';
// const String url = 'http://192.168.0.18:8080';
const String url = 'http://106.255.245.242:28000';
// 'http://192.168.0.41:8081'
// 'http://106.255.245.242:28080'

class Network {
  Network();

  BaseOptions options = BaseOptions(
    baseUrl: url,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  Future<dynamic> getWork({int? cntwrkSeq}) async {
    final dio = Dio(options);

    try {
      Response response = await dio.get(
        cntwrkSeq != null ? '/site/$cntwrkSeq' : '/site',
        options: Options(
          headers: {'Authorization': Header.token},
        ),
      );

      if (response.statusCode != 200) {
        throw Exception();
      } else {
        print("The response is that \n${response.data}\n");
        // no need to decode , when we use dio package , its response
        // returns the String,dynamic
        List responseBody = response.data;
        return responseBody;
      }
    } catch (e) {
      print('===> 공사 리스트 찾기 실패');
      print(e.toString());
    }
  }

  Future<dynamic> getProc(int opertSeq) async {
    var dio = Dio(options);

    try {
      final respense = await dio.get(
        '/site/opert/$opertSeq',
        options: Options(
          headers: {'Authorization': Header.token},
        ),
      );

      if (respense.statusCode == 200) {
        return respense.data;
      }
    } catch (e) {
      // print("공종 리스트 찾기 실패");
      print(e.toString());
    }
  }

  Future<dynamic> postProc(
      Map<dynamic, dynamic> state, String eventType) async {
    var dio = Dio(options);
    // print('===>state ${state}');

    try {
      FormData formData = FormData.fromMap({
        "cntwrkTySeq": state['cntwrkTySeq'],
        "opertSeq": state['opertSeq'],
        "code": state['code'],
        "order": state['order'],
        "eventType": eventType,
      });

      final respense = await dio.post(
        '/site/opert/progrs',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Authorization': Header.token},
        ),
      );

      print('===> ${respense}');

      if (respense.statusCode == 200) {
        if (respense.data['responseMsg']) {
          print('===>성공 $eventType $state ${respense.data}');

          // print("===>성공 $respense");

          return respense.data;
        }
      }
    } catch (e) {
      // print("실패");
      print(e.toString());
    }
  }

  Future<dynamic> putProc(Map<dynamic, dynamic> state, String eventType) async {
    var dio = Dio(options);
    // print('===>state ${state}');

    try {
      FormData formData = FormData.fromMap({
        "cntwrkTySeq": state['cntwrkTySeq'],
        "opertSeq": state['opertSeq'],
        "code": state['code'],
        "order": state['order'],
        "eventType": eventType,
      });

      final respense = await dio.put(
        '/site/opert/progrs',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Authorization': Header.token},
        ),
      );

      print('===> ${respense}');

      if (respense.statusCode == 200) {
        print('===>성공 $eventType $state ${respense.data}');

        // print("===>성공 $respense");

        // return respense.data;
      }
    } catch (e) {
      // print("실패");
      print(e.toString());
    }
  }

  Future<dynamic> updateProc(
      int opertCntwrkTySeq, String cntwrkTyProcdrCd, String eventType) async {
    var dio = Dio(options);

    try {
      FormData formData = FormData.fromMap({
        "opertCntwrkTySeq": opertCntwrkTySeq,
        "cntwrkTyProcdrCd": cntwrkTyProcdrCd,
        "eventType": eventType,
      });

      final respense = await dio.post(
        '/api/bixpo/status',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Authorization': Header.token},
        ),
      );

      if (respense.statusCode == 200) {
        return '성공';
      }
    } catch (e) {
      // print("실패");
      print(e.toString());
    }
  }

  Future<dynamic> getInspect({String prcsCd = ''}) async {
    var dio = Dio(options);

    try {
      final respense = await dio.get(
        '/site/proc/inspect',
        queryParameters: prcsCd == '' ? null : {"prcsCd": prcsCd},
        options: Options(
          headers: {'Authorization': Header.token},
        ),
      );

      if (respense.statusCode == 200) {
        return respense.data;
      }
    } catch (e) {
      // print("공종 리스트 찾기 실패");
      print(e.toString());
    }
  }

  Future<dynamic> getNotics() async {
    var dio = Dio(options);

    try {
      final respense = await dio.get(
        '/api/home/board',
        options: Options(
          headers: {'Authorization': Header.token},
        ),
      );

      if (respense.statusCode == 200) {
        return respense.data;
      }
    } catch (e) {
      // print("공지사항 리스트 찾기 실패");
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> setLogin(String id, String pw) async {
    var dio = Dio(options);
    try {
      var respense = await dio.post(
        '/login',
        data: {
          "id": id,
          "password": pw,
        },
      );
      if (respense.statusCode == 200) {
        final Map<String, dynamic> body = respense.data;

        print(jsonDecode(body["userInfo"]));

        UserResult result = UserResult.fromJson({
          "status": body["status"],
          "message": body["message"],
          "userinfo": jsonDecode(body["userInfo"]),
        });

        Header.token = respense.headers.value("authorization").toString();
        return result;
      }
      // print(res);
      // print('===> ${res.headers.value("authorization")}');
      // Header.token = res.headers.value("authorization").toString();

      // return res;
    } catch (e) {
      // print("로그인 실패");
      print(e.toString());
      return UserResult(status: "fall", message: "fall", userinfo: null);
    }
  }
}

class NaverNetwork {
  NaverNetwork(this.url);

  String url;

  Future<dynamic> getJsonData() async {
    try {
      http.Response response =
          await http.get(Uri.parse(url), headers: Header.headers);

      if (response.statusCode == 200) {
        String jsonData = response.body;
        // var parsingData = jsonDecode(jsonData);
        return jsonData;
      } else {}
    } on SocketException catch (e) {
      print(e.toString());
    }
  }
}

class RndNetwork {
  RndNetwork();

  BaseOptions options = BaseOptions(
    baseUrl: url,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  Future<dynamic> getOpertor({String target = ''}) async {
    var dio = Dio(options);

    try {
      final respense = await dio.get(
        '/rnd/opertor',
        queryParameters: target == '' ? null : {"target": target},
        options: Options(
          headers: {'Authorization': Header.token},
        ),
      );

      if (respense.statusCode == 200) {
        return respense.data;
      }
    } catch (e) {
      // print("공종 리스트 찾기 실패");
      print(e.toString());
    }
  }

  Future<dynamic> putStatus(int eventType) async {
    var dio = Dio(options);
    // print('===>state ${state}');

    try {
      FormData formData = FormData.fromMap({
        // "cntwrkTySeq": state['cntwrkTySeq'],
        // "opertSeq": state['opertSeq'],
        // "code": state['code'],
        // "order": state['order'],
        "process": eventType,
      });

      final respense = await dio.put(
        '/rnd/status',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Authorization': Header.token},
        ),
      );

      // print('===> ${respense}');

      if (respense.statusCode == 200) {
        print('===>성공 $eventType');

        return respense.data;
      }
    } catch (e) {
      // print("실패");
      print(e.toString());
    }
  }
}

class AiNetwork {
  AiNetwork();

  BaseOptions options = BaseOptions(
    baseUrl: 'http://$gwUrl:50770',
    // baseUrl: 'http://219.250.188.208:50770',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  Future<dynamic> FrRecognize() async {
    print('MQTTClient:: FrRecognize()');
    Dio dio = Dio(options);
    try {
      var data = {
        "limit_time_min": 5,
        "report_unit": true,
        "ri": {
          "construction_code": "D54",
          "work_no": 3,
          "work_define_ri": 0.82,
          "ri_parameter_list": [
            {"name": "작업자 숙련도", "ratio": 0.6},
            {"name": "작업자 교육레벨", "ratio": 0.5}
          ],
          "evaluation_work_ri": 0
        },
        "targets": [
          "no000001",
          // "no000002",
          // "no000003",
          // "no000004",
          // "no000005",
          // "no000006",
          // "no000007"
        ]
      };

      return await dio.post(
        '/api/services/AE/FR-Recognize',
        data: data,
        options: Options(
          contentType: 'application/json',
          // headers: {'Authorization': Header.token},
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> OdConSetup() async {
    Dio dio = Dio(options);
    try {
      var data = {
        "limit_time_min": 5,
        "report_unit": true,
        "ri": {
          "construction_code": "D54",
          "work_no": 3,
          "work_define_ri": 0.82,
          "ri_parameter_list": [
            {"name": "작업자 숙련도", "ratio": 0.6},
            {"name": "작업자 교육레벨", "ratio": 0.5}
          ],
          "evaluation_work_ri": 0
        },
        "targets": {
          "signalman": true,
          "sign_traffic_cone": true,
          "sign_board_information": false,
          "sign_board_construction": false,
          "sign_board_traffic": false
        }
      };

      return await dio.post(
        '/api/services/AE/OD-CON-SETUP',
        data: data,
        options: Options(
          contentType: 'application/json',
          // headers: {'Authorization': Header.token},
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> OdPpeDetect() async {
    Dio dio = Dio(options);
    try {
      var data = {
        "limit_time_min": 5,
        "report_unit": true,
        "ri": {
          "construction_code": "D54",
          "work_no": 3,
          "work_define_ri": 0.82,
          "ri_parameter_list": [
            {"name": "작업자 숙련도", "ratio": 0.6},
            {"name": "작업자 교육레벨", "ratio": 0.5}
          ],
          "evaluation_work_ri": 0
        },
        "targets": {
          "safety_helmet_on": true,
          "safety_gloves_work_on": true,
          "safety_boots_on": true,
          "safety_belt_basic_on": false
        }
      };

      return await dio.post(
        '/api/services/AE/OD-PPE-Detect',
        data: data,
        options: Options(
          contentType: 'application/json',
          // headers: {'Authorization': Header.token},
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> OdWorkDetect() async {
    Dio dio = Dio(options);
    try {
      var data = {
        "ri": {
          "construction_code": "D54",
          "work_no": 3,
          "work_define_ri": 0.82,
          "ri_parameter_list": [
            {"name": "작업자 숙련도", "ratio": 0.6},
            {"name": "작업자 교육레벨", "ratio": 0.5}
          ],
          "evaluation_work_ri": 0
        }
      };

      return await dio.post(
        '/api/services/AE/OD-Work-Detect',
        data: data,
        options: Options(
          contentType: 'application/json',
          // headers: {'Authorization': Header.token},
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> OdWorkDetectStop() async {
    Dio dio = Dio(options);
    try {
      // var data = {
      //   "ri": {
      //     "construction_code": "D54",
      //     "work_no": 3,
      //     "work_define_ri": 0.82,
      //     "ri_parameter_list": [
      //       {"name": "작업자 숙련도", "ratio": 0.6},
      //       {"name": "작업자 교육레벨", "ratio": 0.5}
      //     ],
      //     "evaluation_work_ri": 0
      //   }
      // };

      return await dio.post(
        '/api/services/AE/OD-Work-Detect-Stop',
        // data: data,
        options: Options(
          contentType: 'application/json',
          // headers: {'Authorization': Header.token},
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> BiDetect() async {
    Dio dio = Dio(options);
    try {
      var data = {
        "ri": {
          "construction_code": "D54",
          "work_no": 3,
          "work_define_ri": 0.82,
          "ri_parameter_list": [
            {"name": "작업자 숙련도", "ratio": 0.6},
            {"name": "작업자 교육레벨", "ratio": 0.5}
          ],
          "evaluation_work_ri": 0
        }
      };

      return await dio.post(
        '/api/services/AE/BI-Detect',
        data: data,
        options: Options(
          contentType: 'application/json',
          // headers: {'Authorization': Header.token},
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> BiDetectStop() async {
    Dio dio = Dio(options);
    try {
      // var data = {
      //   "ri": {
      //     "construction_code": "D54",
      //     "work_no": 3,
      //     "work_define_ri": 0.82,
      //     "ri_parameter_list": [
      //       {"name": "작업자 숙련도", "ratio": 0.6},
      //       {"name": "작업자 교육레벨", "ratio": 0.5}
      //     ],
      //     "evaluation_work_ri": 0
      //   }
      // };

      return await dio.post(
        '/api/services/AE/BI-Detect-Stop',
        // data: data,
        options: Options(
          contentType: 'application/json',
          // headers: {'Authorization': Header.token},
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}

class ImageNetwork {
  ImageNetwork();

  BaseOptions options = BaseOptions(
    baseUrl: url,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  Future<dynamic> upload(
      List<XFile> pickedImgs, Map<dynamic, dynamic> state, String type) async {
    var dio = Dio(options);
    // print('===>state $state');
    try {
      List<MultipartFile> multipartImgList = [];
      for (int i = 0; i < pickedImgs.length; i++) {
        var pic = await MultipartFile.fromFile(pickedImgs[i].path,
            contentType: MediaType("image", "png"));

        multipartImgList.add(pic);
      }

      String detailPrcsCd = '';

      if (type == 'ISP') {
        List.generate(inspectList2.length, (index) {
          if (inspectList2[index].prcsNm == selectedValue2)
            detailPrcsCd = inspectList2[index].prcsCd;
        });
      }

      FormData formData = FormData.fromMap({
        "images": multipartImgList, // 이미지 파일
        "cntwrkSeq": state['cntwrkSeq'],
        "cntwrkTySeq": state['cntwrkTySeq'],
        "cntwrkTyCd": state['cntwrkTyCd'],
        "opertSeq": state['opertSeq'],
        "code": state['code'],
        "order": state['order'],
        "detailPrcsCd": type == 'ISP' ? detailPrcsCd : null,
        "type": type,
      });

      return await dio.post(
        '/image',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Authorization': Header.token},
        ),
      );
    } catch (e) {
      // print("이미지 등록 실패");
      print(e.toString());
    }
  }

  Future<dynamic> search(Map<dynamic, dynamic> state) async {
    var dio = Dio(options);
    // print(Header.token);

    try {
      // FormData formData = FormData.fromMap({
      //   "opertCntwrkTySeq": opertCntwrkTySeq,
      //   "cntwrkTyProcdrCd": cntwrkTyProcdrCd,
      // });

      return await dio.get(
        '/image',
        queryParameters: {"cntwrkTySeq": state['cntwrkTySeq']},
        options: Options(
          headers: {'Authorization': Header.token},
        ),
      );
    } catch (e) {
      // print("이미지 찾기 실패");
      print(e.toString());
    }
  }

  Future<dynamic> delete(int _pickImg) async {
    var dio = Dio(options);
    try {
      return await dio.delete(
        '/image/$_pickImg',
        options: Options(
          headers: {'Authorization': Header.token},
        ),
      );
    } catch (e) {
      // print("이미지 삭제 실패");
      print(e.toString());
    }
  }
}

class Header {
  static Map<String, String> headers = {};
  static String token = "";
}
