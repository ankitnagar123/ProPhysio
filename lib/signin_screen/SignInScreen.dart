import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:prophysio/signin_screen/signin_controller/SignInController.dart';

import '../Helper/RoutHelper/RoutHelper.dart';
import '../helper/CustomView/CustomView.dart';
import '../helper/mycolor/mycolor.dart';
import '../language_translator/LanguageTranslate.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  LoginCtr loginCtr = LoginCtr();
  LocalString text = LocalString();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  bool submit = false;
  final _formKey = GlobalKey<FormState>();
  var enLocal;
  var itLocal;

  @override
  void initState() {
    super.initState();
    emailCtr.addListener(() {
      setState(() {
        submit = emailCtr.text.isNotEmpty;
      });
    });
  }

  CustomView custom = CustomView();
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          bottomNavigationBar: SizedBox(
              height: 100.0,
              child: Center(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Column(
                    children: [
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: passwordCtr,
                        builder: (context, value, child) {
                          return Obx(() {
                            if (loginCtr.loading.value) {
                              return custom.MyIndicator();
                            }
                            return custom.MyButton(context, text.SIGN_IN.tr,
                                () {
                              /* itLocal = const Locale('it','IT');
                        Get.updateLocale(itLocal);*/
                              if (validation()) {
                                loginCtr.login(
                                    context, emailCtr.text, passwordCtr.text);
                              }
                            },
                                value.text.isNotEmpty
                                    ? MyColor.red
                                    : MyColor.grey,
                                const TextStyle(
                                    fontSize: 17, color: MyColor.white));
                          }); /*ElevatedButton(
                        onPressed: value.text.isNotEmpty ? () {} : null,
                        child: Text('I am disabled when text is empty'),
                      );*/
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          custom.text(text.Dont_have_an_account.tr, 12,
                              FontWeight.w500, MyColor.primary1),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(RouteHelper.getSingUpScreen());
                            },
                            child: Text(
                              text.Sign_UP.tr.toUpperCase(),
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: MyColor.primary1,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: height / 14),
                  const Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage("assets/images/prologo1.png"),
                      // height: 100,
                      width: 170,
                    ),
                  ),
                  SizedBox(height: 10),
                  custom.text(
                      "Welcome back!", 18, FontWeight.w500, MyColor.primary1),
                  custom.text("Login to your account", 11, FontWeight.normal,
                      MyColor.grey),
                  SizedBox(height: height * 0.08),
                  Align(
                    alignment: Alignment.topLeft,
                    child: custom.text(text.HINT_ENTER_USER_EMAIL.tr, 12,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: height * 0.002,
                  ),
                  custom.myField(context, emailCtr, text.ENTER_USER_EMAIL.tr,
                      TextInputType.emailAddress),
                  SizedBox(
                    height: height * 0.020,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: custom.text(text.HINT_ENTER_Password.tr, 12,
                        FontWeight.w500, MyColor.primary1),
                  ),
                  SizedBox(
                    height: height * 0.002,
                  ),
                  custom.PasswordField(
                      context,
                      passwordCtr,
                      text.Enter_Password.tr,
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
                    height: height * 0.012,
                  ),
                  Row(
                    children: [
                      custom.text(text.Forgot_Password.tr, 11, FontWeight.w500,
                          MyColor.primary1),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp()));
                          Get.toNamed(RouteHelper.getForgotPasswordScreen());
                        },
                        child: Text(
                          text.Create_New_One.tr,
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: MyColor.primary1,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.25),
                  const SizedBox(
                    height: 4,
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
      custom.MySnackBar(context, text.Required_Email_or_Username.tr);
    } else if (passwordCtr.text.toString().isEmpty) {
      custom.MySnackBar(context, text.Required_Password.tr);
    } else {
      return true;
    }
    return false;
  }
}
