import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';

import '../../../../Network/ApiService.dart';
import '../../../../Network/Apis.dart';
import '../../../../helper/sharedpreference/SharedPrefrenc.dart';
import 'package:get/get.dart';

import '../../../helper/CustomView/CustomView.dart';
import '../../model/RatingListModel.dart';

class PatientRatingCtr extends GetxController {
  ApiService apiService = ApiService();
  var loading = false.obs;
  var loadingAdd = false.obs;

  var address = RatingListModel(aveRating: '', totalReview: "", users: []).obs;


  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


/*-------------Rating Add API--------------*/
  Future ratingAdd(BuildContext context, String doctorId,
      String rating, String review, String bookingID,
      VoidCallback callback) async {
    loadingAdd.value = true;
    final Map<String, dynamic> cardPeramert = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "doctor_id": doctorId,
      "rating": rating,
      "review": review,
      "booking_id":bookingID,
    };
    log("Rating Parameter$cardPeramert");
    final response = await apiService.postData(MyAPI.pAddRating, cardPeramert);
    try {
      log("response of Patient Rating Review :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loadingAdd.value = false;
      if (result == "success") {
        loadingAdd.value = false;
        log("my patient review $result");
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



  /*---------Fetch Rating's --------*/
  Future<void> fetchRating(String doctorId) async {
    final Map<String, dynamic> perameter = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "doctor_id":doctorId
    };
    try {
      loading.value = true;
      final response =
      await apiService.postData(MyAPI.pFetchRating, perameter);
      log(" Rating Fetch =============${response.body}");
      if (response.statusCode == 200) {
        loading.value = false;
        address(RatingListModel.fromJson(jsonDecode(response.body)));
      } else {
        loading.value = false;
        print("Backed Error");
      }
    } catch (e) {
      loading.value = false;
      print("exception$e");
    }
  }
}