import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../doctor_screens/controller/DoctorSignUpController.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../../patient_screens/controller/auth_controllers/PatientSignUpController.dart';

class PatientSignUp extends StatefulWidget {
  const PatientSignUp({super.key});

  @override
  State<PatientSignUp> createState() => _PatientSignUpState();
}

class _PatientSignUpState extends State<PatientSignUp> {
  LocalString text = LocalString();
  CustomView customView = CustomView();

  /*-----------Get-x Controller initialize----------------*/
  PatientSignUpCtr patientSignUpCtr = PatientSignUpCtr();
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());

  String dropdownvalue = "Mr";

  var items = [
    "Mr",
    "Ms",
    "Mrs",
  ];

  //*************Controllers*************//
  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController weightCtr = TextEditingController();
  TextEditingController ageCtr = TextEditingController();
  TextEditingController heightCtr = TextEditingController();
  TextEditingController trmCtr = TextEditingController();
  TextEditingController birthPlaceCtr = TextEditingController();
  TextEditingController birthDateCtr = TextEditingController();

  TextEditingController emailCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();

  String? selectedBranch;
  DateTime? startDate;
  String _selectedGender = '';

  /*------------------------------new field------------------------------------------*/
  PageController controller = PageController();
  int _curr = 1;
  final int _numpage = 1;

  /*--------new Id type field--------*/
  TextEditingController idTypeCtr = TextEditingController();
  TextEditingController idNumberCtr = TextEditingController();

  /*--------new Kin type field--------*/
  TextEditingController kinNameCtr = TextEditingController();
  TextEditingController kinContactCtr = TextEditingController();

  /*--------new Home Address field--------*/
  TextEditingController homeTitle1Ctr = TextEditingController();
  TextEditingController homeTitle2Ctr = TextEditingController();
  TextEditingController homeAddressCtr = TextEditingController();
  TextEditingController homePostalCodeCtr = TextEditingController();
  TextEditingController homeStateCtr = TextEditingController();
  TextEditingController homeCountryCtr = TextEditingController();
  TextEditingController homePhoneCtr = TextEditingController();

  /*-------- Office field--------*/
  TextEditingController officeTitle1Ctr = TextEditingController();
  TextEditingController officeTitle2Ctr = TextEditingController();
  TextEditingController employmentStatusCtr = TextEditingController();
  TextEditingController occupationCtr = TextEditingController();
  TextEditingController employerCtr = TextEditingController();
  TextEditingController officeAddressCtr = TextEditingController();
  TextEditingController officePostalCtr = TextEditingController();
  TextEditingController officeStateCtr = TextEditingController();
  TextEditingController officeCountryCtr = TextEditingController();
  TextEditingController officePhoneCtr = TextEditingController();

/*----------------Medical Doctor Information-------------------*/
  TextEditingController medicalTitle1Ctr = TextEditingController();
  TextEditingController medicalTitle2Ctr = TextEditingController();
  TextEditingController medicalNameCtr = TextEditingController();
  TextEditingController medicalPracticeNameCtr = TextEditingController();
  TextEditingController medicalAddressCtr = TextEditingController();
  TextEditingController medicalPostalCtr = TextEditingController();
  TextEditingController medicalStateCtr = TextEditingController();
  TextEditingController medicalCountryCtr = TextEditingController();
  TextEditingController medicalPhoneCtr = TextEditingController();

