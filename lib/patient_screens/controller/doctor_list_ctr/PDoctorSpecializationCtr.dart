import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../Network/ApiService.dart';
import '../../../../../Network/Apis.dart';
import '../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../model/PDoctorSpecializationDetailsModel.dart';
import '../../model/PDoctorSpecializationModel.dart';

class DoctorSpecializationCtr extends GetxController {
  ApiService apiService = ApiService();
  var loadingFetch = false.obs;
  var loadingFetchD = false.obs;

  var category = <DoctorSpecializationModel>[].obs;

var categoryDetails = SpecializationDetailsModel(doctorId: '', description: '', catName: '', subcategory: [], details: []).obs;
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


/*dummy*/


  /*--------------------specialization Fetch List  Fetch Api-----------------*/
  Future<void> specializationFetch(String doctorId) async {
    final Map<String, dynamic> Peramert = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "doctor_id": doctorId,
    };
    try {
      loadingFetch.value = true;
      final response = await apiService.postData(MyAPI.pFetchSpecialization,Peramert);
      print("specialization Fetch list=============${response.body}");
      if (response.statusCode == 200) {
        loadingFetch.value = false;
        category.value = doctorSpecializationModelFromJson(response.body);
        print(category);
      } else {
        loadingFetch.value = false;
        print("error");
      }
    } catch (e) {
      loadingFetch.value = false;

      print("exception$e");
    }
  }


}
