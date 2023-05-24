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
import '../center_models/CencelModels/WardDeleteReasonModel.dart';
import '../center_models/CencelModels/WardRemoveDoctorReason.dart';
import '../center_models/CenterAllDrModel.dart';
import '../center_models/CenterSelectedDrModel.dart';


class CenterHomeCtr extends GetxController {
  ApiService apiService = ApiService();
  var loadingFetch = false.obs;
  var loadingAdd = false.obs;
  var loadingFetchS = false.obs;
  var loadingFetchW = false.obs;

  var loadingCancelW = false.obs;
  var loadingCancelD = false.obs;
  var loadingEdit = false.obs;
  var loadingDelete = false.obs;

  var loadingMoreAdd = false.obs;



  var doctorList = <CenterDoctorListModel>[].obs;

  var selectedWardList = <CenterSelectedDWardModel>[].obs;

  var selectedDoctorList = <CenterSelectedDListModel>[].obs;

  var wardRemoveReason = <WardDeleteReasonModel>[].obs;
  var doctorRemoveReason = <WardRemoveDoctorReason>[].obs;

  static int lengthTry = -1;

  Rx<List> selectedOptionList = Rx<List>([]);
  var selectedOption = ''.obs;

  var keywords = ''.obs;

  var location = "".obs;


  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


  /*-----------------Doctor All list  Fetch Api----------------*/
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

  /*----------Add Doctor from all dr list API-----------*/
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
    loadingFetchW.value = true;
    final Map<String, dynamic>Perameter = {
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
    };
    bool connection = await  checkInternetConnection();
    if(connection){
      try {
        final response = await apiService.postData(MyAPI.cSelectedDoctorWard,Perameter);
        print("doctor list=====${response.body}");
        if (response.statusCode == 200) {
          loadingFetchW.value = false;
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



  /*----------------- Selected Doctor Ward  list for user side  Fetch Api----------------*/
  Future<void> centerWardListPatient(BuildContext context,String id ) async {
    loadingFetchW.value = true;
    final Map<String, dynamic>Perameter = {
      "center_id": id,
    };
    bool connection = await  checkInternetConnection();
    if(connection){
      try {
        final response = await apiService.postData(MyAPI.cSelectedDoctorWard,Perameter);
        print("doctor list=====${response.body}");
        if (response.statusCode == 200) {
          loadingFetchW.value = false;
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


  /*----------------- Selected Doctor Ward Remove Cancel Reason list  Api----------------*/
  Future<void> wardDrRemoveReason(BuildContext context,) async {
    loadingCancelD.value = true;
      try {
        final response = await apiService.getData(MyAPI.cDoctorRemoveReason);
        print("Cancel reason remove doctor list=====${response.body}");
        if (response.statusCode == 200) {
          loadingCancelD.value = false;
          doctorRemoveReason.value = wardRemoveDoctorReasonFromJson(response.body.toString());
          log(doctorRemoveReason.toString());
        }
        else {
          loadingCancelD.value = false;
          print("error");
        }
      }catch (e) {
        loadingCancelD.value = false;
        print("exception$e");
      }
  }

  /*----------------- Ward Delete Cancel Reason list  Api----------------*/
  Future<void> wardDeleteReason(BuildContext context,) async {
    loadingCancelW.value = true;
    try {
      final response = await apiService.getData(MyAPI.cWardRemoveReason);
      print("doctor list=====${response.body}");
      if (response.statusCode == 200) {
        loadingCancelW.value = false;
        wardRemoveReason.value = wardDeleteReasonModelFromJson(response.body.toString());
        log(wardRemoveReason.toString());
      }
      else {
        loadingCancelW.value = false;
        print("error");
      }
    }catch (e) {
      loadingCancelW.value = false;
      print("exception$e");
    }
  }



  /*----------Edit Ward Doctor  API-----------*/
  void editWard(
      BuildContext context,
      String wardName,
      String drId,
      String cancelId,
      String wardId,
      VoidCallback callback,
      ) async {
    loadingEdit.value = true;
    final Map<String, dynamic>Perameter = {
      "name":wardName,
      "doctor_id":drId,
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
      "cancel_id":cancelId,
      "ward_id":wardId,
    };
    log(" Edit Ward Doctor Parameter$Perameter");

    final response = await apiService.postData(MyAPI.cEditWard,Perameter);
    try {

      log("Edit Ward Doctor :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        callback();
        loadingEdit.value = false;
        custom.massenger(context, "Ward edit successfully");
      } else {
        custom.massenger(context, "something went wrong");
        loadingEdit.value = false;
        print("error");
      }
    } catch (e) {
      loadingEdit.value = false;
      log("exception$e");
    }
  }


  /*----------Edit Ward Doctor  API-----------*/
  void deleteWard(
      BuildContext context,
      String cancelId,
      String wardId,
      VoidCallback callback,
      ) async {
    final Map<String, dynamic>Perameter = {
      "center_id": await sp.getStringValue(sp.CENTER_ID_KEY),
      "cancel_id":cancelId,
      "ward_id":wardId,
    };
    loadingDelete.value = true;
    log("Edit Ward Doctor Parameter$Perameter");

    final response = await apiService.postData(MyAPI.cDeleteWard,Perameter);
    try {

      log("Delete Ward Doctor :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        callback();
        loadingDelete.value = false;
        custom.massenger(context, "Delete ward successfully");
      } else {
        custom.massenger(context, "Something went wrong");
        loadingDelete.value = false;
        print("error");
      }
    } catch (e) {
      loadingDelete.value = false;
      log("exception$e");
    }
  }


  /*----------Add More Dr in Ward Doctor  API-----------*/
  void addMoreDr(
      BuildContext context,
      String drId,
      String wardId,
      VoidCallback callback,
      ) async {
    final Map<String, dynamic>Perameter = {
      "doctor_id":drId,
      "ward_id":wardId,
    };
    loadingMoreAdd.value = true;
    log("Add More Doctor Parameter$Perameter");

    final response = await apiService.postData(MyAPI.cAddMoreDr,Perameter);
    try {

      log("Add More Ward Doctor :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        callback();
        loadingMoreAdd.value = false;
        custom.massenger(context, "Add doctor successfully");
      } else {
        custom.massenger(context, "Something went wrong");
        loadingMoreAdd.value = false;
        print("error");
      }
    } catch (e) {
      loadingMoreAdd.value = false;
      log("exception$e");
    }
  }
}
