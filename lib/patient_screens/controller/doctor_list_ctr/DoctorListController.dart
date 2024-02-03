import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../../Network/ApiService.dart';
import '../../../../../Network/Apis.dart';
import '../../../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../helper/CustomView/CustomView.dart';
import '../../../network/Internet_connectivity_checker/InternetConnectivity.dart';
import '../../model/DoctorListModel.dart';
import '../../model/DoctorSubCateogryList.dart';
import '../../model/PDoctorCatSucCatModel.dart';

class DoctorListCtr extends GetxController {
  ApiService apiService = ApiService();
  var loadingFetch = false.obs;
  var loadingFetchF = false.obs;
  var loadingFetchD = false.obs;
 var categoryLoading= false.obs;
  var categoryLoadingSub= false.obs;



  var doctorList = <DoctorListModel>[].obs;

  static int lengthTry = -1;

   var catSubCat = <AllCatSucCatModel>[].obs;

  var subCategory = <SubCategoryModel>[].obs;

  Rx<List> selectedOptionList = Rx<List>([]);
  var selectedOption = ''.obs;

  var keywords = ''.obs;

 var location = "".obs;


  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


  /*------------------Doctor list  Fetch Api----------------*/
  Future<void> doctorlistfetch(BuildContext context,String categoryId,String subCatId, String priceRangeStart,
      String priceRangeEnd, String rating,String branchId,
     /* String filterLatitude,
      String filterLongitude,
      String filterDistance,*/
      ) async {
    final Map<String, dynamic> Paramert = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "cat_id":categoryId,
      "subcat_id":subCatId,
      "price_start":priceRangeStart,
      "price_end":priceRangeEnd,
      "rating":rating,
      "branch_id":branchId,

      // "latitude":filterLatitude,
      // "longitude":filterLongitude,
      // "distance":filterDistance,
      // "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),

    };
    log("doctor list parameter=============$Paramert");

