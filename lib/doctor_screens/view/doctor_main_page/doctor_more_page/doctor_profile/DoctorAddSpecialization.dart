import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

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
              "Specialization", 15.0, FontWeight.w500, Colors.black),
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
            customView.text("Category", 10.0, FontWeight.w600, MyColor.black),
            SizedBox(
              height: height * 0.01,
            ),
            category(),
            SizedBox(
              height: height * 0.02,
            ),
            customView.text(
                "Sub-category", 10.0, FontWeight.w600, MyColor.black),
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
                  "Description", 14.0, FontWeight.w600, Colors.black),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  "Please add a description to tell about your experience, educational qualifications or skills. This information will be visible to medical centers and patients",
                  12.0,
                  FontWeight.normal,
                  Colors.black),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            customView.text(
                "Your description", 10.0, FontWeight.w600, MyColor.black),
            SizedBox(
              height: height * 0.01,
            ),
            customView.myField(context, discriptionCtr, "Your description",
                TextInputType.text),
            SizedBox(
              height: height * 0.05,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: customView.text(
                  "Services price", 14.0, FontWeight.w600, Colors.black),
            ),
            GestureDetector(
              onTap: () {
                visitPopUp(context);
                // Get.toNamed(RouteHelper.DAddSpecialization());
              },
              child: Container(
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
                        customView.text(
                            "Add visit", 14.0, FontWeight.w500, MyColor.black),
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
            Align(
              alignment: Alignment.center,
              child: addSpecializationCtr.loading.value
                  ? Center(
                      child: customView.MyIndicator(),
                    )
                  : AnimatedButton(
                      width: MediaQuery.of(context).size.width * 0.9,
                      text: 'Add specialization',
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
                           Get.back();
                            () {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.leftSlide,
                                headerAnimationLoop: false,
                                dialogType: DialogType.success,
                                showCloseIcon: true,
                                title: 'Success',
                                desc: 'Add Successfully',
                                btnOkOnPress: () {
                                  debugPrint('OnClcik');
                                },
                                btnOkIcon: Icons.check_circle,
                                onDismissCallback: (type) {
                                  debugPrint(
                                      'Dialog Dissmiss from callback $type');
                                },
                              ).show();
                              // Get.back();
                            };
                          });
                        }
                      },
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
                            child: customView.text("Add service", 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: customView.text(
                                "Please enter the service name and the price.",
                                12,
                                FontWeight.w400,
                                Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Enter the name", 13,
                                FontWeight.w600, MyColor.black),
                          ),
                          const SizedBox(height: 5.0),
                          customView.myField(context, visitnameCtr,
                              "Visit’s name", TextInputType.name),
                          const SizedBox(height: 15.0),
                          Align(
                            alignment: Alignment.topLeft,
                            child: customView.text("Enter price", 13,
                                FontWeight.w600, MyColor.black),
                          ),
                          const SizedBox(height: 5.0),
                          customView.myField(context, feeCtr, "Enter price",
                              TextInputType.name),
                          const SizedBox(height: 10.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: customView.text("Dismiss", 14.0,
                                      FontWeight.w500, MyColor.grey),
                                ),
                                customView.mysButton(context, "Add visit", () {
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
      customView.MySnackBar(context, "Select category");
    } else if (slectedsubCategory == null) {
      customView.MySnackBar(context, "Select sub-category");
    } else if (discriptionCtr.text.isEmpty) {
      customView.MySnackBar(context, "Enter description");
    } else if (visitNames.isEmpty) {
      customView.MySnackBar(context, "Enter visit name with charges");
    } else if (visitFee.isEmpty) {
      customView.MySnackBar(context, "Enter charges");
    } else {
      return true;
    }
    return false;
  }

  bool validationVisit() {
    if (visitnameCtr.text.isEmpty) {
      customView.MySnackBar(context, "Enter visit name");
    } else if (feeCtr.text.isEmpty) {
      customView.MySnackBar(context, "Enter visit charge");
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
                  hint: const Text("Select Category"),
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
                  hint: const Text("Select Sub-Category"),
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
