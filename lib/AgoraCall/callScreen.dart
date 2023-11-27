/*
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';


import 'call_controller.dart';

class VideoCall extends StatefulWidget {
  final String channelId;
  const VideoCall({super.key, required this.channelId});

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final callCon = Get.put(CallController());

  @override
  void initState() {
    super.initState();
    Wakelock.enable(); // Turn on wakelock feature till call is running
  }

  @override
  void dispose() {
    // _engine.leaveChannel();
    // _engine.destroy();
    Wakelock.disable(); // Turn off wakelock feature after call end
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Obx(() => Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Center(
                  child: AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: callCon.engine,
                      canvas: VideoCanvas(
                          uid: callCon.myremoteUid.value),
                      connection:  RtcConnection(
                          channelId: widget.channelId.toString()),
                    ),
                  )
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 100,
                    height: 150,
                    child: Center(
                        child: callCon.localUserJoined.value
                            ? AgoraVideoView(
                          controller: VideoViewController(
                            rtcEngine: callCon.engine,
                            canvas: const VideoCanvas(uid: 0),
                          ),
                        )
                            : CircularProgressIndicator()),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            callCon.leave();
                        callCon.dispose();
                          },
                          child: const Icon(
                            Icons.call,
                            size: 35,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))),
    );
  }
}
*/
