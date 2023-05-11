import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medica/Network/ApiService.dart';
import 'package:medica/Network/Apis.dart';
import 'package:medica/doctor_screens/model/DPrescriptionModel.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';

import '../../../patient_screens/model/PatinetPrescriptionModel.dart';

class DoctorPrescriptionCtr extends GetxController {
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  ApiService apiService = ApiService();
  CustomView customView  = CustomView();

  var loadingAdd = false.obs;
  var loadingAddP = false.obs;

  var loadingFetch = false.obs;
  var loadingPFetch = false.obs;

/*---------for doctor*---------*/
  var prescriptionList = <DPrescriptionListModel>[].obs;


  /*------for patient---------*/
  var patientPrescriptionList = <PatinetPrescriptionModel>[].obs;


/*---------for doctor*---------*/
  void addPrescription(BuildContext context,String patientId, String type,
      String title, String description, String img, String imgStr,VoidCallback callback) async {
    loadingAdd.value = true;
    Map<String, dynamic> data = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "user_id": patientId,
      "title": title,
      "type": type,
      "description": description,
      "image": img,
      "img_str": imgStr,
    };
    print("add=Prescription  parameter $data");
    final response = await apiService.postData(MyAPI.dAddPrescription, data);
    try {
      log("My add Prescription api response$response");
      var result = jsonDecode(response.body);
      var myData = result["result"];
      if (myData == "Success") {
        callback();
        customView.MySnackBar(context, myData);
        loadingAdd.value = false;
        log("result........$result");
      } else {
        loadingAdd.value = false;
        print("Backend Error");
      }
    } catch (e) {
      log("Exception$e");
    }
  }


  /*---------for patient*---------*/
  void addPrescriptionPatient(BuildContext context,String type,
      String title, String description, String img, String imgStr,VoidCallback callback) async {
    loadingAddP.value = true;
    Map<String, dynamic> data = {
      // "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "title": title,
      "type": type,
      "description": description,
      "image": img,
      "img_str": imgStr,
    };
    print("add=Prescription  parameter $data");
    final response = await apiService.postData(MyAPI.dAddPrescription, data);
    try {
      log("My add Prescription api response$response");
      var result = jsonDecode(response.body);
      var myData = result["result"];
      if (myData == "Success") {
        callback();
        customView.MySnackBar(context, myData);
        loadingAddP.value = false;
        log("result........$result");
      } else {
        loadingAddP.value = false;
        print("Backend Error");
      }
    } catch (e) {
      log("Exception$e");
    }
  }


  /*---------for doctor*---------*/
  Future<void>fetchPrescription(String patientId,String type)async{
    loadingFetch.value = true;
    Map<String,dynamic> data = {
    "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
    "user_id":patientId,
    "type":type,
    };
    final response = await apiService.postData(MyAPI.fetchPrescription, data);
    log("parameter $response");
    try{
      if(response.statusCode == 200){
        loadingFetch.value = false;

        prescriptionList.value =  dPrescriptionListModelFromJson(response.body);
        log(prescriptionList.toString());
      }else{
        loadingFetch.value = false;
      }
    }catch(e){
      loadingFetch.value = true;
      log('Kuch to dikkat hai?$e');
    }
  }


  /*---------for patient*---------*/
  Future<void>fetchPatientPrescription(String type)async{
    loadingPFetch.value = true;
    Map<String,dynamic> data = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "type":type,
    };
    final response = await apiService.postData(MyAPI.pFetchPrescription, data);
    log("parameter $response");
    try{
      if(response.statusCode == 200){
        loadingPFetch.value = false;
        patientPrescriptionList.value =  patinetPrescriptionModelFromJson(response.body);
        log(patientPrescriptionList.toString());
      }else{
        loadingPFetch.value = false;
      }
    }catch(e){
      loadingPFetch.value = false;
      log('Kuch to dikkat hai?$e');
    }
  }

}
