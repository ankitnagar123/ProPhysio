import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:medica/doctor_screens/controller/DoctorSignUpController.dart';

import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../helper/AppConst.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../../patient_screens/controller/doctor_list_ctr/DoctorListController.dart';

class DoctorSignUpScreen extends StatefulWidget {
  const DoctorSignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DoctorSignUpScreen> createState() => _DoctorSignUpScreenState();
}

class _DoctorSignUpScreenState extends State<DoctorSignUpScreen> {
  /*---------TEXT-FIELD CONTROLLER'S----------*/
  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();
  TextEditingController usernameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();

  /*new*/
  TextEditingController birthDateController = TextEditingController();
  TextEditingController birthplaceController = TextEditingController();
  TextEditingController universityAttendedCtr = TextEditingController();
  TextEditingController dateOfEnrollmentCtr = TextEditingController();
  TextEditingController registerOfBelongingCtr = TextEditingController();
  String _selectedGender = '';
  TextEditingController dateOfQualification = TextEditingController();
  TextEditingController dateOfGraduation = TextEditingController();

/*----------API CONTROLLER INITIALIZATION---------*/
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());

  CustomView custom = CustomView();
  PageController controller = PageController();
String flag  = "IT";
  String code = '';
  bool _isHidden = true;
  int _curr = 0;
  final int _numpage = 2;

  String? slectedCategory;

  List<dynamic> slectedCat = [].toList();
  List<dynamic> slectedCatid = [].toList();

  List<String> listOFSelectedItem = [];

  String selectedText = "";

  String? catid;
  double? lat;

  //select date's
  var selectedIndexes = [];
  var selectedIndexes1 = [];

  List subCatIdArray = [];
  List subCatNameArray = [];
  List subCatIdArrayFinal = [];

  @override
  void initState() {
    doctorSignUpCtr.DoctorCategory();
    AppConst.LATITUDE;
    log("My latitude${AppConst.LATITUDE}");
    log("My location${AppConst.LOCATION}");
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          height: 35.0,
          decoration: const BoxDecoration(color: MyColor.midgray),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  custom.text("Do you have an account?", 11, FontWeight.normal,
                      MyColor.primary1),
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
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  _curr = value;
                  print("page index$value");
                  print("curr index$_curr");
                });
              },
              controller: controller,
              children: [
                signUp1(),
                signUp2(),
                signUp3(),
              ],
            ),
          ),
          SizedBox(
            height: 70,
            child: Column(
              children: [
                custom.text("$_curr/3", 13.0, FontWeight.w500, Colors.black),
                Obx(() {
                  if (doctorSignUpCtr.loadingotp.value) {
                    return custom.MyIndicator();
                  }
                  return custom.MyButton(context, "Go on", () {
                    print("My latitude AppCont : -- ${AppConst.LATITUDE}");
                    print("My LONGITUDE AppCont : -- ${AppConst.LONGITUDE}");
                    print("My Location AppCont : -- ${AppConst.LOCATION}");

                    if (validation(context)) {
                      doctorSignUpCtr
                          .doctorSignupOtp(context, emailCtr.text)
                          .then((value) {
                        if (value != "") {
                          var data = {
                            "name": nameCtr.text,
                            "surmane": surnameCtr.text,
                            "username": usernameCtr.text,
                            "email": emailCtr.text,
                            "phone": phoneCtr.text,
                            "password": passwordCtr.text,
                            /*new added*/
                            "birthDate": birthDateController.text,
                            "birthPlace": birthplaceController.text,
                            "universityAttended": universityAttendedCtr.text,
                            "dateOfEnrol": dateOfEnrollmentCtr.text,
                            "registerOfBelonging": registerOfBelongingCtr.text,
                            /*********/
                            "category": slectedCategory.toString(),
                            "imagename": degreefilename.toString(),
                            "imagebase": degreebaseimage.toString(),
                            "address": AppConst.LOCATION,
                            "code": code,
                            "flag":flag,
                            "lat": AppConst.LATITUDE,
                            "longitude": AppConst.LONGITUDE,
                            "subcat": subCatIdArray.join(','),
                            'gender': _selectedGender,
                            "graduationDate": dateOfGraduation.text,
                            "qualificationDate": dateOfQualification.text,
                          };
                          _curr == _numpage
                              ? Get.toNamed(RouteHelper.DSignUpOtp(),
                                  parameters: data, arguments: value)
                              : controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.bounceIn);
                        } else {}
                      });
                    }
                  },
                      MyColor.primary,
                      const TextStyle(
                          color: MyColor.white, fontFamily: "Poppins"));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget signUp1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 18.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Enter your name", 13.0, FontWeight.w500, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            custom.myField(context, nameCtr, "Your name", TextInputType.text),
            const SizedBox(
              height: 16.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Enter your surname", 13.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            custom.myField(
                context, surnameCtr, "Your surname", TextInputType.text),
            const SizedBox(
              height: 16.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Enter your username", 13.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            custom.myField(
                context, usernameCtr, "Your username", TextInputType.text),
            const SizedBox(
              height: 16.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Enter a valid email", 13.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            custom.myField(
                context, emailCtr, "Your email address", TextInputType.text),
            const SizedBox(
              height: 17,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Phone number", 13.0, FontWeight.w500, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 1,
              child: IntlPhoneField(
                controller: phoneCtr,
                decoration: const InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  constraints: BoxConstraints.expand(),
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                initialCountryCode: 'IT',
                onChanged: (phone) {
                  code = phone.countryCode;
                  log(phone.completeNumber);
                  flag = phone.countryISOCode;
                  log(flag);
                },
                onCountryChanged: (cod) {
                  code = cod.dialCode;
                  flag = cod.code;
                  log(flag);

                },
              ),
            ),
            const SizedBox(
              height: 17.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Create a password", 13.0, FontWeight.w500, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            custom.PasswordField(
                context,
                passwordCtr,
                "Enter Password",
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
                            color: MyColor.primary,
                            size: 20,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: MyColor.primary,
                            size: 20,
                          )),
                _isHidden),
          ],
        ),
      ),
    );
  }

  DateTime? startDate;

  String _displayText(DateTime? date) {
    if (date != null) {
      return date.toString().split(' ')[0];
    } else {
      return '';
    }
  }

  Widget signUp2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Date of birth", 13.0, FontWeight.w500, MyColor.primary1),
            ),
            Container(
                height: 45.0,
                width: MediaQuery.of(context).size.width / 0.9,
                padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(7)),
                child: TextFormField(
                  onTap: () async {
                    startDate = await pickDate();
                    birthDateController.text = _displayText(startDate);
                    setState(() {});
                  },
                  readOnly: true,
                  controller: birthDateController,
                  decoration: const InputDecoration(
                    hintText: "Select Date",
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon:
                        Icon(Icons.calendar_month, color: MyColor.primary),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                )),
            const SizedBox(
              height: 16.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Place of birth", 13.0, FontWeight.w500, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            custom.myField(context, birthplaceController, "Your birthplace",
                TextInputType.text),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("University attended", 13.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            custom.myField(context, universityAttendedCtr,
                "Your university attended", TextInputType.text),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Date of enrollment", 13.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            Container(
                height: 45.0,
                width: MediaQuery.of(context).size.width / 0.9,
                padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(7)),
                child: TextFormField(
                  onTap: () async {
                    startDate = await pickDate();
                    dateOfEnrollmentCtr.text = _displayText(startDate);
                    setState(() {});
                    print(dateOfEnrollmentCtr.text);
                  },
                  readOnly: true,
                  controller: dateOfEnrollmentCtr,
                  decoration: const InputDecoration(
                    hintText: "Select Date",
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon:
                        Icon(Icons.calendar_month, color: MyColor.primary),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                )),
            const SizedBox(
              height: 16,
            ),
            /**/
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Date of qualification", 13.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            Container(
                height: 45.0,
                width: MediaQuery.of(context).size.width / 0.9,
                padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(7)),
                child: TextFormField(
                  onTap: () async {
                    startDate = await pickDate();
                    dateOfQualification.text = _displayText(startDate);
                    setState(() {});
                    print(dateOfQualification.text);
                  },
                  readOnly: true,
                  controller: dateOfQualification,
                  decoration: const InputDecoration(
                    hintText: "Select Date",
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon:
                        Icon(Icons.calendar_month, color: MyColor.primary),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                )),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Date of graduation", 13.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            Container(
                height: 45.0,
                width: MediaQuery.of(context).size.width / 0.9,
                padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(7)),
                child: TextFormField(
                  onTap: () async {
                    startDate = await pickDate();
                    dateOfGraduation.text = _displayText(startDate);
                    setState(() {});
                    print(dateOfGraduation.text);
                  },
                  readOnly: true,
                  controller: dateOfGraduation,
                  decoration: const InputDecoration(
                    hintText: "Select Date",
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon:
                        Icon(Icons.calendar_month, color: MyColor.primary),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                )),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Register of belonging", 13.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            custom.myField(context, registerOfBelongingCtr,
                "Your register of belonging", TextInputType.text),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text(
                  "Gender", 13.0, FontWeight.w600, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Radio<String>(
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                          print(_selectedGender);
                        });
                      },
                    ),
                    title: const Text('Male'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    leading: Radio<String>(
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                          print(_selectedGender);
                        });
                      },
                    ),
                    title: const Text('Female'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget signUp3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Select your specializations", 13.0,
                  FontWeight.w500, MyColor.primary1),
            ),
            category(),
            const SizedBox(
              height: 17.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Select your sub-specializations", 13.0,
                  FontWeight.w500, MyColor.primary1),
            ),
            doctorListCtr.categoryLoadingSub.value
                ? custom.MyIndicator()
                : InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColor.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.black38,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 45,
                      child: const Center(
                        child: Text("select sub-category"),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 300,
                                width: double.maxFinite,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: const Align(
                                              alignment: Alignment.topRight,
                                              child:
                                                  Icon(Icons.close_outlined))),
                                      doctorListCtr.subCategory.isEmpty
                                          ? const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text("no sub category"),
                                            )
                                          : Expanded(
                                              child: ListView.builder(
                                              itemCount: doctorListCtr
                                                  .subCategory.length,
                                              itemBuilder: (context, index) {
                                                return StatefulBuilder(
                                                  builder: (context,
                                                      StateSetter setState) {
                                                    return Card(
                                                      elevation: 0.8,
                                                      child: CheckboxListTile(
                                                        tristate: true,
                                                        activeColor:
                                                            MyColor.primary,
                                                        dense: true,
                                                        title: Text(
                                                            doctorListCtr
                                                                .subCategory[
                                                                    index]
                                                                .subcatName),
                                                        value: selectedIndexes
                                                            .contains(index),
                                                        onChanged: (vale) {
                                                          setState(() {
                                                            if (selectedIndexes
                                                                .contains(
                                                                    index)) {
                                                              selectedIndexes
                                                                  .remove(
                                                                      index);
                                                              subCatIdArray.remove(
                                                                  doctorListCtr
                                                                      .subCategory[
                                                                          index]
                                                                      .subcatId);
                                                              // unselect
                                                            } else {
                                                              selectedIndexes
                                                                  .add(index);
                                                              subCatIdArray.add(
                                                                  doctorListCtr
                                                                      .subCategory[
                                                                          index]
                                                                      .subcatId);
                                                              log(".............$subCatIdArray");
                                                            }
                                                          });
                                                          log("Temp$selectedIndexes");
                                                          log("Temp$subCatIdArray");
                                                        },
                                                        controlAffinity:
                                                            ListTileControlAffinity
                                                                .trailing,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              shrinkWrap: true,
                                            ))
                                    ]),
                              ),
                            );
                          });
                    },
                  ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: subCatIdArray.length,
              itemBuilder: (context, index) {
                return Text(subCatIdArray[index]);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: GestureDetector(
            //     onTap: () {
            //       subCatIdArray.addAll(subCatIdArrayFinal);
            //       log("Tem$subCatIdArray");
            //       log("Final$subCatIdArrayFinal");
            //       subCatIdArray.clear();
            //     },
            //     child: Container(
            //         height: 25.0,
            //         width: 70.0,
            //         decoration: BoxDecoration(
            //           color: MyColor.primary,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: Center(
            //           child: Row(
            //                mainAxisAlignment: MainAxisAlignment.spaceAround,
            //               children: const [
            //             Text("Add more",
            //                 style: TextStyle(color: MyColor.white, fontSize: 10)),
            //             Icon(
            //               Icons.add,
            //               color: MyColor.white,
            //               size: 18,
            //             )
            //           ]),
            //         )),
            //   ),
            // ),
            // Text("$subCatIdArrayFinal"),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Upload your degree", 13.0, FontWeight.w500,
                  MyColor.primary1),
            ),
            const SizedBox(
              height: 5.0,
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: MyColor.white,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: Colors.black38,
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 45,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.upload),
                    ),
                    Text(
                      degreefilename.toString(),
                      style:
                          const TextStyle(fontSize: 10, color: Colors.black45),
                    ),
                  ],
                ),
              ),
              onTap: () {
                // AdharIdCtr.toString();
                _chooseDegree();
              },
            ),
            const SizedBox(
              height: 17.0,
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: custom.text("Select your address or offices", 13.0,
                  FontWeight.w500, MyColor.primary1),
            ),
            const SizedBox(
              height: 5.0,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.DSearchLocation());
                setState(() {});
                // Get.toNamed(RouteHelper.getViewCertificateScreen());
              },
              child: Container(
                  height: 50.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: MyColor.midgray,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: custom.text(AppConst.LOCATION, 12.0,
                              FontWeight.w500, MyColor.black),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 20.0,
                          color: MyColor.black,
                        ),
                      ],
                    ),
                  )),
            ),
            const SizedBox(
              height: 17.0,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

/*-------Validation----------*/
  bool validation(
    BuildContext context,
  ) {
    if (nameCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Name is required");
    } else if (surnameCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Surname is required");
    } else if (usernameCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Username is required");
    } else if (!RegExp('.*[a-z].*').hasMatch(usernameCtr.text.toString())) {
      custom.MySnackBar(
          context, "username should contain a lowercase letter a-z or number.");
    } else if (emailCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Email is required");
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailCtr.text.toString())) {
      custom.MySnackBar(context, "Enter valid email");
    } else if (phoneCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Phone no. is required");
    } else if (passwordCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Password is required");
    } else if (passwordCtr.text.toString().length < 6) {
      custom.MySnackBar(context, "Password should be 6 digit");
    } else if (birthDateController.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter birth date");
    } else if (birthplaceController.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter birthplace");
    } else if (universityAttendedCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter university attended");
    } else if (dateOfEnrollmentCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter date of enrollment");
    } else if (dateOfQualification.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter date of qualification");
    } else if (dateOfGraduation.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter date of graduation");
    } else if (registerOfBelongingCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter register of belonging");
    } else if (_selectedGender.isEmpty) {
      custom.MySnackBar(context, "Select gender");
    } else if (slectedCategory == null) {
      custom.MySnackBar(context, "Select your specialization");
    } else if (subCatIdArray.isEmpty) {
      custom.MySnackBar(context, "Select your sub-specialization");
    } else if (degreefilePath == null) {
      custom.MySnackBar(context, "Upload your degree");
    } else if (AppConst.LOCATION.isEmpty) {
      custom.MySnackBar(context, "Add your address");
    } else {
      return true;
    }
    return false;
  }

