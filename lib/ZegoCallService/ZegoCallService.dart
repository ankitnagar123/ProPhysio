import 'dart:developer';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
ZegoUIKitPrebuiltCallController? callController;

/// on user login
void onUserLogin(String id ,String name,String type) async {
  log("onUserLogin-----$id");
  log("type-----$type");
  callController ??= ZegoUIKitPrebuiltCallController();

  /// 4/5. initialized ZegoUIKitPrebuiltCallInvitationService when account is logged in or re-logged in
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: 1913349555,
    appSign: "020acd528334f44c77ed61c20e137d7c051739331aea9c2419a1474971e8478e",
    userID:  id,
    userName: name,
    notifyWhenAppRunningInBackgroundOrQuit: false,
    plugins: [ZegoUIKitSignalingPlugin()],
    controller: callController,
    requireConfig: (ZegoCallInvitationData data) {
      final config = (data.invitees.length > 1)
          ? ZegoCallType.videoCall == data.type
          ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
          : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
          : ZegoCallType.videoCall == data.type
          ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

 // config.avatarBuilder = customAvatarBuilder;


      /// support minimizing, show minimizing button
      config.topMenuBarConfig.isVisible = true;
      config.topMenuBarConfig.buttons
          .insert(0, ZegoMenuBarButtonName.minimizingButton);

      return config;
    },
  );
}

void onUserLogout() {
  callController = null;

  /// 5/5. de-initialization ZegoUIKitPrebuiltCallInvitationService when account is logged out
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}
List<ZegoUIKitUser> getInvitesFromTextCtrl(String textCtrlText ,String username) {
  log("name----------$username");
  log("id----------$textCtrlText");
  final invitees = <ZegoUIKitUser>[];

  final inviteeIDs = textCtrlText.trim().replaceAll('，', '');
  inviteeIDs.split(',').forEach((inviteeUserID) {
    if (inviteeUserID.isEmpty) {
      return;
    }

    invitees.add(ZegoUIKitUser(
      id: inviteeUserID,
      name: username,
    ));
  });
  return invitees;
}

void onSendCallInvitationFinished(
    String code,
    String message,
    List<String> errorInvitees,
    ) {
  if (errorInvitees.isNotEmpty) {
    var userIDs = '';
    for (var index = 0; index < errorInvitees.length; index++) {
      if (index >= 5) {
        userIDs += '... ';
        break;
      }

      final userID = errorInvitees.elementAt(index);
      userIDs += '$userID ';
    }
    if (userIDs.isNotEmpty) {
      userIDs = userIDs.substring(0, userIDs.length - 1);
    }

    var message = "User doesn't exist or is offline: $userIDs";
    if (code.isNotEmpty) {
      message += ', code: $code, message:$message';
    }
    // showToast(
    //   message,
    //   position: StyledToastPosition.top,
    //   context: context,
    // );
  } else if (code.isNotEmpty) {
    // showToast(
    //   'code: $code, message:$message',
    //   position: StyledToastPosition.top,
    //   context: context,
    // );
  }

}
