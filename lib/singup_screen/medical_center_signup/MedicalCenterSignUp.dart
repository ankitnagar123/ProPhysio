import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../../medica_center/center_controller/CenterAuthController.dart';

class MedicalCenterSignUp extends StatefulWidget {
  const MedicalCenterSignUp({Key? key}) : super(key: key);

  @override
  State<MedicalCenterSignUp> createState() => _MedicalCenterSignUpState();
}

class _MedicalCenterSignUpState extends State<MedicalCenterSignUp> {
  /*-----------Getx Controller initialize----------------*/
  CenterAuthCtr centerAuthCtr = CenterAuthCtr();

  //*************Controllers*************//
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();

  TextEditingController passwordCtr = TextEditingController();

  LocalString text = LocalString();

  CustomView customView = CustomView();
  String? latitude;
  String? longitude;
  String code = '+39';
  String flag = 'IT';
  DateTime? startDate, endData;


  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      bottomNavigationBar: Container(
          height: 35.0,
          decoration: const BoxDecoration(color: MyColor.midgray),
          child: Center(
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customView.text(text.have_an_account.tr, 11,
                      FontWeight.normal, MyColor.primary1),
                   Text(
                    text.SIGN_IN.tr,
                    style: const TextStyle(
                        color: MyColor.primary1,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline),
                  )
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.shortestSide / 15,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(text.MedicalName.tr, 12.0,
                  FontWeight.w600, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(context, nameCtr, text.HMedicalName.tr,
                TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(text.Enter_Email.tr, 12.0,
                  FontWeight.w600, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(
                context, emailCtr, text.Enter_Email.tr, TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            SizedBox(
              height: 50,
              width: widht * 1,
              child: IntlPhoneField(
                controller: phoneCtr,
                decoration:  InputDecoration(
                  // focusedErrorBorder: InputBorder.none,
                  counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  constraints: const BoxConstraints.expand(),
                  labelText: text.Phone_Number.tr,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                initialCountryCode: flag,
                onChanged: (phone) {
                  // var flag = phone.countryISOCode;
                  flag = phone.countryISOCode;
                  print(flag);
                  code = phone.countryCode;
                  print(phone.completeNumber);
                },
                onCountryChanged: (cod) {
                  flag = cod.code;
                  print(flag);
                  code = cod.code;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            const SizedBox(
              height: 17.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  text.Create_Passsword.tr, 12.0, FontWeight.w600, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(
                context, passwordCtr, text.Create_Passsword.tr, TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            customView.text(
                text.Select_Address.tr, 12.0, FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(
                context, addressCtr,  text.Select_Address.tr, TextInputType.text),
            const SizedBox(
              height: 22,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Obx(() {
                  if (centerAuthCtr.loadingotp.value) {
                    return customView.MyIndicator();
                  }
                  return customView.MyButton(
                    context,
                    text.Sign_UP.tr,
                    () async {
                      if (await _sendDataToVerificationScrn(context)) {
                        var data = {
                          'name': nameCtr.text,
                          'email': emailCtr.text,
                          'phone': phoneCtr.text,
                          "flag":flag,
                          'code':code,
                          'password': passwordCtr.text,
                          'address': addressCtr.text,
                          "lat": latitude.toString(),
                          "long":longitude.toString(),
                        };
                        centerAuthCtr.CenterSignupOtpVerification(context,code,phoneCtr.text,emailCtr.text,() {
                          Get.toNamed(RouteHelper.CSignUpOtp(),
                              parameters: data,);
                        },);
                       /* centerAuthCtr.CenterSignupOtp(context,code,phoneCtr.text, emailCtr.text)
                            .then((value) {
                          if (value != "") {
                            Get.toNamed(RouteHelper.CSignUpOtp(),
                                parameters: data, arguments: value);
                          } else {}
                        });*/
                      }
                    },
                    MyColor.primary,
                    const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //*******date picker function************//
  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2999),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: MyColor.primary, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.brown, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: MyColor.primary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<bool> _sendDataToVerificationScrn(BuildContext context) async {
    if (nameCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Medical center name is required");
    } else if (emailCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Email is required");
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailCtr.text.toString())) {
      customView.MySnackBar(context, "Enter valid email");
    } else if (passwordCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Password is required");
    } else if (passwordCtr.text.toString().length < 6) {
      customView.MySnackBar(context, "Password should be 6 digit");
    } else if (addressCtr.text.isEmpty) {
      customView.MySnackBar(context, "Address is required");
    } else {
      return await latLong(addressCtr.text);
    }
    return false;
  }

  Future<bool> latLong(String address) async {
    try {
      List<Location> locationsList = await locationFromAddress(address);
      print(locationsList[0].latitude);
      print(locationsList[0].longitude);

      latitude = locationsList[0].latitude.toString();
      longitude = locationsList[0].longitude.toString();
      return true;
    } catch (e) {
      log("Exception :-", error: e.toString());
      customView.MySnackBar(context, "invalid address");
      return false;
    }
  }
}