/*---------SELECT MULTIPLE CATEGORY-----*/
  Widget category() {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Center(
          child: Container(
            height: height * 0.06,
            width: widht * 0.9,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
            decoration: BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: MyColor.grey)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                menuMaxHeight: MediaQuery.of(context).size.height / 3,
                // Initial Value
                value: slectedCategory,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: MyColor.primary),
                // Array list of items
                items: doctorSignUpCtr.category.map((items) {
                  return DropdownMenuItem(
                    value: items.categoryId,
                    child: Text(items.categoryName),
                  );
                }).toList(),
                hint: const Text("Select Category"),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (newValue) {
                  stateSetter(() {
                    slectedCategory = newValue;
                    log('MY CATEGORY>>>$slectedCategory');
                  });
                  doctorListCtr.subCatList(slectedCategory!);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

// Widget subcategory() {
//   final height = MediaQuery.of(context).size.height;
//   final widht = MediaQuery.of(context).size.width;
//   return StatefulBuilder(
//     builder: (context, StateSetter stateSetter1) => Align(
//       alignment: AlignmentDirectional.centerEnd,
//       child: Center(
//         child:doctorListCtr.categoryLoadingSub.value?const Text("loading..."): Container(
//           height: height * 0.06,
//           width: widht*0.9,
//           padding: EdgeInsets.all(10),
//           margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
//           decoration: BoxDecoration(
//               color: MyColor.white,
//               borderRadius: BorderRadius.circular(8.0),
//               border: Border.all(color: MyColor.grey)),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton(
//               menuMaxHeight: MediaQuery.of(context).size.height / 3,
//               // Initial Value
//               value: slectedSubCategory,
//               // Down Arrow Icon
//               icon: const Icon(Icons.keyboard_arrow_down,
//                   color: MyColor.primary),
//               // Array list of items
//               items: doctorListCtr.subCategory.map((items) {
//                 return DropdownMenuItem(
//                   value: items.subcatId,
//                   child: Text(items.subcatName),
//                 );
//               }).toList(),
//               hint: const Text("Select Sub-Category"),
//               // After selecting the desired option,it will
//               // change button value to selected value
//               onChanged: (newValue) {
//                 stateSetter1(() {
//                   slectedSubCategory = newValue;
//                   print(slectedSubCategory);
//
//                 });
//               },
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
//  for Aadhar ID //

  /*----------UPLOAD DEGREE-----------*/
  File? degreefilePath;
  final degreepicker = ImagePicker();
  String degreebaseimage = "";
  String degreefilename = "";

  void _chooseDegree() async {
    final pickedFile = await degreepicker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 200,
        maxWidth: 200);
    setState(() {
      if (pickedFile != null) {
        degreefilePath = File(pickedFile.path);
        List<int> imageBytes = degreefilePath!.readAsBytesSync();
        degreebaseimage = base64Encode(imageBytes);
        degreefilename = DateTime.now().toString() + ".jpeg".toString();
        print(degreebaseimage);
        print(degreefilename);
      } else {
        print('No image selected.');
      }
    });
  }

  //*******date strt end************//
  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      keyboardType: const TextInputType.numberWithOptions(),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
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
}
