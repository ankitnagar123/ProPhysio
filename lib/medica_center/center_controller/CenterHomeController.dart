import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:medica/medica_center/center_models/CenterSelectedWardModel.dart';

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
  var loadingFetchS = false.obs;
  var loadingFetchW = false.obs;




  var doctorList = <CenterDoctorListModel>[].obs;

  var selectedWardList = <CenterSelectedDWardModel>[].obs;


  var selectedDoctorList = <CenterSelectedDListModel>[].obs;


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
      VoidCallback callback,
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
        callback();
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


  /*----------------- Selected Doctor Ward Name list  Fetch Api----------------*/
  Future<void> centerSelectedWardList(BuildContext context,) async {
    final Map<String, dynamic>Perameter = {
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
    };
    bool connection = await  checkInternetConnection();
    if(connection){
      try {
        loadingFetchW.value = true;
        final response = await apiService.postData(MyAPI.cSelectedDoctorWard,Perameter);
        print("doctor list=====${response.body}");
        if (response.statusCode == 200) {
          loadingFetchS.value = false;
          selectedWardList.value = centerSelectedDWardModelFromJson(response.body.toString());
          log(selectedWardList.toString());
        }
        else {
          loadingFetchW.value = false;
          print("error");
        }
      }catch (e) {
        loadingFetchW.value = false;
        print("exception$e");
      }
    }else{
      loadingFetchW.value = false;
      print("no internet");
    }

  }


  /*----------------- Selected Doctor list  Fetch Api----------------*/
  Future<void> centerSelectedDrList(BuildContext context,String wardId) async {
    final Map<String, dynamic>Perameter = {
      "ward_id":wardId
    };
    bool connection = await  checkInternetConnection();
    if(connection){
      try {
        loadingFetchS.value = true;
        final response = await apiService.postData(MyAPI.cSelectedDoctor,Perameter);
        print("doctor list=====${response.body}");
        if (response.statusCode == 200) {
          loadingFetchS.value = false;
          selectedDoctorList.value =  centerSelectedDListModelFromJson(response.body);
          log(selectedDoctorList.toString());

        }
        else {
          loadingFetchS.value = false;
          print("error");
        }
      }catch (e) {
        loadingFetchS.value = false;
        print("exception$e");
      }
    }else{
      loadingFetchS.value = false;
      custom.MySnackBar(context, "no internet");
      print("no internet");
    }

  }




}
