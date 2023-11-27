import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../Network/ApiService.dart';
import '../../../../Network/Apis.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/sharedpreference/SharedPrefrenc.dart';
import 'package:get/get.dart';

import '../../../model/CardListModel.dart';

class CardCtr extends GetxController {
  ApiService apiService = ApiService();
  var loadingAdd = false.obs;
  var loadingFetch = false.obs;
  var loadingDelete = false.obs;

  var cardList = <CardListModel>[].obs;

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CustomView custom = CustomView();


/*-------------Card Add API--------------*/
  Future cardAdd(BuildContext context, String holderName,
      String cardNo, String mothEx, String yearEx, String cvv,
      VoidCallback callback) async {
    loadingAdd.value = true;
    final Map<String, dynamic> cardPeramert = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "card_holder_name": holderName,
      "card_number": cardNo,
      "expiry_month": mothEx,
      "expiry_year": yearEx,
      "cvv": cvv
    };
    print("card Parameter$cardPeramert");
    final response = await apiService.postData(MyAPI.addCard, cardPeramert);
    try {
      log("response of Patient  Card :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loadingAdd.value = false;
      if (result == "success") {
        callback();
        cardFetch();
        loadingAdd.value = false;
        print("my patient Card $result");
        custom.massenger(context, result.toString());
        print(result.toString());
      } else {
        loadingAdd.value = false;
        custom.massenger(context, result.toString());
      }
    } catch (e) {
      loadingAdd.value = false;
      log("exception$e");
    }
  }


  /*--------------------Card Fetch Api-----------------*/
  Future<void> cardFetch() async {
    final Map<String, dynamic> cardPeramert = {
      // "language": await sp.getStringValue(sp.LANGUAGE)??"",
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
  };
    try {
    loadingFetch.value = true;
    final response = await apiService.postData(MyAPI.cardFetch,cardPeramert);
    print("card list=============${response.body}");
    if (response.statusCode == 200) {
    loadingFetch.value = false;
    cardList.value = cardListModelFromJson(response.body);
    print(cardList);
    } else {
    loadingFetch.value = false;
    print("error");
    }
    } catch (e) {
    loadingFetch.value = false;

    print("exception$e");
    }
  }

  

  /*-------------Card Add API--------------*/
  Future cardDelete(BuildContext context, String cardId,
      VoidCallback callback) async {
    loadingAdd.value = true;
    final Map<String, dynamic> cardPeramert = {
      "user_id": await sp.getStringValue(sp.PATIENT_ID_KEY),
      "card_id":cardId,
    };
    print("card Parameter$cardPeramert");
    final response = await apiService.postData(MyAPI.cardRemove, cardPeramert);
    try {
      log("response of Patient Card :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'].toString();
      loadingAdd.value = false;
      if (result == "success") {
        callback();
        loadingAdd.value = false;
        print("my patient Card remove $result");
        custom.massenger(context, result.toString());
        print(result.toString());
        cardFetch();

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