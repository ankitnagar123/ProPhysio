import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../doctor_screens/model/DoctorBookingRatingModel.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../network/ApiService.dart';
import '../../../network/Apis.dart';
import '../../model/PBookingListModel.dart';
import '../../model/PatinetBookingReasonModel.dart';

class PatientBookingController extends GetxController {

  /*----------CUSTOM SERVICES------*/
  CustomView custom = CustomView();
  ApiService apiService = ApiService();
  SharedPreferenceProvider sp = SharedPreferenceProvider();



/*------Model initialize------*/
  var bookingCompleteRate = <DoctorbooingRatingList>[].obs;

  var booking = <PatinetbookingList>[].obs;
  var cancelReason = <PatientBookingCancelModel>[].obs;


  /*-----Loading---------*/
  var loading = false.obs;
  var loadingRate = false.obs;

  var loadingd = false.obs;
  var loadingCancelList = false.obs;
  var loadingCancel = false.obs;

  /*------Get value's---------*/
  var paymentTyp = "".obs;
  var price = "".obs;
  var bookingDate = "".obs;
  var status = "".obs;
  var time = "".obs;
  var patientId = "".obs;
  var location = "".obs;
  var name = "".obs;
  var surname = "".obs;
  var reasonCancel = "".obs;
  var contact = "".obs;
  var drImg = "".obs;

  var bookingId = "".obs;

  var selectedCard = -1.obs;



  /*---------booking Appointment List All--------*/
  Future<void> bookingAppointment(String statusType) async {

    final Map<String, dynamic> perameter = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "status": statusType,
    };
    try {
      loading.value = true;
      final response =
      await apiService.postData(MyAPI.pBookingAppointmentList, perameter);
      print(" user booking  =============${response.body}");
      if (response.statusCode == 200) {
        loading.value = false;
        List<PatinetbookingList> listbooking = jsonDecode(response.body)
            .map((item) => PatinetbookingList.fromJson(item))
            .toList()
            .cast<PatinetbookingList>();
        booking.clear();
        booking.addAll(listbooking);
        print(listbooking);
        print(booking);
      } else {
        loading.value = false;
        print("error");
      }
    } catch (e) {
      loading.value = false;
      print("exception$e");
    }
  }



  /*---------booking Rating Complete  Appointment List --------*/
  Future<void> completeRatingAppoint() async {
    final Map<String, dynamic> perameter = {
       "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
    };
    try {
      loadingRate.value = true;
      final response =
      await apiService.postData(MyAPI.pBookingRatingAppointList, perameter);
      log(" Complete coming do rating this list =============${response.body}");
      if (response.statusCode == 200) {
        loadingRate.value = false;
        bookingCompleteRate.value = doctorbooingRatingListFromJson(response.body);
      } else {
        loadingRate.value = false;
        print("error");
      }
    } catch (e) {
      loadingRate.value = false;
      print("exception$e");
    }
  }

/*----------booking Appointment list details API-----------*/
  void bookingAppointmentDetails(
      BuildContext context,
      String id,
      String statusType,
      VoidCallback callback,
      ) async {
    loadingd.value = true;
    final Map<String, dynamic> Perameter = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "booking_id": id,
      "status": statusType,
    };
    print("Doctor booking Appointment details Parameter$Perameter");

    final response =
    await apiService.postData(MyAPI.pBookingAppointmentDetail, Perameter);
    try {
      log("response of booking Appointment details:-${response.body}");
      if (response.statusCode == 200) {
        callback();
        loadingd.value = false;
        var jsonResponse = jsonDecode(response.body);

        paymentTyp.value = jsonResponse["payment_type"].toString();
        log("doctor_profile${paymentTyp.value}");

        price.value = jsonResponse["price"].toString();
        bookingDate.value = jsonResponse["booking_date"].toString();
        status.value = jsonResponse["status"].toString();
        time.value = jsonResponse["Time"].toString();
        location.value = jsonResponse["location"].toString();
        name.value = jsonResponse["name"].toString();
        surname.value = jsonResponse["surname"].toString();
        reasonCancel.value = jsonResponse["cancel_reason"].toString();

        drImg.value = jsonResponse["doctor_profile"].toString();
        log("doctor_profile${drImg.value}");
        contact.value = jsonResponse["contact"].toString();
        log("contact${contact.value}");



        bookingId.value = jsonResponse["booking_id"];
      } else {
        loadingd.value = false;
        custom.massenger(context, "Invalid");
      }
    } catch (e) {
      loadingd.value = false;
      log("excaption-------$e");
    }
  }

  /*---------booking Appointment Cancel Reason's List--------*/
  Future<void> appointmentCancelReason() async {
    final Map<String, dynamic> Perameter = {
       "language": await sp.getStringValue(sp.LANGUAGE)??"",
    };
    try {
      loadingCancelList.value = true;
      final response =
      await apiService.postData(MyAPI.pBookingAppointmentCancel,Perameter);
      print(" appointment Cancel Reason =============${response.body}");
      if (response.statusCode == 200) {
        loadingCancelList.value = false;

        List<PatientBookingCancelModel> listReason = jsonDecode(response.body)
            .map((item) => PatientBookingCancelModel.fromJson(item))
            .toList()
            .cast<PatientBookingCancelModel>();
        cancelReason.clear();
        cancelReason.addAll(listReason);
        print("appointment Cancel Reason$listReason");
        print("appointment Cancel Reason$cancelReason");
      } else {
        loadingCancelList.value = false;
        print("error");
      }
    } catch (e) {
      loadingCancelList.value = false;
      print("exception$e");
    }
  }


  /*----------booking Appointment Cancel with reason API-----------*/
  void bookingAppointmentCancel(
      BuildContext context,
      String bookingId,
      // String doctorId,
      String cancelId,
      VoidCallback callback,
      ) async {
    loadingCancel.value = true;
    final Map<String, dynamic> Perameter = {
      // "doctor_id": doctorId,
      "booking_id": bookingId,
      "user_id":await sp.getStringValue(sp.PATIENT_ID_KEY),
      "cancle_id":cancelId,
      "user_type":"Patient"

    };
    print("booking Appointment Cancel Parameter$Perameter");
    final response =
    await apiService.postData(MyAPI.dBookingAppointmentCancel, Perameter);
    try {
      log("booking Appointment Cancel :-${response.body}");
      log("my id $Perameter");
      if (response.statusCode == 200) {
        callback();
        bookingAppointment("pending");
        loadingCancel.value = false;
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
      } else {
        loadingCancel.value = false;
        custom.massenger(context, "Invalid");
      }
    } catch (e) {
      loadingCancel.value = false;
      log("exception$e");
    }
  }


/*----------Cancel  Appointment Remove Api ----------*/

  void cancelAppointmentRemove(
      BuildContext context,
      String bookingId,
      VoidCallback callback,
      ) async {
    loadingCancel.value = true;
    final Map<String, dynamic> Perameter = {
      "booking_id": bookingId,
      "user_id":await sp.getStringValue(sp.PATIENT_ID_KEY),
    };
    print("cancel Appointment Remove Parameter$Perameter");
    final response =
    await apiService.postData(MyAPI.pCancelAppointmentRemove, Perameter);
    try {
      log("cancel Appointment Remove :-${response.body}");
      log("my id $Perameter");
      if (response.statusCode == 200) {
        callback();
        bookingAppointment("");
        loadingCancel.value = false;
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
      } else {
        loadingCancel.value = false;
        custom.massenger(context, "Invalid");
      }
    } catch (e) {
      loadingCancel.value = false;
      log("exception$e");
    }
  }
}
