import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/network/Internet_connectivity_checker/InternetConnectivity.dart';

import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../network/ApiService.dart';
import '../../../network/Apis.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../model/DoctorCancelBookingModel.dart';
import '../model/booking_list_model.dart';

class BookingController extends GetxController {
  CustomView custom = CustomView();
  ApiService apiService = ApiService();
  LocalString text = LocalString();

  SharedPreferenceProvider sp = SharedPreferenceProvider();

  var booking = <bookingList>[].obs;
  var cancelReason = <DoctorBookingCancelModel>[].obs;

  var loading = false.obs;
  var loadingd = false.obs;
  var loadingAccept = false.obs;
  var loadingReject = false.obs;

  var loadingDone = false.obs;
  var loadingCancelList = false.obs;
  var loadingCancel = false.obs;

  var username = "".obs;
  var userPic = "".obs;
  var paymentTyp = "".obs;
  var price = "".obs;
  var bookingDate = "".obs;
  var status = "".obs;
  var reasonCancel = "".obs;
  var time = "".obs;
  var bookId = "".obs;
  var patientId = "".obs;
  var location = "".obs;
  var name = "".obs;
  var surname = "".obs;

  var bookingId = "".obs;
  var contact = "".obs;
  var userId = "".obs;
  var patientProfile = "".obs;

