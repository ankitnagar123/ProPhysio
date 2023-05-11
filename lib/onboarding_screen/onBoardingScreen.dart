import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../Helper/RoutHelper/RoutHelper.dart';
import '../helper/CustomView/CustomView.dart';
import '../helper/mycolor/mycolor.dart';
import '../helper/sharedpreference/SharedPrefrenc.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({Key? key}) : super(key: key);

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  CustomView customView = CustomView();
  SharedPreferenceProvider sp = SharedPreferenceProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.3,
                          0.6,
                        ],
                        colors: [
                          Color(0xff5376AA),
                          Color(0xffF6A6CD),
                        ]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                width: double.infinity,
                child: const Center(
                  child: Image(image: AssetImage("assets/images/medicalogo2.png"),height: 80,width: 80),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Image(
                  image: AssetImage("assets/images/MEDICAlogo1.png"),
                  height: 95,
                  width: 110,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: customView.text(
                        'Hey! 😊', 20, FontWeight.bold, MyColor.black)),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 32, right: 20, top: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: customView.text(
                      "Welcome on Medica. Sign in to navigate among the doctors and book all kind of visits you need, for yourself or others.",
                      14,
                      FontWeight.normal,
                      MyColor.primary1),
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              customView.MyButton(context, "let's go", () {
                sp.setBoolValue(sp.ON_BOARDING_KEY, true);
                Get.offNamed(RouteHelper.getLoginScreen());
              }, MyColor.primary,
                  const TextStyle(fontSize: 15.0, color: MyColor.white,fontFamily: "Poppins")),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.offNamed(RouteHelper.DTandCScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Terms and conditions",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: MyColor.primary1,
                          fontSize: 12),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: MyColor.primary1,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
