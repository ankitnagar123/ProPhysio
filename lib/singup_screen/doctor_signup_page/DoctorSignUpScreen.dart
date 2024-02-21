import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:latlong2/latlong.dart' as latLng;

import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../doctor_screens/controller/DoctorSignUpController.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../../patient_screens/controller/doctor_list_ctr/DoctorListController.dart';

class DoctorSignUpScreen extends StatefulWidget {
  const DoctorSignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DoctorSignUpScreen> createState() => _DoctorSignUpScreenState();
}

class _DoctorSignUpScreenState extends State<DoctorSignUpScreen> {
  LocalString text = LocalString();

  /*---------TEXT-FIELD CONTROLLER'S----------*/
  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();
  // TextEditingController usernameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();

  /*new*/
  TextEditingController birthDateController = TextEditingController();
  TextEditingController birthplaceController = TextEditingController();

  // TextEditingController universityAttendedCtr = TextEditingController();
  // TextEditingController dateOfEnrollmentCtr = TextEditingController();
  // TextEditingController registerOfBelongingCtr = TextEditingController();
  String _selectedGender = '';
  bool rememberme = false;

  // TextEditingController dateOfQualification = TextEditingController();
  // TextEditingController dateOfGraduation = TextEditingController();

  TextEditingController destinationController = TextEditingController();

  TextEditingController ageController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String location = ''; 
  String latitude = '';
  String longitude = '';

  // final kGoogleApiKey = "AIzaSyAA838tqJK4u1_Rzef1Qv2FtqFwm3T9bEA";
  final kGoogleApiKey = "AIzaSyDqyr7DbFRLoNkYFxsMtwoNo973uNhd440";

/*----------API CONTROLLER INITIALIZATION---------*/
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());

  CustomView custom = CustomView();
  PageController controller = PageController();

  String code = '+1876';
  String flag = 'JM';
  bool _isHidden = true;
  int _curr = 1;
  final int _numpage = 1;

  String? selectedBranch;
  String? slectedCategory;

  /*multiple services*/
  bool isDropdownOpen = false;
  List serviceIdArray = [];
  List serviceNameArray = [];

