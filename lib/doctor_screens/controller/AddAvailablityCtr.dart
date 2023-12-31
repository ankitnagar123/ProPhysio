import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../../../Network/ApiService.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../language_translator/LanguageTranslate.dart';
import 'package:get/get.dart';

import '../../../Network/Apis.dart';
import '../model/DoctorSelectedCenter.dart';
import '../model/DoctorTimeListModel.dart';

class AddAvailabilityCtr extends GetxController {
  ApiService apiService = ApiService();
  LocalString text = LocalString();

  var loading = false.obs;
  var loadingC = false.obs;
  var loadingf = false.obs;
  var loadingd = false.obs;
var loadingCenter = false.obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();
  final doctorTimeList = <DoctorTimeListModel>[].obs;
  final selectedCenterList = <DoctorSelectedCenterModel>[].obs;
   var dateId = "".obs;

/*-------------Doctor Add Date start and End select--------------*/
  Future addAvailability(BuildContext context, String startDate,
      String endDate ,VoidCallback callback) async {
    loading.value = true;
    final Map<String, dynamic> psetpass = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "from_date": startDate,
      "to_date": endDate,
    };
    log(" support parameter Parameter $psetpass");
    final response = await apiService.postData(MyAPI.dAddAvailibitly, psetpass);
    try {
      log("response of Doctor Add Availability :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      if (result == "success") {
        callback();
        loading.value = false;
        dateId.value = jsonResponse["date_id"].toString();
        log("Date id.......$dateId");
        log("my Doctor Add Availability $result");
        custom.massenger(context, text.AddDateSucces.tr);
        /*Time Slot's api call here*/
        doctorFetchTimeList();
        log(result.toString());
      } else {
        loading.value = false;
        custom.massenger(context, result.toString());
      }
    } catch (e) {
      loading.value = false;
      log("exception$e");
    }
  }

/*-------------Doctor Add Date start and End select--------------*/
  Future addCenterAvailability(BuildContext context, String startDate,
      String endDate,String centerId ,VoidCallback callback) async {
    loadingC.value = true;
    final Map<String, dynamic> psetpass = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "from_date": startDate,
      "to_date": endDate,
      "center_id":centerId,
    };
    log(" support parameter Parameter $psetpass");
    final response = await apiService.postData(MyAPI.dAddAvailibitly, psetpass);
    try {
      log("response of Doctor Add Availability  for Center:-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      if (result == "success") {
        loadingC.value = false;
        dateId.value = jsonResponse["date_id"].toString();
        log("Date id.......$dateId");
        log("my Doctor Add Availability for center $result");
        custom.massenger(context,text.AddDateSucces.tr);
        doctorFetchTimeList();
        log(result.toString());
        callback();
      } else {
        loadingC.value = false;
        custom.massenger(context, result.toString());
      }
    } catch (e) {
      loadingC.value = false;
      log("exception$e");
    }
  }



  /*-----------------Doctor Fetch Time list------------------------------*/
  Future<void> doctorFetchTimeList() async {
    loadingf.value = true;
    final Map<String, dynamic> perameter = {
      "doctor_id":  await sp.getStringValue(sp.DOCTOR_ID_KEY),
    };
    try {
      final response = await apiService.postData(MyAPI.dFetchTime, perameter);
      log(" DoctorFetch Time List =============${response.body}");
      if (response.statusCode == 200) {
        loadingf.value = false;
        doctorTimeList.value = doctorTimeListModelFromJson(response.body.toString());
        log(doctorTimeList.toString());
      } else {
        loadingf.value = false;
        log("error");
      }
    } catch (e) {
      loadingf.value = false;
      print("exception$e");
    }
  }


/*-------------Doctor Select Time Slots --------------*/
  void addTime(BuildContext context, String timeid,String dateId,
      VoidCallback callback) async {
    loadingd.value = true;
    final Map<String, dynamic> psetpass = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "time_id": timeid,
      "date_id":dateId,
    };
    print("add Time parameter Parameter$psetpass");
    final response = await apiService.postData(MyAPI.dAddMultipleTime, psetpass);
    try {
      log("response of Doctor add Time:-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loadingd.value = false;
      if (result == "Success") {
        loadingd.value = false;
        log("my Doctor Add  add Time $result");
        // custom.massenger(context, result);
        print(result.toString());
        callback();
      } else {
         custom.massenger(context, text.SomthingWentWrong.tr);
        loadingd.value = false;
        custom.massenger(context, result);
      }
    } catch (e) {
      loadingd.value = false;
      log("exception$e");
    }
  }


  /*-----------------Selected Center List Fetch Time list------------------------------*/
  Future<void> centerSelectedList() async {
    loadingCenter.value = true;
    final Map<String, dynamic> perameter = {
      "doctor_id":  await sp.getStringValue(sp.DOCTOR_ID_KEY),
    };
    try {
      final response = await apiService.postData(MyAPI.dSelectedCenter, perameter);
      log(" DoctorFetch Time List =============${response.body}");
      if (response.statusCode == 200) {
        loadingCenter.value = false;
        selectedCenterList.value = doctorSelectedCenterModelFromJson(response.body.toString());
        log(selectedCenterList.toString());
      } else {
        loadingCenter.value = false;
        log("error");
      }
    } catch (e) {
      loadingCenter.value = false;
      print("exception$e");
    }
  }
}