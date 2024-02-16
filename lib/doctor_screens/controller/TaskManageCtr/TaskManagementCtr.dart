import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Network/ApiService.dart';
import '../../../../../Network/Apis.dart';
import '../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../helper/CustomView/CustomView.dart';

import '../../../language_translator/LanguageTranslate.dart';
import '../../model/TaskCancelListModel.dart';
import '../../model/TaskManageModel.dart';

class TaskManageCtr extends GetxController {
  ApiService apiService = ApiService();
  var loadingstatusAccept = false.obs;
  var loadingstatusReject = false.obs;
  var loadingTaskList = false.obs;
  var loadingTaskCancel = false.obs;
  LocalString text = LocalString();

  var taskList = <TaskManageListModel>[].obs;
  var taskCancelList = <TaskCancelListModel>[].obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


  /*------------------Task Manage Type Fetch list  Fetch Api----------------*/
  Future<void> taskManageList(BuildContext context,
      String status,) async {
    Map<String,dynamic> parameter = {
      "doctor_id":await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "branch_id":await sp.getStringValue(sp.DOCTOR_BRANCH_ID_KEY),
      "status":status,
    };
    log("parameter$parameter");
    try {
      loadingTaskList.value = true;
      final response = await apiService.postData(MyAPI.dTaskManageList,parameter);
      log("Task Manage List=============${response.body}");
      if (response.statusCode == 200) {
        loadingTaskList.value = false;
        taskList.value = taskManageListModelFromJson(response.body);
      } else {
        loadingTaskList.value = false;
        log("error");
      }
    }catch (e) {
      loadingTaskList.value = false;
      log("exception$e");
    }
  }



  Future<void> taskCancelListApi(BuildContext context,
      ) async {

    try {
      loadingTaskCancel.value = true;
      final response = await apiService.getData(MyAPI.dTaskManageCancel,);
      log("Task Cancel=============${response.body}");
      if (response.statusCode == 200) {
        loadingTaskCancel.value = false;
        taskCancelList.value = taskCancelListModelFromJson(response.body);
      } else {
        loadingTaskCancel.value = false;
        log("error");
      }
    }catch (e) {
      loadingTaskList.value = false;
      log("exception$e");
    }
  }

  /*----------booking Appointment Accept API-----------*/
  void taskStatusChange(
      BuildContext context,
      String taskId,
      String status,
      String cancelReason,
      VoidCallback callback,
      ) async {
    if(status =="Confirmed"){
      loadingstatusAccept.value = true;
    }else{
      loadingstatusReject.value = true;

    }
    final Map<String, dynamic> Perameter = {
      "task_id":taskId,
      "status":status,
      "cancel_reason":cancelReason
    };
    print("task Status Change Parameter$Perameter");
    final response =
    await apiService.postData(MyAPI.dTaskStatusChange, Perameter);
    try {
      log("task Status Change :-${response.body}");
      log("my id $Perameter");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['msg'].toString();
      if (response.statusCode == 200) {
        callback();
        // taskManageList(context, status);
        loadingstatusAccept.value = false;

        loadingstatusReject.value = false;
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
      } else {
        loadingstatusReject.value = false;
        loadingstatusAccept.value = false;

        custom.massenger(context, text.Invalid.tr);
      }
    } catch (e) {
      loadingstatusReject.value = false;
      loadingstatusAccept.value = false;
      log("exception$e");
    }
  }
}
