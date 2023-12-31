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

  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController sureNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController healthCardCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController weightCtr = TextEditingController();
  TextEditingController ageCtr = TextEditingController();
  TextEditingController heightCtr = TextEditingController();
  TextEditingController taxCtr = TextEditingController();
  TextEditingController birthPlaceCtr = TextEditingController();
  TextEditingController birthDateCtr = TextEditingController();
  String? selectedBranch;

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
  String code = '';
  String flag = '';
  String _selectedGender = '';

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
    final height = MediaQuery.of(context).size.height;
    return Obx( () {
      if (profileCtr.resultVar.value == 1) {
        profileCtr.resultVar.value = 0;

        nameCtrl.text = profileCtr.name.value;
        print("my name${profileCtr.name.value}");
        userNameCtrl.text = profileCtr.username.value;
        sureNameCtrl.text = profileCtr.surename.value;
        emailCtrl.text = profileCtr.Email.value;
        phoneNumberCtrl.text = profileCtr.phone.value;
        addressCtrl.text = profileCtr.address.value;
        files = profileCtr.image.value;
        qRCode = profileCtr.qrCode.value;
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Obx(() {
          if (profileCtr.loading.value) {
            return Center(
              heightFactor: 14,
              child: customView.MyIndicator(),
            );
          }
          return Column(
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
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: AnimatedButton(
          text: text.saveProfile.tr,
          color: MyColor.red,
          pressEvent: ()async {
            if(await latLong(addressCtrl.text)){
              profileCtr.patientProfileUpdate(
                  context,
                  nameCtrl.text,
                  sureNameCtrl.text,
                  userNameCtrl.text,
                  emailCtrl.text,
                  // healthCardCtrl.text,
                  addressCtrl.text,
                  phoneNumberCtrl.text,
                  code,
                  flag,
                  imagename,
                  baseimage,
                  _selectedGender.toString(),
                  latitude,
                  longitude,
                  ageCtr.text,
                  weightCtr.text,
                  heightCtr.text,
                  birthPlaceCtr.text,
                  taxCtr.text,
                      birthDateCtr.text,selectedBranch.toString(),
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
              });
            }else{
              customView.massenger(context, text.invalidAddress.tr);
            }

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
}
