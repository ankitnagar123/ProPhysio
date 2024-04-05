import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Network/ApiService.dart';
import '../../../../../Network/Apis.dart';
import '../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../helper/CustomView/CustomView.dart';

import '../../../language_translator/LanguageTranslate.dart';
import '../../model/ComplaintListModel.dart';
import '../../model/LeadSheetListModel.dart';


class LeadSheetCtr extends GetxController {
  ApiService apiService = ApiService();
  var loadingstatusAccept = false.obs;
  var loadingstatusReject = false.obs;


  var loadingleadList = false.obs;
  var loadingcomplaintList = false.obs;
  LocalString text = LocalString();

  var leadList = <LeadSheetModel>[].obs;
  var complaintList = <ComplaintsModel>[].obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


  /*------------------Lead Manage Type Fetch list  Fetch Api----------------*/
  Future<void> leadManageList(BuildContext context,
      String status,) async {
    Map<String,dynamic> parameter = {
      "doctor_id":await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "branch_id":await sp.getStringValue(sp.DOCTOR_BRANCH_ID_KEY),
      "status":status,
    };
    log("leadManageList parameter$parameter");
    try {
      loadingleadList.value = true;
      final response = await apiService.postData(MyAPI.fetchLeadsheetData,parameter);
      log("leadManageList=============${response.body}");
      if (response.statusCode == 200) {
        loadingleadList.value = false;
        leadList.value = leadSheetModelFromJson(response.body);
      } else {
        loadingleadList.value = false;
        log("error");
      }
    }catch (e) {
      loadingleadList.value = false;
      log("exception$e");
    }
  }


  /*----------lead Status Change API-----------*/
  void leadStatusChange(
      BuildContext context,
      String taskId,
      String status,
      VoidCallback callback,
      ) async {
    if(status =="Confirmed"){
      loadingstatusAccept.value = true;
    }else{
      loadingstatusReject.value = true;

    }
    final Map<String, dynamic> Perameter = {
      "lead_id":taskId,
      "status":status,
    };
    print("leadStatusChange Parameter$Perameter");
    final response =
    await apiService.postData(MyAPI.updateLeadsheetData, Perameter);
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





  /*--------------------------------------------------------------------------------*/





  /*------------------Lead Manage Type Fetch list  Fetch Api----------------*/
  Future<void> complaintManageList(BuildContext context,
      String status,) async {
    Map<String,dynamic> parameter = {
      "doctor_id":await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "branch_id":await sp.getStringValue(sp.DOCTOR_BRANCH_ID_KEY),
      "status":status,
    };
    log("complaintManageList parameter$parameter");
    try {
      loadingcomplaintList.value = true;
      final response = await apiService.postData(MyAPI.fetchComplaintsData,parameter);
      log("complaintManageList=============${response.body}");
      if (response.statusCode == 200) {
        loadingcomplaintList.value = false;
        complaintList.value = complaintsModelFromJson(response.body);
      } else {
        loadingcomplaintList.value = false;
        log("error");
      }
    }catch (e) {
      loadingcomplaintList.value = false;
      log("exception$e");
    }
  }


  /*----------lead Status Change API-----------*/
  void complaintStatusChange(
      BuildContext context,
      String supportId,
      String status,
      VoidCallback callback,
      ) async {
    if(status =="Confirmed"){
      loadingstatusAccept.value = true;
    }else{
      loadingstatusReject.value = true;

    }
    final Map<String, dynamic> Perameter = {
      "support_id":supportId,
      "status":status,
    };
    print("complaintStatusChange Parameter$Perameter");
    final response =
    await apiService.postData(MyAPI.updateComplaints, Perameter);
    try {
      log("complaintStatusChange Status Change :-${response.body}");
      log("my id $Perameter");
      var jsonResponse = jsonDecode(response.body);
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
