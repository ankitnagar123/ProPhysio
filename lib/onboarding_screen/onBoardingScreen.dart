import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../Helper/RoutHelper/RoutHelper.dart';
import '../doctor_screens/view/doctor_main_page/doctor_more_page/doctor_term_condition_page/DoctorTermCondition.dart';
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(8),
          child: customView.MyButton(context, "let's go", () {
            sp.setBoolValue(sp.ON_BOARDING_KEY, true);
            Get.offNamed(RouteHelper.getLoginScreen());
          },
              MyColor.red,
              const TextStyle(
                  fontSize: 15.0, color: MyColor.white, fontFamily: "Poppins")),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.3,
                          0.6,
                        ],
                        colors: [
                          Color(0xff003D7C),
                          Color(0xff0172B9),
                        ]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                width: double.infinity,
                child: const Center(
                  child: Image(
                    image: AssetImage("assets/images/prologo.png"),
                    width: 220,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // const Align(
              //   alignment: Alignment.topLeft,
              //   child: Image(
              //     image: AssetImage("assets/images/loading.gif"),
              //     height: 60,
              //     width: 60,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: customView.text(
                        'Hey! 😊', 20, FontWeight.bold, MyColor.primary1)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 20, top: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: customView.text(
                      "Welcome on PRO PHYSIO. Sign in to navigate among the doctors and book all kind of visits you need, for yourself or others.",
                      14,
                      FontWeight.normal,
                      MyColor.primary1),
                ),
              ),
              const SizedBox(
                height: 55.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
