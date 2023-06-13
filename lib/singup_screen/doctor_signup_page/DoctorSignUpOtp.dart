import 'package:flutter/material.dart';
import 'package:medica/doctor_screens/controller/DoctorSignUpController.dart';

import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:get/get.dart';
import '../../Helper/RoutHelper/RoutHelper.dart';
import '../../helper/CustomView/CustomView.dart';

class DoctorSignUpOtp extends StatefulWidget {
  const DoctorSignUpOtp({Key? key}) : super(key: key);

  @override
  State<DoctorSignUpOtp> createState() => _DoctorSignUpOtpState();
}

class _DoctorSignUpOtpState extends State<DoctorSignUpOtp> {
  DoctorSignUpCtr doctorSignUpCtr = DoctorSignUpCtr();
  var name = "";
  var surname = "";
  var username = "";
  var email = "";
  var phoneno = "";
  var password = "";
  var category = "";
  var imagename = "";
  var imagebase = "";
  var address = "";
  var apiotp = "";
  var code = "";
  var lat = "";
  var long = "";
  var subcat ="";

  var birthDate  = "";
  var birthPlace  = "";
  var universityAttended  = "";
  var dateOfEnrol  = "";
  var registerOfBelonging  = "";
  var gender  = "";
  var graduationDate  = "";
  var qualificationDate  = "";


  @override
  void initState() {
    apiotp = Get.arguments;
    print(apiotp);
    gender = Get.parameters["gender"]!;
    subcat = Get.parameters["subcat"]!;
    category = Get.parameters["category"]!;
    print("doctor selcet category$category");
    name = Get.parameters["name"]!;
    surname = Get.parameters["surmane"]!;
    username = Get.parameters["username"]!;
    email = Get.parameters["email"]!;
    phoneno = Get.parameters["phone"]!;
    password = Get.parameters["password"]!;
    // category = Get.parameters["category"]!;
    imagename = Get.parameters["imagename"]!;
    imagebase = Get.parameters["imagebase"]!;
    address = Get.parameters["address"]!;
    code = Get.parameters["code"]!;
    lat = Get.parameters["lat"]!;
    long = Get.parameters["longitude"]!;

    birthDate = Get.parameters["birthDate"]!;
    birthPlace = Get.parameters["birthPlace"]!;
    universityAttended = Get.parameters["universityAttended"]!;
    dateOfEnrol = Get.parameters["dateOfEnrol"]!;
    registerOfBelonging = Get.parameters["registerOfBelonging"]!;

    graduationDate = Get.parameters["graduationDate"]!;
    qualificationDate = Get.parameters["qualificationDate"]!;



    // TODO: implement initState
    super.initState();
  }


  TextEditingController optctr = TextEditingController();

  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(

      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Obx(() {
            if(doctorSignUpCtr.loading.value){
              return custom.MyIndicator();
            }
            return custom.MyButton(context, "Verificate", () {
              if(validationotp()){
                doctorSignUpCtr.doctorSignup(context, name, surname, username, email, code, phoneno, password, category, imagename, imagebase,
                    address, lat, long, subcat,birthDate,birthPlace,
                    universityAttended,dateOfEnrol,registerOfBelonging,
                    gender,graduationDate,qualificationDate,() {
                  Get.offAllNamed(RouteHelper.getLoginScreen());
                });
              }
            }, MyColor.primary, const TextStyle(
                fontSize: 16, color: MyColor.white, fontFamily: "Poppins")
            );
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: height * 0.09
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.arrow_back_ios),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                custom.text("Verification", 23, FontWeight.w700, MyColor.black),
                SizedBox(
                    height: height * 0.02
                ),
                custom.text(
                    "We need to verificate your email to create your account. Please enter OTP number, we sent it on your email account.",
                    12, FontWeight.normal, MyColor.primary1),

                SizedBox(
                    height: height * 0.07
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: custom.text(
                      "Enter OTP number", 13, FontWeight.w600, MyColor.primary1),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                custom.myField(context, optctr, "Enter 4 characters",
                    TextInputType.emailAddress),
                SizedBox(
                  height: height * 0.03,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    custom.text("Not received??", 11, FontWeight.w500,
                        MyColor.primary1),
                    const Text("Send a new OTP number", style: TextStyle(
                      color: MyColor.primary1,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,),),
                    SizedBox(height: height * 0.01,),
                  ],
                ),
                SizedBox(
                  height: height * 0.33,
                ),

                SizedBox(height: height * 0.03,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  bool validationotp() {
    print("api otp${apiotp.toString()}");
    print("my otp${optctr.text.toString()}");
    if (optctr.text.isEmpty || optctr.text.length != 4) {
      custom.massenger(context, "plz filled all fild");
    } else if (apiotp == optctr.text) {
      print("Correct OTP");
      return true;
    } else {
      custom.massenger(context, "invalid otp");
      return false;
    }
    return false;
  }
}
