/*
import 'dart:convert';
import 'dart:developer';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prophysio/helper/AppConst.dart';
import '../Network/ApiService.dart';


class CallController extends GetxController {





  ApiService apiService = ApiService();
  RxInt myremoteUid = 0.obs;
  RxBool localUserJoined = false.obs;
  RxBool muted = true.obs;
  RxBool videoPaused = false.obs;
  RxBool switchMainView = false.obs;
  RxBool mutedVideo = false.obs;
  RxBool reConnectingRemoteView = false.obs;
  RxBool isFront = false.obs;
  late RtcEngine engine;

 */
/* @override
  void onInit() {
    super.onInit();
    // initilize();
  }

  @override
  void onClose() {
    super.onClose();
    clear();
  }

  clear() {
    engine.leaveChannel();
    isFront.value = false;
    reConnectingRemoteView.value = false;
    videoPaused.value = false;
    muted.value = false;
    mutedVideo.value = false;
    switchMainView.value = false;
    localUserJoined.value = false;
    update();
  }

  Future<void> initilize(String chanId,String token,String uid) async {
    Future.delayed(Duration.zero, () async {
      await _initAgoraRtcEngine();
      _addAgoraEventHandlers();
      await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      VideoEncoderConfiguration configuration =
      const VideoEncoderConfiguration();
      await engine.setVideoEncoderConfiguration(configuration);
      await engine.leaveChannel();
      await engine.joinChannel(
        token: token,
        channelId: chanId,
        uid: int.parse(uid),
        options: const ChannelMediaOptions(),
      );
      update();
    });
  }

  Future<void> _initAgoraRtcEngine() async {
    engine = createAgoraRtcEngine();
    await engine.initialize( RtcEngineContext(
      appId: AppConst.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    await engine.enableVideo();
    // await engine.startPreview();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  }

  void _addAgoraEventHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            localUserJoined.value = true;
            update();
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            localUserJoined.value = true;
            myremoteUid.value = remoteUid;
            update();
          },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            if (reason == UserOfflineReasonType.userOfflineDropped) {

              // Wakelock.disable();
              myremoteUid.value = 0;
              onCallEnd();
              update();
            } else {
              myremoteUid.value = 0;
              onCallEnd();
              update();
            }
          },
          onRemoteVideoStats:
              (RtcConnection connection, RemoteVideoStats remoteVideoStats) {
            if (remoteVideoStats.receivedBitrate == 0) {
              videoPaused.value = true;
              update();
            } else {
              videoPaused.value = false;
              update();
            }
          },
          onTokenPrivilegeWillExpire:
              (RtcConnection connection, String token) {},
          onLeaveChannel: (RtcConnection connection, stats) {
            clear();
            onCallEnd();
            update();
          }),
    );
  }

  void onVideoOff() {
    mutedVideo.value = !mutedVideo.value;
    engine.muteLocalVideoStream(mutedVideo.value);
    update();
  }

  void onCallEnd() {
    clear();
    update();
    // Get.back();
  }

  void onToggleMute() {
    muted.value = !muted.value;
    engine.muteLocalAudioStream(muted.value);
    update();
  }

  void onToggleMuteVideo() {
    mutedVideo.value = !mutedVideo.value;
    engine.muteLocalVideoStream(mutedVideo.value);
    update();
  }

  void onSwitchCamera() {
    engine.switchCamera().then((value) => {}).catchError((err) {});
  }

*//*

  late RtcEngine agoraEngine; // Agora engine instance

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey
  = GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }





  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize( RtcEngineContext(
        appId: AppConst.appId
    ));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage("Local user uid:${connection.localUid} joined the channel");
            _isJoined = true;
          update();

        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          update();
            _remoteUid = remoteUid;
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
            _remoteUid = null;
            update();
        },
      ),
    );
  }

  void  join(String tokens,String uIds,String chanelNames) async {

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: tokens,
      channelId: chanelNames,
      options: options,
      uid: int.parse(uIds),
    );
  }

  void leave() {
      _isJoined = false;
      _remoteUid = null;
      update();
    agoraEngine.leaveChannel();
  }
// Clean up the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    super.dispose();
  }

}
*/
