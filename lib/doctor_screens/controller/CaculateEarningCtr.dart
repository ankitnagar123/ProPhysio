import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../../Network/ApiService.dart';
import '../../../../Network/Apis.dart';
import '../../../../helper/sharedpreference/SharedPrefrenc.dart';
import 'package:get/get.dart';

import '../model/CalculateEarningModel.dart';


class DoctorEarningCtr extends GetxController {
  ApiService apiService = ApiService();
  var loading = false.obs;

  var earning = CalculateEarningModel(startDate: DateTime.parse("2023-03-20"), endDate:  DateTime.parse("2023-03-20"), totalAmount: "", list: []).obs;


  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();

  /*---------Fetch Earning behalf of Past Appointment --------*/
  Future<void> fetchEarning(String startDate,String endDate,VoidCallback callback) async {
    final Map<String, dynamic> perameter = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "doctor_id":await sp.getStringValue(sp.DOCTOR_ID_KEY),
      "start_date":startDate,
      "end_date":endDate,
    };
    try {
      loading.value = true;
      final response =
      await apiService.postData(MyAPI.dCalculateEarning, perameter);
      print(" fetch Earning  =============${response.body}");
      if (response.statusCode == 200) {
        callback();
        loading.value = false;
        earning(CalculateEarningModel.fromJson(jsonDecode(response.body)));
      } else {
        loading.value = false;
        print("Backend Error");
      }
    } catch (e) {
      loading.value = false;
      print("exception$e");
    }
  }
}