import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../controller/DocotorBookingController.dart';

class DoctorChatProfile extends StatefulWidget {
  const DoctorChatProfile({Key? key}) : super(key: key);

  @override
  State<DoctorChatProfile> createState() => _DoctorChatProfileState();
}

class _DoctorChatProfileState extends State<DoctorChatProfile> {
  CustomView customView = CustomView();
  BookingController bookingController = Get.put(BookingController());
  String patientId = "";
  String patientName = "";
  String patientPic = "";
  String patientSurname = "";
  String patientUsername = "";
  String patientAddress = "";

  @override
  void initState() {
    super.initState();
    if (Get.arguments["bookingSide"] == "booking") {
      patientId = Get.parameters["ID"].toString();
      patientName = Get.arguments["name"];
      patientPic = Get.arguments["pic"];
      patientSurname = Get.arguments["surname"];
      patientUsername = Get.arguments["username"];
      patientAddress = Get.arguments["userLocation"];
      print(patientAddress);
      } else {
      patientId = Get.arguments["ID"];
      patientName = Get.arguments["name"];
      patientPic = Get.arguments["pic"];
      patientSurname = Get.arguments["surname"];
      patientUsername = Get.arguments["username"];
      patientAddress = Get.arguments["address"];
      print(patientAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customView.callButton(context, "Call", () {
              UrlLauncher.launchUrl(
                  Uri.parse('tel:${bookingController.contact.value}'));
            },
                MyColor.primary,
                const TextStyle(
                  color: MyColor.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                Icons.call),
            customView.callButton(context, "Message", () {
              Get.back();
            },
                MyColor.primary,
                const TextStyle(
                  color: MyColor.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                Icons.chat_bubble_outline_outlined)
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: customView.text(
            "@$patientUsername", 17, FontWeight.bold, MyColor.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyColor.black,
            size: 18,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                imagePopUp(context, patientPic);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120.0),
                child: FadeInImage.assetNetwork(
                  imageErrorBuilder: (context, error, stackTrace) {
                    return const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image(
                          image: AssetImage("assets/images/dummyprofile.jpg")),
                    );
                  },
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: "assets/images/loading.gif",
                  image: patientPic,
                  placeholderFit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Align(
                alignment: Alignment.center,
                child: customView.text("$patientName $patientSurname", 18,
                    FontWeight.w500, MyColor.black)),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: MyColor.grey,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: customView.text(
                      patientAddress, 12, FontWeight.normal, MyColor.grey),
                ),
              ],
            )
          ],
        ),
      ),
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
}
