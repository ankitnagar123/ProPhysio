import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../ZegoCallService/ZegoCallService.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../controller/doctor_list_ctr/DoctorListController.dart';
import '../../../controller/patinet_chat_controller/PatinetChatController.dart';
import 'PatientChatProfile.dart';

class PatientChatScreen extends StatefulWidget {
  const PatientChatScreen({
    super.key,
  });

  @override
  State<PatientChatScreen> createState() => _PatientChatScreenState();
}

class _PatientChatScreenState extends State<PatientChatScreen> {
  TextEditingController messageCtr = TextEditingController();
  LocalString text = LocalString();
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  ChatController chatController = Get.put(ChatController());

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView view = CustomView();
  var ilaod = true;
  late Timer _timer;
  String patientId = "";
  String doctorId = "";
  String doctorName = "";
  String doctorAddress = "";
  String doctorImg = "";
  String doctorSurname = "";
  String doctorContact = "";

  @override
  void initState() {
    super.initState();
    if (Get.parameters["doctorList"].toString() == "drListData") {
      doctorId = Get.parameters["doctorId"].toString();
      doctorName = Get.parameters["drName"].toString();
      doctorAddress = Get.parameters["drAddress"].toString();
      doctorImg = Get.parameters["doctorImg"].toString();
      doctorSurname = Get.parameters["drSurname"].toString();
      doctorContact = Get.parameters["contact"].toString();
      log("doctorName---${doctorName} ${doctorSurname}");
      log("doctorImg---$doctorImg");
    } else {
      doctorId = Get.parameters["doctorId"].toString();
      doctorName = Get.parameters["drName"].toString();
      doctorAddress = Get.parameters["drAddress"].toString();
      doctorImg = Get.parameters["doctorImg"].toString();
      doctorSurname = Get.parameters["drSurname"].toString();
      log("doctorName---${doctorName} ${doctorSurname}");
      log("doctorImg---$doctorImg");

      // doctorContact = Get.arguments["contact"];
    }

    log("doctor Id==>>>>$doctorId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.receivedMsgList.clear();
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        chatController.receivedMsgListFetch(context, doctorId);
      });
    });
    getData();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        ilaod = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: <Color>[MyColor.primary, MyColor.primary1]),
              ),
            ),
            toolbarHeight: 75.0,
            actions: [
              ZegoSendCallInvitationButton(
                isVideoCall: true,
                invitees: getInvitesFromTextCtrl(
                    doctorId, "$doctorName $doctorSurname"),
                resourceID: 'zego_data',
                iconSize: const Size(40, 40),
                buttonSize: const Size(40, 40),
                onPressed: onSendCallInvitationFinished,
                icon: ButtonIcon(
                  icon: const Icon(
                    Icons.video_call,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              ZegoSendCallInvitationButton(
                isVideoCall: false,
                invitees: getInvitesFromTextCtrl(
                    doctorId, "$doctorName $doctorSurname"),
                resourceID: 'zego_data',
                iconSize: const Size(40, 40),
                buttonSize: const Size(40, 40),
                onPressed: onSendCallInvitationFinished,
                icon: ButtonIcon(
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientChatProfile(
                                  name: doctorName,
                                  surname: doctorSurname,
                                  address: doctorAddress,
                                  img: doctorImg,
                                  contact: doctorContact,
                                )));
                  },
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 10.0,
              )
            ],
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: MyColor.primary),
            leading: InkWell(
                onTap: () {
                  if (_timer != null) {
                    _timer.cancel();
                  } else {
                    _timer.isBlank;
                  }

                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 18.0,
                  color: Colors.white,
                )),
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: FadeInImage.assetNetwork(
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset("assets/images/dummyprofile.png",
                            width: 45, height: 45, fit: BoxFit.cover),
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    placeholder: "assets/images/loading.gif",
                    image: doctorImg.toString(),
                    placeholderFit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    doctorName,
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            )),
        body: Column(
          children: [
            Expanded(
                child: SizedBox(
              height: 300,
              child: chatController.receivedMsgList.isEmpty
                  ? const SizedBox()
                  : ilaod == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          reverse: true,
                          itemCount: chatController.receivedMsgList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var reversedList = chatController
                                .receivedMsgList.reversed
                                .toList();
                            return Row(
                              mainAxisAlignment:
                                  doctorId == reversedList[index].id
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 45,
                                  ),
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    color: patientId == reversedList[index].id
                                        ? MyColor.chatColor
                                        : MyColor.white,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 30,
                                            top: 5,
                                            bottom: 20,
                                          ),
                                          child: view.text(
                                              reversedList[index]
                                                  .message
                                                  .toString(),
                                              15,
                                              FontWeight.w400,
                                              MyColor.black),
                                        ),
                                        Positioned(
                                          bottom: 2,
                                          right: 3,
                                          child: view.text(
                                              reversedList[index]
                                                  .sentat
                                                  .toString(),
                                              8,
                                              FontWeight.w400,
                                              MyColor.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColor.lightcolor,
                          // border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        style: const TextStyle(decorationThickness: 0),
                        controller: messageCtr,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(12),
                            hintText: text.enterMessage.tr,
                            hintStyle: const TextStyle(
                                color: MyColor.white,
                                fontSize: 12,
                                letterSpacing: 1.0)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.primary1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(55, 55)),
                      onPressed: () {
                        if (messageCtr.text.trim().isNotEmpty) {
                          chatController.sendingMsgApi(context, doctorId,
                              "Text", messageCtr.text, "User", () {});
                        } else {
                          print('filed');
                        }
                        messageCtr.clear();
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ))
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Future<String?> getData() async {
    patientId = (await sp.getStringValue(sp.PATIENT_ID_KEY.toString()))!;
    print("user------------>:${await sp.getStringValue(sp.PATIENT_ID_KEY)}");
    return null;
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