  /*---------booking Appointment List with Status type--------*/
  Future<void> bookingAppointment(
      BuildContext context, String statusType, String dateFilter) async {
    bool connection = await checkInternetConnection();
    final Map<String, dynamic> perameter = {
       "language": await sp.getStringValue("it")??"",
      "id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "status": statusType,
      "type": dateFilter,
    };
    if (connection) {
      try {
        loading.value = true;
        final response =
            await apiService.postData(MyAPI.dBookingAppointmentList, perameter);
        print(" doctor booking Appointment =============${response.body}");
        if (response.statusCode == 200) {
          loading.value = false;
          List<bookingList> listbooking = jsonDecode(response.body)
              .map((item) => bookingList.fromJson(item))
              .toList()
              .cast<bookingList>();
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
    } else {
      loading.value = false;
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

/*----------booking Appointment details API-----------*/
  void bookingAppointmentDetails(
    BuildContext context,
    String id,
    String statusType,
    VoidCallback callback,
  ) async {
    loadingd.value = true;
    final Map<String, dynamic> Perameter = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "booking_id": id,
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "status": statusType,
    };
    print("Doctor booking Appointment details Parameter$Perameter");

    final response =
        await apiService.postData(MyAPI.dBookingAppointmentDetial, Perameter);
    try {
      log("response of booking Appointment details:-${response.body}");
      log("my id $Perameter");
      if (response.statusCode == 200) {
        callback();
        loadingd.value = false;
        var jsonResponse = jsonDecode(response.body);
        // String result = jsonResponse['result'];
        // print("my doctor profile====${result.toString()}");
        patientProfile.value = jsonResponse["user_profile"].toString();
        userPic.value = jsonResponse["user_profile"].toString();
        userId.value = jsonResponse["user_id"].toString();
        paymentTyp.value = jsonResponse["payment_type"].toString();
        price.value = jsonResponse["price"].toString();
        bookingDate.value = jsonResponse["booking_date"].toString();
        status.value = jsonResponse["status"].toString();
        reasonCancel.value = jsonResponse['cancle_reason'].toString();
        time.value = jsonResponse["Time"].toString();
        bookId.value = jsonResponse["book_ID"].toString();
        patientId.value = jsonResponse["patient_ID"].toString();
        location.value = jsonResponse["location"].toString();
        name.value = jsonResponse["name"].toString();
        username.value = jsonResponse["username"].toString();
        surname.value = jsonResponse["surname"].toString();

        bookingId.value = jsonResponse["booking_id"].toString();
        contact.value = jsonResponse["contact"].toString();
        loadingd.value = false;
      } else {
        loadingd.value = false;
        custom.massenger(context, "Invalid");
      }
    } catch (e) {
      loadingd.value = false;
      log("exception$e");
    }
  }

/*----------booking Appointment Accept API-----------*/
  void bookingAppointmentAccept(
    BuildContext context,
    String id,
    VoidCallback callback,
  ) async {
    loadingAccept.value = true;
    final Map<String, dynamic> Perameter = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "booking_id": id,
    };
    print("booking Appointment Accept Parameter$Perameter");
    final response =
        await apiService.postData(MyAPI.dBookingAppointmentAccept, Perameter);
    try {
      log("booking Appointment Accept :-${response.body}");
      log("my id $Perameter");
      if (response.statusCode == 200) {
        callback();
        bookingAppointment(context, "pending", "");
        loadingAccept.value = false;
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
      } else {
        loadingAccept.value = false;
        custom.massenger(context, text.Invalid.tr);
      }
    } catch (e) {
      loadingAccept.value = false;
      log("exception$e");
    }
  }

/*----------booking Appointment Reject API-----------*/
  void bookingAppointmentReject(
    BuildContext context,
    String id,
    VoidCallback callback,
  ) async {
    loadingReject.value = true;
    final Map<String, dynamic> Perameter = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "booking_id": id,
    };
    print("booking Appointment Reject Parameter$Perameter");
    final response =
        await apiService.postData(MyAPI.dBookingAppointmentReject, Perameter);
    try {
      log("booking Appointment Reject:-${response.body}");
      log("my id $Perameter");
      if (response.statusCode == 200) {
        callback();
        bookingAppointment(context, "pending", "");
        loadingReject.value = false;
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
      } else {
        loadingReject.value = false;
        custom.massenger(context, text.Invalid.tr);
      }
    } catch (e) {
      loadingReject.value = false;
      log("exception$e");
    }
  }

  /*----------booking Appointment Done API-----------*/
  void bookingAppointmentDone(
    BuildContext context,
    String id,
    VoidCallback callback,
  ) async {
    loadingDone.value = true;
    final Map<String, dynamic> Perameter = {
      "doctor_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "booking_id": id,
    };
    print("booking Appointment DONE Parameter$Perameter");
    final response =
        await apiService.postData(MyAPI.dBookingAppointmentDone, Perameter);
    try {
      log("booking Appointment DONE :-${response.body}");
      log("my id $Perameter");
      if (response.statusCode == 200) {
        callback();
        bookingAppointment(context, "pending", "");
        loadingDone.value = false;
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
      } else {
        loadingDone.value = false;
        custom.massenger(context, "Invalid");
      }
    } catch (e) {
      loadingDone.value = false;
      log("exception$e");
    }
  }

  /*---------booking Appointment Cancel Reason's List--------*/
  Future<void> appointmentCancelReason() async {
    final Map<String, dynamic> parameter = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
    };
    try {
      loadingCancelList.value = true;
      final response = await apiService.postData(MyAPI.dAppointmentCancelList,parameter);
      print(" appointment Cancel Reason =============${response.body}");
      if (response.statusCode == 200) {
        loadingCancelList.value = false;
        cancelReason.value = doctorBookingCancelModelFromJson(response.body);
        print("appointment Cancel Reason${cancelReason.length}");
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
    String cancelId,
    VoidCallback callback,
  ) async {
    loadingCancel.value = true;
    final Map<String, dynamic> Perameter = {
      "user_id": await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "booking_id": bookingId,
      "cancle_id": cancelId,
    };
    print("booking Appointment Cancel Parameter$Perameter");
    final response =
        await apiService.postData(MyAPI.dBookingAppointmentCancel, Perameter);
    try {
      log("booking Appointment Cancel :-${response.body}");
      log("my id $Perameter");
      if (response.statusCode == 200) {
        callback();
        bookingAppointment(context, "pending", "");
        loadingCancel.value = false;
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
      } else {
        loadingCancel.value = false;
        custom.massenger(context,text.Invalid.tr);
      }
    } catch (e) {
      loadingCancel.value = false;
      log("exception$e");
    }
  }
}