/*-----Other Information---------*/
  TextEditingController aboutUsCtr = TextEditingController();

  /*---------------------------------------------------------------------------------------------------*/

  String _displayText(DateTime? date) {
    if (date != null) {
      return date.toString().split(' ')[0];
    } else {
      return '';
    }
  }

  bool _isHidden = true;
  String code = '+1876';
  String flag = 'JM';

  @override
  void initState() {
    super.initState();
    doctorSignUpCtr.branchListApi();
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async {
      if (_curr == 1) {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Exit from SignUp Form",
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              content: const Text(
                "Are you sure want to exit",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(Colors.white)),
                  child: Text(
                    text.No.tr,
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'Poppins'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(MyColor.red)),
                  child: Text(
                    text.Yes.tr,
                    style: const TextStyle(
                        fontFamily: 'Poppins', color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      }
      else if(_curr ==6){
        setState(() {
          // _curr =5;
          controller.previousPage(
              duration: const Duration(milliseconds: 10),
          curve: Curves.bounceIn);
        });
      } else if(_curr ==5){
        setState(() {
          // _curr =5;
          controller.previousPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.bounceIn);
        });
      } else if(_curr ==4){
        setState(() {
          // _curr =5;
          controller.previousPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.bounceIn);
        });
      }else if(_curr ==3){
        setState(() {
          // _curr =5;
          controller.previousPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.bounceIn);
        });
      }else if(_curr ==2){
        setState(() {
          // _curr =5;
          controller.previousPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.bounceIn);
        });
      }else{}
      return false;
    },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Container(
              height: 75.0,
              decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border.all(color: MyColor.primary1.withOpacity(0.2)),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14))),
              child: Column(
                children: [
                  customView.text(
                      "$_curr/6", 13.0, FontWeight.w500, Colors.black),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Obx(() {
                      if (patientSignUpCtr.loadingotp.value) {
                        return Center(child: customView.MyIndicator());
                      }
                      return customView.MyButton(
                        context,
                        text.Sign_UP.tr,
                        () {
                          if (_curr == 1) {
                            if (validation1(context) == false) {
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 10),
                                  curve: Curves.bounceIn
                              );
                            }
                          } else if (_curr == 2) {
                            if (validation2(context) == false) {
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 10),
                                  curve: Curves.bounceIn);
                            }
                          } else if (_curr == 3) {
                            if (validation3(context) == false) {
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 10),
                                  curve: Curves.bounceIn);
                            }
                          } else if (_curr == 4) {
                            if (validation4(context) == false) {
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 10),
                                  curve: Curves.bounceIn);
                            }
                          } else if (_curr == 5) {
                            if (validation5(context) == false) {
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 10),
                                  curve: Curves.bounceIn);
                            }
                          } else if (_curr == 6) {
                            if (validation6(context) == false) {
                            } else {
                              var data = {
                                'title': dropdownvalue.toString(),
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
                                'dob': birthDateCtr.text,
                                'branchId': selectedBranch.toString(),

                                /*-----------------New Field Added*-----------------*/
                                /* -----Identification Document-------*/
                                'idType': idTypeCtr.text,
                                'idNumber': idNumberCtr.text,

                                /*-----kin-------*/
                                "kinName": kinNameCtr.text,
                                "kinContact": kinContactCtr.text,

                                /*-----Home Address-------*/
                                "homeTitle1": homeTitle1Ctr.text,
                                "homeTitle2": homeTitle2Ctr.text,
                                "homeAddress": homeAddressCtr.text,
                                "homeState": homeStateCtr.text,
                                "homePostalCode": homePostalCodeCtr.text,
                                "homeCountry": homeCountryCtr.text,
                                "homePhone": homePhoneCtr.text,

                                /* -----Office Address-------*/
                                "officeTitle1": officeTitle1Ctr.text,
                                "officeTitle2": officeTitle2Ctr.text,
                                "employmentStatus": employmentStatusCtr.text,
                                "occupation": occupationCtr.text,
                                "employer": employerCtr.text,
                                "officeAddress": officeAddressCtr.text,
                                "officeState": officeStateCtr.text,
                                "officePostalCode": officePostalCtr.text,
                                "officeCountry": officeCountryCtr.text,
                                "officePhone": officePhoneCtr.text,

                                /*-----Medical Doctor INfo-------*/
                                "medicalTitle1": medicalTitle1Ctr.text,
                                "medicalTitle2": medicalTitle2Ctr.text,
                                "medicalName": medicalNameCtr.text,
                                "medicalPracticeName":
                                    medicalPracticeNameCtr.text,
                                "medicalAddress": medicalAddressCtr.text,
                                "medicalState": medicalStateCtr.text,
                                "medicalPostalCode": medicalPostalCtr.text,
                                "medicalCountry": medicalCountryCtr.text,
                                "medicalPhone": medicalPhoneCtr.text,
                                "aboutUs": aboutUsCtr.text,
                              };
                              patientSignUpCtr.PatientSignupOtpVerification(
                                  context, code, phoneCtr.text, emailCtr.text,
                                  () {
                                Get.toNamed(
                                  RouteHelper.getSingUpOtpScreen(),
                                  parameters: data,
                                );
                              });
                            }
                          }

                          /*   patientSignUpCtr.PatientSignupOtp(context,code,phoneCtr.text,emailCtr.text,)
                            .then((value) {
                          if (value != "") {
                            Get.toNamed(
                                RouteHelper.getSingUpOtpScreen(),
                                parameters: data, arguments: value);
                          } else {}
                        });*/
                        },
                        MyColor.red,
                        const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: "Poppins"),
                      );
                    }),
                  ),
                  // Center(
                  //   child: InkWell(
                  //     onTap: () {
                  //       Get.back();
                  //     },
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         customView.text(text.have_an_account.tr, 11,
                  //             FontWeight.normal, MyColor.primary1),
                  //         Text(
                  //           text.SIGN_IN.tr,
                  //           style: TextStyle(
                  //               color: MyColor.primary1,
                  //               fontWeight: FontWeight.w700,
                  //               decoration: TextDecoration.underline),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              )),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  setState((){
                    _curr = 1 + value;
                    log("value page index - $value");
                    log("curr index-$_curr");
                  });
                },
                controller: controller,
                children: [
                  signUp1(),
                  signUp2(),
                  signUp3(),
                  signUp4(),
                  signUp5(),
                  signUp6(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*------------------sign-Up 1----------------*/
  Widget signUp1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: MyColor.primary1.withOpacity(0.3))),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: customView.text("Demographics Info", 15.0,
                      FontWeight.w600, MyColor.primary1),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(text.Enter_Name.tr, 13.0,
                    FontWeight.w500, MyColor.primary1),
              ),
              const SizedBox(
                height: 3.0,
              ),
              Row(
                children: [
                  Expanded(flex: 0, child: _buildDropDownButton()),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    flex: 1,
                    child: customView.myField(context, nameCtr,
                        text.H_Enter_Name.tr, TextInputType.text),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(text.Enter_Surname.tr, 13.0,
                    FontWeight.w500, MyColor.primary1),
              ),
              const SizedBox(
                height: 3.0,
              ),
              customView.myField(context, surnameCtr, text.H_Enter_Surname.tr,
                  TextInputType.text),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customView.text(text.Age.tr, 13.0, FontWeight.w500,
                              MyColor.primary1),
                          const SizedBox(
                            height: 3.0,
                          ),
                          customView.myField(context, ageCtr, text.Age.tr,
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
                          customView.text(text.Weight.tr, 13.0, FontWeight.w500,
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
                          customView.text(text.Height.tr, 13.0, FontWeight.w500,
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
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customView.text(text.TRM.tr, 13.0, FontWeight.w500,
                              MyColor.primary1),
                          const SizedBox(
                            height: 3.0,
                          ),
                          customView.myField(
                              context, trmCtr, text.TRM.tr, TextInputType.text),
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
                          customView.text(text.Birth_Place.tr, 13.0,
                              FontWeight.w500, MyColor.primary1),
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
                height: 15.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    text.Gender.tr, 13.0, FontWeight.w500, MyColor.primary1),
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
                            log(_selectedGender);
                          });
                        },
                      ),
                      title: Text(text.Female.tr),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(text.Date_of_Birth.tr, 13.0,
                    FontWeight.w500, MyColor.primary1),
              ),
              Container(
                  height: 45.0,
                  width: MediaQuery.of(context).size.width / 0.9,
                  padding: const EdgeInsets.only(left: 10.0, bottom: 2),
                  margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextFormField(
                    onTap: () async {
                      startDate = await pickDate();
                      birthDateCtr.text = _displayText(startDate);
                      setState(() {});
                    },
                    readOnly: true,
                    controller: birthDateCtr,
                    decoration: InputDecoration(
                      hintText: text.Select_Date.tr,
                      hintStyle: const TextStyle(fontSize: 15),
                      suffixIcon: const Icon(Icons.calendar_month,
                          color: MyColor.primary),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  /*------------------sign-Up 2----------------*/
  Widget signUp2() {
    final widht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: MyColor.primary1.withOpacity(0.3))),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: customView.text("Contact Information", 15.0,
                      FontWeight.w600, MyColor.primary1),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(text.Enter_Email.tr, 13.0,
                    FontWeight.w500, MyColor.primary1),
              ),
              const SizedBox(
                height: 3.0,
              ),
              customView.myField(
                  context, emailCtr, text.H_Enter_Email.tr, TextInputType.text),
              const SizedBox(
                height: 15.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(text.Phone_Number.tr, 13.0,
                    FontWeight.w500, MyColor.primary1),
              ),
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
                    log(flag);
                    code = phone.countryCode;
                    log(phone.completeNumber);
                  },
                  onCountryChanged: (cod) {
                    flag = cod.code;
                    log(flag);
                    code = cod.code;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(text.Create_Passsword.tr, 13.0,
                    FontWeight.w500, MyColor.primary1),
              ),
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
                height: 15.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(text.Select_Branch.tr, 13.0,
                    FontWeight.w500, MyColor.primary1),
              ),
              const SizedBox(
                height: 3.0,
              ),
              branch(),
            ]),
          ),
        ),
      ),
    );
  }

  /*------------------sign-Up 3----------------*/
  Widget signUp3() {
    final widht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const SizedBox(
                height: 17.0,
              ),
              /*-------------------Identification Document-----------------*/

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: MyColor.primary1.withOpacity(0.3))),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: customView.text("Identification Document", 15.0,
                      FontWeight.w600, MyColor.primary1),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "ID Type", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myField(
                  context, idTypeCtr, "Enter ID Type", TextInputType.text),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "ID Number", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myField(
                  context, idNumberCtr, "Enter ID Number", TextInputType.text),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: MyColor.primary1.withOpacity(0.3))),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: customView.text(
                      "Next of Kin", 15.0, FontWeight.w600, MyColor.primary1),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "Name", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myField(
                  context, kinNameCtr, "Enter Name", TextInputType.text),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "Phone", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myField(
                  context, kinContactCtr, "Enter Phone", TextInputType.number),
              SizedBox(
                height: 15,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  /*------------------sign-Up 4----------------*/
  Widget signUp4() {
    final widht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              /*----------------------Home Address--------------------*/
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: MyColor.primary1.withOpacity(0.3))),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: customView.text(
                      "Home Address", 15.0, FontWeight.w600, MyColor.primary1),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "Title 1", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myFieldExpand(
                  context, homeTitle1Ctr, "Enter Title 1", TextInputType.text),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "Title 2", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              const SizedBox(
                height: 5,
              ),
              customView.myFieldExpand(context, homeTitle2Ctr, "Enter Title 2",
                  TextInputType.multiline),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("City", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myFieldExpand(context, homeAddressCtr,
                              "Enter City", TextInputType.text),
                        ],
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customView.text(
                              "State", 13.0, FontWeight.w500, MyColor.primary1),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(
                              context,
                              homeStateCtr,
                              "Enter State/Province/Parish",
                              TextInputType.text),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Postal Code", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(context, homePostalCodeCtr,
                              "Enter Postal Code", TextInputType.number),
                        ],
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Country", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(context, homeCountryCtr,
                              "Enter Country", TextInputType.text),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "Home Phone", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myField(
                  context, homePhoneCtr, "Enter phone", TextInputType.number),
              SizedBox(
                height: 15,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  /*------------------sign-Up 5----------------*/
  Widget signUp5() {
    final widht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              /*---------------------------Employment Information--------------------*/
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: MyColor.primary1.withOpacity(0.3))),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: customView.text("Employment Status", 15.0,
                      FontWeight.w600, MyColor.primary1),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "Title 1", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myFieldExpand(context, officeTitle1Ctr,
                  "Enter Title 1", TextInputType.text),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "Title 2", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              const SizedBox(
                height: 5,
              ),
              customView.myFieldExpand(context, officeTitle2Ctr,
                  "Enter Title 2", TextInputType.multiline),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text("Employment Status", 13.0,
                    FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myField(context, employmentStatusCtr,
                  "Enter Employment Status", TextInputType.text),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Occupation", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(context, occupationCtr,
                              "Enter Occupation", TextInputType.text),
                        ],
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Employer", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(context, employerCtr,
                              "Enter Employer", TextInputType.text),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("City", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myFieldExpand(context, officeAddressCtr,
                              "Enter City", TextInputType.text),
                        ],
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("State", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(
                              context,
                              officeStateCtr,
                              "Enter State/Province/Parish",
                              TextInputType.text),
                        ],
                      ))
                ],
              ),

              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Postal Code", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(context, officePostalCtr,
                              "Enter Postal Code", TextInputType.text),
                        ],
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Country", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(context, officeCountryCtr,
                              "Enter Country", TextInputType.text),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "Office Phone", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myField(
                  context, officePhoneCtr, "Enter phone", TextInputType.number),
              SizedBox(
                height: 15,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  /*------------------sign-Up 6----------------*/
  Widget signUp6() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              /*--------------Medical Doctor Information----------------------------*/
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: MyColor.primary1.withOpacity(0.3))),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: customView.text("Medical Doctor Information", 15.0,
                      FontWeight.w600, MyColor.primary1),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "Title 1", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myFieldExpand(context, medicalTitle1Ctr,
                  "Enter Title 1", TextInputType.text),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "Title 2", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              const SizedBox(
                height: 5,
              ),
              customView.myFieldExpand(context, medicalTitle2Ctr,
                  "Enter Title 2", TextInputType.multiline),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Name", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(context, medicalNameCtr,
                              "Enter Name", TextInputType.text),
                        ],
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Practice Name", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(context, medicalPracticeNameCtr,
                              "Enter Practice Name", TextInputType.text),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("City", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(context, medicalAddressCtr,
                              "Enter City", TextInputType.text),
                        ],
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("State", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(
                              context,
                              medicalStateCtr,
                              "Enter State/Province/Parish",
                              TextInputType.text),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Postal Code", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(context, medicalPostalCtr,
                              "Enter Postal Code", TextInputType.text),
                        ],
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Country", 13.0,
                                FontWeight.w500, MyColor.primary1),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          customView.myField(context, medicalCountryCtr,
                              "Enter Country", TextInputType.text),
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "Medical Phone", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myField(context, medicalPhoneCtr, "Enter phone",
                  TextInputType.number),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customView.text(
                    "About", 13.0, FontWeight.w500, MyColor.primary1),
              ),
              SizedBox(
                height: 5,
              ),
              customView.myFieldExpand(
                  context, aboutUsCtr, "Enter about", TextInputType.text),
              SizedBox(
                height: 15,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  bool validation1(BuildContext context) {
    if (nameCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Name is required");
    } else if (surnameCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Surname is required");
    } else if (ageCtr.text.toString().isEmpty) {
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
    } else if (birthDateCtr.text.isEmpty) {
      customView.MySnackBar(context, "Enter DOB");
    } else {
      return true;
    }
    return false;
  }

  bool validation2(BuildContext context) {
    if (emailCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Email ID is required");
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailCtr.text.toString())) {
      customView.MySnackBar(context, "Enter valid email");
    } else if (phoneCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Phone no. is required");
    } else if (passwordCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Password is required");
    } else if (passwordCtr.text.toString().length < 6) {
      customView.MySnackBar(context, "Password should be 6 digit");
    } else if (selectedBranch == null) {
      customView.MySnackBar(context, "Select your Branch");
    } else {
      return true;
    }
    return false;
  }

  bool validation3(BuildContext context) {
    if (idTypeCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "ID type is required");
    } else if (idNumberCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter Id number");
    } else if (kinNameCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter kin Name");
    } else if (kinContactCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter kin phone no");
    } else {
      return true;
    }
    return false;
  }

  bool validation4(BuildContext context) {
    if (homeTitle1Ctr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter home title 1");
    } else if (homeTitle2Ctr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter home title 2");
    } else if (homeAddressCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter home address");
    } else if (homeStateCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter home state");
    } else if (homePostalCodeCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter home postal code");
    } else if (homeCountryCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter home country");
    } else if (homePhoneCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter home contact");
    } else {
      return true;
    }
    return false;
  }

  bool validation5(BuildContext context) {
    if (officeTitle1Ctr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter office title 1");
    } else if (officeTitle2Ctr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter office title 2");
    } else if (employmentStatusCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter employment status");
    } else if (occupationCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter occupation");
    } else if (employerCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter employer");
    } else if (officeAddressCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter office address");
    } else if (officeStateCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter office state");
    } else if (officePostalCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter office postal code");
    } else if (officeCountryCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter office country");
    } else if (officePhoneCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter office contact");
    } else {
      return true;
    }
    return false;
  }

  bool validation6(BuildContext context) {
    if (medicalTitle1Ctr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter medical title 1");
    } else if (medicalTitle2Ctr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter medical title 2");
    } else if (medicalNameCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter medical name");
    } else if (medicalPracticeNameCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter practice name");
    } else if (medicalAddressCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter medical Address");
    } else if (medicalStateCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter medical state");
    } else if (medicalPostalCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter medical postal code");
    } else if (medicalCountryCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter medical country");
    } else if (medicalPhoneCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Enter medical contact");
    } else {
      return true;
    }
    return false;
  }

  /*---------SELECT BRANCH-----*/
  Widget branch() {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Center(
          child: Container(
            height: height * 0.065,
            width: widht * 1,
            padding: const EdgeInsets.only(left: 8),
            // margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
            decoration: BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: MyColor.grey)),
            child: doctorSignUpCtr.branchLoading.value
                ? customView.MyIndicator()
                : DropdownButtonHideUnderline(
                    child: DropdownButton(
                      menuMaxHeight: MediaQuery.of(context).size.height / 3,
                      // Initial Value
                      value: selectedBranch,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: MyColor.primary),
                      // Array list of items
                      items: doctorSignUpCtr.branchList.map((items) {
                        return DropdownMenuItem(
                          value: items.branchId,
                          child: Text(items.branchName),
                        );
                      }).toList(),
                      hint: Text(text.Select_Branch.tr),
                      onChanged: (newValue) {
                        stateSetter(() {
                          selectedBranch = newValue;
                          log('MY selected Branch>>>$selectedBranch');
                        });
                      },
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      keyboardType: const TextInputType.numberWithOptions(),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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

  /*------Select MR MS etc*/
  Widget _buildDropDownButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            iconEnabledColor: Colors.black,
            style: TextStyle(
              color: Colors.black,
            ),
            dropdownColor: Colors.grey.shade300,
            value: dropdownvalue,
            items: items
                .map((String value) => DropdownMenuItem(
                      value: value,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(value),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }
}
