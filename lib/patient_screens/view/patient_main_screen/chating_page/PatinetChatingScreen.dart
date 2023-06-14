import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';

import '../../../../helper/mycolor/mycolor.dart';
import '../../../controller/doctor_list_ctr/DoctorListController.dart';
import '../../../controller/patinet_chat_controller/PatinetChatController.dart';
import 'PatientChatProfile.dart';

class PatientChatScreen extends StatefulWidget {
  const PatientChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PatientChatScreen> createState() => _PatientChatScreenState();
}

class _PatientChatScreenState extends State<PatientChatScreen> {
  TextEditingController messageCtr = TextEditingController();

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
    if(Get.arguments["chatList"] =="listData"){
      doctorId = Get.arguments["doctorId"];
      doctorName = Get.arguments["drName"];
      doctorAddress = Get.arguments["drAddress"];
      doctorImg = Get.arguments["drImg"];
      doctorSurname = Get.arguments["drSurname"];
      // doctorContact = Get.arguments["contact"];
    }else /*if(Get.arguments["doctorList"] =="drListData")*/{
      doctorId = Get.arguments["doctorId"];
      doctorName = Get.arguments["drName"];
      doctorAddress = Get.arguments["drAddress"];
      doctorImg = Get.arguments["drImg"];
      doctorSurname = Get.arguments["drSurname"];
      doctorContact = Get.arguments["contact"];
    }


    print("doctor Id==>>>>$doctorId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.receivedMsgList.clear();
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        chatController.receivedMsgListFetch(context, doctorId);
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
                  } else {
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
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset("assets/images/dummyprofile.jpg",
                            width: 50, height: 50, fit: BoxFit.cover),
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    placeholder: "assets/images/loading.gif",
                    image: doctorImg,
                    placeholderFit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 9.0,
                ),
                Column(
                  children: [
                    Text(
                      "$doctorName $doctorSurname",
                      style:
                          const TextStyle(fontFamily: "Poppins", fontSize: 18),
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
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        style: const TextStyle(decorationThickness: 0),
                        controller: messageCtr,
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
                        if (messageCtr.text.trim().isNotEmpty) {
                          chatController.sendingMsgApi(context, doctorId,
                              "Text", messageCtr.text, () {});
                        } else {
                          print('filed');
                        }
                        messageCtr.clear();
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
    patientId = (await sp.getStringValue(sp.PATIENT_ID_KEY.toString()))!;
    print("user------------>:${await sp.getStringValue(sp.PATIENT_ID_KEY)}");
    return null;
  }
}
