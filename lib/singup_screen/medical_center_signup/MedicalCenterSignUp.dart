import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

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

  final bool _isHidden = true;

  CustomView customView = CustomView();
  String code = '';
  String? latitude;
  String? longitude;

  String _displayText(DateTime? date) {
    if (date != null) {
      return date.toString().split(' ')[0];
    } else {
      return 'Choose The Date';
    }
  }

  DateTime? startDate, endData;

  final String _selectedGender = '';

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
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
                  customView.text("Do you have an account?", 11,
                      FontWeight.normal, MyColor.primary1),
                  const Text(
                    "Sign-in",
                    style: TextStyle(
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
              child: customView.text("Enter your Medical center name", 12.0,
                  FontWeight.w600, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(context, nameCtr, "Your Medical center name",
                TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text("Enter a valid email / username", 12.0,
                  FontWeight.w600, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(
                context, emailCtr, "Your email", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  "Enter password", 12.0, FontWeight.w600, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(
                context, passwordCtr, "Your password", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            customView.text(
                "Enter your address", 12.0, FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(
                context, addressCtr, "Your address", TextInputType.text),

            // customView.myField(context, usernameCtr,
            //     "Your address", TextInputType.text),
            // const SizedBox(
            //   height: 17.0,
            // ),
            // customView.text(
            //     "E-mail", 12.0, FontWeight.w600, MyColor.primary1),
            // const SizedBox(
            //   height: 3.0,
            // ),
            // customView.myField(context, emailCtr,
            //     "Enter a valid email", TextInputType.text),
            // const SizedBox(
            //   height: 17.0,
            // ),
            // customView.text("Health card code", 12.0,
            //     FontWeight.w600, MyColor.primary1),
            // const SizedBox(
            //   height: 3.0,
            // ),
            // customView.myField(context, healthCardCtr,
            //     "Enter Your health code", TextInputType.text),
            // const SizedBox(
            //   height: 17.0,
            // ),
            // customView.text("Age", 12.0,
            //     FontWeight.w600, MyColor.primary1),
            // const SizedBox(
            //   height: 3.0,
            // ),
            // customView.myField(context, ageCtr,
            //     "Enter your age", TextInputType.text),
            // const SizedBox(
            //   height: 17.0,
            // ),
            // customView.text("Weight", 12.0,
            //     FontWeight.w600, MyColor.primary1),
            // const SizedBox(
            //   height: 3.0,
            // ),
            // customView.myField(context, weightCtr,
            //     "Enter your weight", TextInputType.text),
            // const SizedBox(
            //   height: 17.0,
            // ), customView.text("Height", 12.0,
            //     FontWeight.w600, MyColor.primary1),
            // const SizedBox(
            //   height: 3.0,
            // ),
            // customView.myField(context, heightCtr,
            //     "Enter your height", TextInputType.text),
            // const SizedBox(
            //   height: 17.0,
            // ), customView.text("TAX CODE", 12.0,
            //     FontWeight.w600, MyColor.primary1),
            // const SizedBox(
            //   height: 3.0,
            // ),
            // customView.myField(context, taxCtr,
            //     "Enter your tax code", TextInputType.text),
            // const SizedBox(
            //   height: 17.0,
            // ),
            // customView.text("Birth place", 12.0,
            //     FontWeight.w600, MyColor.primary1),
            // const SizedBox(
            //   height: 3.0,
            // ),
            // customView.myField(context, birthPlaceCtr,
            //     "Enter your birth place", TextInputType.text),
            // const SizedBox(
            //   height: 17.0,
            // ),
            // customView.text("Gender", 12.0,
            //     FontWeight.w600, MyColor.primary1),
            // const SizedBox(
            //   height: 3.0,
            // ),
            // Row(children: [
            //   Expanded(
            //     flex: 1,
            //     child: ListTile(
            //       contentPadding: EdgeInsets.zero,
            //       visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            //       leading: Radio<String>(
            //         value: 'male',
            //         groupValue: _selectedGender,
            //         onChanged: (value) {
            //           setState(() {
            //             _selectedGender = value!;
            //             print(_selectedGender);
            //           });
            //         },
            //       ),
            //       title: const Text('Male'),
            //     ),
            //   ),
            //   Expanded(
            //     flex: 1,
            //     child: ListTile(
            //       contentPadding: EdgeInsets.zero,
            //       visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            //       leading: Radio<String>(
            //         value: 'female',
            //         groupValue: _selectedGender,
            //         onChanged: (value) {
            //           setState(() {
            //             _selectedGender = value!;
            //             print(_selectedGender);
            //
            //           });
            //         },
            //       ),
            //       title: const Text('Female'),
            //     ),
            //   ),
            // ],),
            // // Container(
            // //     height: 45.0,
            // //     width: MediaQuery
            // //         .of(context)
            // //         .size
            // //         .width / 0.9,
            // //     padding: const EdgeInsets.only(left: 10.0, bottom: 5),
            // //     margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            // //     decoration: BoxDecoration(
            // //       color: MyColor.white,
            // //         border: Border.all(color: Colors.black54),
            // //         borderRadius: BorderRadius.circular(7)),
            // //     child: TextFormField(
            // //       onTap: () async {
            // //         startDate = await pickDate();
            // //         startDateController.text = _displayText(startDate);
            // //         setState(() {});
            // //       },
            // //       readOnly: true,
            // //       controller: startDateController,
            // //       decoration: const InputDecoration(
            // //         hintText: "Select Date",
            // //         hintStyle: TextStyle(fontSize: 15),
            // //         suffixIcon:
            // //         Icon(Icons.calendar_month, color: MyColor.primary),
            // //         border: InputBorder.none,
            // //         focusedBorder: InputBorder.none,
            // //         enabledBorder: InputBorder.none,
            // //       ),
            // //     )),
            // const SizedBox(
            //   height: 22.0,
            // ),
            // customView.text(
            //     "Phone number", 12.0, FontWeight.w600, MyColor.primary1),
            // const SizedBox(
            //   height: 3.0,
            // ),
            // SizedBox(
            //   height: 50,
            //   width: widht * 1,
            //   child: IntlPhoneField(
            //     initialValue: "IT",
            //     controller: phoneCtr,
            //     decoration: const InputDecoration(
            //       // focusedErrorBorder: InputBorder.none,
            //       counterText: '',
            //       filled: true,
            //       fillColor: Colors.white,
            //       constraints: BoxConstraints.expand(),
            //       labelText: 'Phone Number',
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black),
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(5),
            //         ),
            //       ),
            //     ),
            //     initialCountryCode: 'IT',
            //     onChanged: (phone) {
            //       code = phone.countryCode;
            //       print(phone.completeNumber);
            //     },
            //     onCountryChanged: (cod) {
            //       code = cod.dialCode;
            //     },
            //     autovalidateMode: AutovalidateMode.onUserInteraction,
            //   ),
            // ),
            // const SizedBox(
            //   height: 17.0,
            // ),
            // customView.text(
            //     "Create a password", 12.0, FontWeight.w600, MyColor.primary1),
            // const SizedBox(
            //   height: 3.0,
            // ),
            // customView.PasswordField(
            //     context, passwordCtr, "Enter at least 6 characters",
            //     TextInputType.text, GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         _isHidden = !_isHidden;
            //       });
            //     },
            //     child: _isHidden
            //         ? const Icon(
            //       Icons.visibility_off,
            //       color: MyColor.primary1,
            //       size: 18,
            //     )
            //         : const Icon(
            //       Icons.visibility,
            //       color: MyColor.primary1,
            //       size: 18,
            //
            //     )),
            //     _isHidden),
            // const SizedBox(
            //   height: 17.0,
            // ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Obx(() {
                  if (centerAuthCtr.loadingotp.value) {
                    return customView.MyIndicator();
                  }
                  return customView.MyButton(
                    context,
                    "Sign up",
                    () async {
                      if (await _sendDataToVerificationScrn(context)) {
                        var data = {
                          'name': nameCtr.text,
                          'email': emailCtr.text,
                          'password': passwordCtr.text,
                          'address': addressCtr.text,
                          "lat": latitude.toString(),
                          "long":longitude.toString(),
                        };
                        centerAuthCtr.CenterSignupOtp(context, emailCtr.text)
                            .then((value) {
                          if (value != "") {
                            Get.toNamed(RouteHelper.CSignUpOtp(),
                                parameters: data, arguments: value);
                          } else {}
                        });
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
