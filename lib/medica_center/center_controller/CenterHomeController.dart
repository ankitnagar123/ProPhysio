import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../../Network/ApiService.dart';
import '../../../../../Network/Apis.dart';
import '../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../network/Internet_connectivity_checker/InternetConnectivity.dart';
import '../center_models/CenterAllDrModel.dart';


class CenterHomeCtr extends GetxController {
  ApiService apiService = ApiService();
  var loadingFetch = false.obs;
  var loadingAdd = false.obs;




  var doctorList = <CenterDoctorListModel>[].obs;

  static int lengthTry = -1;

  Rx<List> selectedOptionList = Rx<List>([]);
  var selectedOption = ''.obs;

  var keywords = ''.obs;

  var location = "".obs;


  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


  /*------------------Doctor list  Fetch Api----------------*/
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
}
