import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/signin_screen/signin_controller/SignInController.dart';

import '../helper/CustomView/CustomView.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  LoginCtr loginCtr = LoginCtr();
  final TextEditingController _inputController = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  bool submit = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailCtr.addListener(() {
      setState(() {
        submit = emailCtr.text.isNotEmpty;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  CustomView custom = CustomView();
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.12),
                  custom.text("Sign in", 23, FontWeight.w700, MyColor.black),
                  SizedBox(height: height * 0.08),
                  Align(
                    alignment: Alignment.topLeft,
                    child: custom.text("Enter your username/email", 13,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  custom.myField(context, emailCtr, "Enter Email ID/User Id",
                      TextInputType.emailAddress),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: custom.text("Enter your Password", 13,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  custom.PasswordField(
                      context,
                      passwordCtr,
                      "Enter Password",
                      TextInputType.text,
                      GestureDetector(
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
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      custom.text("Forgot password?", 12, FontWeight.w500,
                          MyColor.primary1),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp()));
                          Get.toNamed(RouteHelper.getForgotPasswordScreen());
                        },
                        child: const Text(
                          "Create a new one",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: MyColor.primary1,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.25),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: passwordCtr,
                    builder: (context, value, child) {
                      return Obx(() {
                        if (loginCtr.loading.value) {
                          return custom.MyIndicator();
                        }
                        return custom.MyButton(context, "Sign in", () {
                          if (validation()) {
                            loginCtr.login(
                                context, emailCtr.text, passwordCtr.text);
                          }
                        },
                            value.text.isNotEmpty
                                ? MyColor.primary
                                : MyColor.grey,
                            const TextStyle(
                                fontSize: 18, color: MyColor.white));
                      }); /*ElevatedButton(
                        onPressed: value.text.isNotEmpty ? () {} : null,
                        child: Text('I am disabled when text is empty'),
                      );*/
                    },
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      custom.text("Don’t have an account?", 12, FontWeight.w500,
                          MyColor.primary1),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(RouteHelper.getSingUpScreen());
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: MyColor.primary1,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //******************LOGIN VALIDATION (IF/ELSE CONDITIONS.)*****************//
  bool validation() {
    if (emailCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Required Email or Username");
    } else if (emailCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Enter Valid email address");
    } else if (passwordCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, "Incorrect Password or Username");
    } else {
      return true;
    }
    return false;
  }
}
