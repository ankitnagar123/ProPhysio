import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../singup_screen/doctor_signup_page/DoctorSelectAddress.dart';
import '../../../../controller/DoctorProfileController.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  CustomView customView = CustomView();
  LocalString text = LocalString();

  DoctorProfileCtr doctorProfileCtr = Get.put(DoctorProfileCtr());
  String degree = "";

  @override
  void initState() {
    degree = doctorProfileCtr.degree.value;
    print(degree);
    doctorProfileCtr.doctorProfile(context);
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
        backgroundColor: Colors.white24,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.shortestSide / 10,
            ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(doctorProfileCtr.image.value),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Align(
              alignment: Alignment.center,
              child: customView.text(doctorProfileCtr.name.value, 15.0,
                  FontWeight.w500, MyColor.black),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Align(
              alignment: Alignment.center,
              child: customView.text(doctorProfileCtr.Email.value, 11.0,
                  FontWeight.w500, MyColor.grey),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            const Divider(
              thickness: 1.5,
              height: 50.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  text.certificates.tr, 13.0, FontWeight.w500, Colors.black),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    openImages();
                  },
                  child: const Card(
                    child: SizedBox(
                      height: 90,
                      width: 90,
                      child: Icon(Icons.add, size: 30, color: MyColor.grey),
                    ),
                  ),
                ),
                InkWell(
                  onTap:  () {
                    imagePopUp(context,degree);
                  },
                  child: Card(
                    child: SizedBox(
                        height: 90,
                        width: 90,
                        child: Image(
                          image: NetworkImage(doctorProfileCtr.degree.value),
                        )),
                  ),
                ),
              ],
            ),

            otherWidgets(),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: customView.MyButton(
                context,
                text.saveProfile.tr,
                () {

                },
                MyColor.primary,
                const TextStyle(fontFamily: "Poppins", color: Colors.white),
              ),
            ),

            //open button --------
            // --------

            // otherWidgets(),
          ],
        ),
      ),
    );
  }

  Widget otherWidgets() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  text.specializations.tr, 13.0, FontWeight.w500, Colors.black),
            ),
            const SizedBox(
              height: 5.0,
            ),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: customView.text(
            //       "Lorem ipsum dolor sit amet consectetur senectus sit iaculis viverra leo imperdiet nisl.",
            //       12.0,
            //       FontWeight.normal,
            //       Colors.black),
            // ),
            const SizedBox(
              height: 5.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.DAddSpecialization());
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customView.text(text.addSpecialization.tr, 14.0,
                            FontWeight.w500, MyColor.black),
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
              height: 20.0,
            ),
            /*Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  "Offices and addresses", 13.0, FontWeight.w500, Colors.black),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  "Lorem ipsum dolor sit amet consectetur senectus sit iaculis viverra leo imperdiet nisl.",
                  12.0,
                  FontWeight.normal,
                  Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DoctorSelectAddress()));
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customView.text("Add address", 14.0, FontWeight.w500,
                            MyColor.black),
                        const Icon(
                          Icons.arrow_forward,
                          size: 20.0,
                          color: MyColor.black,
                        ),
                      ],
                    ),
                  )),
            ),*/
            // Container(
            //   decoration: BoxDecoration(
            //       color: MyColor.white,
            //       border: Border.all(color: MyColor.black)
            //   ),
            //   child: customView.searchField(context, searchctr, "Your address or offices", TextInputType.text, const Icon(Icons.add), const Text(""), () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const DoctorSelectAddress()));
            //   }),
            // ),
           /* const SizedBox(
              height: 17.0,
            ),*/
          ],
        ),
      ),
    );
  }

  //  for Aadhar ID //
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

  void _choose(ImageSource source) async {
    final pickedFile = await degreepicker.getImage(
        source: source, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        degreefilePath = File(pickedFile.path);
        List<int> imageBytes = degreefilePath!.readAsBytesSync();
        degreebaseimage = base64Encode(imageBytes);
        degreefilename = 'image_${DateTime.now()}_.jpg';
        print(degreebaseimage);
        print(degreefilename);
        customView.MySnackBar(context, "Degree Upload Successfully");
      } else {
        // MySnackBar(context, "Upload Field");

        print('No image selected.');
      }
    });
  }

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles == null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
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

}
