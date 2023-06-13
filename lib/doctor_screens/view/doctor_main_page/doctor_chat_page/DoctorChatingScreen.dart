import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';

import '../../../../helper/mycolor/mycolor.dart';
import '../../../../patient_screens/controller/patinet_chat_controller/PatinetChatController.dart';
import '../../../controller/DocotorBookingController.dart';

class DoctorChatScreen extends StatefulWidget {
  DoctorChatScreen({
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

  // var ilaod = true;
  late Timer _timer;
  String patientId = "";
  String patientName = "";
  String patientPic = "";
  String patientSurname = "";
  String patientUsername = "";
  String? doctorId;

  @override
  void initState() {
    patientId = Get.arguments["ID"];
/*    patientName = Get.arguments["name"];
    patientPic = Get.arguments["pic"];
    patientSurname = Get.arguments["surname"];
    patientUsername = Get.arguments["username"];*/

    print("doctor Id==>>>>$patientId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.receivedMsgList.clear();
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        chatController.doctorReceivedMsgListFetch(context, patientId);
      });
    });
    getData();
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        // ilaod = false;
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
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topLeft,
                    colors: <Color>[MyColor.primary1, MyColor.secondary]),
              ),
            ),
            toolbarHeight: 85.0,
            actions: [
              InkWell(
                  onTap: () {
                    var patientInfo = {
                      "ID": patientId,
                      "name": patientName,
                      "pic":patientPic,
                      "surname":patientName,
                      "username":patientUsername,
                    };
                    Get.toNamed(RouteHelper.DChatProfile(),arguments: patientInfo);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const PatientChatProfile()));
                  },
                  child: const Icon(Icons.more_vert)),
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
                  } else if (_timer != null) {
                    _timer.isBlank;
                  }
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 18.0,
                )),
            elevation: 0,
            title: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(120.0),
                  child: FadeInImage.assetNetwork(
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image(
                            image: AssetImage("assets/images/dummyprofile.jpg")),
                      );
                    },
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    placeholder: "assets/images/loading.gif",
                    image: patientPic,
                    placeholderFit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 9.0,
                ),
                Column(
                  children: [
                    Text(
                      "$patientName $patientSurname",
                      style: const TextStyle(fontFamily: "Poppins", fontSize: 17),
                    ),
                   /* const Text(
                      "online",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                    )*/
                  ],
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
                  : ListView.builder(
                      reverse: true,
                      itemCount: chatController.receivedMsgList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var reversedList =
                            chatController.receivedMsgList.reversed.toList();
                        return Row(
                          mainAxisAlignment: doctorId == reversedList[index].id
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
                                          reversedList[index].sentat.toString(),
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
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        style: const TextStyle(decorationThickness: 0),
                        controller: messagectr,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'Enter message...',
                            hintStyle: TextStyle(
                                color: MyColor.primary1,
                                fontSize: 12,
                                letterSpacing: 1.0)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.primary1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(55, 55)),
                      onPressed: () {
                        if (messagectr.text.trim().isNotEmpty) {
                          chatController.doctorSendingMsgApi(context, patientId,
                              "Text", messagectr.text, () {});
                          // chatController.sendingMsgApi(context, doctorId!, "Text", messagectr.text, () {});
                        } else {
                          print('filed');
                        }
                        messagectr.clear();
                      },
                      child: const Icon(Icons.send))
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
  }
}