/*working day*/
  // List<String> selectedDays = [];
  // String selectedDaysList = "";

  /*Doctor Timing*/
  String? _StartTime;
  String? _endTime;

  String? catid;
  double? lat;

  //select date's
  // var selectedIndexes = [];
  // var selectedIndexes1 = [];

  // List subDummyCatIdArray = [];

  // List subCatIdArray = [];
  // List subCatNameArray = [];
  // List subCatIdArrayFinal = [];
  int selectedOption = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doctorSignUpCtr.branchListApi();
      // doctorSignUpCtr.doctorServices();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                      Get.back();
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(MyColor.red)),
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
        } else if (_curr == 3) {
          setState(() {
            controller.previousPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.bounceIn);
          });
        } else if (_curr == 2) {
          setState(() {
            controller.previousPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.bounceIn);
          });
        } else if (_curr == 1) {
          setState(() {
            controller.previousPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.bounceIn);
          });
        } else {}
        return false;
      },
      child: Scaffold(
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
                    custom.text(text.have_an_account.tr, 11, FontWeight.normal,
                        MyColor.primary1),
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
        body: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    _curr = 1 + value;
                    log("page index$value");
                    log("curr index$_curr");
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
                    return custom.MyButton(context, text.Go_On.tr, () {
                      if (_curr == 1) {
                        if (validation1(context) == false) {
                        } else {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 10),
                              curve: Curves.bounceIn);
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
                          log("$_curr $_numpage");
                          var data = {
                            "name": nameCtr.text,
                            "surname": surnameCtr.text,
                            "username": "",
                            "email": emailCtr.text,
                            "phone": phoneCtr.text,
                            "code": code,
                            "flag": flag,
                            "password": passwordCtr.text,

                            "birthDate": birthDateController.text,
                            "birthPlace": birthplaceController.text,
                            "age": ageController.text,
                            "experience": experienceController.text,
                            'gender': _selectedGender,
                            "address": location,
                            "lat": latitude,
                            "longitude": longitude,
                            "description": descriptionController.text,

                            "branch": selectedBranch.toString(),
                            "category": slectedCategory.toString(),
                            "services": serviceIdArray.join(','),
                            // "workingDays": selectedDaysList.toString(),
                            "startTime": _StartTime.toString(),
                            "endTime": _endTime.toString(),
                            "imagename": degreefilename.toString(),
                            "imagebase": degreebaseimage.toString(),
                          };
                          doctorSignUpCtr.doctorSignupOtpVerification(
                              context, code, phoneCtr.text, emailCtr.text, () {
                            log("gender$_selectedGender");
                            Get.toNamed(RouteHelper.DSignUpOtp(),
                                parameters: data);
                          });
                        }
                      }
                    },
                        MyColor.red,
                        const TextStyle(
                            color: MyColor.white, fontFamily: "Poppins"));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            child: Column(
              children: [
                const SizedBox(
                  height: 18.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Enter_Name.tr, 13.0, FontWeight.w500,
                      MyColor.primary1),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                custom.myField(
                    context, nameCtr, text.H_Enter_Name.tr, TextInputType.text),
                const SizedBox(
                  height: 16.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Enter_Surname.tr, 13.0,
                      FontWeight.w500, MyColor.primary1),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                custom.myField(context, surnameCtr, text.H_Enter_Surname.tr,
                    TextInputType.text),
                // const SizedBox(
                //   height: 16.0,
                // ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: custom.text(text.Enter_Username.tr, 13.0,
                //       FontWeight.w500, MyColor.primary1),
                // ),
                // const SizedBox(
                //   height: 3.0,
                // ),
                // custom.myField(context, usernameCtr, text.H_Enter_Username.tr,
                //     TextInputType.text),
                const SizedBox(
                  height: 16.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Enter_Email.tr, 13.0, FontWeight.w500,
                      MyColor.primary1),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                custom.myField(context, emailCtr, text.H_Enter_Email.tr,
                    TextInputType.text),
                const SizedBox(
                  height: 17,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Phone_Number.tr, 13.0,
                      FontWeight.w500, MyColor.primary1),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 1,
                  child: IntlPhoneField(
                    controller: phoneCtr,
                    decoration: InputDecoration(
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
                  child: custom.text(text.Create_Passsword.tr, 13.0,
                      FontWeight.w500, MyColor.primary1),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                custom.PasswordField(
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
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 25.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Date_of_Birth.tr, 13.0,
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
                        birthDateController.text = _displayText(startDate);
                        setState(() {});
                      },
                      readOnly: true,
                      controller: birthDateController,
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
                const SizedBox(
                  height: 16.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Place_of_Birth.tr, 13.0,
                      FontWeight.w500, MyColor.primary1),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                custom.myField(context, birthplaceController,
                    text.Place_of_Birth.tr, TextInputType.text),
                const SizedBox(
                  height: 16,
                ),
                /*---------------*new field*----------------------------------------------------*/
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      text.Age.tr, 13.0, FontWeight.w500, MyColor.primary1),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                custom.myField(
                    context, ageController, text.Age.tr, TextInputType.number),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.experience.tr, 13.0, FontWeight.w500,
                      MyColor.primary1),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                custom.myField(context, experienceController,
                    text.experience.tr, TextInputType.number),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      text.Gender.tr, 13.0, FontWeight.w500, MyColor.primary1),
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
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        leading: Radio<String>(
                          activeColor: MyColor.primary1,
                          value: 'Male',
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
                          activeColor: MyColor.primary1,
                          value: 'Female',
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
                SizedBox(
                  height: 3,
                ),
                const SizedBox(
                  height: 17.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Select_Address.tr, 13.0,
                      FontWeight.w500, MyColor.primary1),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: custom.searchField(
                      context,
                      destinationController,
                      location,
                      TextInputType.text,
                      const Text(""),
                      const Icon(Icons.search_rounded), () async {
                    var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: kGoogleApiKey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [],
                        onError: (err) {
                          print(err);
                        });
                    if (place != null) {
                      setState(() {
                        location = place.description.toString();
                      });

                      final plist = GoogleMapsPlaces(
                        apiKey: kGoogleApiKey,
                        // apiHeaders: await const GoogleApiHeaders().getHeaders(),
                      );
                      String placeId = place.placeId ?? "0";
                      final detail = await plist.getDetailsByPlaceId(placeId);
                      final geometry = detail.result.geometry!;
                      final lat = geometry.location.lat;
                      final lang = geometry.location.lng;
                      var newlatlang = latLng.LatLng(lat, lang);
                      log(newlatlang.latitude.toString());
                      log(newlatlang.longitude.toString());
                      log(">>>>>>>>>>>>>>>>>>", error: location);
                      try {
                        latitude = newlatlang.latitude.toString();
                        longitude = newlatlang.longitude.toString();
                        location = location.toString();
                      } catch (e) {
                        log("Exception :-- ${e.toString()}");
                      }
                      log("My latitude   : -- $latitude");
                      log("My LONGITUDE  : -- $longitude");
                      log("My location   : -- $location");
                    }
                  }, () {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUp3() {
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
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Select_Branch.tr, 13.0,
                      FontWeight.w500, MyColor.primary1),
                ),
                branch(),
                const SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Select_Category.tr, 13.0,
                      FontWeight.w500, MyColor.primary1),
                ),
               Obx(() =>  doctorSignUpCtr.categoryLoading.value?custom.MyIndicator():    category(),),
                const SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Select_Services.tr, 13.0,
                      FontWeight.w500, MyColor.primary1),
                ),
                selectServiceList(),
                if (isDropdownOpen)
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                      height: 120,
                      width: double.maxFinite,
                      child: Obx(() {
                        return Column(children: [
                          doctorSignUpCtr.services.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.all(17.0),
                                  child: Text("No Services"),
                                )
                              : doctorSignUpCtr.serviceLoading.value
                                  ? custom.MyIndicator()
                                  : Expanded(
                                      child: ListView.builder(
                                        padding:  EdgeInsets.all(0),
                                      itemCount:
                                          doctorSignUpCtr.services.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (serviceIdArray.contains(
                                                  doctorSignUpCtr
                                                      .services[index]
                                                      .serviceId)) {
                                                serviceIdArray.remove(
                                                    doctorSignUpCtr
                                                        .services[index]
                                                        .serviceId);
                                                serviceNameArray.remove(
                                                    doctorSignUpCtr
                                                        .services[index]
                                                        .serviceName);
                                              } else {
                                                serviceIdArray.add(
                                                    doctorSignUpCtr
                                                        .services[index]
                                                        .serviceId);
                                                serviceNameArray.add(
                                                    doctorSignUpCtr
                                                        .services[index]
                                                        .serviceName);
                                              }
                                              log("Service-Id-Array -${serviceIdArray.join(",")}");
                                              log("Service-Name-Array-${serviceNameArray.join(",")}");
                                            });
                                          },
                                          child: Card(
                                            color: Colors.white,
                                            elevation: 0.8,
                                            child: ListTile(

                                              trailing: serviceIdArray.contains(
                                                      doctorSignUpCtr
                                                          .services[index]
                                                          .serviceId)
                                                  ? const Icon(
                                                      Icons.task_alt,
                                                      color: MyColor.primary1,
                                                    )
                                                  : null,
                                              title: serviceIdArray.contains(
                                                      doctorSignUpCtr
                                                          .services[index]
                                                          .serviceId)
                                                  ? custom.text(
                                                      "${index + 1}. ${doctorSignUpCtr.services[index].serviceName.toUpperCase()}",
                                                      12,
                                                      FontWeight.w500,
                                                      MyColor.primary1)
                                                  : custom.text(
                                                      "${index + 1}. ${doctorSignUpCtr.services[index].serviceName.toUpperCase()}",
                                                      11,
                                                      FontWeight.w500,
                                                      MyColor.black),
                                            ),
                                          ),
                                        );
                                      },
                                      shrinkWrap: true,
                                    ))
                        ]);
                      }),
                    ),
                  ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: serviceNameArray.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(4),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: custom.text(
                            "${index + 1}. ${serviceNameArray[index]}",
                            12,
                            FontWeight.w400,
                            MyColor.black),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                /*  Align(
                    alignment: Alignment.topLeft,
                    child: custom.text("Select working days:", 13, FontWeight.w500,
                        MyColor.primary1)),
                for (String day in [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday'
                ])
                  Card(
                    child: CheckboxListTile.adaptive(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.all(0),
                      activeColor: MyColor.primary1,
                      checkColor: Colors.white,
                      title: custom.text(day, 13, FontWeight.w500, MyColor.black),
                      value: selectedDays.contains(day),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null && value) {
                            selectedDays.add(day);
                            selectedDaysList = jsonEncode(selectedDays);
                            log("days---$selectedDaysList");
                          } else {
                            selectedDays.remove(day);
                            selectedDaysList = jsonEncode(selectedDays);
                            log("days--$selectedDaysList");
                          }
                        });
                      },
                    ),
                  ),*/
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      "Select Timing", 13.0, FontWeight.w500, MyColor.primary1),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: _Starttime,
                        child: Container(
                          height: 47,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 07,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColor.black),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.timer_outlined,
                                color: MyColor.primary1,
                              ),
                              const VerticalDivider(
                                width: 18,
                                color: Colors.black38,
                                thickness: 1,
                              ),
                              custom.text(
                                  _StartTime != null
                                      ? _StartTime!
                                      : 'start time',
                                  14,
                                  FontWeight.w400,
                                  MyColor.black),
                              const SizedBox(
                                width: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: _endtime,
                        child: Container(
                          height: 47,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 07,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColor.black),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.timer_outlined,
                                color: MyColor.primary1,
                              ),
                              const VerticalDivider(
                                width: 18,
                                color: Colors.black38,
                                thickness: 1,
                              ),
                              custom.text(
                                  _endTime != null ? _endTime! : 'end time',
                                  14,
                                  FontWeight.w400,
                                  MyColor.black),
                              const SizedBox(
                                width: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.Upload_your_Degree.tr, 13.0,
                      FontWeight.w500, MyColor.primary1),
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
                          style: const TextStyle(
                              fontSize: 10, color: Colors.black45),
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
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(text.enterDescription.tr, 13.0,
                      FontWeight.w500, MyColor.primary1),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 3.0,
                ),
                custom.myFieldExpand(context, descriptionController,
                    text.enterDescription.tr, TextInputType.text),
                const SizedBox(
                  height: 5,
                ),
                MyCheckbox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

