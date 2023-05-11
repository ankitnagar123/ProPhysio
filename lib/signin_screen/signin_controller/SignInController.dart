import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../Network/ApiService.dart';
import '../../Network/Apis.dart';
import '../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../network/Internet_connectivity_checker/InternetConnectivity.dart';

class LoginCtr extends GetxController {
  SharedPreferenceProvider sp = SharedPreferenceProvider();

  CustomView custom = CustomView();
  ApiService apiService = ApiService();
  var loading = false.obs;

  void login(
    BuildContext context,
    String username,
    String password,
  ) async {
    loading.value = true;
    final Map<String, dynamic> LoginPerameter = {
      "username": username,
      "password": password,
    };
    print("Login Parameter$LoginPerameter");
    bool isConnected = await checkInternetConnection();

    if (isConnected) {
      final response = await apiService.postData(MyAPI.Login, LoginPerameter);
      try {
        log("response of Login :-${response.body}");
        loading.value = false;
        var jsonResponse = jsonDecode(response.body);
        String result = jsonResponse['result'].toString();
        String usertype = jsonResponse['user_type'].toString();
        String id = jsonResponse['id'].toString();
        // sp.setStringValue(sp.PATIENT_ID_KEY, id);
        if (result == 'Success') {
          AnimatedButton(
            text: 'Info Reverse Dialog Without buttons',
            pressEvent: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.infoReverse,
                headerAnimationLoop: true,
                animType: AnimType.bottomSlide,
                title: 'INFO Reversed',
                reverseBtnOrder: true,
                btnOkOnPress: () {},
                btnCancelOnPress: () {},
                desc:
                    'Lorem ipsum dolor sit amet consectetur adipiscing elit eget ornare tempus, vestibulum sagittis rhoncus felis hendrerit lectus ultricies duis vel, id morbi cum ultrices tellus metus dis ut donec. Ut sagittis viverra venenatis eget euismod faucibus odio ligula phasellus,',
              ).show();
            },
          );
          custom.massenger(context, 'Login successfully');
          if (usertype == "Doctor") {
            loading.value = false;
            sp.setStringValue(sp.DOCTOR_ID_KEY, id);
            sp.setBoolValue(sp.DOCTOR_LOGIN_KEY, true);
            print(sp.DOCTOR_LOGIN_KEY);
            print(sp.getStringValue(sp.DOCTOR_ID_KEY));
            print("Doctor login ID${id.toString()}");
            Get.offAndToNamed(RouteHelper.DHomePage());
          } else if (usertype == "User") {
            loading.value = false;
            sp.setStringValue(sp.PATIENT_ID_KEY, id);
            sp.setBoolValue(sp.PATIENT_LOGIN_KEY, true);
            print(" Patient login ID${id.toString()}");
            Get.offAndToNamed(RouteHelper.getBottomNavigation());
          } else if (usertype == "Medical") {
            loading.value = false;
            sp.setStringValue(sp.CENTER_ID_KEY, id);
            sp.setBoolValue(sp.CENTER_LOGIN_KEY, true);
            print(" MEDICAL CENTER login ID${id.toString()}");
            Get.offAndToNamed(RouteHelper.CBottomNavigation());
          }else {
            loading.value = false;
            custom.massenger(context, result);
          }
        } else {
          custom.massenger(context, result.toString());
          loading.value = false;
        }
      } catch (e) {
        loading.value = false;
        log("exception$e");
      }
    } else {
      loading.value = false;
      custom.MySnackBar(context, "Check your Internet connection");
    }
  }


  /*----------Update Device  API-----------*/
  void updateToken(
      BuildContext context,
      String id,
      String userTyp,
      String deviceID,
      String deviceTyp,
      ) async {
    final Map<String, dynamic>UpdatePerameter = {
      "user_id": id,
      "device_id": deviceID,
      "device_status": deviceTyp,
      "user_type": userTyp,
    };
    log(" Update Parameter$UpdatePerameter");

    final response =
    await apiService.postData(MyAPI.updateToken,UpdatePerameter);
    try {
      log("response of Device Update :-${response.body}");
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
      } else {
        print("error");
      }
    } catch (e) {
      log("exception$e");
    }
  }
}




//*********Get  Device (for notification)Token**************//
// Future<String> _getDeviceToken() async {
//   String _deviceToken="";
//   if(Platform.isIOS) {
//     _deviceToken = (await FirebaseMessaging.instance.getAPNSToken())!;
//   }else {
//     _deviceToken = (await FirebaseMessaging.instance.getToken())!;
//   }
//   if (_deviceToken != null) {
//     print('--------Device Token---------- '+_deviceToken);
//   }
//   return _deviceToken;
// }

// SharedPreferenceProvider sp = SharedPreferenceProvider();

/************Update Token(for notification)***************/
// Future<http.Response?> updateToken(String id,String deviceTyp,String userTyp) async {
//   try {
//     String _deviceToken = await _getDeviceToken();
//     // FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
//     late final response;
//     if (Platform.isIOS) {
//       response = await http.post(Uri.parse(MyAPI.updateToken),
//           body: {
//             "user_id": id,
//             "device_id": _deviceToken,
//             "device_status": deviceTyp,
//             "user_type": userTyp,
//           }
//       );
//     } else {
//       response = await http.post(Uri.parse(MyAPI.updateToken),
//           body: {
//             "user_id":  await sp.getStringValue(sp.DOCTOR_ID_KEY),
//             "device_id": _deviceToken,
//             "device_status": "Android",
//             "user_type": "Doctor"
//           }
//       );
//     }
//     print("My device id *******${response}");
// return response;
//   }catch(e){
//     return null!;
//     print("Excaption$e");
//   }
// }

// String apiUrl;
// if(usertype == "User"){
//   apiUrl = "https://cisswork.com/Android/Medica/Apis/process.php?action=user_login";
//   // final response = await apiService.postData(MyAPI.Login, LoginPerameter);
// }else if(usertype == "Doctor"){
//   apiUrl = "https://cisswork.com/Android/Medica/Apis/process.php?action=user_login";
//   // final response = await apiService.postData(MyAPI.Login, LoginPerameter);
// }else {
//   throw Exception('Invalid user type: $usertype');
// }
