import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medica/Network/ApiService.dart';
import 'package:medica/Network/Apis.dart';
import 'package:medica/doctor_screens/model/DPrescriptionModel.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';

import '../../../patient_screens/model/MedicinsListModel.dart';
import '../../../patient_screens/model/PatinetPrescriptionModel.dart';
import '../../model/MedicineModel/AddFetchMedicneList.dart';
import '../../model/MedicineModel/MedicineAllListModel.dart';
import '../../model/QrPresciptionList.dart';

class DoctorPrescriptionCtr extends GetxController {
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  ApiService apiService = ApiService();
  CustomView customView = CustomView();

  var loadingAdd = false.obs;
  var loadingAddMedicne = false.obs;

  var loadingAddP = false.obs;

  var loadingFetch = false.obs;
  var loadingPFetch = false.obs;

  var loadingFetchQR = false.obs;

  var loadingMedicine = false.obs;

  var loadingMedicineFetch = false.obs;
  var pLoadingMedicineFetch = false.obs;

/*---------for doctor*---------*/
  var prescriptionList = Rxn<DPrescriptionListModel>();

  /*---------for doctor QR scanning*---------*/
  var prescriptionReportQrList = Rxn<PrescriptionReportQrModel>();

  /*------for patient---------*/
  var patientPrescriptionList = <PatinetPrescriptionModel>[].obs;

  /*For Medicine all List*/
  var allMedicineList = <MedicineAllListModel>[].obs;

  /*For Medicine add wali List*/
  var fetchMedicineList = <AddFetchMedicineListModel>[].obs;

  /*For Patient show Medicine  List*/
  var patientFetchMedicineList = <PatinetMedicineListModel>[].obs;

/*---------for doctor*---------*/
  void addPrescription(
      BuildContext context,
      String patientId,
      String type,
      String title,
      String description,
      String img,
      String imgStr,
      VoidCallback callback) async {
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
      loadingAdd.value = false;
      log("Exception$e");
    }
  }

  /*---------for patient*---------*/
  void addPrescriptionPatient(
      BuildContext context,
      String type,
      String title,
      String description,
      String img,
      String imgStr,
      VoidCallback callback) async {
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
      loadingAddP.value = false;
      log("Exception$e");
    }
  }

  /*---------for doctor*---------*/
  Future<void> fetchPrescription(String patientId, String type) async {
    loadingFetch.value = true;
    Map<String, dynamic> data = {
      "user_id": patientId,
      "type": type,
    };
    final response = await apiService.postData(MyAPI.fetchPrescription, data);
    log("parameter ${response.body}");
    try {
      if (response.statusCode == 200) {
        loadingFetch.value = false;

        prescriptionList.value = dPrescriptionListModelFromJson(response.body);
        log(prescriptionList.toString());
      } else {
        log("error");
        loadingFetch.value = false;
      }
    } catch (e) {
      loadingFetch.value = true;
      log('Kuch to dikkat hai?$e');
    }
  }

  /*---------for doctor qr*---------*/
  Future<void> fetchQrPrescription(String patientId, String type) async {
    loadingFetchQR.value = true;
    Map<String, dynamic> data = {
      "patient_id": patientId,
      "type": type,
    };
    final response = await apiService.postData(MyAPI.fetchQrPrescription, data);
    log("Qr scanner parameter ${response.body}");
    try {
      if (response.statusCode == 200) {
        loadingFetchQR.value = false;
        prescriptionReportQrList.value =
            prescriptionReportQrModelFromJson(response.body);
        log(prescriptionReportQrList.toString());
      } else {
        loadingFetchQR.value = false;
      }
    } catch (e) {
      loadingFetchQR.value = true;
      log('Kuch to dikkat hai?$e');
    }
  }

  /*---------for patient*---------*/
  Future<void> fetchPatientPrescription(String type) async {
    loadingPFetch.value = true;
    Map<String, dynamic> data = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "type": type,
    };
    final response = await apiService.postData(MyAPI.pFetchPrescription, data);
    log("parameter ${response.body}");
    try {
      if (response.statusCode == 200) {
        loadingPFetch.value = false;
        patientPrescriptionList.value =
            patinetPrescriptionModelFromJson(response.body);
        log(patientPrescriptionList.toString());
      } else {
        loadingPFetch.value = false;
      }
    } catch (e) {
      loadingPFetch.value = false;
      log('Kuch to dikkat hai?$e');
    }
  }

  /*---------for Doctor add Medicine List All*---------*/
  Future<void> medicineListAllApi() async {
    loadingMedicine.value = true;

    final response = await apiService.getData(MyAPI.allMedicineList);
    log("parameter medicine all list ${response.body}");
    try {
      if (response.statusCode == 200) {
        loadingMedicine.value = false;
        allMedicineList.value = medicineAllListModelFromJson(response.body);
        log(patientPrescriptionList.toString());
      } else {
        loadingMedicine.value = false;
      }
    } catch (e) {
      loadingMedicine.value = false;
      log('Kuch to dikkat hai?$e');
    }
  }

  /*---------for medicins add*---------*/
/*---------for doctor*---------*/
  void medicinesAdd(
      BuildContext context,
      String patientId,
      String medicineName,
      String medicineId,
      String description,
      String timing,
      String slot,
      VoidCallback callback) async {
    loadingAddMedicne.value = true;
    Map<String, dynamic> data = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "user_id": patientId,
      "medicine_name": medicineName,
      "mad_id": medicineId,
      "description": description,
      "medicine_timing": timing,
      "medicine_slot": slot,
    };
    print("add=Medicines parameter $data");
    final response = await apiService.postData(MyAPI.addMedicineList, data);
    try {
      log("My add Medicines api response$response");
      var result = jsonDecode(response.body);
      var myData = result["result"];
      if (myData == "Success") {
        callback();
        customView.MySnackBar(context, myData);
        loadingAddMedicne.value = false;
        log("result........$result");
      } else {
        loadingAddMedicne.value = false;
        print("Backend Error");
      }
    } catch (e) {
      loadingAddMedicne.value = false;
      log("Exception$e");
    }
  }

  /*---------for Doctor add Medicine add Wali List *---------*/
  Future<void> AddFetchmedicineListAll(String userId) async {
    loadingMedicineFetch.value = true;
    Map<String, dynamic> data = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "user_id": userId,
    };
    final response =
        await apiService.postData(MyAPI.addFetchMedicineList, data);
    log("parameter medicine all list ${response.body}");
    try {
      if (response.statusCode == 200) {
        loadingMedicineFetch.value = false;
        fetchMedicineList.value =
            addFetchMedicineListModelFromJson(response.body);
        log(fetchMedicineList.toString());
      } else {
        loadingMedicineFetch.value = false;
      }
    } catch (e) {
      loadingMedicineFetch.value = false;
      log('Kuch to dikkat hai?$e');
    }
  }


  Future<void> patientFetchmedicineList() async {
    pLoadingMedicineFetch.value = true;
    Map<String, dynamic> data = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
    };
    final response =
    await apiService.postData(MyAPI.addFetchMedicineList, data);
    log("Patient side parameter medicine all list ${response.body}");
    try {
      if (response.statusCode == 200) {
        pLoadingMedicineFetch.value = false;
        patientFetchMedicineList.value =
            patinetMedicineListModelFromJson(response.body);
        log(patientFetchMedicineList.toString());
      } else {
        pLoadingMedicineFetch.value = false;
      }
    } catch (e) {
      pLoadingMedicineFetch.value = false;
      log('Kuch to dikkat hai?$e');
    }
  }
}