/*-------Validation----------*/
  bool validation1(
    BuildContext context,
  ) {
    if (nameCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Name is required");
    } else if (surnameCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Surname is required");
    }/* else if (usernameCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Username is required");
    } else if (!RegExp('.*[a-z].*').hasMatch(usernameCtr.text.toString())) {
      custom.MySnackBar(
          context, "username should contain a lowercase letter a-z or number.");
    } */else if (emailCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Email is required");
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailCtr.text.toString())) {
      custom.MySnackBar(context, "Enter valid email");
    } else if (phoneCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Phone no. is required");
    } else if (passwordCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Password is required");
    } else if (passwordCtr.text.toString().length < 6) {
      custom.MySnackBar(context, "Password should be 6 digit");
    }
    /* else if (_selectedService == "") {
      custom.MySnackBar(context, "Select first consultation fee");
    }*/
    else {
      return true;
    }
    return false;
  }

  bool validation2(
    BuildContext context,
  ) {
    if (birthDateController.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter birth date");
    } else if (birthplaceController.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter birth place");
    } else if (ageController.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter age");
    } else if (experienceController.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter year of experience");
    } else if (_selectedGender.isEmpty) {
      custom.MySnackBar(context, "Select gender");
    } else if (location.toString().isEmpty) {
      custom.MySnackBar(context, "Enter location");
    } else {
      return true;
    }
    return false;
  }

  bool validation3(
    BuildContext context,
  ) {
    if (selectedBranch == null) {
      custom.MySnackBar(context, "Select your branch");
    } else if (slectedCategory == null) {
      custom.MySnackBar(context, "Select your specialization");
    } else if (serviceIdArray.length == 0) {
      custom.MySnackBar(context, "Select your services");
    } else if (_StartTime == null) {
      custom.MySnackBar(context, "Select your start timing");
    } else if (_endTime == null) {
      custom.MySnackBar(context, "Select your start timing");
    } else if (degreefilePath == null) {
      custom.MySnackBar(context, "Upload your degree");
    } else if (longitude.isEmpty) {
      custom.MySnackBar(context, "Add your address");
    } else if (descriptionController.text.isEmpty) {
      custom.MySnackBar(context, "Enter description about specialization");
    } else if (rememberme == false) {
      custom.MySnackBar(
          context, "Accept Term Condition and Privacy Policy");
    }else {
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
            height: height * 0.06,
            width: widht * 0.9,
            padding: const EdgeInsets.only(left: 4),
            margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
            decoration: BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: MyColor.grey)),
            child: DropdownButtonHideUnderline(
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
                hint: Text(
                  text.Select_Branch.tr,
                  style: TextStyle(fontSize: 13),
                ),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (newValue) {
                  stateSetter(() {
                    selectedBranch = newValue;
                    log('MY CATEGORY>>>$selectedBranch');
                    doctorSignUpCtr.doctorCategory(selectedBranch.toString());

                  });
                  serviceNameArray.clear();
                  serviceIdArray.clear();
                   doctorSignUpCtr.doctorServices('',selectedBranch.toString());
                  setState(() {

                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

/*---------SELECT  CATEGORY-----*/
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
                hint: Text(
                  text.Select_Category.tr,
                  style: TextStyle(fontSize: 13),
                ),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (newValue) {
                  stateSetter(() {
                    slectedCategory = newValue;
                    log('MY CATEGORY>>>$slectedCategory');
                  });
                  doctorSignUpCtr.doctorServices(slectedCategory.toString(),selectedBranch.toString());
                  serviceNameArray.clear();
                  serviceIdArray.clear();
                  log("this for clear service Id Array---${serviceIdArray.join(",")}");
                  log("this for clear service Name Array---${serviceNameArray.join(',')}");
                  setState(() {});

                  /*doctorListCtr.subCatList(slectedCategory!);*/
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*---------SELECT Services Multiple-----*/
  Widget selectServiceList() {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) => Align(
        alignment: AlignmentDirectional.center,
        child: Obx(
          () => doctorSignUpCtr.serviceLoading.value
              ? custom.MyIndicator()
              : Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isDropdownOpen = !isDropdownOpen;
                      });
                    },
                    child: Container(
                        height: height * 0.06,
                        width: widht * 1,
                        padding: const EdgeInsets.only(left: 10),
                        margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
                        decoration: BoxDecoration(
                            color: MyColor.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: MyColor.grey)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width / 2.1,
                                    child: Text(
                                      serviceNameArray.isNotEmpty
                                          ? "${serviceNameArray.length.toString()} Service selected"
                                          : text.Select_Services.tr,
                                      style: TextStyle(fontSize: 13),
                                    )),
                                Icon(
                                    isDropdownOpen
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: MyColor.primary1),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
        ),
      ),
    );
  }


  Widget MyCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Wrap(
          children: [
            Checkbox(
              visualDensity: VisualDensity.compact,
              activeColor: MyColor.primary1,
              checkColor: Colors.white,
              value: rememberme,
              onChanged: (newValue) {
                setState(() {
                  rememberme = newValue!;
                  log("$rememberme");
                });
              },
            ),
          ],
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {},
            child: RichText(
              // textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Accept',
                  style: TextStyle(
                      color: Colors.black, fontSize: 11, fontFamily: "Lato"),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(
                            RouteHelper.DTandCScreen(),
                          );
                        },
                      text: ' Terms and Condition ',
                      style: TextStyle(
                          color: MyColor.primary1,
                          fontSize: 12,
                          fontFamily: "Lato"),
                    ),
                    TextSpan(
                      text: 'and ',
                      style: TextStyle(fontSize: 11, fontFamily: "Lato"),
                    ),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Get.toNamed(RouteHelper.getPrivacyPolicy());
                          },
                        text: ' Privacy Policy',
                        style:
                        TextStyle(color: MyColor.primary1, fontSize: 12)),
                  ]),
            ),
          ),
        ),
      ],
    );
  }


/*----------UPLOAD DEGREE-----------*/
  File? degreefilePath;
  final degreepicker = ImagePicker();
  String degreebaseimage = "";
  String degreefilename = "";

  void _chooseDegree() async {
    final pickedFile = await degreepicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
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

//*******date start end************//
  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      keyboardType: const TextInputType.numberWithOptions(),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
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

  Future<void> _Starttime() async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: MyColor.primary1,
                onPrimary: Colors.white, // header text color
                onSurface: Colors.brown, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
              ),
            ),
            child: child!,
          ),
        );
      },
    );
    if (result != null) {
      setState(() {
        _StartTime = result.format(context);
        log("$_StartTime");
      });
    }
  }

  Future<void> _endtime() async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true,),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: MyColor.primary1,
                  onPrimary: Colors.white, // header text color
                  onSurface: Colors.brown, // body text color
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                ),
              ),
              child: child!,
            ),
          );
        });
    if (result != null) {
      setState(() {
        _endTime = result.format(context);
        log("$_endTime");
      });
    }
  }

/*-----------Google Search------------------*/
  Future<Prediction?> showGoogleAutoComplete(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: kGoogleApiKey,
      components: [],
      types: [],
      hint: text.SearchAddress.tr,
    );
    return p;
  }
}
