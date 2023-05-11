import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../../../controller/auth_controllers/PatientProfileController.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({Key? key}) : super(key: key);

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  CustomView customView = CustomView();
  PatientProfileCtr profileCtr = Get.put(PatientProfileCtr());

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
  TextEditingController genderCtr = TextEditingController();

  String files = "";
  String code = '';

  final bool _isHidden = true;
  File? file;
  final picker = ImagePicker();
  String baseimage = "";
  String imagename = "";

  void _choose(ImageSource source) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 100, maxHeight: 500, maxWidth: 500);
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
    WidgetsFlutterBinding.ensureInitialized();
    profileCtr.patientProfile(context);
    nameCtrl.text = profileCtr.name.value;
    print("my name${profileCtr.name.value}");
    userNameCtrl.text = profileCtr.username.value;
    sureNameCtrl.text = profileCtr.surename.value;
    emailCtrl.text = profileCtr.Email.value;
    healthCardCtrl.text = profileCtr.healthCard.value;
    phoneNumberCtrl.text = profileCtr.phone.value;
    addressCtrl.text = profileCtr.address.value;
    files = profileCtr.image.value;
    code = profileCtr.code.value;

    /*--new filed added--*/
    ageCtr.text = profileCtr.age.value;
    heightCtr.text = profileCtr.height.value;
    weightCtr.text = profileCtr.weight.value;
    taxCtr.text = profileCtr.taxCode.value;
    birthPlaceCtr.text = profileCtr.birthplace.value;
genderCtr.text = profileCtr.gender.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
        title:
            customView.text("Profile", 15.0, FontWeight.w500, Colors.black),
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
                      borderRadius: BorderRadius.circular(120.0),
                      child: file == null
                          ? FadeInImage.assetNetwork(
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                  "assets/images/dummyprofile.jpg",
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover),
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                              placeholder: "assets/images/loading.gif",
                              image: files,
                              placeholderFit: BoxFit.cover,
                            )
                          : Image.file(file!,
                              width: 120, height: 120, fit: BoxFit.fill),
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
                                          child: Row(
                                            children: const [
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
                                            _choose(ImageSource.camera);
                                          },
                                          child: Row(
                                            children: const [
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
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              customView.text(
                  "Your username", 10.0, FontWeight.w600, MyColor.black),
              SizedBox(
                height: height * 0.01,
              ),
              customView.myField(context, userNameCtrl, "Enter User Name",
                  TextInputType.text),
              const Divider(
                thickness: 2.0,
                height: 50.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customView.text("Your name", 10.0, FontWeight.w600,
                            MyColor.black),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        customView.myField(
                            context, nameCtrl, "Name", TextInputType.text),
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
                        customView.text("Your surname", 10.0, FontWeight.w600,
                            MyColor.black),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        customView.myField(context, sureNameCtrl, "Surname",
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
                  "Your email", 10.0, FontWeight.w600, MyColor.black),
              SizedBox(
                height: height * 0.01,
              ),
              customView.myField(
                  context, emailCtrl, "Enter Email", TextInputType.text),
              const Divider(
                thickness: 2.0,
                height: 50.0,
              ),
              customView.text("Your Health card code", 10.0, FontWeight.w600,
                  MyColor.black),
              SizedBox(
                height: height * 0.01,
              ),
              customView.myField(context, healthCardCtrl,
                  "Enter Health card code", TextInputType.text),
              SizedBox(
                height: height * 0.03,
              ),
              customView.text(
                  "Your phone number", 10.0, FontWeight.w600, MyColor.black),
              SizedBox(
                height: height * 0.01,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 1,
                child: IntlPhoneField(
                  keyboardType: TextInputType.number,
                  showCountryFlag: false,
                  initialValue: "$code",
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
              const Divider(
                thickness: 2.0,
                height: 50.0,
              ),
              customView.text(
                  "Your Address", 10.0, FontWeight.w600, MyColor.black),
              SizedBox(
                height: height * 0.01,
              ),
              customView.myField(context, addressCtrl, "Enter Your Address",
                  TextInputType.text),
              SizedBox(
                height: height * 0.03,
              ),
              customView.text(
                  "Your Gender", 10.0, FontWeight.w600, MyColor.black),
              SizedBox(
                height: height * 0.01,
              ),
              customView.myField(context, genderCtr, "Enter Your gender",
                  TextInputType.text),
              SizedBox(
                height: height * 0.03,
              ),
              customView.text(
                  "Your Age", 10.0, FontWeight.w600, MyColor.black),
              SizedBox(
                height: height * 0.01,
              ),
              myField(context, ageCtr, "age", TextInputType.text),
              SizedBox(
                height: height * 0.03,
              ),
              customView.text(
                  "Your Height", 10.0, FontWeight.w600, MyColor.black),
              SizedBox(
                height: height * 0.01,
              ),
              myField(context, heightCtr, "height", TextInputType.text),
              SizedBox(
                height: height * 0.03,
              ),
              customView.text(
                  "Your Weight", 10.0, FontWeight.w600, MyColor.black),
              SizedBox(
                height: height * 0.01,
              ),
              myField(context, weightCtr, "weight", TextInputType.text),
              SizedBox(
                height: height * 0.03,
              ),
              customView.text(
                  "Your Tax code", 10.0, FontWeight.w600, MyColor.black),
              SizedBox(
                height: height * 0.01,
              ),
              myField(context, taxCtr, "tax code", TextInputType.text),
              SizedBox(
                height: height * 0.03,
              ),
              customView.text(
                  "Your Birth-place", 10.0, FontWeight.w600, MyColor.black),
              SizedBox(
                height: height * 0.01,
              ),
              myField(context, birthPlaceCtr, "birth-place", TextInputType.text),
              SizedBox(
                height: height * 0.04,
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: AnimatedButton(
          // width: MediaQuery.of(context).size.width * 0.8,
          text: 'Save Profile',
          color: MyColor.primary,
          pressEvent: () {
            profileCtr.patientProfileUpdate(
                context,
                nameCtrl.text,
                sureNameCtrl.text,
                userNameCtrl.text,
                emailCtrl.text,
                healthCardCtrl.text,
                addressCtrl.text,
                phoneNumberCtrl.text,
                code,
                imagename,
                baseimage,
                genderCtr.text,
                    () {
              AwesomeDialog(
                context: context,
                animType: AnimType.leftSlide,
                headerAnimationLoop: false,
                dialogType: DialogType.success,
                showCloseIcon: true,
                title: 'Success',
                desc: 'Profile Update Successfully',
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

  Widget myField(BuildContext context, TextEditingController controller,
      String hintText, TextInputType inputType) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widht,
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
}
