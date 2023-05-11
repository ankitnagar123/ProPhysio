import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../patient_screens/controller/auth_controllers/PatientSignUpController.dart';

class PatientSignUp extends StatefulWidget {
  const PatientSignUp({Key? key}) : super(key: key);

  @override
  State<PatientSignUp> createState() => _PatientSignUpState();
}

class _PatientSignUpState extends State<PatientSignUp> {
  /*-----------Getx Controller initialize----------------*/
  PatientSignUpCtr patientSignUpCtr = PatientSignUpCtr();

  //*************Controllers*************//
  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();

  TextEditingController usernameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController healthCardCtr = TextEditingController();

  TextEditingController weightCtr = TextEditingController();
  TextEditingController ageCtr = TextEditingController();
  TextEditingController heightCtr = TextEditingController();
  TextEditingController taxCtr = TextEditingController();
  TextEditingController birthPlaceCtr = TextEditingController();

  TextEditingController passwordCtr = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  bool _isHidden = true;

  CustomView customView = CustomView();
  String code = '';

  String _displayText(DateTime? date) {
    if (date != null) {
      return date.toString().split(' ')[0];
    } else {
      return 'Choose The Date';
    }
  }

  DateTime? startDate, endData;

  String _selectedGender = '';

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      bottomNavigationBar: Container(
          height: 35.0,
          decoration: const BoxDecoration(color: MyColor.midgray),
          child: Center(
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customView.text(
                      "Do you have an account?", 11, FontWeight.normal,
                      MyColor.primary1),
                  const Text("Sign-in",style:TextStyle(color: MyColor.primary1,fontWeight: FontWeight.w700,decoration: TextDecoration.underline) ,)

                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .shortestSide / 15,
            ), Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  "Name", 12.0, FontWeight.w600, MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(
                context, nameCtr, "Your name", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  "Surname", 12.0, FontWeight.w600,
                  MyColor.primary1),
            ),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(
                context, surnameCtr, "Your surname", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            customView.text(
                "Create a username", 12.0, FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(context, usernameCtr,
                "Your username", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            customView.text(
                "E-mail", 12.0, FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(context, emailCtr,
                "Enter a valid email", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            customView.text("Health card code", 12.0,
                FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(context, healthCardCtr,
                "Enter Your health code", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            customView.text("Age", 12.0,
                FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(context, ageCtr,
                "Enter your age", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            customView.text("Weight", 12.0,
                FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(context, weightCtr,
                "Enter your weight", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ), customView.text("Height", 12.0,
                FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(context, heightCtr,
                "Enter your height", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ), customView.text("TAX CODE", 12.0,
                FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(context, taxCtr,
                "Enter your tax code", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            customView.text("Birth place", 12.0,
                FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.myField(context, birthPlaceCtr,
                "Enter your birth place", TextInputType.text),
            const SizedBox(
              height: 17.0,
            ),
            customView.text("Gender", 12.0,
                FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
           Row(children: [
             Expanded(
               flex: 1,
               child: ListTile(
                 contentPadding: EdgeInsets.zero,
                 visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                 leading: Radio<String>(
                   value: 'male',
                   groupValue: _selectedGender,
                   onChanged: (value) {
                     setState(() {
                       _selectedGender = value!;
                       print(_selectedGender);
                     });
                   },
                 ),
                 title: const Text('Male'),
               ),
             ),
             Expanded(
               flex: 1,
               child: ListTile(
                 contentPadding: EdgeInsets.zero,
                 visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                 leading: Radio<String>(
                   value: 'female',
                   groupValue: _selectedGender,
                   onChanged: (value) {
                     setState(() {
                       _selectedGender = value!;
                       print(_selectedGender);

                     });
                   },
                 ),
                 title: const Text('Female'),
               ),
             ),
           ],),
            // Container(
            //     height: 45.0,
            //     width: MediaQuery
            //         .of(context)
            //         .size
            //         .width / 0.9,
            //     padding: const EdgeInsets.only(left: 10.0, bottom: 5),
            //     margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            //     decoration: BoxDecoration(
            //       color: MyColor.white,
            //         border: Border.all(color: Colors.black54),
            //         borderRadius: BorderRadius.circular(7)),
            //     child: TextFormField(
            //       onTap: () async {
            //         startDate = await pickDate();
            //         startDateController.text = _displayText(startDate);
            //         setState(() {});
            //       },
            //       readOnly: true,
            //       controller: startDateController,
            //       decoration: const InputDecoration(
            //         hintText: "Select Date",
            //         hintStyle: TextStyle(fontSize: 15),
            //         suffixIcon:
            //         Icon(Icons.calendar_month, color: MyColor.primary),
            //         border: InputBorder.none,
            //         focusedBorder: InputBorder.none,
            //         enabledBorder: InputBorder.none,
            //       ),
            //     )),
            const SizedBox(
              height: 22.0,
            ),
            customView.text(
                "Phone number", 12.0, FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            SizedBox(
              height: 50,
              width: widht * 1,
              child: IntlPhoneField(
                initialValue: "IT",
                controller: phoneCtr,
                decoration: const InputDecoration(
                  // focusedErrorBorder: InputBorder.none,
                  counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  constraints: BoxConstraints.expand(),
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                initialCountryCode: 'IT',
                onChanged: (phone) {
                  code = phone.countryCode;
                  print(phone.completeNumber);
                },
                onCountryChanged: (cod) {
                  code = cod.dialCode;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            const SizedBox(
              height: 17.0,
            ),
            customView.text(
                "Create a password", 12.0, FontWeight.w600, MyColor.primary1),
            const SizedBox(
              height: 3.0,
            ),
            customView.PasswordField(
                context, passwordCtr, "Enter at least 6 characters",
                TextInputType.text, GestureDetector(
                onTap: () {
                  setState(() {
                    _isHidden = !_isHidden;
                  });
                },
                child: _isHidden
                    ? const Icon(
                  Icons.visibility_off,
                  color: MyColor.primary1,
                  size: 18,
                )
                    : const Icon(
                  Icons.visibility,
                  color: MyColor.primary1,
                  size: 18,

                )),
                _isHidden),
            const SizedBox(
              height: 17.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Obx(() {
                if (patientSignUpCtr.loadingotp.value) {
                  return Center(child: customView.MyIndicator());
                }
                return customView.MyButton(
                  context,
                  "Sign up",
                      () {
                    var data = {
                      'name': nameCtr.text,
                      'surname': surnameCtr.text,
                      'username': usernameCtr.text,
                      'phone': phoneCtr.text,
                      'healthcard': healthCardCtr.text,
                      'email': emailCtr.text,
                      'password': passwordCtr.text,
                      'code': code,
                      'weight':weightCtr.text,
                      'height':heightCtr.text,
                      'tax':taxCtr.text,
                      'birthPlace':birthPlaceCtr.text,
                      'age':ageCtr.text,
                      'gender':_selectedGender,
                    };
                    if (_sendDataToVerificationScrn(context)) {
                      patientSignUpCtr.PatientSignupOtp(context, emailCtr.text)
                          .then((value) {
                        if (value != "") {
                          Get.toNamed(
                              RouteHelper.getSingUpOtpScreen(),
                              parameters: data, arguments: value);
                        } else {}
                      });
                    }
                  },
                  MyColor.primary,
                  const TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "Poppins"),);
              }),
            ),
          ],
        ),
      ),
    );
  }

  //*******date picker function************//
  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2999),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: MyColor.primary, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.brown, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: MyColor.primary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }


  bool _sendDataToVerificationScrn(BuildContext context) {
    if (nameCtr.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, "Name is required");
    }else if (surnameCtr.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, "Surname is required");
    }else if (usernameCtr.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, "Username is required");
    }else if (!RegExp('.*[a-z].*').hasMatch(usernameCtr.text.toString())) {
      customView.MySnackBar(context, "Username should contain a lowercase letter a-z or number.");
    } else if (emailCtr.text.toString().isEmpty) {
      customView.MySnackBar(context, "Email ID is required");
    }else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(emailCtr.text.toString())) {
      customView.MySnackBar(context, "Enter valid email");
    }  else if (healthCardCtr.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, "Health Card is required");
    } else if (ageCtr.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, "Age is required");
    }else if (weightCtr.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, "Weight is required");
    }else if (heightCtr.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, "Height is required");
    } else if (taxCtr.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, "Tax Code is required");
    }else if (birthPlaceCtr.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, "Birthplace is required");
    }else if (_selectedGender == "") {
      customView.MySnackBar(context, "Select gender");
    }else if (phoneCtr.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, "Phone no. is required");
    }else if (passwordCtr.text
        .toString()
        .isEmpty) {
      customView.MySnackBar(context, "Password is required");
    }else if (passwordCtr.text.toString().length < 6) {
      customView.MySnackBar(context, "Password should be 6 digit");
    }else {
      return true;
    }
    return false;
  }
}
