import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import '../../../Network/ApiService.dart';
import '../../../Network/Apis.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../../patient_screens/model/MedicinsListModel.dart';
import '../../../patient_screens/model/PatinetPrescriptionModel.dart';
import '../../model/DPrescriptionModel.dart';
import '../../model/MedicineModel/AddFetchMedicneList.dart';
import '../../model/MedicineModel/MedicineAllListModel.dart';
import '../../model/QrPresciptionList.dart';

class DoctorPrescriptionCtr extends GetxController {
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  LocalString text = LocalString();
  ApiService apiService = ApiService();
  CustomView customView = CustomView();

  var loadingAdd = false.obs;

  var loadingAddP = false.obs;

  var loadingFetch = false.obs;
  var loadingPFetch = false.obs;

  var downloadingList = false.obs;

/*---------for doctor*---------*/
  var prescriptionList = Rxn<DPrescriptionListModel>();


  // Function to handle download for a specific item using its index
  void downLoadFileRepost(BuildContext context,String fileurl, String patientName,) async {
    downloadingList = true.obs;
    update(); // Notify GetX that the downloading list has changed
    try {
      await FileDownloader.downloadFile(
        url: fileurl,
        name: "$patientName Prescription Report.pdf",
        onProgress: (String? fileName, double? progress) {
          log('FILE fileName HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) {
          log('FILE DOWNLOADED TO PATH: $path');
          downloadingList = false.obs;
          customView.MySnackBar(context, "$patientName Report Download Successfully");
          update(); // Notify GetX that the downloading list has changed
        },
        onDownloadError: (String error) {
          log('DOWNLOAD ERROR: $error');
          downloadingList = false.obs;
          customView.MySnackBar(context, "Something went wrong ");

          update(); // Notify GetX that the downloading list has changed
        },
        notificationType: NotificationType.all,
      );
    } catch (e) {
      log('DOWNLOAD ERROR: $e');
      downloadingList = false.obs;
      update(); // Notify GetX that the downloading list has changed
    }
  }



  /*------for patient---------*/
  var patientPrescriptionList = <PatinetPrescriptionModel>[].obs;


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
        customView.MySnackBar(context, text.success.tr);
        loadingAdd.value = false;
        log("result........$result");
      } else {
        customView.MySnackBar(context, text.SomthingWentWrong.tr);
        loadingAdd.value = false;
        print("Backend Error");
      }
    } catch (e) {
      customView.MySnackBar(context, text.SomthingWentWrong.tr);
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
        customView.MySnackBar(context, text.success.tr);
        loadingAddP.value = false;
        log("result........$result");
      } else {
        customView.MySnackBar(context, text.SomthingWentWrong.tr);
        loadingAddP.value = false;
        print("Backend Error");
      }
    } catch (e) {
      customView.MySnackBar(context, text.SomthingWentWrong.tr);
      loadingAddP.value = false;
      log("Exception$e");
    }
  }

  /*---------for doctor*---------*/
  Future<void> fetchPrescription(String patientId, String type) async {
    loadingFetch.value = true;
    Map<String, dynamic> data = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "patient_id": patientId,
      "type": type,
    };
    log("parameter $data");

    final response = await apiService.postData(MyAPI.fetchPrescription, data);
    log("response fetch prescription ${response.body}");
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
      loadingFetch.value = false;
      log('Kuch to dikkat hai?$e');
    }
  }


  /*---------for patient*---------*/
  Future<void> fetchPatientPrescription(String type) async {
    loadingPFetch.value = true;
    Map<String, dynamic> data = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
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


}