    bool connection = await  checkInternetConnection();
  if(connection){
    try {
      loadingFetch.value = true;
      final response = await apiService.postData(MyAPI.pDoctorList,Paramert);
      log("doctor list=============${response.body}");
      if (response.statusCode == 200) {
        loadingFetch.value = false;
        doctorList.value = doctorListModelFromJson(response.body);
      } else {
        loadingFetch.value = false;
        print("error");
      }
    }catch (e) {
      loadingFetch.value = false;
      print("excaption$e");
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

/*  *//*------------------Doctor list  Fetch Api with filter----------------*/
/*
  Future<void> doctorlistfetch(BuildContext context,String categoryId,String subCatId,
      String priceStart,
      String priceEnd,
      String rating,
      String latitude,
      String longitude,
      String distance,
      ) async {
    final Map<String, dynamic> cardPeramert = {
      "cat_id":categoryId,
      "subcat_id":subCatId,
      "price_start":priceStart,
      "price_end":priceEnd,
      "rating":rating,
      "latitude":latitude,
      "longitude":longitude,
      "distance":distance,
    };
    bool connection = await  checkInternetConnection();
    print("doctor list peramertr=============${cardPeramert}");

    if(connection){
      try {
        loadingFetchF.value = true;
        final response = await apiService.postData(MyAPI.pDoctorList,cardPeramert);
        print("doctor list=============${response.body}");
        if (response.statusCode == 200) {
          loadingFetchF.value = false;
          var jsonString = response.body;
          print(jsonString);
          List<DoctorListModel> listdoctor = jsonDecode(response.body)
              .map((item) => DoctorListModel.fromJson(item))
              .toList()
              .cast<DoctorListModel>();
          doctorList.clear();
          doctorList.addAll(listdoctor);

          lengthTry = doctorList.value.length;
          print(listdoctor);
        } else {
          loadingFetchF.value = false;
          print("error");
        }
      }catch (e) {
        loadingFetchF.value = false;
        print("excaption$e");
      }
    }else{
      loadingFetchF.value = false;
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

  }*/


  /*------------------Particular Doctor Details------------------------*/
  var address = "".obs;
  var image = "".obs;
  var doc = "".obs;
  var doctorid = "".obs;
 var doctorname = "".obs;
 var drSurname = "".obs;
 var biography ="".obs;
  var fee ="".obs;
  var latitude = "".obs;
  var longitude= "".obs;
var category = "".obs;
var categoryId = "".obs;
var branchName = "".obs;
var branchAddress = "".obs;
var branchLat = "".obs;
var branchLong = "".obs;
var branchId = "".obs;
var drProfile = "".obs;


  var resultVar = RxnInt(0);

  void doctorDetialsfetch(String id) async {
    final Map<String, dynamic> Peramert = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "doctor_id": id,
    };
    try {
      loadingFetchD.value = true;
      resultVar.value = 0;
      final response =
          await apiService.postData(MyAPI.pDoctorDetails, Peramert);
      log("doctor Detail=============${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse["result"].toString();
      if (result == "Success") {
        loadingFetchD.value = false;
        String img = jsonResponse["Doctor_document"].toString();
        String location = jsonResponse["location"].toString();
// category.value = jsonResponse["cat"].jsonResponse["category_name"].toString();
        log("cate..........${category.value}");
        log(img);
        fee.value = jsonResponse["fees"].toString();
        doctorname.value = jsonResponse["name"].toString();
        drSurname.value = jsonResponse["surname"].toString();
        image.value = img;
        address.value = location;
        biography.value = jsonResponse["description"].toString();
        categoryId.value = jsonResponse["category_id"].toString();
        image.value = jsonResponse["Doctor_profile"].toString();
        doc.value = jsonResponse["Doctor_document"].toString();
        doctorid.value = jsonResponse["doctor_id"].toString();
        latitude.value = jsonResponse["latitude"].toString();
        longitude.value = jsonResponse["longitude"].toString();
        branchName.value = jsonResponse["branch_name"].toString();
        branchId.value = jsonResponse["branch_id"].toString();
        branchAddress.value = jsonResponse["branch_address"].toString();
        branchLong.value = jsonResponse["branch_long"].toString();
        branchLat.value = jsonResponse["branch_lat"].toString();
        drProfile.value = jsonResponse["Doctor_profile"].toString();
        resultVar.value = 1;
      } else {
        loadingFetchD.value = false;
        resultVar.value = 2;
        log("error");
      }
    } catch (e) {
      loadingFetchD.value = false;
      resultVar.value = 2;
      log("exception$e");
    }
  }

  /*-------------Sub+Category List--------------------*/
  Future<void> subCatList(String categoryId) async {
    final Map<String, dynamic> Peramert = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "category_id":categoryId,
    };
    try {
      categoryLoadingSub.value = true;
      final response = await apiService.postData(MyAPI.subcategoryList,Peramert);
      log("  Sub Category List>>>>>>=======${response.body}");
      if (response.statusCode == 200) {
        categoryLoadingSub.value = false;
        subCategory.value = subCategoryModelFromJson(response.body.toString());
        log("response subcat${subCategory.toString()}");
      } else {
        categoryLoadingSub.value = false;
        log("error");
      }
    } catch (e) {
      categoryLoadingSub.value = false;
      log("exception$e");
    }
  }

  /*------------------Category SubCategory both in one list------------------------*/
  Future<void> catSubCatList() async {
    final Map<String, dynamic> Peramert = {
      "language": await sp.getStringValue(sp.LANGUAGE)??"",
    };
    try {
      categoryLoading.value = true;
      final response = await apiService.postData(MyAPI.catSubcategoryList,Peramert);
      print(" Category Sub Category List  =============${response.body}");
      if (response.statusCode == 200) {
        categoryLoading.value = false;
        catSubCat.value = allCatSucCatModelFromJson(response.body.toString());
        print(catSubCat.toString());
      } else {
        categoryLoading.value = false;
        print("error");
      }
    } catch (e) {
      categoryLoading.value = false;
      print("exception$e");
    }
  }
}
