import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:prophysio/helper/AppConst.dart';


import '../../../../../doctor_screens/controller/DoctorSignUpController.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/auth_controllers/PatientProfileController.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({Key? key}) : super(key: key);

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  CustomView customView = CustomView();
  PatientProfileCtr profileCtr = Get.put(PatientProfileCtr());
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());

  LocalString text = LocalString();
  PageController controller = PageController();

  String dropdownvalue = "";

  var items = [
    "Mr", "Ms", "Miss", "Mrs",
  ];
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController sureNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  var code = "";
  var flag = "";

  TextEditingController addressCtrl = TextEditingController();
  TextEditingController weightCtr = TextEditingController();
  TextEditingController ageCtr = TextEditingController();
  TextEditingController heightCtr = TextEditingController();
  TextEditingController taxCtr = TextEditingController();
  TextEditingController birthPlaceCtr = TextEditingController();
  TextEditingController birthDateCtr = TextEditingController();
  String _selectedGender = '';
  String? selectedBranch;
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




  DateTime? startDate;

  String _displayText(DateTime? date) {
    if (date != null) {
      return date.toString().split(' ')[0];
    } else {
      return '';
    }
  }
  String qRCode = "";
  String files = "";


  File? file;
  final picker = ImagePicker();
  String baseimage = "";
  String imagename = "";
  String latitude = "";
  String longitude = "";

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

  @override
  void initState() {
    super.initState();
    profileCtr.patientProfile(context);
    doctorSignUpCtr.branchListApi();

  }

  @override
  Widget build(BuildContext context) {
    return Obx( () {
      if (profileCtr.resultVar.value == 1) {
        profileCtr.resultVar.value = 0;
        nameCtrl.text = profileCtr.name.value;
        userNameCtrl.text = profileCtr.username.value;
        sureNameCtrl.text = profileCtr.surename.value;
        emailCtrl.text = profileCtr.Email.value;
        phoneNumberCtrl.text = profileCtr.phone.value;
        addressCtrl.text = profileCtr.address.value;
        files = profileCtr.image.value;
        flag = profileCtr.flag.value;
        code = profileCtr.code.value;
        _selectedGender = profileCtr.gender.value;
        /*--new filed added--*/
        ageCtr.text = profileCtr.age.value;
        heightCtr.text = profileCtr.height.value;
        weightCtr.text = profileCtr.weight.value;
        taxCtr.text = profileCtr.taxCode.value;
        birthPlaceCtr.text = profileCtr.birthplace.value;
        birthDateCtr.text = profileCtr.dob.value;
        selectedBranch = profileCtr.branchId.value;
        /*new---------*/
        idNumberCtr.text = profileCtr.idNumber.value;
        idTypeCtr.text = profileCtr.idType.value;
        /*-----kin-------*/
        kinNameCtr.text = profileCtr.kinName.value;
        kinContactCtr.text = profileCtr.kinContact.value;
        /*-----Home Address-------*/
        homeTitle1Ctr.text = profileCtr.homeTitle1.value;
        homeTitle2Ctr.text = profileCtr.homeTitle2.value;
        homeAddressCtr.text = profileCtr.homeAddress.value;
        homeStateCtr.text = profileCtr.homeState.value;
        homePostalCodeCtr.text = profileCtr.homePostalCode.value;
        homeCountryCtr.text = profileCtr.homeCountry.value;
        homePhoneCtr.text = profileCtr.homePhone.value;
        /*-----Office Address-------*/
        officeTitle1Ctr.text = profileCtr.officeTitle1.value;
        officeTitle2Ctr.text = profileCtr.officeTitle2.value;
        employmentStatusCtr.text = profileCtr.employmentStatus.value;
        occupationCtr.text = profileCtr.occupation.value;
        employerCtr.text = profileCtr.employer.value;
        officeAddressCtr.text = profileCtr.officeAddress.value;
        officeStateCtr.text = profileCtr.officeState.value;
        officePostalCtr.text = profileCtr.officePostalCode.value;
        officeCountryCtr.text = profileCtr.officeCountry.value;
        officePhoneCtr.text = profileCtr.officePhone.value;
        /*-----Medical Doctor INfo-------*/
        medicalTitle1Ctr.text = profileCtr.medicalTitle1.value;
        medicalTitle2Ctr.text= profileCtr.medicalTitle2.value;
        medicalNameCtr.text = profileCtr.medicalName.value;
        medicalPracticeNameCtr.text = profileCtr.medicalPracticeName.value;
        medicalAddressCtr.text = profileCtr.medicalAddress.value;
        medicalStateCtr.text =profileCtr.medicalState.value;
        medicalPostalCtr.text = profileCtr.medicalPostalCode.value;
        medicalCountryCtr.text = profileCtr.medicalCountry.value;
        medicalPhoneCtr.text = profileCtr.medicalPhone.value;
        dropdownvalue = profileCtr.title.value;

        aboutUsCtr.text =profileCtr.aboutUs.value;



/*set local */
        AppConst.Patinet_Profile = files;
        AppConst.Patient_Name = nameCtrl.text;
        AppConst.Patinet_Surname = sureNameCtrl.text;

      }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: customView.text(text.Profile.tr, 15.0, FontWeight.w500, Colors.black),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (profileCtr.loading.value) {
          return Center(
            heightFactor: 14,
            child: customView.MyIndicator(),
          );
        }
        return  Column(
          children: [
            Expanded(child: PageView(
              onPageChanged: (value) {

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
            ),),

          ],
        ); /*Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.shortestSide / 12,
            ),
            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: file == null
                        ? InkWell(
                            onTap: () {
                              imagePopUp(context, files);
                            },
                            child: FadeInImage.assetNetwork(
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                  "assets/images/dummyprofile.png",
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover),
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              placeholder: "assets/images/loading.gif",
                              image: files,
                              placeholderFit: BoxFit.cover,
                            ),
                          )
                        : Image.file(file!,
                            width: 120, height: 120, fit: BoxFit.cover),
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
                                          _choose(ImageSource.gallery);
                                        },
                                        child:  Row(
                                          children: [
                                            const Icon(Icons.image, size: 20),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              text.imageFromgallary.tr,
                                              style: const TextStyle(
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
                                          _choose(ImageSource.camera);
                                        },
                                        child:  Row(
                                          children: [
                                            const Icon(Icons.camera_alt),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                text.imageFromCamra.tr,
                                              style: const TextStyle(
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
                ],
              ),
            ),
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
                      customView.text(
                          text.H_Enter_Name.tr, 10.0, FontWeight.w600, MyColor.black),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      customView.myField(
                          context, nameCtrl, text.Enter_Name.tr, TextInputType.text),
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
                      customView.text(text.H_Enter_Surname.tr, 10.0, FontWeight.w600,
                          MyColor.black),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      customView.myField(context, sureNameCtrl, text.Enter_Surname.tr,
                          TextInputType.text),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            customView.text(
                text.yourEmail.tr, 10.0, FontWeight.w600, MyColor.black),
            SizedBox(
              height: height * 0.01,
            ),
            customView.myField(
                context, emailCtrl, text.enterEmail.tr, TextInputType.text),

            SizedBox(
              height: height * 0.03,
            ),
            customView.text(
                text.yourPhoneNumber.tr, 10.0, FontWeight.w600, MyColor.black),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 1,
              child: IntlPhoneField(
                keyboardType: TextInputType.number,
                showCountryFlag: true,
                // initialValue: "IN",
                controller: phoneNumberCtrl,
                decoration:  InputDecoration(
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
                  print(phone.completeNumber);
                },
                onCountryChanged: (cod) {
                  flag = cod.code;
                  log(flag);
                  code = '+${cod.dialCode}';
                },
              ),
            ),
            const Divider(
              thickness: 2.0,
              height: 50.0,
            ),
            customView.text(
               text.yourAddres.tr, 10.0, FontWeight.w600, MyColor.black),
            SizedBox(
              height: height * 0.01,
            ),
            customView.myField(context, addressCtrl,  text.yourAddres.tr,
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
                      customView.text(text.yourAge.tr, 10.0, FontWeight.w600,
                          MyColor.black),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      customView.myField(context, ageCtr, text.yourAge.tr,
                          TextInputType.text),
                    ],
                  ),
                ),
              ],
            ),
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
                      customView.text(
                          text.yourHeight.tr, 10.0, FontWeight.w600, MyColor.black),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      customView.myField(
                          context, heightCtr,  text.yourHeight.tr, TextInputType.text),
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
                      customView.text(text.yourWeight.tr, 10.0, FontWeight.w600,
                          MyColor.black),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      customView.myField(context, weightCtr, text.yourWeight.tr,
                          TextInputType.text),
                    ],
                  ),
                ),
              ],
            ),
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
                      customView.text(
                          text.TRM.tr, 10.0, FontWeight.w600, MyColor.black),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      customView.myField(
                          context, taxCtr, text.TRM.tr, TextInputType.text),
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
                      customView.text(text.yourBirthplace.tr, 10.0, FontWeight.w600,
                          MyColor.black),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      customView.myField(context, birthPlaceCtr, text.yourBirthplace.tr,
                          TextInputType.text),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            const SizedBox(
              height: 17.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  text.Date_of_Birth.tr, 13.0, FontWeight.w500, MyColor.primary1),
            ),
            Container(
                height: 45.0,
                width: MediaQuery.of(context).size.width / 0.9,
                padding:  const EdgeInsets.only(left: 10.0, bottom: 2),
                margin:  const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
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
                  decoration:  InputDecoration(
                    hintText: text.Select_Date.tr,
                    hintStyle: const TextStyle(fontSize: 15),
                    suffixIcon:
                    const Icon(Icons.calendar_month, color: MyColor.primary),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                )),
            const SizedBox(
              height: 17.0,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: customView.text(text.Select_Branch.tr, 13.0,
                  FontWeight.w500, MyColor.primary1),
            ),
            SizedBox(
              height: 5,
            ),
            branch(),
            const SizedBox(
              height: 17.0,
            ),
            customView.text(
                text.yourGender.tr, 10.0, FontWeight.w600, MyColor.black),
            SizedBox(
              height: height * 0.01,
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
                    title:  Text(text.Male.tr),
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
                    title:  Text(text.Female.tr),
                  ),
                ),
              ],
            ),
          ],
        );*/
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: AnimatedButton(
          text: text.saveProfile.tr,
          color: MyColor.red,
          pressEvent: ()async {
              profileCtr.patientProfileUpdate(
                  context, dropdownvalue, nameCtrl.text, sureNameCtrl.text, emailCtrl.text, code, phoneNumberCtrl.text, flag, "", ageCtr.text, weightCtr.text, birthPlaceCtr.text,
                  heightCtr.text, taxCtr.text, _selectedGender.toString(), birthDateCtr.text,
                  selectedBranch.toString(), idTypeCtr.text,
                  idNumberCtr.text, kinNameCtr.text, kinContactCtr.text,
                  homeTitle1Ctr.text, homeTitle2Ctr.text,
                  homeAddressCtr.text, homeStateCtr.text, homePostalCodeCtr.text,
                  homeCountryCtr.text, homePhoneCtr.text, officeTitle1Ctr.text, officeTitle2Ctr.text,
                  employmentStatusCtr.text, occupationCtr.text, employerCtr.text,
                  officeAddressCtr.text, officeStateCtr.text, officePostalCtr.text,
                  officeCountryCtr.text, officePhoneCtr.text, medicalTitle1Ctr.text,
                  medicalTitle2Ctr.text, medicalNameCtr.text, medicalPracticeNameCtr.text,
                  medicalAddressCtr.text, medicalStateCtr.text,
                  medicalPostalCtr.text, medicalCountryCtr.text, medicalPhoneCtr.text, aboutUsCtr.text, () {
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
          },
        ),
      ),
    );
  }
   );}



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
            // width: widht * 1,
            padding: const EdgeInsets.only(left: 10),
            // margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
            decoration: BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: MyColor.grey)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                // menuMaxHeight: MediaQuery.of(context).size.height / 3,
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
                hint:  Text(text.Select_Branch.tr),
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

  Widget myField(BuildContext context, TextEditingController controller,
      String hintText, TextInputType inputType) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        readOnly: true,
        textInputAction: TextInputAction.next,
        keyboardType: inputType,
        cursorColor: Colors.black,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 3, left: 20),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12),
          filled: true,
          fillColor: MyColor.white,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

