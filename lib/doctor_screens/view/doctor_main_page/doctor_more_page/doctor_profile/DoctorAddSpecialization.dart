import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../patient_screens/controller/doctor_list_ctr/DoctorListController.dart';
import '../../../../controller/AddSpecializationCtr.dart';
import '../../../../controller/DoctorProfileController.dart';
import '../../../../controller/DoctorSignUpController.dart';

class DoctorAddSpecialization extends StatefulWidget {
  const DoctorAddSpecialization({Key? key}) : super(key: key);

  @override
  State<DoctorAddSpecialization> createState() =>
      _DoctorAddSpecializationState();
}

class _DoctorAddSpecializationState extends State<DoctorAddSpecialization> {
  CustomView customView = CustomView();
  LocalString text = LocalString();

  DoctorProfileCtr doctorProfileCtr = Get.put(DoctorProfileCtr());
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());

  AddSpecializationCtr addSpecializationCtr = Get.put(AddSpecializationCtr());
  String? slectedCategory;
  String? slectedsubCategory;

  @override
  TextEditingController discriptionCtr = TextEditingController();
  TextEditingController visitnameCtr = TextEditingController();
  TextEditingController feeCtr = TextEditingController();

  final List<String> visitNames = <String>[];
  final List<String> visitFee = <String>[];
  String? visitList;
  String? feeList;

  void addItemToList() {
    setState(() {
      visitNames.insert(0, visitnameCtr.text);
      visitList = visitNames.join(',');
      print("comma ,,,,$visitList");
      // print("=>>>>Visit Charge${visitNames}");
      visitFee.insert(0, feeCtr.text);
      feeList = visitFee.join(',');
      // print("=>>>>Visit Charge${visitFee}");
      print("=>>>>Visit Charge$feeList");
    });
  }

  @override
  void initState() {
    addSpecializationCtr.doctorSelectedCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: customView.text(
              text.specializations.tr, 15.0, FontWeight.w500, Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white24,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Divider(
              thickness: 1.5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.shortestSide / 15,
            ),
            customView.text(text.category.tr, 10.0, FontWeight.w600, MyColor.black),
            SizedBox(
              height: height * 0.01,
            ),
            category(),
            SizedBox(
              height: height * 0.02,
            ),
            customView.text(
                text.subCategory.tr, 10.0, FontWeight.w600, MyColor.black),
            subcategory(),
            const Divider(
              thickness: 1.5,
              height: 60,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  text.description.tr, 14.0, FontWeight.w600, Colors.black),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                 text.descriptionDetail.tr,
                  12.0,
                  FontWeight.normal,
                  Colors.black),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            customView.text(
                text.yourDescription.tr, 10.0, FontWeight.w600, MyColor.black),
            SizedBox(
              height: height * 0.01,
            ),
            customView.myField(context, discriptionCtr,  text.yourDescription.tr,
                TextInputType.text),
            SizedBox(
              height: height * 0.05,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  text.servicesPrice.tr, 14.0, FontWeight.w600, Colors.black),
            ),
            GestureDetector(
              onTap: () {
                visitPopUp(context);
                // Get.toNamed(RouteHelper.DAddSpecialization());
              },
              child: Container(
                  height: 47.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: MyColor.midgray,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customView.text(
                            text.addVisit.tr, 14.0, FontWeight.w500, MyColor.black),
                        const Icon(
                          Icons.arrow_forward,
                          size: 20.0,
                          color: MyColor.black,
                        ),
                      ],
                    ),
                  )),
            ),
            SingleChildScrollView(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: visitNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 50.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: MyColor.midgray,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customView.text(visitNames[index], 14.0,
                                  FontWeight.w500, MyColor.black),
                              const Icon(
                                Icons.arrow_forward,
                                size: 20.0,
                                color: MyColor.black,
                              ),
                            ],
                          ),
                        ));
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.center,
                child: addSpecializationCtr.loading.value
                    ? Center(
                        child: customView.MyIndicator(),
                      )
                    : AnimatedButton(
                        width: MediaQuery.of(context).size.width * 0.9,
                        text: text.addSpecialization.tr,
                        color: MyColor.primary,
                        pressEvent: () {
                          if (validation()) {
                            addSpecializationCtr.addSpecializationFee(
                                context,
                                slectedCategory.toString(),
                                slectedsubCategory.toString(),
                                discriptionCtr.text,
                                visitList!,
                                feeList!, () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.leftSlide,
                                headerAnimationLoop: false,
                                dialogType: DialogType.success,
                                showCloseIcon: true,
                                title: text.success.tr,
                                desc: text.addSuccessfully.tr,
                                btnOkOnPress: () {
                                  Get.back();
                                  debugPrint('OnClcik');
                                },
                                btnOkIcon: Icons.check_circle,
                                onDismissCallback: (type) {
                                  debugPrint(
                                      'Dialog Dissmiss from callback $type');
                                },
                              ).show();
                            });
                          }
                        },
                      ),
              ),
            ),
          ]),
        ),

        // bottomNavigationBar: Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        //   child: Obx(() {
        //     if (addSpecializationCtr.loading.value) {
        //       return Center(
        //         child: customView.MyIndicator(),
        //       );
        //     }
        //     return customView.MyButton(
        //       context,
        //       "",
        //           () {},
        //       MyColor.primary,
        //       const TextStyle(fontFamily: "Poppins", color: Colors.white),
        //     );
        //   }),
        // ),
      ),
    );
  }

  void visitPopUp(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text(text.addService.tr, 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text(
                                text.pleaseEnterServiceNamePrice.tr,
                                12,
                                FontWeight.w400,
                                Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text(text.enterTheName.tr, 13,
                                FontWeight.w600, MyColor.black),
                          ),
                          const SizedBox(height: 5.0),
                          customView.myField(context, visitnameCtr,
                              text.visitName.tr, TextInputType.name),
                          const SizedBox(height: 15.0),
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text(text.enterPrice.tr, 13,
                                FontWeight.w600, MyColor.black),
                          ),
                          const SizedBox(height: 5.0),
                          customView.myField(context, feeCtr,text.enterPrice.tr,
                              TextInputType.name),
                          const SizedBox(height: 10.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: customView.text(text.Dismiss.tr, 14.0,
                                      FontWeight.w500, MyColor.grey),
                                ),
                                customView.mysButton(context, text.addVisit.tr, () {
                                  if (validationVisit()) {
                                    addItemToList();
                                    Get.back();
                                  }
                                  /* if (validation()) {
                                    addSpecializationCtr.addFeeApi(
                                      context,
                                      visitnameCtr.text,
                                      () {
                                        Get.back();
                                      },
                                      feeCtr.text,
                                    );
                                  }*/
                                  /* changePassCtr.deleteAccount(context, passwordCtr.text, () {
                                      Get.offAllNamed(RouteHelper.getLoginScreen());
                                    });*/
                                },
                                    MyColor.primary,
                                    const TextStyle(
                                      color: MyColor.white,
                                    ))
                              ])
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }

  bool validation() {
    if (slectedCategory == null) {
      customView.MySnackBar(context, text.selectCategory.tr);
    } else if (slectedsubCategory == null) {
      customView.MySnackBar(context, text.selectSubCategory.tr);
    } else if (discriptionCtr.text.isEmpty) {
      customView.MySnackBar(context, text.enterDescription.tr);
    } else if (visitNames.isEmpty) {
      customView.MySnackBar(context,text.enterVisitNameCharges.tr);
    } else if (visitFee.isEmpty) {
      customView.MySnackBar(context, text.enterCharges.tr);
    } else {
      return true;
    }
    return false;
  }

  bool validationVisit() {
    if (visitnameCtr.text.isEmpty) {
      customView.MySnackBar(context, text.enterVisitName.tr);
    } else if (feeCtr.text.isEmpty) {
      customView.MySnackBar(context,text.enterVisitCharge.tr);
    } else {
      return true;
    }
    return false;
  }

  Widget category() {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Center(
          child: Obx(() {
            if (addSpecializationCtr.categoryloding.value) {
              return customView.MyIndicator();
            }
            return Container(
              height: height * 0.06,
              width: widht * 0.9,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
              decoration: BoxDecoration(
                  color: MyColor.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: MyColor.grey)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  menuMaxHeight: MediaQuery.of(context).size.height / 3,
                  // Initial Value
                  value: slectedCategory,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: MyColor.primary),
                  // Array list of items
                  items: addSpecializationCtr.selectedCategory.map((items) {
                    return DropdownMenuItem(
                      value: items.categoryId,
                      child: Text(items.categoryName),
                    );
                  }).toList(),
                  hint:  Text(text.selectCategory.tr),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (newValue) {
                    stateSetter(() {
                      slectedCategory = newValue;
                      log('$slectedCategory');
                    });
                    addSpecializationCtr
                        .doctorSelectedSubCategory(slectedCategory.toString());
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget subcategory() {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Center(
          child: Obx(() {
            if (addSpecializationCtr.categorySubLoading.value) {
              return customView.MyIndicator();
            }
            return Container(
              height: height * 0.06,
              width: widht * 0.9,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
              decoration: BoxDecoration(
                  color: MyColor.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: MyColor.grey)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  menuMaxHeight: MediaQuery.of(context).size.height / 3,
                  // Initial Value
                  value: slectedsubCategory,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: MyColor.primary),
                  // Array list of items
                  items: addSpecializationCtr.selectedSubCategory.map((items) {
                    return DropdownMenuItem(
                      value: items.subcatId,
                      child: Text(items.subcatName),
                    );
                  }).toList(),
                  hint:  Text(text.selectSubCategory.tr),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (newValue) {
                    stateSetter(() {
                      slectedsubCategory = newValue;
                      log('$slectedsubCategory');
                    });
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
