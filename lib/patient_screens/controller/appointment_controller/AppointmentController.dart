import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../../../../Network/ApiService.dart';
import '../../../../../Network/Apis.dart';
import '../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../doctor_screens/model/DoctorbookedSlotListModel.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../language_translator/LanguageTranslate.dart';
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
var loadingFetchDateDr = false.obs;


var loadingAdd = false.obs;

  var visitCharge = <VisitChargeModel>[].obs;
  var timeList = <DoctorTimeSlotModel>[].obs;
  var dateList = <CalenderDateShowModel>[].obs;
  var bookedTimeSlot = <DoctorbookedSlotList>[].obs;
  var seletedtime = "".obs;
var bookingId = "".obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();

  /*------------------Doctor date show on calender  list Fetch Api----------------*/
  Future<void> dateCalender(String id,String branchId) async {
    loadingFetchDate.value = true;
    final Map<String, dynamic> paremert = {
      "doctor_id": id,
      "branch_id":branchId,
    };
    log("dateCalender${paremert}");
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
  Future<void> doctorViewDateCalender(String branchId) async {
    loadingFetchDateDr.value = true;
    final Map<String, dynamic> paremert = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "branch_id":branchId,
    };
    try {
      log("calendar list of date's parameter.....$paremert");
      final response = await apiService.postData(MyAPI.pCalenderDate, paremert);
      log("calendar list of date's.....${response.body}");

      if (response.statusCode == 200) {
        loadingFetchDateDr.value = false;
        dateList.value = calenderDateShowModelFromJson(response.body);
      } else {
        loadingFetchDateDr.value = false;
        log("backend error");
      }
    } catch (e) {
      loadingFetchDateDr.value = false;
      log("exception$e");
    }
  }

  /*------------------Doctor visit charge list Fetch Api----------------*/
  Future<void> doctorVisitChargeFetch(String catId,String branchId) async {
    final Map<String, dynamic> Peramert = {
      "cat_id": catId,
      "branch_id": branchId,
    };
    log("Peramert$Peramert");
    try {
      loadingFetch.value = true;
      final response =
          await apiService.postData(MyAPI.pDoctorVisitCharge, Peramert);
      log("doctor visit charge list-----${response.body}");
      if (response.statusCode == 200) {
        loadingFetch.value = false;
        visitCharge.value = visitChargeModelFromJson(response.body);
        log(visitCharge.toString());
      } else {
        loadingFetch.value = false;
        log("error");
      }
    } catch (e) {
      loadingFetch.value = false;
      log("exception$e");
    }
  }

  /*------------------Doctor time slots list Fetch Api----------------*/
  Future<void> doctorTimeSlotsFetch(String id, String date,) async {
    loadingFetchTime.value = true;
    final Map<String, dynamic> Peramert = {
      // "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "doctor_id": id,
      "date": date,
      // "center_id":centerId,
    };
    log("parameter------$Peramert");
    try {
      final response =
          await apiService.postData(MyAPI.pDoctorTimeSlot, Peramert);
      log("$Peramert");
      log("doctor time list=============${response.body}");
      if (response.statusCode == 200) {
        loadingFetchTime.value = false;
        timeList.value = doctorTimeSlotModelFromJson(response.body);
      } else {
        loadingFetchTime.value = false;
        log("error");
      }
    } catch (e) {
      loadingFetchTime.value = false;
      log("exception$e");
    }
  }


  /*------------------Center Doctor view  time slots list Fetch Api----------------*/
  Future<void> doctorViewTimeSlotsFetch(String date,) async {
    loadingFetchTime.value = true;
    final Map<String, dynamic> Peramert = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "date": date,
    };
    try {
      final response =
      await apiService.postData(MyAPI.pDoctorTimeSlot, Peramert);
      print(Peramert);
      print("doctor time list=============${response.body}");
      if (response.statusCode == 200) {
        loadingFetchTime.value = false;
       timeList.value = doctorTimeSlotModelFromJson(response.body);
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
  Future<void> doctorBookedTimeSlotsFetch(String date,) async {
    loadingFetchTimeBooked.value = true;
    final Map<String, dynamic> Peramert = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "date": date,
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

/*-------------Appointment booking  Payment API--------------*/
Future paymentAppointment(BuildContext context, String bookingId,String recivedId,VoidCallback callback) async {
  loadingAdd.value = true;
  final Map<String, dynamic> Peramert = {
    "sender_id":await sp.getStringValue(sp.PATIENT_ID_KEY),
    "reciver_id":recivedId,
    "booking_id": bookingId,
  };
  print(" Parameter----------------$Peramert");
  final response = await http.post(
      Uri.parse(
        "https://sicparvismagna.it/Medica/Apis/test_payment.php",
      ),
      body: Peramert);
  try {
    log("response of Booking Payment Appointment  :-${response.body}");
    var jsonResponse = jsonDecode(response.body);
    var result = jsonResponse['result'].toString();
    if (result == "Payment Successfully") {
      loadingAdd.value = false;
      print("my  payment Appointment $result");
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


  /*-------------Appointment booking  API--------------*/
  Future bookingAppointment(BuildContext context, String reciver, String cardId,
      String time, String price, String date,String centerId,String type ,VoidCallback callback) async {
    loadingAdd.value = true;
    final Map<String, dynamic> Peramert = {
      "sender_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "reciver_id": reciver,
      "card_id": cardId,
      "time_id": time,
      "price": price,
      "date": date,
      "center_id":centerId,
      "type":type,
    };
    print("appointment Parameter$Peramert");
    final response =
        await apiService.postData(MyAPI.pBookingAppointment, Peramert);
    try {
      log("response of Booking Appointment  :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      if (result == "success") {
        callback();
        loadingAdd.value = false;
        String id = jsonResponse["bookID"].toString();
        // String reciverid = jsonResponse["reciver_id"].toString();
        log("id----------------->:$id");
        log("my Appointment $result");
   /*     if(type == "Paid"){
          paymentAppointment(context,id,reciver,() {
            callback();
          });
        }else{
          callback();
        }*/
        custom.massenger(context, text.appointmentPayment.tr);
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