//*********Get user latitude and longitude*********//
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
      customView.MySnackBar(context, text.invalidAddress.tr);
      return false;
    }
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
                  return  Padding(
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
                          imageErrorBuilder:
                              (context, error, stackTrace) {
                            return const Image(
                                image: AssetImage(
                                    "assets/images/noimage.png"));
                          },
                          width: MediaQuery.of(context).size.width,
                          height:
                          MediaQuery.of(context).size.height * 0.5,
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


  /*------Select MR MS etc*/
  Widget _buildDropDownButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color:  Colors.black),
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
            items:items
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

  /*------------------sign-Up 1----------------*/
  Widget signUp1(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: MyColor.primary1.withOpacity(0.3))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: customView.text("Demographics Info", 15.0,
                          FontWeight.w600, MyColor.primary1),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(80.0),
                          child: file == null
                              ? InkWell(
                            onTap: () {
                              imagePopUp(context, files);
                            },
                            child: FadeInImage.assetNetwork(
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                  "assets/images/dummyprofile.png",
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              placeholder: "assets/images/loading.gif",
                              image: files,
                              placeholderFit: BoxFit.cover,
                            ),
                          )
                              : Image.file(file!,
                              width: 120, height: 120, fit: BoxFit.cover),
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
                                                _choose(ImageSource.gallery);
                                              },
                                              child:  Row(
                                                children: [
                                                  const Icon(Icons.image, size: 20),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    text.imageFromgallary.tr,
                                                    style: const TextStyle(
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
                                                _choose(ImageSource.camera);
                                              },
                                              child:  Row(
                                                children: [
                                                  const Icon(Icons.camera_alt),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    text.imageFromCamra.tr,
                                                    style: const TextStyle(
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
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
                      Expanded(
                          flex: 0,
                          child: _buildDropDownButton()),
                      SizedBox(
                        width: 2,
                      ),
                      Expanded(
                        flex: 1, child: customView.myField(context, nameCtrl,
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
                  customView.myField(context, sureNameCtrl,
                      text.H_Enter_Surname.tr, TextInputType.text),
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
                              customView.myField(context, taxCtr, text.TRM.tr,
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
                    child: customView.text(
                        text.Date_of_Birth.tr, 13.0, FontWeight.w500, MyColor.primary1),
                  ),
                  Container(
                      height: 45.0,
                      width: MediaQuery.of(context).size.width / 0.9,
                      padding:  const EdgeInsets.only(left: 10.0, bottom: 2),
                      margin:  const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
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
                        decoration:  InputDecoration(
                          hintText: text.Select_Date.tr,
                          hintStyle: const TextStyle(fontSize: 15),
                          suffixIcon:
                          const Icon(Icons.calendar_month, color: MyColor.primary),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      )),
                ]
            ),
          ),
        ),
      ),
    );

  }

  /*------------------sign-Up 2----------------*/
  Widget signUp2(){
    final widht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children:[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: MyColor.primary1.withOpacity(0.3))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: customView.text(
                          "Contact Information", 15.0, FontWeight.w600, MyColor.primary1),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text(
                        text.Enter_Email.tr, 13.0, FontWeight.w500, MyColor.primary1),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  customView.myField(
                      context, emailCtrl, text.H_Enter_Email.tr, TextInputType.text),

                  const SizedBox(
                    height: 15.0,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text(
                        text.Phone_Number.tr, 13.0, FontWeight.w500, MyColor.primary1),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  SizedBox(
                    height: 50,
                    width: widht * 1,
                    child: IntlPhoneField(
                      controller: phoneNumberCtrl,
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
                    child: customView.text(text.Select_Branch.tr, 13.0, FontWeight.w500,
                        MyColor.primary1),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  branch(),
                ]
            ),
          ),
        ),
      ),
    );

  }

  /*------------------sign-Up 3----------------*/
  Widget signUp3(){
    final widht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children:[
                  const SizedBox(
                    height: 17.0,
                  ),
                  /*-------------------Identification Document-----------------*/

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: MyColor.primary1.withOpacity(0.3))
                    ),
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
                    child: customView.text("ID Type", 13.0,
                        FontWeight.w500, MyColor.primary1),
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
                    child: customView.text("ID Number", 13.0,
                        FontWeight.w500, MyColor.primary1),
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
                        border: Border.all(color: MyColor.primary1.withOpacity(0.3))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: customView.text("Next of Kin", 15.0,
                          FontWeight.w600, MyColor.primary1),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Name", 13.0,
                        FontWeight.w500, MyColor.primary1),
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
                    child: customView.text("Phone", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, kinContactCtr, "Enter Phone", TextInputType.number),
                  SizedBox(
                    height: 15,
                  ),
                ]
            ),
          ),
        ),
      ),
    );

  }

  /*------------------sign-Up 4----------------*/
  Widget signUp4(){
    final widht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children:[
                  /*----------------------Home Address--------------------*/
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: MyColor.primary1.withOpacity(0.3))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: customView.text("Home Address", 15.0,
                          FontWeight.w600, MyColor.primary1),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Title 1", 13.0,
                        FontWeight.w500, MyColor.primary1),
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
                    child: customView.text("Title 2", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  customView.myFieldExpand(
                      context, homeTitle2Ctr, "Enter Title 2", TextInputType.multiline),
                  const  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Home Address", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myFieldExpand(
                      context, homeAddressCtr, "Enter Full Address", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("State", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, homeStateCtr, "Enter State/Province/Parish", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Postal Code", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, homePostalCodeCtr, "Enter Postal Code", TextInputType.number),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Country", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, homeCountryCtr, "Enter Country", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Home Phone", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, homePhoneCtr, "Enter phone", TextInputType.number),
                  SizedBox(
                    height: 15,
                  ),
                ]
            ),
          ),
        ),
      ),
    );

  }


  /*------------------sign-Up 5----------------*/
  Widget signUp5(){
    final widht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children:[
                  /*---------------------------Employment Information--------------------*/
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: MyColor.primary1.withOpacity(0.3))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: customView.text("Employment Status", 15.0,
                          FontWeight.w600, MyColor.primary1),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Title 1", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myFieldExpand(
                      context, officeTitle1Ctr, "Enter Title 1", TextInputType.text),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Title 2", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  customView.myFieldExpand(
                      context, officeTitle2Ctr, "Enter Title 2", TextInputType.multiline),
                  const  SizedBox(
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
                  customView.myField(
                      context, employmentStatusCtr, "Enter Employment Status", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Occupation", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, occupationCtr, "Enter Occupation", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Employer", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, employerCtr, "Enter Employer", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Office Address", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myFieldExpand(
                      context, officeAddressCtr, "Enter Full Address", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("State", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, officeStateCtr, "Enter State/Province/Parish", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Postal Code", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, officePostalCtr, "Enter Postal Code", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Country", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, officeCountryCtr, "Enter Country", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Office Phone", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, officePhoneCtr, "Enter phone", TextInputType.number),
                  SizedBox(
                    height: 15,
                  ),

                ]
            ),
          ),
        ),
      ),
    );

  }

  /*------------------sign-Up 6----------------*/
  Widget signUp6(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyColor.primary1.withOpacity(0.3))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children:[
                  /*--------------Medical Doctor Information----------------------------*/
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: MyColor.primary1.withOpacity(0.3))
                    ),
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
                    child: customView.text("Title 1", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myFieldExpand(
                      context, medicalTitle1Ctr, "Enter Title 1", TextInputType.text),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Title 2", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  customView.myFieldExpand(
                      context, medicalTitle2Ctr, "Enter Title 2", TextInputType.multiline),
                  const  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Name", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, medicalNameCtr, "Enter Name", TextInputType.text),

                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Practice Name", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, medicalPracticeNameCtr, "Enter Practice Name", TextInputType.text),


                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Medical Address", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, medicalAddressCtr, "Enter Full Address", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("State", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, medicalStateCtr, "Enter State/Province/Parish", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Postal Code", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, medicalPostalCtr, "Enter Postal Code", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Country", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, medicalCountryCtr, "Enter Country", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("Medical Phone", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myField(
                      context, medicalPhoneCtr, "Enter phone", TextInputType.number),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customView.text("About", 13.0,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  customView.myFieldExpand(
                      context, aboutUsCtr, "Enter about", TextInputType.text),
                  SizedBox(
                    height: 15,
                  ),

                ]
            ),
          ),
        ),
      ),
    );

  }

}
