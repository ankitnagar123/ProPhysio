import 'dart:developer';

import 'package:get/get.dart';

import '../../../../../Network/ApiService.dart';
import '../../../../../Network/Apis.dart';
import '../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../model/CenterSide/pCenterListModel.dart';

class PCenterCtr extends GetxController {
  ApiService apiService = ApiService();
  var loadingFetch = false.obs;
  var loadingFetchF = false.obs;




  var centerList = <PCenterListModel>[].obs;


  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


  /*-------------Center List Api--------------------*/
  Future<void> centerListApi() async {
    final Map<String, dynamic> Parameter = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
    };
    try {
      loadingFetch.value = true;
      final response = await apiService.postData(MyAPI.cCenterList,Parameter);
      log("Center List>>>>>>=======${response.body}");
      if (response.statusCode == 200) {
        loadingFetch.value = false;
        centerList.value = pCenterListModelFromJson(response.body.toString());
        log("response Center List${centerList.toString()}");
      } else {
        loadingFetch.value = false;
        log("error");
      }
    } catch (e) {
      loadingFetch.value = false;
      log("exception$e");
    }
  }
}
