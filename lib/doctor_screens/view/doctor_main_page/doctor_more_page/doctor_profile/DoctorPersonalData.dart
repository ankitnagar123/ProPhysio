import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:medica/doctor_screens/controller/DoctorProfileController.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../../../../Helper/RoutHelper/RoutHelper.dart';

class DoctorPersonalData extends StatefulWidget {
  const DoctorPersonalData({Key? key}) : super(key: key);

  @override
  State<DoctorPersonalData> createState() => _DoctorPersonalDataState();
}

class _DoctorPersonalDataState extends State<DoctorPersonalData> {
  DoctorProfileCtr doctorProfileCtr = Get.put(DoctorProfileCtr());

  CustomView customView = CustomView();

  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController bioCtrl = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surename = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();

/*new*/
  TextEditingController birthDateController = TextEditingController();
  TextEditingController birthplaceController = TextEditingController();
  TextEditingController universityAttendedCtr = TextEditingController();
  TextEditingController dateOfEnrollmentCtr = TextEditingController();
  TextEditingController registerOfBelongingCtr = TextEditingController();
  TextEditingController dateOfQualification = TextEditingController();
  TextEditingController dateOfGraduation = TextEditingController();

  String files = "";
  String code = '';

  File? file;
  final picker = ImagePicker();
  String baseimage = "";
  String imagename = "";

  DateTime? startDate;
  String _displayText(DateTime? date) {
    if (date != null) {
      return date.toString().split(' ')[0];
    } else {
      return '';
    }
  }


  void _choose(ImageSource source) async {
    final pickedFile = await picker.getImage(
        source: source, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        List<int> imageBytes = file!.readAsBytesSync();
        baseimage = base64Encode(imageBytes);
        imagename = 'image_${DateTime.now().millisecondsSinceEpoch}_.jpg';
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doctorProfileCtr.doctorProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
        surename.text = doctorProfileCtr.surename.value;
        phoneNumberCtrl.text = doctorProfileCtr.phone.value;

        /*new*/
        genderCtrl.text = doctorProfileCtr.gender.value;
        birthDateController.text = doctorProfileCtr.dateOfBirth.value;
        birthplaceController.text = doctorProfileCtr.placeOfBirth.value;
        universityAttendedCtr.text = doctorProfileCtr.universityAttended.value;
        dateOfEnrollmentCtr.text = doctorProfileCtr.dateOfEnrollment.value;
        registerOfBelongingCtr.text =
            doctorProfileCtr.registerOfBelonging.value;
        dateOfQualification.text = doctorProfileCtr.dateOfQualification.value;
        dateOfGraduation.text = doctorProfileCtr.dateOfGraduation.value;
        print("date  q======${doctorProfileCtr.dateOfQualification.value}");

        print("date of birth======${doctorProfileCtr.dateOfBirth.value}");
      }
      return Obx(() {
        return Scaffold(
            appBar: AppBar(
              actions: [
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
              ],
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
                  "Personal data", 15.0, FontWeight.w500, Colors.black),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.white24,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: doctorProfileCtr.loading.value
                  ? Center(child: customView.MyIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.shortestSide / 10,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(120.0),
                                child: file == null
                                    ? FadeInImage.assetNetwork(
                                        imageErrorBuilder: (c, o, s) =>
                                            Image.asset(
                                                "assets/images/dummyprofile.jpg",
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
                                                      _choose(
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
                        customView.text("Your username", 10.0, FontWeight.w600,
                            MyColor.black),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        customView.myField(context, userNameCtrl,
                            "Enter User Name", TextInputType.text),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        customView.text(
                            "Your bio", 10.0, FontWeight.w600, MyColor.black),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        customView.myField(
                            context, bioCtrl, "Your bio", TextInputType.text),
                        const Divider(
                          thickness: 1.5,
                          height: 50.0,
                        ),
                        customView.text("Personal data", 14.0, FontWeight.w500,
                            MyColor.black),
                        Container(
                            height: 45.0,
                            width: MediaQuery.of(context).size.width / 2.3,
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
                                hintStyle: TextStyle(fontSize: 11),
                                suffixIcon:
                                Icon(Icons.calendar_month, color: MyColor.primary),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            )),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customView.text("Your name", 10.0,
                                      FontWeight.w600, MyColor.black),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  customView.myField(context, name, "Name",
                                      TextInputType.text),
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
                                  customView.text("Your surname", 10.0,
                                      FontWeight.w600, MyColor.black),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  customView.myField(context, surename,
                                      "Surname", TextInputType.text),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        customView.text(
                            "Your email", 10.0, FontWeight.w600, MyColor.black),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        customView.myField(context, emailCtrl, "Enter Email",
                            TextInputType.text),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        /*-new-*/
                        customView.text("Your gender", 10.0, FontWeight.w600,
                            MyColor.black),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        customView.myField(context, genderCtrl, "Enter gender",
                            TextInputType.text),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customView.text("Your birth of date", 10.0,
                                      FontWeight.w600, MyColor.black),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  customView.myField(
                                      context,
                                      birthDateController,
                                      "birth date",
                                      TextInputType.text),
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
                                  customView.text("Your birthplace", 10.0,
                                      FontWeight.w600, MyColor.black),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  customView.myField(
                                      context,
                                      birthplaceController,
                                      "birthplace",
                                      TextInputType.text),
                                ],
                              ),
                            ),
                          ],
                        ),
/*-new-*/
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customView.text("Your graduation date", 10.0,
                                      FontWeight.w600, MyColor.black),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  customView.myField(context, dateOfGraduation,
                                      "graduation date", TextInputType.text),
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
                                  customView.text("Your qualification date",
                                      10.0, FontWeight.w600, MyColor.black),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  customView.myField(
                                      context,
                                      dateOfQualification,
                                      "qualification date",
                                      TextInputType.text),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        customView.text("Your Contact", 10.0, FontWeight.w600,
                            MyColor.black),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 1,
                          child: IntlPhoneField(
                            initialValue: "it",
                            controller: phoneNumberCtrl,
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
                              print(phone.completeNumber);
                            },
                            onCountryChanged: (cod) {
                              code = cod.dialCode;
                            },
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                      ],
                    ),
            ),
            bottomNavigationBar: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: customView.MyButton(
                context,
                "Save profile",
                () {
                  doctorProfileCtr.doctorProfileUpdate(
                      context,
                      name.text,
                      surename.text,
                      userNameCtrl.text,
                      bioCtrl.text,
                      code,
                      emailCtrl.text,
                      phoneNumberCtrl.text,
                      imagename,
                      baseimage,
                      genderCtrl.text,
                      birthDateController.text,
                      birthplaceController.text,
                      universityAttendedCtr.text,
                      dateOfEnrollmentCtr.text,
                      registerOfBelongingCtr.text,
                      dateOfQualification.text,
                      dateOfGraduation.text);
                  // doctorProfileCtr.doctorProfileUpdate(context, name, surname, username, category, location, docImg, docBase, code, email, phone, password, image, baseImage)
                },
                MyColor.primary,
                const TextStyle(fontFamily: "Poppins", color: Colors.white),
              ),
            ));
      });
    });
  }

  //*******date strt end************//
  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      keyboardType: TextInputType.numberWithOptions(),
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
