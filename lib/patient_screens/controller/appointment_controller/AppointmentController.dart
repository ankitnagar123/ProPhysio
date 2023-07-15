import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/language_translator/LanguageTranslate.dart';

import '../../../../../Network/ApiService.dart';
import '../../../../../Network/Apis.dart';
import '../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../doctor_screens/model/DoctorbookedSlotListModel.dart';
import '../../model/CalenderDateShowModel.dart';
import '../../model/DoctorPatinetTimeModel.dart';
import '../../model/VisitChargeModel.dart';

class AppointmentController extends GetxController {
LocalString text = LocalString();
  ApiService apiService = ApiService();
  var loadingFetch = false.obs;
  var loadingFetchTime = false.obs;
  var loadingFetchTimeBooked = false.obs;

  var loadingFetchDate = false.obs;

  var loadingAdd = false.obs;

  var visitCharge = <VisitChargeModel>[].obs;
  var timeList = <DoctorTimeListModelpatinet>[].obs;
  var dateList = <CalenderDateShowModel>[].obs;
  var bookedTimeSlot = <DoctorbookedSlotList>[].obs;
  var seletedtime = "".obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();

  /*------------------Doctor date show on calender  list Fetch Api----------------*/
  Future<void> dateCalender(String id,String centerId) async {
    loadingFetchDate.value = true;
    final Map<String, dynamic> paremert = {
      "doctor_id": id,
      "center_id":centerId,
    };
    try {
      final response = await apiService.postData(MyAPI.pCalenderDate, paremert);
      log("calendar list of date's.....${response.body}");
      if (response.statusCode == 200) {
        loadingFetchDate.value = false;
        dateList.value = calenderDateShowModelFromJson(response.body);
        log("date list$dateList");
      } else {
        loadingFetchDate.value = false;
        log("backend error");
      }
    } catch (e) {
      loadingFetchDate.value = false;
      log("exception$e");
    }
  }


  /*------------------For Doctor view date show on calender  list Fetch Api----------------*/
  Future<void> doctorViewDateCalender(String centerId) async {
    loadingFetchDate.value = true;
    final Map<String, dynamic> paremert = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "center_id":centerId,
    };
    try {
      log("calendar list of date's parameter.....$paremert");
      final response = await apiService.postData(MyAPI.pCalenderDate, paremert);
      log("calendar list of date's.....${response.body}");

      if (response.statusCode == 200) {
        loadingFetchDate.value = false;
        dateList.value = calenderDateShowModelFromJson(response.body);
      } else {
        loadingFetchDate.value = false;
        log("backend error");
      }
    } catch (e) {
      loadingFetchDate.value = false;
      log("exception$e");
    }
  }

  /*------------------Doctor visit charge list Fetch Api----------------*/
  Future<void> doctorVisitChargefetch(String id) async {
    final Map<String, dynamic> Peramert = {"doctor_id": id};
    try {
      loadingFetch.value = true;
      final response =
          await apiService.postData(MyAPI.pDoctorVisitCharge, Peramert);
      print("doctor visit charge list=============${response.body}");
      if (response.statusCode == 200) {
        loadingFetch.value = false;
        visitCharge.value = visitChargeModelFromJson(response.body);
        print(visitCharge.toString());
      } else {
        loadingFetch.value = false;
        print("error");
      }
    } catch (e) {
      loadingFetch.value = false;
      print("exception$e");
    }
  }

  /*------------------Doctor time slots list Fetch Api----------------*/
  Future<void> doctorTimeSlotsFetch(String id, String date,centerId) async {
    loadingFetchTime.value = true;
    final Map<String, dynamic> Peramert = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "doctor_id": id,
      "date": date,
      "center_id":centerId,
    };
    try {
      final response =
          await apiService.postData(MyAPI.pDoctorTimeSlot, Peramert);
      print(Peramert);
      print("doctor time list=============${response.body}");
      if (response.statusCode == 200) {
        loadingFetchTime.value = false;
        List<DoctorTimeListModelpatinet> list = jsonDecode(response.body)
            .map((item) => DoctorTimeListModelpatinet.fromJson(item))
            .toList()
            .cast<DoctorTimeListModelpatinet>();
        timeList.clear();
        timeList.addAll(list);
        print(timeList.toString());
      } else {
        loadingFetchTime.value = false;
        print("error");
      }
    } catch (e) {
      loadingFetchTime.value = false;
      print("exception$e");
    }
  }


  /*------------------Center Doctor view  time slots list Fetch Api----------------*/
  Future<void> doctorViewTimeSlotsFetch(String date,centerId) async {
    loadingFetchTime.value = true;
    final Map<String, dynamic> Peramert = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "date": date,
      "center_id":centerId,
    };
    try {
      final response =
      await apiService.postData(MyAPI.pDoctorTimeSlot, Peramert);
      print(Peramert);
      print("doctor time list=============${response.body}");
      if (response.statusCode == 200) {
        loadingFetchTime.value = false;
        List<DoctorTimeListModelpatinet> list = jsonDecode(response.body)
            .map((item) => DoctorTimeListModelpatinet.fromJson(item))
            .toList()
            .cast<DoctorTimeListModelpatinet>();
        timeList.clear();
        timeList.addAll(list);
        print(timeList.toString());
      } else {
        loadingFetchTime.value = false;
        print("error");
      }
    } catch (e) {
      loadingFetchTime.value = false;
      print("exception$e");
    }
  }

  /*------------------Center Doctor Booked time slots list Fetch Api----------------*/
  Future<void> doctorBookedTimeSlotsFetch(String date,centerId) async {
    loadingFetchTimeBooked.value = true;
    final Map<String, dynamic> Peramert = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "date": date,
      "center_id":centerId,
    };
    try {
      final response =
      await apiService.postData(MyAPI.pDoctorBookedTimeSlot  , Peramert);
      print(Peramert);
      print("doctor booked time list*******====${response.body}");
      if (response.statusCode == 200) {
        loadingFetchTimeBooked.value = false;
         bookedTimeSlot.value =doctorbookedSlotListFromJson(response.body);
      } else {
        loadingFetchTimeBooked.value = false;
        print("error");
      }
    } catch (e) {
      loadingFetchTimeBooked.value = false;
      print("exception$e");
    }
  }

  /*-------------Appointment booking  API--------------*/
  Future bookingAppointment(BuildContext context, String reciver, String cardId,
      String time, String price, String date,String centerId, VoidCallback callback) async {
    loadingAdd.value = true;
    final Map<String, dynamic> Peramert = {
      "sender_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "reciver_id": reciver,
      "card_id": cardId,
      "time_id": time,
      "price": price,
      "date": date,
      "center_id":centerId,
    };
    print("card Parameter$Peramert");
    final response =
        await apiService.postData(MyAPI.pBookingAppointment, Peramert);
    try {
      log("response of Booking Appointment  :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      if (result == "success") {
        loadingAdd.value = false;
        print("my Appointment $result");
        custom.massenger(context, text.appointmentCorrectlySaved.tr);
        print(result.toString());
        callback();
      } else {
        loadingAdd.value = false;
        custom.massenger(context, result.toString());
      }
    } catch (e) {
      loadingAdd.value = false;
      log("exception$e");
    }
  }
}
