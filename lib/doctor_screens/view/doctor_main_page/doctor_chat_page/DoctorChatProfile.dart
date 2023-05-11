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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customView.callButton(
                  context,
                  "Call",
                      () {
                    UrlLauncher.launchUrl(Uri.parse(
                        'tel:${bookingController.contact.value}'));
                  },
                  MyColor.primary,
                  const TextStyle(
                    color: MyColor.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  Icons.call),
              customView.callButton(context, "Massage", () {
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
              "@${bookingController.name.value}", 17, FontWeight.bold,
              MyColor.black),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios, color: MyColor.black, size: 18,),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Divider(),
              const SizedBox(height: 20,),
              const CircleAvatar(
                radius: 62.0,
                backgroundImage: AssetImage("assets/images/doctorimg.png"),
              ),
              const SizedBox(height: 10.0,),

              Align(
                  alignment: Alignment.center,
                  child: customView.text(
                      bookingController.username.value, 18, FontWeight.w500,
                      MyColor.black)),
              const SizedBox(height: 16.0,),
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
                        "Via Massimiliano d’Azeglio 14, Torino (TO)", 12,
                        FontWeight.normal, MyColor.grey),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
