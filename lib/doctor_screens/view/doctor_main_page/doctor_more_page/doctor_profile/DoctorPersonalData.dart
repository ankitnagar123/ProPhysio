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
  TextEditingController bioCtrl = TextEditingController();
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

  String? selectedBranch;
  String? slectedCategory;

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
        imagename = 'image_${DateTime
            .now()
            .millisecondsSinceEpoch}_.jpg';
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
        dImageName = 'image_${DateTime
            .now()
            .millisecondsSinceEpoch}_.jpg';
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
      doctorSignUpCtr.DoctorCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Obx(() {
      if (doctorProfileCtr.resultVar.value == 1) {
        doctorProfileCtr.resultVar.value = 0;
        userNameCtrl.text = doctorProfileCtr.username.value;
        print("user ka email===-${doctorProfileCtr.Email.value}");
        emailCtrl.text = doctorProfileCtr.Email.value;
        name.text = doctorProfileCtr.name.value;
        bioCtrl.text = doctorProfileCtr.bio.value;
        print("user ka bio${bioCtrl.text}");
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
        /*universityAttendedCtr.text = doctorProfileCtr.universityAttended.value;
        dateOfEnrollmentCtr.text = doctorProfileCtr.dateOfEnrollment.value;
        registerOfBelongingCtr.text =
            doctorProfileCtr.registerOfBelonging.value;
        dateOfQualification.text = doctorProfileCtr.dateOfQualification.value;
        dateOfGraduation.text = doctorProfileCtr.dateOfGraduation.value;*/
        flag = doctorProfileCtr.flag.value;

        age.text = doctorProfileCtr.age.value;
        experience.text = doctorProfileCtr.experience.value;
        descriptionCtr.text = doctorProfileCtr.description.value;
        _selectedService = doctorProfileCtr.firstService.value;
        selectedBranch = doctorProfileCtr.branchId.value;
        slectedCategory = doctorProfileCtr.slectedCategory.value;
        print("date  q======${doctorProfileCtr.dateOfQualification.value}");

        print("date of birth======${doctorProfileCtr.dateOfBirth.value}");
      }
      return Obx(() {
        return Scaffold(
          appBar: AppBar(
              bottom: const PreferredSize(
                  child: Divider(color: MyColor.midgray),
                  preferredSize: Size.fromHeight(4.0)),
        /*    actions: [
              InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.DProfile());
                  },
                  child: const Icon(
                    color: MyColor.black,
                    Icons.edit,
                    size: 19.0,
                  )),
              const SizedBox(
                width: 10,
              ),
            ],*/
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: doctorProfileCtr.loading.value
                ? Center(heightFactor: 13.0, child: customView.MyIndicator())
                : Column(
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
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover),
                            width: 110,
                            height: 110,
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
                customView.text(text.yourbio.tr, 10.0, FontWeight.w600,
                    MyColor.black),
                SizedBox(
                  height: height * 0.01,
                ),
                customView.myField(context, bioCtrl, text.yourbio.tr,
                    TextInputType.text),
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
                customView.myField(context, emailCtrl,
                    text.yourUsernameEmail.tr, TextInputType.text),
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
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2.3,
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
                                  suffixIcon: const Icon(Icons.calendar_month,
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
                              text.experience.tr, TextInputType.text),
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
                customView.text(text.category.tr, 10.0,
                    FontWeight.w600, MyColor.black),
                category(),
                SizedBox(
                  height: height * 0.02,
                ),
                customView.text(text.yourContact.tr, 10.0,
                    FontWeight.w600, MyColor.black),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1,
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
                        visualDensity: const VisualDensity(
                            horizontal: -4, vertical: -4),
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
                SizedBox(
                  height: height * 0.01,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: customView.text(
                      text.certificates.tr, 13.0, FontWeight.w500, Colors.black),
                ),
                Stack(
                  children:[
                    InkWell(
                    onTap:  () {
                      imagePopUp(context,dFiles);
                    },
                    child: Card(
                      child: dFile == null
                          ?FadeInImage.assetNetwork(
                        imageErrorBuilder: (c, o, s) =>
                            Image.asset(
                                "assets/images/dummyprofile.png",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        placeholder:
                        "assets/images/loading.gif",
                        image: dFiles,
                        placeholderFit: BoxFit.cover,
                      ) : Image.file(dFile!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.fill),
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
                                            _chooseDegree(ImageSource.camera);
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
                        ]
                ),
                /* customView.text(text.firstConsultation.tr, 10.0,
                          FontWeight.w600, MyColor.black),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -4),
                                leading: Radio<String>(
                                  activeColor: MyColor.red,
                                  value: 'Free',
                                  groupValue: _selectedService,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedService = value!;
                                      print(_selectedService);
                                    });
                                  },
                                ),
                                title: customView.text("Free", 14,
                                    FontWeight.w500, MyColor.primary1)),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -4),
                                leading: Radio<String>(
                                  activeColor: MyColor.red,
                                  value: 'Paid',
                                  groupValue: _selectedService,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedService = value!;
                                      print(_selectedService);
                                    });
                                  },
                                ),
                                title: customView.text("Paid", 14,
                                    FontWeight.w500, MyColor.primary1)),
                          ),

                          */
                /*Transform.scale(
                  scale: 0.9,
                  child: Radio(
                    value: 1,
                    groupValue: selectedOption,
                    onChanged: (value) {
                        setState(() {
                          radioButtonItem = 'Free';
                      });
                    },
                  ),
                ),
                Radio(
                  value: 2,
                  groupValue: selectedOption,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Paid';
                    });
                  },
                ),*/
                /*
                        ],
                      ),*/
              ],

            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: AnimatedButton(
              // width: MediaQuery.of(context).size.width * 0.8,
              text: text.saveProfile.tr,
              color: MyColor.primary,
              pressEvent: () {
                doctorProfileCtr.doctorProfileUpdate(
                  context,
                  name.text,
                  surename.text,
                  userNameCtrl.text,
                  bioCtrl.text,
                  location,
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
                  "",
                  "",
                  "",
                  "",
                  "",
                  age.text,
                  experience.text,
                  descriptionCtr.text,
                  _selectedService.toString(),
                  flag,
                  selectedBranch.toString(),
                  slectedCategory.toString(),
                      "doc","docstr",
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
                );
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
            )
            ,
          )
          ,
        );
      });
    }

    );
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
        MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.5,
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
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) =>
          Align(
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
                    menuMaxHeight: MediaQuery
                        .of(context)
                        .size
                        .height / 3,
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
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) =>
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Center(
              child: Container(
                height: height * 0.06,
                width: widht * 1,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
                decoration: BoxDecoration(
                    color: MyColor.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: MyColor.grey)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    menuMaxHeight: MediaQuery
                        .of(context)
                        .size
                        .height / 3,
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
                    hint: Text(text.Select_Category.tr),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (newValue) {
                      stateSetter(() {
                        slectedCategory = newValue;
                        log('MY CATEGORY>>>$slectedCategory');
                      });
                      /*doctorListCtr.subCatList(slectedCategory!);*/
                    },
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
