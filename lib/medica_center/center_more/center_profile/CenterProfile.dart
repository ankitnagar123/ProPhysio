import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/medica_center/center_controller/CenterAuthController.dart';

class CenterProfile extends StatefulWidget {
  const CenterProfile({Key? key}) : super(key: key);

  @override
  State<CenterProfile> createState() => _CenterProfileState();
}

class _CenterProfileState extends State<CenterProfile> {
  CustomView customView = CustomView();

  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController bioCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  TextEditingController phoneNumberCtrl = TextEditingController();
  CenterAuthCtr centerAuthCtr = CenterAuthCtr();
  String files = "";
  String code = '';

  File? file;
  final picker = ImagePicker();
  String baseimage = "";
  String imagename = "";
  String lat = "";
  String long = "";

  void _choose(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
      imageQuality: 70,
    );
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        List<int> imageBytes = file!.readAsBytesSync();
        baseimage = base64Encode(imageBytes);
        imagename = 'image_${DateTime.now().millisecondsSinceEpoch}_.jpg';
        Get.back();
      } else {
        customView.MySnackBar(context, "No image selected");
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerAuthCtr.centerProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Obx(() {
      if (centerAuthCtr.resultVar.value == 1) {
        centerAuthCtr.resultVar.value = 0;
        bioCtrl.text = centerAuthCtr.bio.value;
        emailCtrl.text = centerAuthCtr.Email.value;
        addressCtrl.text = centerAuthCtr.location.value;
        files = centerAuthCtr.image.value.toString();
        lat = centerAuthCtr.lat.value.toString();
        long = centerAuthCtr.long.value.toString();
        log(files);
        log(centerAuthCtr.name.value);
        log(centerAuthCtr.name.value);
        userNameCtrl.text = centerAuthCtr.name.value;
        print("naam${userNameCtrl.text}");
      }
      return Obx(() {
        return SafeArea(
          child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: centerAuthCtr.loadingUpdateP.value
                    ? customView.MyIndicator()
                    : customView.MyButton(
                        context,
                        "Save profile",
                        () async {
                          if (await updateValidation(context)) {
                            centerAuthCtr.centerProfileUpdate(
                                context,
                                userNameCtrl.text,
                                bioCtrl.text,
                                emailCtrl.text,
                                addressCtrl.text,
                                lat,
                                long,
                                imagename,
                                baseimage);
                          } else {}
                        },
                        MyColor.primary,
                        const TextStyle(
                            fontFamily: "Poppins", color: Colors.white),
                      ),
              ),
              // bottomNavigationBar: Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
              //   child: centerAuthCtr.loadingUpdateP.value ? customView
              //       .MyIndicator() : customView.MyButton(
              //     context,
              //     "Save profile",
              //         () {
              //       centerAuthCtr.centerProfileUpdate(
              //           context,
              //           userNameCtrl.text,
              //           bioCtrl.text,
              //           emailCtrl.text,
              //           addressCtrl.text,
              //           "",
              //           "",
              //           imagename,
              //           baseimage);
              //     },
              //     MyColor.primary,
              //     const TextStyle(fontFamily: "Poppins", color: Colors.white),
              //   ),
              // ),
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
                title: customView.text(
                    "Profile", 15.0, FontWeight.w500, Colors.black),
                centerTitle: true,
                elevation: 0.0,
                backgroundColor: Colors.white24,
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: centerAuthCtr.loadingP.value
                      ? Center(
                          heightFactor: 13, child: customView.MyIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.shortestSide / 15,
                            ),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          _choose(ImageSource
                                                              .gallery);
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
                                                          _choose(ImageSource
                                                              .camera);
                                                        },
                                                        child: const Row(
                                                          children: [
                                                            Icon(Icons
                                                                .camera_alt),
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
                            customView.text("Your medical center name", 12.0,
                                FontWeight.w600, MyColor.primary1),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            customView.myField(
                                context,
                                userNameCtrl,
                                "Enter medical center name",
                                TextInputType.text),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            customView.text("Your bio", 11.0, FontWeight.w600,
                                MyColor.primary1),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            customView.myField(context, bioCtrl, "Your bio",
                                TextInputType.text),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            customView.text("Your username / email", 11.0,
                                FontWeight.w600, MyColor.primary1),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            customView.myField(context, emailCtrl,
                                "Enter Email", TextInputType.text),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            /*-new-*/
                            customView.text("Your address", 10.0,
                                FontWeight.w600, MyColor.primary1),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            customView.myField(context, addressCtrl,
                                "Enter address", TextInputType.text),
                            SizedBox(
                              height: height * 0.025,
                            ),
                          ],
                        ),
                ),
              )),
        );
      });
    });
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

  Future<bool> updateValidation(BuildContext context) async {
    if (userNameCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, "Medical center name is required");
    } else if (emailCtrl.text.toString().isEmpty) {
      customView.MySnackBar(context, "Email is required");
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailCtrl.text.toString())) {
      customView.MySnackBar(context, "Enter valid email");
    } else if (addressCtrl.text.isEmpty) {
      customView.MySnackBar(context, "Address is required");
    } else {
      return await latLong(addressCtrl.text);
    }
    return false;
  }

  Future<bool> latLong(String address) async {
    try {
      List<Location> locationsList = await locationFromAddress(address);
      print(locationsList[0].latitude);
      print(locationsList[0].longitude);

      lat = locationsList[0].latitude.toString();
      long = locationsList[0].longitude.toString();
      return true;
    } catch (e) {
      log("Exception :-", error: e.toString());
      customView.MySnackBar(context, "invalid address");
      return false;
    }
  }
}
