import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:latlong2/latlong.dart' as latLng;

import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/DoctorProfileController.dart';
import '../../../../controller/DoctorSignUpController.dart';

class DoctorPersonalData extends StatefulWidget {
  const DoctorPersonalData({Key? key}) : super(key: key);

  @override
  State<DoctorPersonalData> createState() => _DoctorPersonalDataState();
}

class _DoctorPersonalDataState extends State<DoctorPersonalData> {
  DoctorProfileCtr doctorProfileCtr = Get.put(DoctorProfileCtr());
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());

  CustomView customView = CustomView();
  LocalString text = LocalString();

  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surename = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  String location = '';

  // final kGoogleApiKey = "AIzaSyAA838tqJK4u1_Rzef1Qv2FtqFwm3T9bEA";
  final kGoogleApiKey = "AIzaSyDqyr7DbFRLoNkYFxsMtwoNo973uNhd440";

  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();

/*new*/
  TextEditingController birthDateController = TextEditingController();
  TextEditingController birthplaceController = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController descriptionCtr = TextEditingController();
  String latitude = "";
  String longitude = "";
  String files = "";
  String dFiles = "";
  String code = '';
  String flag = '';
  String _selectedGender = '';
  String _selectedService = '';
  bool isDropdownOpen = false;
  List serviceIdArray = [];
  List serviceNameArray = [];
  String? selectedBranch;
  String? slectedCategory;

  List<String> allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List backendDays = [];
  String selectedDaysList = "";
  Map<String, bool> checkboxValues = {}; // Map to store checkbox states
  String? _StartTime;
  String? _endTime;

/*------FOR PROFILE------*/
  File? file;
  final picker = ImagePicker();
  String baseimage = "";
  String imagename = "";

  void _choose(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        List<int> imageBytes = file!.readAsBytesSync();
        baseimage = base64Encode(imageBytes);
        imagename = 'image_${DateTime.now().millisecondsSinceEpoch}_.jpg';
        Get.back();
      } else {
        print('No image selected.');
      }
    });
  }

/*----------FOR DEGREE-----------*/
  File? dFile;
  final dPicker = ImagePicker();
  String dBaseImage = "";
  String dImageName = "";

  void _chooseDegree(ImageSource source) async {
    final pickedFile1 = await dPicker.pickImage(
      source: source,
      imageQuality: 100,
    );
    setState(() {
      if (pickedFile1 != null) {
        dFile = File(pickedFile1.path);
        List<int> imageBytes = dFile!.readAsBytesSync();
        dBaseImage = base64Encode(imageBytes);
        dImageName = 'image_${DateTime.now().millisecondsSinceEpoch}_.jpg';
        Get.back();
      } else {
        print('No image selected.');
      }
    });
  }

