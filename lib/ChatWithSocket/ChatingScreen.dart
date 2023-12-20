import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophysio/helper/mycolor/mycolor.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../helper/sharedpreference/SharedPrefrenc.dart';
import 'MsModel.dart';
import 'SocketController.dart';


class PatientChatScreens extends StatefulWidget {
  const PatientChatScreens({super.key});

  @override
  State<PatientChatScreens> createState() => _PatientChatScreensState();
}

class _PatientChatScreensState extends State<PatientChatScreens> {


   SharedPreferenceProvider sp = SharedPreferenceProvider();


  String? userId = "";
  String doctorId = "";
  String doctorName = "";
  String doctorAddress = "";
  String doctorImg = "";
  String doctorSurname = "";
  String doctorContact = "";
  TextEditingController messageCtr = TextEditingController();
  SocketIo socketIoInit = SocketIo();
  List<MessageModel> messagesList = [];

  @override
  void initState() {
    super.initState();
    SocketIo.userConnect();
    getId();
    if (Get.arguments["chatList"] == "listData") {
      doctorId = Get.arguments["doctorId"];
      doctorName = Get.arguments["drName"];
      doctorAddress = Get.arguments["drAddress"];
      doctorImg = Get.arguments["drImg"];
      doctorSurname = Get.arguments["drSurname"];
      // doctorContact = Get.arguments["contact"];
    } else {
      doctorId = Get.arguments["doctorId"];
      doctorName = Get.arguments["drName"];
      doctorAddress = Get.arguments["drAddress"];
      doctorImg = Get.arguments["drImg"];
      doctorSurname = Get.arguments["drSurname"];
      doctorContact = Get.arguments["contact"];
    }

    log("doctor Id==>>>>$doctorId");

  }


  @override
  void dispose() {
    super.dispose();
    SocketIo.socket.disconnect();
    SocketIo.socket.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    /*Get.offNamed(RouteHelper.getChatHomePage());*/
                    Get.back();
                  },
                  child: Container(
                    height: 35,
                    width: 40,
                    decoration: BoxDecoration(
                      color: MyColor.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: MyColor.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Chat",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.merge(TextStyle(color: MyColor.black)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: messagesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var reversedList = messagesList.reversed.toList();
                          return Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context)
                                          .size
                                          .width -
                                          45),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    reversedList[index].toString(),
                                    style:
                                    TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade500,
                                  borderRadius:
                                  BorderRadius.circular(20)),
                              child: TextField(
                                style:
                                TextStyle(decorationThickness: 0),
                                controller: messageCtr,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.all(12),
                                    hintText: 'Type your message'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              sendMessage(messageCtr.text, userId.toString(), doctorId);                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey.shade500,
                              ),
                              child: Center(child: Icon(Icons.send)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  void connectSocket() {
    try {
      SocketIo.socket.onConnect((data) {
        log("Connect");
        log("socket connection: ${SocketIo.socket.connected}");
      });
      requestChatHistory();

      SocketIo.socket.on("message", (msg) {
        log("------------------>${msg[0]}");

        setMsg("destination", msg[0]["message"].toString(),);

        WidgetsBinding.instance.addPostFrameCallback((_){
          // _scrollToBottom();
        });

      });

      SocketIo.socket.onDisconnect((data) {
        log("Disconnected");
      });

      SocketIo.socket.onError((error) {
        log("Error: $error");
      });
    } catch (e) {
      log("Exception----------------------: $e");
    }
  }


  sendMessage(String message,String source,String target){
    setMsg(message,"source");
    SocketIo.socket.emit("message",
        {"message":message,"targetId":target.toString(),"sourceId":source.toString(),"filename":"",
          "filePath":"","mimetype":"text","thumbnail":""});
    WidgetsBinding.instance.addPostFrameCallback((_){
      // _scrollToBottom();
    });
  }

   setMsg(String msg, String typ){
     MessageModel messageModel = MessageModel(message: msg, type: typ);
     messagesList.add(messageModel);
   }


  void getId()async{
    var userType = await sp.getStringValue(sp.USER_TYPE);

    if(userType =="Doctor"){
      userId = await sp.getStringValue(sp.DOCTOR_ID_KEY);
    }else{
      userId = await sp.getStringValue(sp.PATIENT_ID_KEY);
    }
    log('user id -----$userId');
    connectSocket();
  }


   void requestChatHistory() {
     SocketIo.socket.emit("chatHistory",{"sourceId":userId,"targetId":doctorId});
     // Listen for the 'chatHistory' event to receive the chat history.
     SocketIo.socket.on('chatHistory', (data) {
       log("---Chat History--------------->$data");
       WidgetsBinding.instance.addPostFrameCallback((_) {
         // _scrollToBottom();
       });

       List? chatHistoryList = List<dynamic>.from(json.decode(json.encode(data)));

       for(int i =0; i < chatHistoryList.length;i++){
         setMsg(chatHistoryList[i]["message"].toString(),chatHistoryList[i]["user_from"].toString() == userId ?"source":"destination",
           );
       }
     });
   }


}
