import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../Network/ApiService.dart';
import 'package:get/get.dart';

import '../../../Network/Apis.dart';
import '../../../doctor_screens/model/DoctorChatListModel.dart';
import '../../../doctor_screens/model/DoctorViewMsgList.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../network/Internet_connectivity_checker/InternetConnectivity.dart';
import "../../model/Chat Model's/ChatigViewListModel.dart";
import "../../model/Chat Model's/PatinetChatListModel.dart";

class ChatController extends GetxController {
  ApiService apiService = ApiService();
  var loadingset = false.obs;
  var loadingFetch = false.obs;
  var loadingFetchList = false.obs;
  var loadingListDelete = false.obs;

  var loadingFetchListD = false.obs;

  var receivedMsgList = <PChatingViewListModel>[].obs;

  var drReceivedMsgList = <DoctorViewMsgList>[].obs;


  var msgList = <PatinetChatModel>[].obs;

  var doctorMsgList = <DoctorChatModel>[].obs;


  SharedPreferenceProvider sp= SharedPreferenceProvider();
  CustomView custom = CustomView();

/*-------------Patient Send MSG--------------*/
  Future sendingMsgApi(BuildContext context, String receiverId,
      String statusUpload, String message,String type, VoidCallback callback) async {
    loadingset.value = true;
    final Map<String, dynamic> psentmsg = {
      "sender_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "reciver_id": receiverId,
      "status_upload": statusUpload,
      "message": message,
      "type":type
    };
    print("Patient Send Msg Parameter$psentmsg");
    final response = await apiService.postData(MyAPI.pSendMsg, psentmsg);
    try {
      log("response of Patient Send Msg :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      if (result == "success") {
        loadingset.value = false;
        print("my patient send msg$result");
        print(result.toString());
        callback();
      } else {
        custom.massenger(context, "no sending msg");
      }
    } catch (e) {
      loadingset.value = false;
      log("exception$e");
    }
  }

/*-------------Doctor Send MSG--------------*/
  Future doctorSendingMsgApi(BuildContext context, String receiverId,
      String statusUpload, String message,String type ,VoidCallback callback) async {
    loadingset.value = true;
    final Map<String, dynamic> psentmsg = {
      "sender_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "reciver_id": receiverId,
      "status_upload": statusUpload,
      "message": message,
      "type":type,
    };
    print("Patient Send Msg Parameter$psentmsg");
    final response = await apiService.postData(MyAPI.pSendMsg, psentmsg);
    try {
      log("response of Patient Send Msg :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      if (result == "success") {
        loadingset.value = false;
        print("my patient send msg$result");
        print(result.toString());
        callback();
      } else {
        custom.massenger(context, "no sending msg");
      }
    } catch (e) {
      loadingset.value = false;
      log("exception$e");
    }
  }


/*-------------Patient Fetch  received MSG list on view --------------*/
  Future<void> receivedMsgListFetch(BuildContext context,String receiverId) async {
    final Map<String, dynamic> parameter = {
      "sender_id":await sp.getStringValue(sp.PATIENT_ID_KEY),
      "receiver_id":receiverId,
      "type":"User",
    };
    bool connection = await  checkInternetConnection();
    if(connection){
      print("my parameter$parameter");
      try {
        print("my parameter$parameter");

        loadingFetch.value = true;
        final response = await apiService.postData(MyAPI.pChatViewListFetch,parameter);
        print("Chat view list=============${response.body}");

        if (response.statusCode == 200) {
          loadingFetch.value = false;
          var jsonString = response.body;
          print(jsonString);
receivedMsgList.value = pChatingViewListModelFromJson(response.body);
          print(receivedMsgList);
        } else {
          loadingFetch.value = false;
          print("error");
        }
      }catch (e) {
        loadingFetch.value = false;
        print("exception$e");
      }
    }else{
      loadingFetch.value = false;
      AwesomeDialog(
        context: context,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.warning,
        showCloseIcon: true,
        title: 'NO INTERNET',
        desc: 'Check your internet connection and try again.',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
      log("no internet");
    }

  }

/*-------------Doctor Fetch  received MSG list on view --------------*/
  Future<void> doctorReceivedMsgListFetch(BuildContext context,String receiverId) async {
    final Map<String, dynamic> Peramert = {
      "sender_id":await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "receiver_id":receiverId,
      "type":"Doctor",
      // "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
    };
    bool connection = await  checkInternetConnection();
    if(connection){
      print("my peramiter$Peramert");
      try {
        print("my peramiter$Peramert");

        loadingFetch.value = true;
        final response = await apiService.postData(MyAPI.doctorChatViewListFetch,Peramert);
        print("Doctor Chat view list=============${response.body}");

        if (response.statusCode == 200) {
          loadingFetch.value = false;
          drReceivedMsgList.value = doctorViewMsgListFromJson(response.body);
          print(drReceivedMsgList);
        } else {
          loadingFetch.value = false;
          print("error");
        }
      }catch (e) {
        loadingFetch.value = false;
        print("exception$e");
      }
    }else{
      loadingFetch.value = false;
      AwesomeDialog(
        context: context,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.warning,
        showCloseIcon: true,
        title: 'NO INTERNET',
        desc: 'Check your internet connection and try again.',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
      print("no internet");
    }

  }





/*-------------Patient Fetch  MSG list on view --------------*/
  Future<void> msgListFetch(BuildContext context) async {
    loadingFetchList.value = true;
    final Map<String, dynamic> Peramert = {
        "user_id":await sp.getStringValue(sp.PATIENT_ID_KEY),
    };
    bool connection = await  checkInternetConnection();
    if(connection){
      log("my parameter$Peramert");
      try {
        log("my parameter$Peramert");

        final response = await apiService.postData(MyAPI.pChatListFetch,Peramert);
        log("Chat list=============${response.body}");

        if (response.statusCode == 200) {
          loadingFetchList.value = false;
          var jsonString = response.body;
          log(jsonString);
          List<PatinetChatModel> list = jsonDecode(response.body)
              .map((item) => PatinetChatModel.fromJson(item))
              .toList()
              .cast<PatinetChatModel>();
          msgList.clear();
          msgList.addAll(list);
          print(list);
          print(msgList);
        } else {
          loadingFetchList.value = false;
          log("error");
        }
      }catch (e) {
        loadingFetchList.value = false;
        log("exception$e");
      }
    }else{
      loadingFetchList.value = false;
      AwesomeDialog(
        context: context,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.warning,
        showCloseIcon: true,
        title: 'NO INTERNET',
        desc: 'Check your internet connection and try again.',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
      log("no internet");
    }

  }
/*-------------Patient Doctor Delete in chat contact list --------------*/
Future<void>msgListDelete(BuildContext context,String doctorId,VoidCallback callback)async{
  loadingListDelete.value = true;
  final Map<String,dynamic> perameter = {
    "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
    "doctor_id":doctorId,
  };
  print("Patient chat list delete Parameter$perameter");
final response = await apiService.postData(MyAPI.pChatListDelete, perameter);
try{
  log("response of chat list Delete Api${response.body}");
  var jsonResponse = jsonDecode(response.body);
  var result = jsonResponse["result"];
  log(result);
  if(result == "delete success"){
    callback();
    loadingListDelete.value = false;
    print("my chat list delete$result");
    print(result.toString());
  }else{
    custom.massenger(context, "Something went wrong");
  }
}catch(e){
  log("exception$e");
}

}


/*-------------Patient Doctor Delete in chat contact list --------------*/
  Future<void>drUserMsgListDelete(BuildContext context,String userId,VoidCallback callback)async{
    loadingListDelete.value = true;
    final Map<String,dynamic> perameter = {
      "user_id": userId,
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
    };
    print("Doctor side user chat list delete Parameter$perameter");
    final response = await apiService.postData(MyAPI.dChatListDelete, perameter);
    try{
      log("response of chat list Delete Api${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse["result"];
      log(result);
      if(result == "delete success"){
        callback();
        loadingListDelete.value = false;
        print("my chat list delete$result");
        print(result.toString());
      }else{
        custom.massenger(context, "Something went wrong");
      }
    }catch(e){
      log("exception$e");
    }

  }



/*-------------Doctor Fetch  MSG list on view --------------*/
  Future<void> doctorMsgListFetch(BuildContext context) async {
    loadingFetchListD.value = true;
    final Map<String, dynamic> Peramert = {
      "doctor_id":await sp.getStringValue(sp.DOCTOR_ID_KEY),
    };
    bool connection = await  checkInternetConnection();
    if(connection){
      log("my parameter$Peramert");
      try {
        log("my parameter$Peramert");

        final response = await apiService.postData(MyAPI.dChatListFetch,Peramert);
        log("Chat list=============${response.body}");

        if (response.statusCode == 200) {
          loadingFetchListD.value = false;
          var jsonString = response.body;
          print(jsonString);
          List<DoctorChatModel> list = jsonDecode(response.body)
              .map((item) => DoctorChatModel.fromJson(item))
              .toList()
              .cast<DoctorChatModel>();
          doctorMsgList.clear();
          doctorMsgList.addAll(list);
          log("$list");
          log("$doctorMsgList");
        } else {
          loadingFetchListD.value = false;
          print("error");
        }
      }catch (e) {
        loadingFetchListD.value = false;
        print("exception$e");
      }
    }else{
      loadingFetchListD.value = false;
      AwesomeDialog(
        context: context,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.warning,
        showCloseIcon: true,
        title: 'NO INTERNET',
        desc: 'Check your internet connection and try again.',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
      print("no internet");
    }

  }


}