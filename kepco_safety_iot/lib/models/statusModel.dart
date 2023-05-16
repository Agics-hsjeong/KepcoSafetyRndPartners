// ignore_for_file: file_names
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:kepco_safety_iot/widgets/common/WorkerBox.dart';
import 'package:kepco_safety_iot/widgets/common/TableBox.dart';

String gwUrl = '223.171.144.245';
// String gwUrl = '223.171.144.244';

List<XFile> pickedImgs = [];
String pathPDF = "";
bool isNext = false;
// List imageList = [];

class Status {
  static late Map<String, dynamic> user;
  static late Map<String, dynamic> currentStage;
  static bool isOpen = true;
}

class Process {
  final String stateTitle;
  final String titleNumber;
  final String opertProcssCode;

  Process(
      {required this.stateTitle,
      required this.titleNumber,
      required this.opertProcssCode});

  factory Process.fromJson(Map<String, dynamic> parsedJson) {
    return Process(
      stateTitle: parsedJson['stateTitle'],
      titleNumber: parsedJson['titleNumber'],
      opertProcssCode: parsedJson['opertProcssCode'],
    );
  }

  Map<String, dynamic> toJson() => {
        'stateTitle': stateTitle,
        'titleNumber': titleNumber,
        'opertProcssCode': opertProcssCode,
      };
}

class UserResult {
  final String status;
  final String message;
  final UserInfo? userinfo;

  UserResult(
      {required this.status, required this.message, required this.userinfo});

  factory UserResult.fromJson(Map<String, dynamic> parsedJson) {
    return UserResult(
      status: parsedJson['status'],
      message: parsedJson['message'],
      userinfo: parsedJson['userinfo'] == null
          ? null
          : UserInfo.fromJson(parsedJson['userinfo']),
    );
  }
}

class UserInfo {
  final String id;
  // final String password;
  final String userNm;
  // final String userAdres;
  // final String userEmail;
  final String kcPlc1;
  final String kcPlc2;
  final String role;
  // final String roleNm;
  // final String? groupNm;
  // final String? orgnztNm;

  UserInfo({
    required this.id,
    // required this.password,
    required this.userNm,
    // required this.userAdres,
    // required this.userEmail,
    required this.kcPlc1,
    required this.kcPlc2,
    required this.role,
    // required this.roleNm,
    // required this.groupNm,
    // required this.orgnztNm,
  });

  factory UserInfo.fromJson(Map<String, dynamic> parsedJson) {
    return UserInfo(
      id: parsedJson['id'],
      // password: parsedJson['password'],
      userNm: parsedJson['userNm'],
      // userAdres: parsedJson['userAdres'],
      // userEmail: parsedJson['userEmail'],
      kcPlc1: parsedJson['kcPlc1'],
      kcPlc2: parsedJson['kcPlc2'],
      role: parsedJson['role'],
      // roleNm: parsedJson['roleNm'],
      // groupNm: parsedJson['groupNm'] as String?,
      // orgnztNm: parsedJson['orgnztNm'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        // "password": password,
        "userNm": userNm,
        // "userAdres": userAdres,
        // "userEmail": userEmail,
        "kcPlc1": kcPlc1,
        "kcPlc2": kcPlc2,
        "role": role,
        // "roleNm": roleNm,
        // "groupNm": groupNm,
        // "orgnztNm": orgnztNm,
      };
}

class FadeIn {
  static bool status = false;
}

class HealthStatus {
  static int bodyStatus = 0;
  static int stressStatus = 0;
}

class VideoStatus {
  // static String url = 'http://106.255.245.242:39104/video/1.작업신원확인_5s.mp4';
  // // static late List<VlcPlayerController> controllers;
  // static int selectedVideoIndex = 0;

  static late VlcPlayerController controller;
  // static VideoPlayerController videoPlayerController =
  //     VideoPlayerController.network(
  //   'http://106.255.245.242:39104/video/1.작업신원확인_5s.mp4',
  // );
  // static ChewieController chewieController = ChewieController(
  //   videoPlayerController: VideoStatus.videoPlayerController,
  //   aspectRatio: VideoStatus.videoPlayerController.value.aspectRatio * 2,
  //   autoInitialize: true,
  //   autoPlay: true,
  //   showOptions: false,
  //   showControls: true,
  //   looping: true,
  // );

  // static Future<void> setVideoCheing(String path) async {
  //   VideoStatus.videoPlayerController.dispose();
  //   VideoStatus.chewieController.dispose();

  //   VideoStatus.videoPlayerController = VideoPlayerController.network(
  //     path,
  //   );

  //   VideoStatus.chewieController = ChewieController(
  //     videoPlayerController: VideoStatus.videoPlayerController,
  //     aspectRatio: VideoStatus.videoPlayerController.value.aspectRatio * 2,
  //     autoInitialize: true,
  //     autoPlay: true,
  //     showOptions: false,
  //     showControls: true,
  //     looping: true,
  //   );
  //   // chewieController.allowMuting;
  //   VideoStatus.chewieController.setVolume(0);
  // VideoStatus.chewieController.play();
  // }
}

class StepStatus {
  List<bool> isChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
}

bool isChecked = false;

int selectedIndex = 0;

bool isRisk = false;

ScrollController scrollController = ScrollController();

class InspectState {
  String prcsCd;
  String prcsNm;

  InspectState({
    required this.prcsCd,
    required this.prcsNm,
  });
}

List<InspectState> inspectList = [InspectState(prcsCd: '00', prcsNm: '기본공사')];
List<InspectState> inspectList2 = [InspectState(prcsCd: '00', prcsNm: '기본공사')];
String selectedValue1 = '기본공사';
String selectedValue2 = '기본공사';

List<UserState> userStages = List.empty(growable: true);
bool isFinding = false;
bool isFirst = false;

List<SingleRowState> gearList = List.empty(growable: true);

// class GearState {
//   String contents;
//   List<bool> isChecked;

//   GearState({
//     required this.contents,
//     required this.isChecked,
//   });
// }
