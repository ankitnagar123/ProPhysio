import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prophysio/patient_screens/view/IntakeForm/answerCtr.dart';
import 'package:prophysio/patient_screens/view/IntakeForm/widgets/medical_radio_card.dart';
import 'package:prophysio/patient_screens/view/IntakeForm/widgets/ratingselect_card1.dart';

import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';

class IntakeFormScreen extends StatefulWidget {
  final bookingId;
  const IntakeFormScreen({super.key, this.bookingId});

  @override
  State<IntakeFormScreen> createState() => _IntakeFormScreenState();
}

class _IntakeFormScreenState extends State<IntakeFormScreen> {
  final CustomView customView = CustomView();
  final _imageKey = GlobalKey<ImagePainterState>();
  File? _file = null;
  int _curr = 1;

  PageController controller = PageController();
  LocalString text = LocalString();

  IntakeController intakeController = Get.put(IntakeController());

  @override
  void initState() {
    log("message*****${widget.bookingId}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<IntakeController>().fetchintakeFormQue("pain_rating");
      Get.find<IntakeController>().fetchintakeFormQue("medical_history");
      Get.find<IntakeController>().fetchintakeFormQue("medical_testing");
      Get.find<IntakeController>().fetchintakeFormQue("general_health");
      Get.find<IntakeController>().fetchintakeFormQue("work_environment");
      Get.find<IntakeController>().fetchintakeFormQue("home_environment");
    });
    // TODO: implement initState
    super.initState();
  }

  void saveImage() async {
    final image = await _imageKey.currentState?.exportImage();

    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath =
        '$directory/sample/${DateTime.now().millisecondsSinceEpoch}.png';
    final imgFile = File(fullPath);
    if (image != null) {
      imgFile.writeAsBytesSync(image);
      _file = imgFile;
      log("image$_file");
      controller.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_curr == 1) {
          final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  "Exit from Intake Form",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                content: const Text(
                  "Are you sure want to exit",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    child: Text(
                      text.No.tr,
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'Poppins'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(MyColor.red)),
                    child: Text(
                      text.Yes.tr,
                      style: const TextStyle(
                          fontFamily: 'Poppins', color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
          if (value != null) {
            return Future.value(value);
          } else {
            return Future.value(false);
          }
        } else if (_curr == 7) {
          setState(() {
            // _curr =5;
            controller.previousPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.bounceIn);
          });
        } else if (_curr == 6) {
          setState(() {
            // _curr =5;
            controller.previousPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.bounceIn);
          });
        } else if (_curr == 5) {
          setState(() {
            // _curr =5;
            controller.previousPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.bounceIn);
          });
        } else if (_curr == 4) {
          setState(() {
            // _curr =5;
            controller.previousPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.bounceIn);
          });
        } else if (_curr == 3) {
          setState(() {
            // _curr =5;
            controller.previousPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.bounceIn);
          });
        } else if (_curr == 2) {
          setState(() {
            // _curr =5;
            controller.previousPage(
                duration: const Duration(milliseconds: 10),
                curve: Curves.bounceIn);
          });
        } else {}
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(7.0), child: Divider()),
              backgroundColor: Colors.white24,
              leading: Text(""),
              elevation: 0,
              centerTitle: true,
              title: customView.text(
                  "General Details", 17, FontWeight.w500, MyColor.black),
            ),
            body: GetBuilder<IntakeController>(builder: (cartController) {
              return Column(
                children: [
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (value) {
                        setState(() {
                          _curr = 1 + value;
                          log("page index$value");
                          log("curr index$_curr");
                        });
                      },
                      controller: controller,
                      children: [
                        KeepAlivePage(
                          child: imagePickerPage(),
                        ),
                        KeepAlivePage(
                          child: painratigDetail(cartController),
                        ),
                        KeepAlivePage(
                          child: mediclehistoryDetail(cartController),
                        ),
                        KeepAlivePage(
                            child: medicalTestingDetail(cartController)),
                        KeepAlivePage(
                          child: medicalgenralhealthDetail(cartController),
                        ),
                        KeepAlivePage(
                          child: medicalworkenvironmentDetail(cartController),
                        ),
                        KeepAlivePage(
                            child: medicalhomeenvirnmentDetail(cartController)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Column(
                      children: [
                        customView.text(
                            "$_curr/7", 13.0, FontWeight.w500, Colors.black),
                     intakeController.loadingListAdd.value?customView.MyIndicator():
                     customView.MyButton(
                            context, _curr == 7 ? "SUBMIT" : "NEXT", () {

                          if (_curr == 1) {
                            saveImage();
                          }
                          else if (_curr == 2) {
                            log("answerList--${cartController.answerList.length}");
                            log("intake-form-que-List--${cartController.intakeformqueList.length}");
                            if (cartController.answerList.length <
                                cartController.intakeformqueList.length) {
                              customView.MySnackBar(
                                  context, "please answer all the questions");
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 10),
                                  curve: Curves.bounceIn);
                            }
                          }
                          else if (_curr == 3) {
                            log("answerList--${cartController.answerList.length}");
                            log("intakeformqueList--${cartController.intakeformqueList.length}");
                            log("intakmediclehistoryList--${cartController.intakmediclehistoryList.length}");
                            if ((cartController.answerList.length <
                                cartController.intakeformqueList.length +
                                    cartController
                                        .intakmediclehistoryList.length)) {
                              customView.MySnackBar(
                                  context, "please answer all the questions");
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 10),
                                  curve: Curves.bounceIn);
                            }
                          }
                          else if (_curr == 4) {
                            log("answerList--${cartController.answerList.length}");
                            log("intake form queList--${cartController.intakeformqueList.length}");
                            log("intake medical historyList--${cartController.intakmediclehistoryList.length}");
                            log("intake medical testingList--${cartController.intakmedicaltestingList.length}");
                            if ((cartController.answerList.length <
                                cartController.intakeformqueList.length +
                                    cartController
                                        .intakmediclehistoryList.length +
                                    cartController
                                        .intakmedicaltestingList.length)) {
                              customView.MySnackBar(
                                  context, "please answer all the questions");
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 10),
                                  curve: Curves.bounceIn);
                            }
                          }
                          else if (_curr == 5) {
                            log("answerList--${cartController.answerList.length}");
                            log("intake form queList--${cartController.intakeformqueList.length}");
                            log("intake medical historyList--${cartController.intakmediclehistoryList.length}");
                            log("intake medical testingList--${cartController.intakmedicaltestingList.length}");
                            log("intake general Health List List--${cartController.intakegenralList.length}");

                            if ((cartController.answerList.length <
                                cartController.intakeformqueList.length +
                                    cartController.intakmediclehistoryList.length +
                                    cartController.intakmedicaltestingList.length +
                                    cartController.intakegenralList.length)) {
                                customView.MySnackBar(
                                  context, "please answer all the questions");
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 10),
                                  curve: Curves.bounceIn);
                            }
                          }
                          else if (_curr == 6) {
                            log("answerList--${cartController.answerList.length}");
                            log("intake form queList--${cartController.intakeformqueList.length}");
                            log("intake medical historyList--${cartController.intakmediclehistoryList.length}");
                            log("intake medical testingList--${cartController.intakmedicaltestingList.length}");
                            log("intake general Health List List--${cartController.intakegenralList.length}");
                            log("intake work environment List List--${cartController.intakworkenvironmentList.length}");

                            if ((cartController.answerList.length <
                                    cartController.intakeformqueList.length +
                                    cartController.intakmediclehistoryList.length +
                                    cartController.intakmedicaltestingList.length +
                                    cartController.intakegenralList.length+
                                        cartController.intakworkenvironmentList.length)
                                ) {
                              customView.MySnackBar(
                                  context, "please answer all the questions");
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 10),
                                  curve: Curves.bounceIn);
                            }
                          }
                          else {
                            log("answerList--${cartController.answerList.length}");
                            log("intake form queList--${cartController.intakeformqueList.length}");
                            log("intake medical historyList--${cartController.intakmediclehistoryList.length}");
                            log("intake medical testingList--${cartController.intakmedicaltestingList.length}");
                            log("intake general Health List List--${cartController.intakegenralList.length}");
                            log("intake work environment List List--${cartController.intakworkenvironmentList.length}");
                            log("intake home environment List List--${cartController.intakehomeenvironmentList.length}");
                            if ((cartController.answerList.length <
                                cartController.intakeformqueList.length +
                                    cartController.intakmediclehistoryList.length +
                                    cartController.intakmedicaltestingList.length +
                                    cartController.intakegenralList.length+
                                    cartController.intakworkenvironmentList.length+
                                    cartController.intakehomeenvironmentList.length)) {
                              customView.MySnackBar(
                                  context, "please answer all the questions");
                            } else {
                              cartController.intakeFormInsertiondata(_file,widget.bookingId.toString(),context);

                            }
                          }

                        }, MyColor.primary, TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ],
              );
            })),
      ),
    );
  }
  Widget imagePickerPage() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customView.text("Please mark the body pain points", 15,
              FontWeight.w600, Colors.black),
          SizedBox(
            height: 20,
          ),
          ImagePainter.asset(
            "assets/images/pro_physio_humanbody.jpg",
            key: _imageKey,
            scalable: true,
            height: context.width,
            showControls: true,
            initialStrokeWidth: 4,
            textDelegate: TextDelegate(),
            initialColor: Colors.red,
            initialPaintMode: PaintMode.circle,
          ),
          Expanded(child: SizedBox()),
          // Center(child: customView.mysButton(context, "NEXT", () {
          //   saveImage();
          // }, MyColor.primary,TextStyle(color: Colors.white) ) ,)
        ],
      ),
    );
  }

  Widget painratigDetail(IntakeController cartController) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7.0,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: MyColor.primary1.withOpacity(0.3))),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: MyColor.primary1.withOpacity(0.3))),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: customView.text("Pain Rating", 16.0,
                            FontWeight.w600, MyColor.primary1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: MyColor.primary1.withOpacity(0.2),
                        );
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartController.intakeformqueList.length,
                      itemBuilder: (context, index2) => RatingSelectCard1(
                          intakeFormQuestionDetailModel:
                              cartController.intakeformqueList[index2],
                          indexrating: index2,
                          cartController: cartController)),
                  SizedBox(height: 5),
                ],
              ),
            ),
          )),
    );
  }

  Widget mediclehistoryDetail(IntakeController cartController) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7.0,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: MyColor.primary1.withOpacity(0.3))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: MyColor.primary1.withOpacity(0.3))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: customView.text("Medical History", 16.0,
                          FontWeight.w600, MyColor.primary1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: MyColor.primary1.withOpacity(0.3),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartController.intakmediclehistoryList.length,
                    itemBuilder: (context, index2) => Card(
                        elevation: 1.5,
                        surfaceTintColor: MyColor.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customView.text(
                                  "${cartController.intakmediclehistoryList[index2].questionText}",
                                  13,
                                  FontWeight.w400,
                                  MyColor.black),
                              MedicalRadioCard(
                                nestedQuestion: cartController
                                    .intakmediclehistoryList[index2]
                                    .nestedQuestion
                                    .toString(),
                                questionId: cartController
                                    .intakmediclehistoryList[index2].questionId
                                    .toString(),
                              )
                            ],
                          ),
                        ))),
              ],
            ),
          )),
    );
  }


  Widget medicalTestingDetail(IntakeController cartController) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7.0,
          ),          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: MyColor.primary1.withOpacity(0.3))),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: MyColor.primary1.withOpacity(0.3))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: customView.text("Medical Testing", 16.0,
                          FontWeight.w600, MyColor.primary1),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartController.intakmedicaltestingList.length,
                    itemBuilder: (context, index2) => Card(
                        elevation: 2,
                        surfaceTintColor: MyColor.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customView.text(
                                  "${cartController.intakmedicaltestingList[index2].questionText}",
                                  14,
                                  FontWeight.w400,
                                  MyColor.black),
                              MedicalRadioCard(
                                nestedQuestion: cartController
                                    .intakmedicaltestingList[index2]
                                    .nestedQuestion
                                    .toString(),
                                questionId: cartController
                                    .intakmedicaltestingList[index2].questionId
                                    .toString(),
                              ),
                            ],
                          ),
                        ))),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          )),
    );
  }


  Widget medicalgenralhealthDetail(IntakeController cartController) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7.0,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: MyColor.primary1.withOpacity(0.3))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: MyColor.primary1.withOpacity(0.3))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: customView.text("General Health", 16.0,
                          FontWeight.w600, MyColor.primary1),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartController.intakegenralList.length,
                    itemBuilder: (context, index2) => Card(
                        elevation: 2,
                        surfaceTintColor: MyColor.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customView.text(
                                  "${cartController.intakegenralList[index2].questionText}",
                                  14,
                                  FontWeight.w400,
                                  MyColor.black),
                              MedicalRadioCard(
                                nestedQuestion: cartController
                                    .intakegenralList[index2].nestedQuestion
                                    .toString(),
                                questionId: cartController
                                    .intakegenralList[index2].questionId
                                    .toString(),
                              )
                            ],
                          ),
                        ))),
                SizedBox(height: 5,)
              ],
            ),
          )),
    );
  }

  Widget medicalworkenvironmentDetail(IntakeController cartController) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7.0,
          ),          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: MyColor.primary1.withOpacity(0.3))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: MyColor.primary1.withOpacity(0.3))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: customView.text("Work Environment", 16.0,
                          FontWeight.w600, MyColor.primary1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartController.intakworkenvironmentList.length,
                    itemBuilder: (context, index2) => Card(
                        elevation: 2,
                        surfaceTintColor: MyColor.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customView.text(
                                  "${cartController.intakworkenvironmentList[index2].questionText}",
                                  14,
                                  FontWeight.w400,
                                  MyColor.black),
                              MedicalRadioCard(
                                nestedQuestion: cartController
                                    .intakworkenvironmentList[index2]
                                    .nestedQuestion
                                    .toString(),
                                questionId: cartController
                                    .intakworkenvironmentList[index2].questionId
                                    .toString(),
                              )
                            ],
                          ),
                        ))),
              ],
            ),
          )),
    );
  }

  Widget medicalhomeenvirnmentDetail(IntakeController cartController) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7.0,
          ),           child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: MyColor.primary1.withOpacity(0.3))),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: MyColor.primary1.withOpacity(0.3))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: customView.text("Home Environment", 16.0,
                          FontWeight.w600, MyColor.primary1),
                    ),
                  ),
                ),
                customView.text(
                    "", 20, FontWeight.w600, Colors.black),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartController.intakehomeenvironmentList.length,
                    itemBuilder: (context, index2) => Card(
                        elevation: 4,
                        surfaceTintColor: MyColor.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customView.text(
                                  "${cartController.intakehomeenvironmentList[index2].questionText}",
                                  14,
                                  FontWeight.w400,
                                  MyColor.black),
                              MedicalRadioCard(
                                nestedQuestion: cartController
                                    .intakehomeenvironmentList[index2]
                                    .nestedQuestion
                                    .toString(),
                                questionId: cartController
                                    .intakehomeenvironmentList[index2].questionId
                                    .toString(),
                              )
                            ],
                          ),
                        ))),
              ],
            ),
          )),
    );
  }


}

class KeepAlivePage extends StatefulWidget {
  KeepAlivePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    /// Dont't forget this
    super.build(context);

    return widget.child;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
