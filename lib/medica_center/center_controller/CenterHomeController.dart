import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../../Network/ApiService.dart';
import '../../../../../Network/Apis.dart';
import '../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../network/Internet_connectivity_checker/InternetConnectivity.dart';
import '../center_models/CenterAllDrModel.dart';
import '../center_models/CenterSelectedDrModel.dart';


class CenterHomeCtr extends GetxController {
  ApiService apiService = ApiService();
  var loadingFetch = false.obs;
  var loadingAdd = false.obs;




  var doctorList = <CenterDoctorListModel>[].obs;

  var selectedDoctorList = <Map<String,dynamic>>[].obs;


 var medicalCenterName = "".obs;

  static int lengthTry = -1;

  Rx<List> selectedOptionList = Rx<List>([]);
  var selectedOption = ''.obs;

  var keywords = ''.obs;

  var location = "".obs;


  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


  /*-----------------Doctor list  Fetch Api----------------*/
  Future<void> centerDoctorListFetch(BuildContext context) async {
    bool connection = await  checkInternetConnection();
    if(connection){
      try {
        loadingFetch.value = true;
        final response = await apiService.getData(MyAPI.cAllDoctorList);
        print("doctor list=====${response.body}");
        if (response.statusCode == 200) {
          loadingFetch.value = false;
          var jsonString = response.body;
          print(jsonString);
          List<CenterDoctorListModel> listdoctor = jsonDecode(response.body)
              .map((item) => CenterDoctorListModel.fromJson(item))
              .toList()
              .cast<CenterDoctorListModel>();
          doctorList.clear();
          doctorList.addAll(listdoctor);
          print(doctorList);
          print(listdoctor);
        }
        else {
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

  /*----------Update Device  API-----------*/
  void addDoctors(
      BuildContext context,
      String wardName,
      String drList,
      ) async {
    final Map<String, dynamic>Perameter = {
      "name":wardName,
      "doctor_id":drList,
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
    };
    loadingAdd.value = true;
    log(" add Doctor Parameter$Perameter");

    final response = await apiService.postData(MyAPI.cAddDoctor,Perameter);
    try {

      log("response of add dr :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        loadingAdd.value = false;
        custom.massenger(context, "Doctor Add Succesfully");
      } else {
        custom.massenger(context, "somthing ");
        loadingAdd.value = false;
        print("error");
      }
    } catch (e) {
      loadingAdd.value = false;
      log("exception$e");
    }
  }

  /*----------------- Selected Doctor list  Fetch Api----------------*/
  Future<void> centerSelectedDrList(BuildContext context,) async {
    final Map<String, dynamic>Perameter = {
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
    };
    bool connection = await  checkInternetConnection();
    if(connection){
      try {
        loadingFetch.value = true;
        final response = await apiService.postData(MyAPI.cSelectedDoctor,Perameter);
        print("doctor list=====${response.body}");
        if (response.statusCode == 200) {
          loadingFetch.value = false;
          var jsonResponse = jsonDecode(response.body);

   medicalCenterName.value = jsonResponse["medical_center_name"];
   selectedDoctorList.value = List<Map<String,dynamic>>.from(jsonResponse["doctor_list"]);
        }
        else {
          loadingFetch.value = false;
          print("error");
        }
      }catch (e) {
        loadingFetch.value = false;
        print("exception$e");
      }
    }else{
      loadingFetch.value = false;
      print("no internet");
    }

  }

}
