import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../../patient_screens/controller/auth_controllers/PatientSignUpController.dart';

class PatientSignUp extends StatefulWidget {
  const PatientSignUp({Key? key}) : super(key: key);

  @override
  State<PatientSignUp> createState() => _PatientSignUpState();
}

class _PatientSignUpState extends State<PatientSignUp> {
  LocalString text = LocalString();

  /*-----------Get-x Controller initialize----------------*/
  PatientSignUpCtr patientSignUpCtr = PatientSignUpCtr();

  //*************Controllers*************//
  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();

  TextEditingController emailCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();

  TextEditingController weightCtr = TextEditingController();
  TextEditingController ageCtr = TextEditingController();
  TextEditingController heightCtr = TextEditingController();
  TextEditingController trmCtr = TextEditingController();
  TextEditingController birthPlaceCtr = TextEditingController();

  TextEditingController passwordCtr = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  bool _isHidden = true;

  CustomView customView = CustomView();
  String code = '+39';
  String flag = 'IT';




  String _selectedGender = '';

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
                  customView.text(text.have_an_account.tr, 11,
                      FontWeight.normal, MyColor.primary1),
                  Text(
                    text.SIGN_IN.tr,
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
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customView.text(text.Enter_Name.tr, 12.0,
                            FontWeight.w600, MyColor.primary1),
                        const SizedBox(
                          height: 3.0,
                        ),
                        customView.myField(context, nameCtr,
                            text.H_Enter_Name.tr, TextInputType.text),
                      ],
                    )),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customView.text(text.Enter_Surname.tr, 12.0,
                            FontWeight.w600, MyColor.primary1),
                        const SizedBox(
                          height: 3.0,
                        ),
                        customView.myField(context, surnameCtr,
                            text.H_Enter_Surname.tr, TextInputType.text),
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 17.0,
            ),
            /*     customView.text(
                text.Enter_Username.tr, 12.0, FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(context, usernameCtr,
                text.H_Enter_Username.tr, TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),*/
            customView.text(
                text.Enter_Email.tr, 12.0, FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(
                context, emailCtr, text.H_Enter_Email.tr, TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customView.text(text.Age.tr, 12.0, FontWeight.w600,
                            MyColor.primary1),
                        const SizedBox(
                          height: 3.0,
                        ),
                        customView.myField(
                            context, ageCtr, text.Age.tr, TextInputType.number),
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 17.0,
            ),

            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customView.text(text.Weight.tr, 12.0, FontWeight.w600,
                            MyColor.primary1),
                        const SizedBox(
                          height: 3.0,
                        ),
                        customView.myField(context, weightCtr, text.Weight.tr,
                            TextInputType.number),
                      ],
                    )),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customView.text(text.Height.tr, 12.0, FontWeight.w600,
                            MyColor.primary1),
                        const SizedBox(
                          height: 3.0,
                        ),
                        customView.myField(context, heightCtr, text.Height.tr,
                            TextInputType.number),
                      ],
                    ))
              ],
            ),

            const SizedBox(
              height: 17.0,
            ),

            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customView.text(text.TRM.tr, 12.0, FontWeight.w600,
                            MyColor.primary1),
                        const SizedBox(
                          height: 3.0,
                        ),
                        customView.myField(context, trmCtr, text.TRM.tr,
                            TextInputType.text),
                      ],
                    )),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customView.text(text.Birth_Place.tr, 12.0,
                            FontWeight.w600, MyColor.primary1),
                        const SizedBox(
                          height: 3.0,
                        ),
                        customView.myField(context, birthPlaceCtr,
                            text.Birth_Place.tr, TextInputType.text),
                      ],
                    ))
              ],
            ),

             const SizedBox(
              height: 17.0,
            ),
            customView.text(
                text.Gender.tr, 12.0, FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Radio<String>(
                      value: 'male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                          print(_selectedGender);
                        });
                      },
                    ),
                    title: Text(text.Male.tr),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Radio<String>(
                      value: 'female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                          print(_selectedGender);
                        });
                      },
                    ),
                    title: Text(text.Female.tr),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 22.0,
            ),
            customView.text(
                text.Phone_Number.tr, 12.0, FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            SizedBox(
              height: 50,
              width: widht * 1,
              child: IntlPhoneField(
                controller: phoneCtr,
                decoration: InputDecoration(
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
              height: 15.0,
            ),
            customView.text(text.Create_Passsword.tr, 12.0, FontWeight.w600,
                MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.PasswordField(
                context,
                passwordCtr,
                text.H_Create_Passsword.tr,
                TextInputType.text,
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _isHidden = !_isHidden;
                      });
                    },
                    child: _isHidden
                        ? const Icon(
                            Icons.visibility_off,
                            color: MyColor.primary1,
                            size: 18,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: MyColor.primary1,
                            size: 18,
                          )),
                _isHidden),
            const SizedBox(
              height: 17.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Obx(() {
                if (patientSignUpCtr.loadingotp.value) {
                  return Center(child: customView.MyIndicator());
                }
                return customView.MyButton(
                  context,
                  text.Sign_UP.tr,
                  () {
                    var data = {
                      'name': nameCtr.text,
                      'surname': surnameCtr.text,
                      'phone': phoneCtr.text,
                      "flag": flag,
                      'email': emailCtr.text,
                      'password': passwordCtr.text,
                      'code': code,
                      'weight': weightCtr.text,
                      'height': heightCtr.text,
                      'tax': trmCtr.text,
                      'birthPlace': birthPlaceCtr.text,
                      'age': ageCtr.text,
                      'gender': _selectedGender,
                    };
                    if (_sendDataToVerificationScrn(context)) {
                      patientSignUpCtr.PatientSignupOtpVerification(
                          context, code, phoneCtr.text, emailCtr.text, () {
                        Get.toNamed(
                          RouteHelper.getSingUpOtpScreen(),
                          parameters: data,
                        );
                      });
                      /* patientSignUpCtr.PatientSignupOtp(context,code,phoneCtr.text,emailCtr.text,)
                          .then((value) {
                        if (value != "") {
                          Get.toNamed(
                              RouteHelper.getSingUpOtpScreen(),
                              parameters: data, arguments: value);
                        } else {}
                      });*/
                    }
                  },
                  MyColor.red,
                  const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "Poppins"),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  bool _sendDataToVerificationScrn(BuildContext context) {
    if (nameCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Name is required");
    } else if (surnameCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Surname is required");
    } else if (emailCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Email ID is required");
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailCtr.text.toString())) {
      customView.MySnackBar(context, "Enter valid email");
    }  else if (ageCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Age is required");
    } else if (weightCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Weight is required");
    } else if (heightCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Height is required");
    } else if (trmCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "TRM is required");
    } else if (birthPlaceCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Birthplace is required");
    } else if (_selectedGender == "") {
      customView.MySnackBar(context, "Select gender");
    } else if (phoneCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Phone no. is required");
    } else if (passwordCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Password is required");
    } else if (passwordCtr.text.toString().length < 6) {
      customView.MySnackBar(context, "Password should be 6 digit");
    } else {
      return true;
    }
    return false;
  }
}
