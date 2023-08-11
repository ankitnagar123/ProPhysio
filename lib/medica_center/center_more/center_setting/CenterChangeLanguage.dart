import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../language_translator/LanguageTranslate.dart';


class CenterLanguagePage extends StatefulWidget {
  const CenterLanguagePage({Key? key}) : super(key: key);

  @override
  State<CenterLanguagePage> createState() => _CenterLanguagePageState();
}

class _CenterLanguagePageState extends State<CenterLanguagePage> {
  LocalString text = LocalString();
  CustomView customView = CustomView();
  var enlocal;
  var Itlocal;
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  int? index;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
          child:  customView.MyButton(
            context,
            text.Submit.tr,
                () {
              Get.back();
            },
            MyColor.primary,
            const TextStyle(fontFamily: "Poppins", color: Colors.white),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title:   Text(
            text.Language.tr,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
        ),
        body: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  text.Select_language.tr,
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          index = 1;
                          enlocal = const Locale('en','US');
                          sp.setStringValue(sp.LANGUAGE, "en");
                          Get.updateLocale(enlocal);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow:  const [
                                BoxShadow(
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0,
                                    color: Colors.black26
                                )
                              ],
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Card(
                              elevation: 0.0,
                              shape:index==1?  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side:  BorderSide(color: MyColor.primary,width: 3)
                              ):null ,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/img_1.png",
                                      width: 80,
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                     text.English.tr,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          index = 2;
                          Itlocal= const Locale('it','IT');
                          sp.setStringValue(sp.LANGUAGE, "it");
                          Get.updateLocale(Itlocal);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow:  const [
                                BoxShadow(
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0,
                                    color: Colors.black26
                                )
                              ],
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Card(
                              elevation: 0.0,
                              shape:index == 2?  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side:  BorderSide(color: MyColor.primary,width: 3)
                              ):null ,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/Flagitaly.png",
                                      width: 80,
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      text.Italian.tr,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ]),
      ),
    );
  }
}

