import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
class PatientEditLocation extends StatefulWidget {
  const PatientEditLocation({Key? key}) : super(key: key);

  @override
  State<PatientEditLocation> createState() => _PatientEditLocationState();
}

class _PatientEditLocationState extends State<PatientEditLocation> {
  TextEditingController  labelCtr = TextEditingController();
  TextEditingController  addressCtr = TextEditingController();
  TextEditingController  capCtr = TextEditingController();


  CustomView custom = CustomView();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: custom.text("Edit location", 17, FontWeight.bold, MyColor.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close_outlined, color: MyColor.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: custom.MyButton(context, "Edit location", () {
          Get.back();
        }, MyColor.primary,
            const TextStyle(color: MyColor.white, fontFamily: "Poppins")),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const Divider(),
              SizedBox(
                height: height * 0.03,
              ),
              custom.text(
                  "Edit to address to calculate the distance\n from.", 13, FontWeight.w500, MyColor.black),
              SizedBox(
                height: height * 0.04,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: custom.text(
                    "Set label", 13.0, FontWeight.w500, Colors.black),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              custom.myField(context, labelCtr,
                  "Your user label", TextInputType.text),
              SizedBox(
                height: height * 0.04,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: custom.text(
                    "Enter the address", 13.0, FontWeight.w500, Colors.black),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              custom.myField(context, labelCtr,
                  "Your address", TextInputType.text),SizedBox(
                height: height * 0.04,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: custom.text(
                    "Enter CAP", 13.0, FontWeight.w500, Colors.black),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              custom.myField(context, labelCtr,
                  "Your CAP", TextInputType.text),

            ],
          ),
        ),
      ),
    );
  }
}
