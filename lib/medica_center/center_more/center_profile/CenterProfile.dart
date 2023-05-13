import 'dart:convert';
import 'dart:io';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medica/doctor_screens/controller/DoctorProfileController.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../../../../Helper/RoutHelper/RoutHelper.dart';

class CenterProfile extends StatefulWidget {
  const CenterProfile({Key? key}) : super(key: key);

  @override
  State<CenterProfile> createState() => _CenterProfileState();
}

class _CenterProfileState extends State<CenterProfile> {

  CustomView customView = CustomView();

  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController bioCtrl = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surename = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();

  String files = "";
  String code = '';

  File? file;
  final picker = ImagePicker();
  String baseimage = "";
  String imagename = "";

  void _choose(ImageSource source) async {
    final pickedFile = await picker.getImage(
        source: source, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        List<int> imageBytes = file!.readAsBytesSync();
        baseimage = base64Encode(imageBytes);
        imagename = 'image_${DateTime
            .now()
            .millisecondsSinceEpoch}_.jpg';
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return SafeArea(

      child: Scaffold(
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: customView.MyButton(
              context,
              "Save profile",
              (){},
              MyColor.primary,
              const TextStyle(fontFamily: "Poppins", color: Colors.white),
            ),
          ),
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
                "Profile", 15.0, FontWeight.w500, Colors.black),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white24,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .shortestSide / 10,
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
                    height: height * 0.04,
                  ),
                  customView.text(
                      "Your medical center name", 11.0, FontWeight.w600, MyColor.primary1),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  customView.myField(context, userNameCtrl, "Enter User Name",
                      TextInputType.text),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  customView.text(
                      "Your bio", 11.0, FontWeight.w600, MyColor.primary1),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  customView.myField(
                      context, bioCtrl, "Your bio", TextInputType.text),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  customView.text(
                      "Your username / email", 11.0, FontWeight.w600, MyColor.primary1),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  customView.myField(
                      context, emailCtrl, "Enter Email", TextInputType.text),

                  SizedBox(
                    height: height * 0.03,
                  ),
                  /*-new-*/
                  customView.text(
                      "Your address", 10.0, FontWeight.w600, MyColor.primary1),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  customView.myField(
                      context, genderCtrl, "Enter address", TextInputType.text),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
          )),
    );
  }

}
