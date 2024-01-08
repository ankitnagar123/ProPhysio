import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../../Network/ApiService.dart';
import '../../../../../Network/Apis.dart';
import '../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../network/Internet_connectivity_checker/InternetConnectivity.dart';

import '../../model/LearningMangeTypeModel.dart';
import '../../model/learningManageList.dart';

class LearningManageCtr extends GetxController {
  ApiService apiService = ApiService();
  var loadingLearningType = false.obs;
  var loadingLearningList = false.obs;
  var learningType = <LearningManageTypeModel>[].obs;
  var learningTypeList = <LearningManageListModel>[].obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


  /*------------------learning Manage Type Fetch list  Fetch Api----------------*/
  Future<void> learningManageTypeFetch(BuildContext context,
      ) async {

      try {
        loadingLearningType.value = true;
        final response = await apiService.getData(MyAPI.dLearningManageType,);
        log("Learning Manage Type=============${response.body}");
        if (response.statusCode == 200) {
          loadingLearningType.value = false;
          learningType.value = learningManageTypeModelFromJson(response.body);
        } else {
          loadingLearningType.value = false;
          log("error");
        }
      }catch (e) {
        loadingLearningType.value = false;
        log("exception$e");
      }
    }


  Future<void> learningManageList(BuildContext context,String learningType,
      ) async {
Map<String,dynamic> parameter = {
"branch_id":await sp.getStringValue(sp.DOCTOR_BRANCH_ID_KEY),
  "type":learningType,
};
log("parameter$parameter");
    try {
      loadingLearningList.value = true;
      final response = await apiService.postData(MyAPI.dLearningManageList,parameter);
      log("Learning Manage List=============${response.body}");
      if (response.statusCode == 200) {
        loadingLearningList.value = false;
        learningTypeList.value = learningManageListModelFromJson(response.body);
      } else {
        loadingLearningList.value = false;
        log("error");
      }
    }catch (e) {
      loadingLearningList.value = false;
      log("exception$e");
    }
  }
}
