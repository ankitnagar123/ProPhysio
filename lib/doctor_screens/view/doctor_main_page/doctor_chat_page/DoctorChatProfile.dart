import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../controller/DocotorBookingController.dart';

class DoctorChatProfile extends StatefulWidget {
  const DoctorChatProfile({super.key});

  @override
  State<DoctorChatProfile> createState() => _DoctorChatProfileState();
}

class _DoctorChatProfileState extends State<DoctorChatProfile> {
  CustomView customView = CustomView();
  LocalString text = LocalString();

  BookingController bookingController = Get.put(BookingController());
  String patientId = "";
  String patientName = "";
  String patientPic = "";
  String patientSurname = "";
  String patientAddress = "";

  bool readMore = false;

  @override
  void initState() {
    super.initState();
   /* if (Get.arguments["bookingSide"] == "booking") {
      patientId = Get.parameters["ID"].toString();
      patientName = Get.arguments["name"];
      patientPic = Get.arguments["pic"];
      patientSurname = Get.arguments["surname"];
      patientUsername = Get.arguments["username"];
       patientAddress = Get.arguments["address"];
      print(patientAddress);
      } else {
      patientId = Get.arguments["ID"];
      patientName = Get.arguments["name"];
      patientPic = Get.arguments["pic"];
      patientSurname = Get.arguments["surname"];
      patientUsername = Get.arguments["username"];
       patientAddress = Get.arguments["address"];
      print(patientAddress);
    }*/
    patientId = Get.parameters["ID"].toString();
    patientName = Get.parameters["name"].toString();
    patientPic = Get.parameters["pic"].toString();
    patientSurname = Get.parameters["surname"].toString();
    patientAddress = Get.parameters["address"].toString();
    print("profile address user $patientAddress");
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
            customView.callButton(context, text.call.tr, () {
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
            customView.callButton(context, text.Message.tr, () {
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
        bottom: PreferredSize(preferredSize: Size.fromHeight(1), child: Divider(color: Colors.grey,)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: customView.text(
            "Profile", 17, FontWeight.bold, MyColor.black),
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
                          image: AssetImage("assets/images/dummyprofile.png")),
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
                child: customView.text("$patientName $patientSurname".toUpperCase(), 18,
                    FontWeight.w500, MyColor.black)),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 22,
                  color: MyColor.primary1,
                ),
                SizedBox(
                   width: readMore ?MediaQuery.sizeOf(context).width/1.2:MediaQuery.sizeOf(context).width/1.2,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          readMore = !readMore;
                        });
                      },
                      child: Text(patientAddress,overflow: TextOverflow.ellipsis,
                        maxLines: readMore ? 3:1,
                      ),
                    ),

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void imagePopUp(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Image(
                            image: AssetImage("assets/images/noimage.png"));
                      },
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.contain,
                      placeholder: "assets/images/loading.gif",
                      image: image,
                      placeholderFit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    right:1,
                    child: InkWell(
                        onTap:() {
                          Get.back();
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: MyColor.primary1,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: const Icon(Icons.close,color: Colors.white,))))
              ]
          ),
        );
      },
    );
  }

}