/*-----------------------------------------*/
  DateTime? startDate;
  DateTime? startDate1;
  DateTime? startDate2;

  String _displayText(DateTime? date) {
    if (date != null) {
      return date.toString().split(' ')[0];
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doctorProfileCtr.doctorProfile(context);
      doctorSignUpCtr.branchListApi();
      doctorSignUpCtr.doctorCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Obx(() {
      if (doctorProfileCtr.resultVar.value == 1) {
        doctorProfileCtr.resultVar.value = 0;
        userNameCtrl.text = doctorProfileCtr.username.value;
        print("user ka email===-${doctorProfileCtr.Email.value}");
        emailCtrl.text = doctorProfileCtr.Email.value;
        name.text = doctorProfileCtr.name.value;
        descriptionCtr.text = doctorProfileCtr.description.value;
        files = doctorProfileCtr.image.value.toString();
        dFiles = doctorProfileCtr.degree.value.toString();
        surename.text = doctorProfileCtr.surename.value;
        phoneNumberCtrl.text = doctorProfileCtr.phone.value;
        addressCtrl.text = doctorProfileCtr.location.value;
        /*new*/
        _selectedGender = doctorProfileCtr.gender.value;
        print("user ka gender$_selectedGender");

        birthDateController.text = doctorProfileCtr.dateOfBirth.value;
        birthplaceController.text = doctorProfileCtr.placeOfBirth.value;

        flag = doctorProfileCtr.flag.value;
        age.text = doctorProfileCtr.age.value;
        experience.text = doctorProfileCtr.experience.value;
        descriptionCtr.text = doctorProfileCtr.description.value;
        _selectedService = doctorProfileCtr.firstService.value;
        selectedBranch = doctorProfileCtr.branchId.value;
        slectedCategory = doctorProfileCtr.slectedCategory.value;

        location = doctorProfileCtr.location.value;
        latitude = doctorProfileCtr.lat.value;
        longitude = doctorProfileCtr.lang.value;

        /*API*/
        doctorSignUpCtr.doctorServices(slectedCategory.toString());
        _StartTime = doctorProfileCtr.sTime.value;
        _endTime = doctorProfileCtr.eTime.value;

        serviceIdArray =
            doctorProfileCtr.profileDetails.value!.service.map((serviceId) {
          return serviceId.id;
        }).toList();
        log("service ids${serviceIdArray.join(",")}");
        /*service name'''''*/
        serviceNameArray =
            doctorProfileCtr.profileDetails.value!.service.map((serviceId) {
          return serviceId.naam;
        }).toList();
        log("service name${serviceNameArray.join(",")}");

        backendDays =
            doctorProfileCtr.profileDetails.value!.totalDay.map((serviceId) {
          return serviceId.day;
        }).toList();
        log("Days ids${backendDays.join(",")}");
        for (String day in allDays) {
          checkboxValues[day] = backendDays.contains(day);
        }

        print("date of birth======${doctorProfileCtr.dateOfBirth.value}");
      }
      return Obx(() {
        return Scaffold(
          appBar: AppBar(
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(4.0),
                child: Divider(color: MyColor.midgray)),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: customView.text(
                text.Profile.tr, 15.0, FontWeight.w500, Colors.black),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white24,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: MyColor.primary1.withOpacity(0.3))
                ),
                child: doctorProfileCtr.loading.value
                    ? Center(heightFactor: 13.0, child: customView.MyIndicator())
                    : Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(120.0),
                                    child: file == null
                                        ? InkWell(
                                            onTap: () {
                                              imagePopUp(context, files);
                                            },
                                            child: FadeInImage.assetNetwork(
                                              imageErrorBuilder: (c, o, s) =>
                                                  Image.asset(
                                                      "assets/images/dummyprofile.png",
                                                      width: 90,
                                                      height: 90,
                                                      fit: BoxFit.cover),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                              placeholder:
                                                  "assets/images/loading.gif",
                                              image: files,
                                              placeholderFit: BoxFit.cover,
                                            ),
                                          )
                                        : Image.file(file!,
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.fill),
                                  ),
                                  Positioned(
                                    bottom: -10.0,
                                    right: -5.0,
                                    child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  content: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          _choose(
                                                              ImageSource.gallery);
                                                        },
                                                        child: const Row(
                                                          children: [
                                                            Icon(Icons.image,
                                                                size: 20),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Image from gallery",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          _choose(ImageSource.camera);
                                                        },
                                                        child: const Row(
                                                          children: [
                                                            Icon(Icons.camera_alt),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Image from camera",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        icon: const CircleAvatar(
                                          radius: 13,
                                          backgroundColor: MyColor.iconColor,
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 13.0,
                                            color: MyColor.white,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            customView.text(text.H_Enter_Username.tr, 10.0,
                                FontWeight.w600, MyColor.black),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            customView.myField(context, userNameCtrl,
                                text.H_Enter_Username.tr, TextInputType.text),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customView.text(text.H_Enter_Name.tr, 10.0,
                                          FontWeight.w600, MyColor.black),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      customView.myField(context, name,
                                          text.H_Enter_Name.tr, TextInputType.text),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customView.text(text.H_Enter_Surname.tr, 10.0,
                                          FontWeight.w600, MyColor.black),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      customView.myField(
                                          context,
                                          surename,
                                          text.H_Enter_Surname.tr,
                                          TextInputType.text),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            customView.text(text.yourUsernameEmail.tr, 10.0,
                                FontWeight.w600, MyColor.black),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SizedBox(
                              width: widht,
                              child: TextFormField(
                                enabled: false,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.black,
                                controller: emailCtrl,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(top: 3, left: 20),
                                  hintText: text.yourUsernameEmail.tr,
                                  hintStyle: const TextStyle(fontSize: 12),
                                  filled: true,
                                  fillColor: MyColor.white,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            customView.text(text.yourContact.tr, 10.0,
                                FontWeight.w600, MyColor.black),
                            SizedBox(
                              height: height * 0.012,
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 1,
                              child: IntlPhoneField(
                                controller: phoneNumberCtrl,
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
                                  flag = phone.countryISOCode;
                                  log(flag);
                                  code = phone.countryCode;
                                  log("code$code");
                                  log(phone.completeNumber);
                                },
                                onCountryChanged: (cod) {
                                  flag = cod.code;
                                  log(flag);
                                  code = cod.dialCode;
                                },
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            customView.text(text.yourAddres.tr, 10.0, FontWeight.w600,
                                MyColor.black),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: customView.searchField(
                                  context,
                                  addressCtrl,
                                  "Enter address",
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
                                  final detail =
                                      await plist.getDetailsByPlaceId(placeId);
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
                                    addressCtrl.text = location.toString();
                                  } catch (e) {
                                    print("Exception :-- ${e.toString()}");
                                  }
                                  print("My latitude AppCont : -- $latitude");
                                  print("My LONGITUDE AppCont : -- $longitude");
                                  print(
                                      "My address AppCont : -- ${addressCtrl.text}");
                                }
                              }, () {}),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customView.text(text.Date_of_Birth.tr, 10.0,
                                          FontWeight.w600, MyColor.black),
                                      SizedBox(
                                        height: height * 0.005,
                                      ),
                                      Container(
                                          height: 48.0,
                                          width:
                                              MediaQuery.of(context).size.width / 2.3,
                                          padding: const EdgeInsets.only(
                                              left: 10.0, bottom: 5),
                                          margin: const EdgeInsets.fromLTRB(
                                              0.0, 5.0, 0.0, 0.0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(7)),
                                          child: TextFormField(
                                            onTap: () async {
                                              startDate = await pickDate();
                                              birthDateController.text =
                                                  _displayText(startDate);
                                            },
                                            readOnly: true,
                                            controller: birthDateController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(top: 8),
                                              hintText: text.Select_Date.tr,
                                              hintStyle:
                                                  const TextStyle(fontSize: 12),
                                              suffixIcon: const Icon(
                                                  Icons.calendar_month,
                                                  color: MyColor.primary),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customView.text(text.yourBirthplace.tr, 10.0,
                                          FontWeight.w600, MyColor.black),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      customView.myField(
                                          context,
                                          birthplaceController,
                                          text.yourBirthplace.tr,
                                          TextInputType.text),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                                /*-new-*/
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customView.text(text.yourAge.tr, 10.0,
                                          FontWeight.w600, MyColor.black),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      customView.myField(context, age, text.Age.tr,
                                          TextInputType.number),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customView.text(text.experience.tr, 10.0,
                                          FontWeight.w600, MyColor.black),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      customView.myField(context, experience,
                                          text.experience.tr, TextInputType.number),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            /* Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customView.text(text.yourGraduationDate.tr,
                                          10.0, FontWeight.w600, MyColor.black),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Container(
                                          height: 48.0,
                                          width:
                                              MediaQuery.of(context).size.width / 2.3,
                                          padding: const EdgeInsets.only(
                                              left: 10.0, bottom: 5),
                                          margin: const EdgeInsets.fromLTRB(
                                              0.0, 5.0, 0.0, 0.0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(7)),
                                          child: TextFormField(
                                            onTap: () async {
                                              startDate = await pickDate();
                                              dateOfGraduation.text =
                                                  _displayText(startDate);
                                              print(dateOfGraduation.text);
                                            },
                                            readOnly: true,
                                            controller: dateOfGraduation,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(top: 7),
                                              hintText: text.Select_Date.tr,
                                              hintStyle:
                                                  const TextStyle(fontSize: 14),
                                              suffixIcon: Icon(Icons.calendar_month,
                                                  color: MyColor.primary),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customView.text(text.Date_of_Qualification.tr,
                                          10.0, FontWeight.w600, MyColor.black),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Container(
                                          height: 48.0,
                                          width:
                                              MediaQuery.of(context).size.width / 2.3,
                                          padding: const EdgeInsets.only(
                                              left: 10.0, bottom: 5),
                                          margin: const EdgeInsets.fromLTRB(
                                              0.0, 5.0, 0.0, 0.0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(7)),
                                          child: TextFormField(
                                            onTap: () async {
                                              startDate = await pickDate();
                                              dateOfQualification.text =
                                                  _displayText(startDate);
                                              print(dateOfQualification.text);
                                            },
                                            readOnly: true,
                                            controller: dateOfQualification,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(top: 7),
                                              hintText: text.Select_Date.tr,
                                              hintStyle:
                                                  const TextStyle(fontSize: 14),
                                              suffixIcon: Icon(Icons.calendar_month,
                                                  color: MyColor.primary),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),*/
                            customView.text(text.Select_Branch.tr, 10.0,
                                FontWeight.w600, MyColor.black),
                            branch(),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            customView.text(text.category.tr, 10.0, FontWeight.w600,
                                MyColor.black),
                            category(),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: customView.text(text.Select_Services.tr, 10.0,
                                  FontWeight.w600, MyColor.black),
                            ),
                            selectServiceList(),
                            if (isDropdownOpen)
                              Card(
                                color: Colors.white,
                                elevation: 2,
                                margin: EdgeInsets.zero,
                                child: SizedBox(
                                  height: 250,
                                  width: double.maxFinite,
                                  child: Obx(() {
                                    return Column(children: [
                                      doctorSignUpCtr.services.isEmpty
                                          ? const Padding(
                                              padding: EdgeInsets.all(17.0),
                                              child: Text("No Services"),
                                            )
                                          : doctorSignUpCtr.serviceLoading.value
                                              ? customView.MyIndicator()
                                              : Expanded(
                                                  child: ListView.builder(
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
                                                          // leading: ClipRRect(
                                                          //   child: FadeInImage.assetNetwork(
                                                          //     imageErrorBuilder: (c, o, s) =>
                                                          //         Image.asset(
                                                          //             "assets/images/noimage.png",
                                                          //             width: 40,
                                                          //             height: 40,
                                                          //             fit: BoxFit.cover),
                                                          //     width: 45,
                                                          //     height: 45,
                                                          //     fit: BoxFit.cover,
                                                          //     placeholder:
                                                          //         "assets/images/loading.gif",
                                                          //     image: doctorSignUpCtr
                                                          //         .services[index].image
                                                          //         .toString(),
                                                          //     placeholderFit: BoxFit.cover,
                                                          //   ),
                                                          // ),
                                                          trailing:
                                                              serviceIdArray.contains(
                                                                      doctorSignUpCtr
                                                                          .services[
                                                                              index]
                                                                          .serviceId)
                                                                  ? const Icon(
                                                                      Icons.task_alt,
                                                                      color: MyColor
                                                                          .primary1,
                                                                    )
                                                                  : null,
                                                          title: serviceIdArray
                                                                  .contains(
                                                                      doctorSignUpCtr
                                                                          .services[
                                                                              index]
                                                                          .serviceId)
                                                              ? customView.text(
                                                                  "${index + 1}. ${doctorSignUpCtr.services[index].serviceName.toUpperCase()}",
                                                                  12,
                                                                  FontWeight.w500,
                                                                  MyColor.primary1)
                                                              : customView.text(
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
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: serviceNameArray.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: const EdgeInsets.all(4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: customView.text(
                                        "${index + 1}. ${serviceNameArray[index]}",
                                        12,
                                        FontWeight.w400,
                                        MyColor.black),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: customView.text("Working days:", 10,
                                    FontWeight.w600, MyColor.black)),
                            Column(
                              children: allDays.map((day) {
                                return Card(
                                  child: CheckboxListTile(
                                    visualDensity: VisualDensity.compact,
                                    activeColor: MyColor.primary1,
                                    checkColor: MyColor.white,
                                    controlAffinity: ListTileControlAffinity.platform,
                                    title: customView.text(
                                        day, 12.0, FontWeight.w500, MyColor.black),
                                    value: checkboxValues[day],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        checkboxValues[day] = value!;
                                        List<String> selectedDays = [];
                                        checkboxValues.forEach((day, isSelected) {
                                          if (isSelected ?? false) {
                                            selectedDays.add(day);
                                            selectedDaysList =
                                                jsonEncode(selectedDays);
                                            log("days1---$selectedDaysList");
                                          }
                                        });
                                        log('Selected Days: ${selectedDays.join(',')}');
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: customView.text(
                                  "Timing", 10.0, FontWeight.w600, MyColor.black),
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
                                          customView.text(
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
                                          customView.text(
                                              _endTime != null
                                                  ? _endTime!
                                                  : 'end time',
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
                            SizedBox(
                              height: height * 0.02,
                            ),
                            /*-new-*/
                            customView.text(text.yourGender.tr, 10.0, FontWeight.w600,
                                MyColor.black),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4),
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
                                    visualDensity: const VisualDensity(
                                        horizontal: -4, vertical: -4),
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
                              height: height * 0.01,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: customView.text(text.certificates.tr, 13.0,
                                  FontWeight.w500, Colors.black),
                            ),
                            Stack(children: [
                              InkWell(
                                onTap: () {
                                  imagePopUp(context, dFiles);
                                },
                                child: Card(
                                  child: dFile == null
                                      ? FadeInImage.assetNetwork(
                                          imageErrorBuilder: (c, o, s) => Image.asset(
                                              "assets/images/dummyprofile.png",
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover),
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          placeholder: "assets/images/loading.gif",
                                          image: dFiles,
                                          placeholderFit: BoxFit.cover,
                                        )
                                      : Image.file(dFile!,
                                          width: 120, height: 120, fit: BoxFit.fill),
                                ),
                              ),
                              Positioned(
                                bottom: -10.0,
                                right: -10.0,
                                child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              content: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      _chooseDegree(
                                                          ImageSource.gallery);
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        Icon(Icons.image, size: 20),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "Image from gallery",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      _chooseDegree(
                                                          ImageSource.camera);
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        Icon(Icons.camera_alt),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "Image from camera",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: const CircleAvatar(
                                      radius: 13,
                                      backgroundColor: MyColor.iconColor,
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 13.0,
                                        color: MyColor.white,
                                      ),
                                    )),
                              ),
                            ]),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            customView.text("Your description", 10.0, FontWeight.w600,
                                MyColor.black),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            customView.myFieldExpand(context, descriptionCtr,
                                text.yourbio.tr, TextInputType.text),
                          ],
                        ),
                    ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
            child: AnimatedButton(
              // width: MediaQuery.of(context).size.width * 0.8,
              text: text.saveProfile.tr,
              color: MyColor.primary,
              pressEvent: () {
                List<String> selectedDays = [];
                checkboxValues.forEach((day, isSelected) {
                  if (isSelected ?? false) {
                    selectedDays.add(day);
                    selectedDaysList = jsonEncode(selectedDays);
                    log("days1---$selectedDaysList");
                  }
                });
                doctorProfileCtr.doctorProfileUpdate(
                    context,
                    selectedBranch.toString(),
                    name.text,
                    surename.text,
                    userNameCtrl.text,
                    emailCtrl.text,
                    slectedCategory.toString(),
                    serviceIdArray.join(','),
                    flag,
                    code,
                    phoneNumberCtrl.text,
                    "",
                    _selectedGender.toString(),
                    location,
                    latitude,
                    longitude,
                    birthDateController.text,
                    birthplaceController.text,
                    age.text,
                    descriptionCtr.text,
                    experience.text,
                    _StartTime.toString(),
                    _endTime.toString(),
                    dImageName,
                    dBaseImage,
                    selectedDaysList,
                    imagename,
                    baseimage, () {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.leftSlide,
                    headerAnimationLoop: false,
                    dialogType: DialogType.success,
                    showCloseIcon: true,
                    title: text.success.tr,
                    desc: text.ProfileUpdateSuccessfully.tr,
                    btnOkOnPress: () {
                      debugPrint('OnClick');
                    },
                    btnOkIcon: Icons.check_circle,
                    onDismissCallback: (type) {
                      debugPrint('Dialog Dismiss from callback $type');
                    },
                  ).show();
                });
                // doctorProfileCtr.doctorProfileUpdate(
                //   context,
                //   name.text,
                //   surename.text,
                //   userNameCtrl.text,
                //   bioCtrl.text,
                //   location,
                //   latitude,
                //   longitude,
                //   code,
                //   emailCtrl.text,
                //   phoneNumberCtrl.text,
                //   imagename,
                //   baseimage,
                //   _selectedGender,
                //   birthDateController.text,
                //   birthplaceController.text,
                //   "",
                //   "",
                //   "",
                //   "",
                //   "",
                //   age.text,
                //   experience.text,
                //   descriptionCtr.text,
                //   _selectedService.toString(),
                //   flag,
                //   selectedBranch.toString(),
                //   slectedCategory.toString(),
                //       "doc","docstr",
                //       () {
                //
                //   },
                // );
                /* doctorProfileCtr.doctorProfileUpdate(
                  context,
                  name.text,
                  surename.text,
                  userNameCtrl.text,
                  bioCtrl.text,
                  addressCtrl.text,
                  latitude,
                  longitude,
                  code,
                  emailCtrl.text,
                  phoneNumberCtrl.text,
                  imagename,
                  baseimage,
                  _selectedGender,
                  birthDateController.text,
                  birthplaceController.text,
                  universityAttendedCtr.text,
                  dateOfEnrollmentCtr.text,
                  registerOfBelongingCtr.text,
                  dateOfQualification.text,
                  dateOfGraduation.text,
                  flag,
                  age.text,
                  experience.text,
                  descriptionCtr.text,
                  _selectedService.toString(),
                  () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.leftSlide,
                      headerAnimationLoop: false,
                      dialogType: DialogType.success,
                      showCloseIcon: true,
                      title: text.success.tr,
                      desc: text.ProfileUpdateSuccessfully.tr,
                      btnOkOnPress: () {
                        debugPrint('OnClick');
                      },
                      btnOkIcon: Icons.check_circle,
                      onDismissCallback: (type) {
                        debugPrint('Dialog Dismiss from callback $type');
                      },
                    ).show();
                  },
                );*/
              },
            ),
          ),
        );
      });
    });
  }

//*******date strt end************//
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

  void imagePopUp(BuildContext context, String image) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InteractiveViewer(
                      panEnabled: false,
                      // Set it to false
                      boundaryMargin: const EdgeInsets.all(100),
                      minScale: 0.5,
                      maxScale: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FadeInImage.assetNetwork(
                          imageErrorBuilder: (context, error, stackTrace) {
                            return const Image(
                                image: AssetImage("assets/images/noimage.png"));
                          },
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.cover,
                          placeholder: "assets/images/loading.gif",
                          image: image,
                          placeholderFit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
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
            width: widht * 1,
            padding: const EdgeInsets.only(left: 10),
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
                  doctorSignUpCtr.doctorServices(slectedCategory.toString());
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
              ? customView.MyIndicator()
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
          return Theme(
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
          );
        });
    if (result != null) {
      setState(() {
        _endTime = result.format(context);
        log("$_endTime");
      });
    }
  }
}
