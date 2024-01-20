import 'dart:async';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../ZegoCallService/ZegoCallService.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../../patient_screens/controller/patinet_chat_controller/PatinetChatController.dart';
import '../../../controller/DocotorBookingController.dart';

class DoctorChatScreen extends StatefulWidget {
  const DoctorChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DoctorChatScreen> createState() => _DoctorChatScreenState();
}

class _DoctorChatScreenState extends State<DoctorChatScreen> {
  TextEditingController messagectr = TextEditingController();

  // /* DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  ChatController chatController = Get.put(ChatController());
  BookingController bookingController = Get.put(BookingController());

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView view = CustomView();
  LocalString text = LocalString();

  var ilaod = true;
  late Timer _timer;
  String patientId = "";
  String patientName = "";
  String patientPic = "";
  String patientSurname = "";
  String patientUsername = "";
  String patientAddress = "";
  String patientContact = "";

  String? doctorId;

  final appId = '94a17beb94774769a4372f873bc053ee';
  final appCertificate = '79717ca6faa94fb5acc061beb699ed93';

  final expirationInSeconds = 3600;
  final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  FilePickerResult? result;

  @override
  void initState() {
    if (Get.arguments["bookingSide"] == "booking") {
      patientId = Get.arguments["ID"];
      patientName = Get.arguments["name"];
      patientPic = Get.arguments["userProfile"];
      patientSurname = Get.arguments["surName"];
      patientUsername = Get.arguments["userName"];
      patientAddress = Get.arguments["userLocation"];
      patientContact = Get.arguments["userContact"];
      log("patientName---${patientName} ${patientSurname}");

    } else {
      patientId = Get.arguments["ID"];
      patientName = Get.arguments["name"];
      patientPic = Get.arguments["pic"];
      patientSurname = Get.arguments["surname"];
      patientUsername = Get.arguments["username"];
      patientAddress = Get.arguments["address"];
      log("chat side address $patientAddress");
      log("patientName---${patientName} ${patientSurname}");

      // patientContact = Get.arguments["userContact"];
    }

    print("doctor Id==>>>>$patientId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.receivedMsgList.clear();
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        chatController.doctorReceivedMsgListFetch(context, patientId);
      });
    });
    getData();
    super.initState();
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
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: <Color>[MyColor.primary, MyColor.primary1]),
              ),
            ),
            toolbarHeight: 75.0,
            actions: [
           /*   GestureDetector(
                  onTap: () async {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const PrintScreen(),));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddInvoice(),));


                  },
                  child: Row(
                    children: [
                      view.text("Invoice", 11, FontWeight.normal, Colors.white),
                      const Icon(Icons.check_circle),
                    ],
                  )),*/
              ZegoSendCallInvitationButton(
                isVideoCall: true,
                invitees: getInvitesFromTextCtrl(patientId,"$patientName $patientSurname"),
                resourceID: 'zego_data',
                iconSize: const Size(40, 40),
                buttonSize: const Size(40, 40),
                onPressed: onSendCallInvitationFinished,
                // clickableBackgroundColor: Colors.white,
                icon: ButtonIcon(icon: const Icon(Icons.video_call_sharp,color: Colors.white,fill: CircularProgressIndicator.strokeAlignOutside),),
              ),
              const SizedBox(
                width: 5,
              ),
              ZegoSendCallInvitationButton(
                isVideoCall: false,
                invitees: getInvitesFromTextCtrl(patientId,"$patientName $patientSurname"),
                resourceID: 'zego_data',
                iconSize: const Size(40, 40),
                buttonSize: const Size(40, 40),
                onPressed: onSendCallInvitationFinished,
                // clickableBackgroundColor: Colors.white,
                icon: ButtonIcon(icon: const Icon(Icons.call,color: Colors.white,fill: CircularProgressIndicator.strokeAlignOutside),),
              ),
              SizedBox(
                width: 8,
              ),
              InkWell(
                  onTap: () {
                    var patientInfo = {
                      "ID": patientId,
                      "name": patientName,
                      "pic": patientPic,
                      "surname": patientName,
                      "username": patientUsername,
                      "address": patientAddress,
                    };
                    Get.toNamed(RouteHelper.DChatProfile(),
                        parameters: patientInfo);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const PatientChatProfile()));
                  },
                  child: const Icon(Icons.more_vert,color: Colors.white,)),
              const SizedBox(
                width: 10.0,
              ),
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
                  color: Colors.white70,
                )),
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: FadeInImage.assetNetwork(
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image(
                            image:
                                AssetImage("assets/images/dummyprofile.png")),
                      );
                    },
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    placeholder: "assets/images/loading.gif",
                    image: patientPic,
                    placeholderFit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    patientName,
                    style: const TextStyle(fontFamily: "Poppins", fontSize: 16,color: Colors.white),
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
              child: chatController.drReceivedMsgList.isEmpty
                  ? const SizedBox()
                  : ilaod == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          reverse: true,
                          itemCount: chatController.drReceivedMsgList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var reversedList = chatController
                                .drReceivedMsgList.reversed
                                .toList();
                            return Row(
                              mainAxisAlignment:
                                  patientId == reversedList[index].id
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
                                    color: doctorId == reversedList[index].id
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
                        controller: messagectr,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                            // suffixIcon: InkWell(
                            //     onTap: () {
                            //       showModalBottomSheet(
                            //           context: context,
                            //           shape: const RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.vertical(
                            //               top: Radius.circular(25.0),
                            //             ),
                            //           ),
                            //           backgroundColor: Colors.grey.shade200,
                            //           // <-- SEE HERE
                            //           builder: (context) {
                            //             return SizedBox(
                            //               height: 100,
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(10.0),
                            //                 child: InkWell(
                            //                   onTap: () async {
                            //                     result = await FilePicker
                            //                         .platform
                            //                         .pickFiles(
                            //                             allowMultiple: true);
                            //                     if (result == null) {
                            //                       log("No file selected");
                            //                     } else {
                            //                       setState(() {});
                            //                       for (var element in result!.files) {
                            //                         log("pdf ko naam-------${element.name}==${element.path}==${element.bytes}");
                            //                       }
                            //                     }
                            //                   },
                            //                   child: Column(
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.center,
                            //                     children: [
                            //                       view.text(
                            //                           "Select Patient Prescription and Invoices file to send",
                            //                           13,
                            //                           FontWeight.w500,
                            //                           MyColor.primary1),
                            //                       const Icon(Icons.file_present,
                            //                           size: 31,
                            //                           color: MyColor.primary1),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ),
                            //             );
                            //           });
                            //     },
                            //     child: const Icon(Icons.file_upload_outlined,
                            //         color: MyColor.primary1)),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(12),
                            hintText: text.enterMassage.tr,
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
                        if (messagectr.text.trim().isNotEmpty) {
                          chatController.doctorSendingMsgApi(context, patientId,
                              "Text", messagectr.text, "Doctor", () {});
                          // chatController.sendingMsgApi(context, doctorId!, "Text", messagectr.text, () {});
                        } else {
                          print('filed');
                        }
                        messagectr.clear();
                      },
                      child: const Icon(Icons.send,color: Colors.white,))
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Future<String?> getData() async {
    doctorId = (await sp.getStringValue(sp.DOCTOR_ID_KEY.toString()))!;
    print("user------------>:${await sp.getStringValue(sp.DOCTOR_ID_KEY)}");
    return null;
  }
}
