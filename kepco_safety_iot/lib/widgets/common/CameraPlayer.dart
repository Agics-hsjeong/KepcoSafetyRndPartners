import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import 'package:kepco_safety_iot/models/designModel.dart';
import 'package:kepco_safety_iot/models/models.dart';
import 'vlc_player_with_controls.dart';

class CameraPlayer extends StatefulWidget {
  CameraPlayer({Key? key}) : super(key: key);

  var state = _CameraPlayerState();

  @override
  // ignore: library_private_types_in_public_api
  _CameraPlayerState createState() => state;
  // State<CameraPlayer> createState() => _CameraPlayerState();
}

class _CameraPlayerState extends State<CameraPlayer> {
  bool showPlayerControls = false;
  late VlcPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VlcPlayerController _controller = VlcPlayerController.network(
      'rtsp://$gwUrl:8554/cam/0/low',
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(
          // advanced: VlcAdvancedOptions([
          //   VlcAdvancedOptions.networkCaching(100),
          // ]),
          // subtitle: VlcSubtitleOptions([
          //   VlcSubtitleOptions.boldStyle(true),
          //   VlcSubtitleOptions.fontSize(30),
          //   VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
          //   VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
          //   // works only on externally added subtitles
          //   VlcSubtitleOptions.color(VlcSubtitleColor.navy),
          // ]),
          http: VlcHttpOptions([
            VlcHttpOptions.httpReconnect(true),
          ]),
          rtp: VlcRtpOptions([
            VlcRtpOptions.rtpOverRtsp(true),
          ])),
      // options: VlcPlayerOptions(),
      // options: VlcPlayerOptions(
      //   advanced: VlcAdvancedOptions([
      //     VlcAdvancedOptions.networkCaching(2000),
      //   ]),
      //   rtp: VlcRtpOptions([
      //     VlcRtpOptions.rtpOverRtsp(true),
      //   ]),
      // ),
    );

    // ignore: avoid_single_cascade_in_expression_statements

    // _controller
    //   ..initialize().then((_) {
    //     setState(() {
    //       _controller.setLooping(true);
    //     });
    //   });

    // controller.setLooping(true);
    VideoStatus.controller = _controller;
  }

  @override
  void dispose() async {
    // await _controller.stopRendererScanning();
    // await _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: double.infinity,
      // height:
      //     showPlayerControls ? 400 : MediaQuery.of(context).size.height * 0.36,
      child: VlcPlayerWithControls(
        controller: VideoStatus.controller,
        // showControls: true,

        // aspectRatio: 16 / 9,
        // virtualDisplay: false,
        // placeholder: Center(child: CircularProgressIndicator()),
        // showControls: showPlayerControls,
      ),
    );
    // return VlcPlayer(
    //     controller: controllers[0],
    //     aspectRatio: 16 / 9,
    //     placeholder: Center(child: CircularProgressIndicator()));
    // return ListView.separated(
    //   controller: ScrollController(),
    //   itemCount: controllers.length,
    //   separatorBuilder: (_, index) {
    //     return Divider(height: 5, thickness: 5, color: Colors.grey);
    //   },
    //   itemBuilder: (_, index) {
    //     return Stack(children: [
    //       VlcPlayer(
    //           controller: controllers[index],
    //           aspectRatio: 16 / 9,
    //           placeholder: Center(child: CircularProgressIndicator())),
    //       Positioned(
    //         top: 10,
    //         left: 10,
    //         child: AnimatedOpacity(
    //           opacity: recordingTextOpacity,
    //           duration: Duration(seconds: 1),
    //           child: Container(
    //             child: Wrap(
    //               crossAxisAlignment: WrapCrossAlignment.center,
    //               children: [
    //                 Icon(Icons.circle, color: Colors.red),
    //                 SizedBox(width: 5),
    //                 Text(
    //                   'REC',
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ]);
    //   },
    // );
  }
}
