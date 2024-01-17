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

class IntakeFormScreen extends StatefulWidget {
  const IntakeFormScreen({super.key});

  @override
  State<IntakeFormScreen> createState() => _IntakeFormScreenState();
}

class _IntakeFormScreenState extends State<IntakeFormScreen> {
  final CustomView customView=CustomView();
  final _imageKey = GlobalKey<ImagePainterState>();
    File? _file=null;
  int _curr = 1;

  PageController controller = PageController();
IntakeController intakeController = Get.put(IntakeController());


@override
  void initState() {

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
    final imgFile = File('$fullPath');
    if (image != null) {
      imgFile.writeAsBytesSync(image);
      _file=imgFile;
      print("ssdfsfsdfsdfsdf$_file");
      controller.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceIn);


    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customView.MyAppBar(context,"Genral Details",),


      body:GetBuilder<IntakeController>(builder: (cartController){return Column(
        children: [
          Expanded(
            child: PageView(
              // physics: NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  _curr = 1 + value;
                  print("page index$value");
                  print("curr index$_curr");
                });
              },
              controller: controller,
              children: [

                KeepAlivePage(child: imagePickerPage(),),
                KeepAlivePage(child:  painratigDetail(cartController),),
                KeepAlivePage(child: mediclehistoryDetail(cartController),),
                KeepAlivePage(child:medicalTestingDetail(cartController)),
                KeepAlivePage(child:  medicalgenralhealthDetail(cartController),),
                KeepAlivePage(child: medicalworkenvironmentDetail(cartController),),
                KeepAlivePage(child:medicalhomeenvirnmentDetail(cartController)),

              ],
            ),
          ),
          SizedBox(
            height: 70,
            child: Column(
              children: [
                customView.text("$_curr/7", 13.0, FontWeight.w500, Colors.black),
                customView.MyButton(context,_curr==7?"SUBMIT": "NEXT", () {
                  // _curr == 1 + _curr
                  //             ? ""
                  //             :
                  if(_curr==1)
                    {
                      saveImage();
                    }
                  else if(_curr==2)
                    {
                      if(cartController.intakeformqueList.length>cartController.answerList.length){
                        customView.MySnackBar(context, "please add question first");
                      }
                      else{
                        controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.bounceIn);
                      }

                    }
                  else if(_curr==3)
                  {
                    if((cartController.intakeformqueList.length+cartController.intakmediclehistoryList.length)>cartController.answerList.length){
                      customView.MySnackBar(context, "please add question first");
                    }
                    else{
                      controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn);
                    }
                  }
                  else if(_curr==4)
                  {
                    if((cartController.intakeformqueList.length+cartController.intakmediclehistoryList.length+cartController.intakmedicaltestingList.length)>cartController.answerList.length){
                      customView.MySnackBar(context, "please add question first");
                    }
                    else{
                      controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn);
                    }
                  }
                  else if(_curr==5)
                  {
                    if((cartController.intakeformqueList.length+cartController.intakmediclehistoryList.length+cartController.intakmedicaltestingList.length+cartController.intakegenralList.length)>cartController.answerList.length){
                      customView.MySnackBar(context, "please add question first");
                    }
                    else{
                      controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn);
                    }
                  }
                  else if(_curr==6)
                  {
                    if((cartController.intakeformqueList.length+cartController.intakmediclehistoryList.length+cartController.intakmedicaltestingList.length+cartController.intakworkenvironmentList.length)>cartController.answerList.length){
                      customView.MySnackBar(context, "please add question first");
                    }
                    else{
                      controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn);
                    }
                  }
                  else
                    {
                      if((cartController.intakeformqueList.length+cartController.intakmediclehistoryList.length+cartController.intakmedicaltestingList.length+cartController.intakworkenvironmentList.length+cartController.intakehomeenvironmentList.length)>cartController.answerList.length){
                        customView.MySnackBar(context, "please add question first");
                      }
                      else{
                        cartController.intakeFormInsertiondata(_file);
                      }

                      print("radhe");
                    }

                  // cartController.intakeFormInsertiondata("fgfdgd");
                  // controller.nextPage(
                  //     duration: const Duration(milliseconds: 200),
                  //     curve: Curves.bounceIn);
                }, MyColor.primary, TextStyle(color: Colors.white))
                // Obx(() {
                //   if (doctorSignUpCtr.loadingotp.value) {
                //     return custom.MyIndicator();
                //   }
                //   return custom.MyButton(context, text.Go_On.tr, () {
                //     log("$_curr $_numpage");
                //
                //     // controller.jumpToPage(_curr);
                //     if (validation1(context)||validation2(context)) {
                //       controller.jumpToPage(_curr);
                //     }
                //     else{
                //
                //     }
                //     /*else if (validation2(context)) {
                //       //controller.jumpToPage(_curr);
                //
                //     } else {
                //
                //       doctorSignUpCtr.doctorSignupOtpVerification(
                //           context, code, phoneCtr.text, emailCtr.text, () {
                //         log("gender$_selectedGender");
                //         var data = {
                //           "name": nameCtr.text,
                //           "surmane": surnameCtr.text,
                //           "username": usernameCtr.text,
                //           "email": emailCtr.text,
                //           "phone": phoneCtr.text,
                //           "password": passwordCtr.text,
                //           //*new added*//
                //           "birthDate": birthDateController.text,
                //           "birthPlace": birthplaceController.text,
                //           //  "universityAttended": universityAttendedCtr.text,
                //           "dateOfEnrol": dateOfEnrollmentCtr.text,
                //           "registerOfBelonging": registerOfBelongingCtr.text,*//*
                //           //*********//
                //           "category": slectedCategory.toString(),
                //           "imagename": degreefilename.toString(),
                //           "imagebase": degreebaseimage.toString(),
                //           "address": AppConst.LOCATION,
                //           "code": code,
                //           "flag": flag,
                //           "lat": AppConst.LATITUDE,
                //           "longitude": AppConst.LONGITUDE,
                //           "subcat": "", //subCatIdArray.join(','),
                //           'gender': _selectedGender,
                //           // "graduationDate": dateOfGraduation.text,
                //           "qualificationDate": dateOfQualification.text,*//*
                //           "age": ageController.text,
                //           "experience": experienceController.text,
                //           "description": descriptionController.text,
                //           "firstService": _selectedService,
                //           "branch": selectedBranch.toString(),
                //         };
                //       }
                //
                //         //   print("my data$data");
                //         curr == 1 + numpage
                //             ? Get.toNamed(RouteHelper.DSignUpOtp(),
                //             parameters: data)
                //             : controller.nextPage(
                //             duration: const Duration(milliseconds: 200),
                //             curve: Curves.bounceIn);*//*
                //
                //       );
                //     }*/
                //   },
                //       MyColor.red,
                //       const TextStyle(
                //           color: MyColor.white, fontFamily: "Poppins"));
                // }),
              ],
            ),
          ),
        ],
      );})
    );
  }

  Widget painratigDetail(IntakeController cartController){
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customView.text("Pain Rating", 20, FontWeight.w600, Colors.black),
              SizedBox(height: 10,),
              ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemCount: cartController.intakeformqueList.length,itemBuilder: (context,index2)=>RatingSelectCard1(intakeFormQuestionDetailModel: cartController.intakeformqueList[index2], indexrating: index2, cartController: cartController)),

            ],
          )

      ),
    );

  }


  Widget medicalgenralhealthDetail(IntakeController cartController){
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customView.text("Genral Health", 20, FontWeight.w600, Colors.black),
              SizedBox(height: 10,),
              ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemCount: cartController.intakegenralList.length,itemBuilder: (context,index2)=>Card(elevation: 4,surfaceTintColor: MyColor.white,child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    customView.text("${cartController.intakegenralList[index2].questionText}", 14, FontWeight.w400, MyColor.black),
                    MedicalRadioCard(nestedQuestion:cartController.intakegenralList[index2].nestedQuestion.toString() ,questionId: cartController.intakegenralList[index2].questionId.toString(),)

                  ],
                ),
              ))),

            ],
          )

      ),
    );

  }


  Widget medicalworkenvironmentDetail(IntakeController cartController){
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customView.text("Work Environment", 20, FontWeight.w600, Colors.black),
              SizedBox(height: 10,),
              ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemCount: cartController.intakworkenvironmentList.length,itemBuilder: (context,index2)=>Card(elevation: 4,surfaceTintColor: MyColor.white,child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    customView.text("${cartController.intakworkenvironmentList[index2].questionText}", 14, FontWeight.w400, MyColor.black),
                    MedicalRadioCard(nestedQuestion:cartController.intakworkenvironmentList[index2].nestedQuestion.toString() ,questionId: cartController.intakworkenvironmentList[index2].questionId.toString(),)

                  ],
                ),
              ))),

            ],
          )

      ),
    );

  }


  Widget medicalhomeenvirnmentDetail(IntakeController cartController){
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customView.text("Home Environment", 20, FontWeight.w600, Colors.black),
              SizedBox(height: 10,),
              ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemCount: cartController.intakehomeenvironmentList.length,itemBuilder: (context,index2)=>Card(elevation: 4,surfaceTintColor: MyColor.white,child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    customView.text("${cartController.intakehomeenvironmentList[index2].questionText}", 14, FontWeight.w400, MyColor.black),
                    MedicalRadioCard(nestedQuestion:cartController.intakehomeenvironmentList[index2].nestedQuestion.toString() ,questionId: cartController.intakehomeenvironmentList[index2].questionId.toString(),)

                  ],
                ),
              ))),

            ],
          )

      ),
    );

  }





  Widget mediclehistoryDetail(IntakeController cartController){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customView.text("Medical History", 20, FontWeight.w600, Colors.black),
            SizedBox(height: 10,),
            ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemCount: cartController.intakmediclehistoryList.length,itemBuilder: (context,index2)=>Card(elevation: 4,surfaceTintColor: MyColor.white,child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  customView.text("${cartController.intakmediclehistoryList[index2].questionText}", 14, FontWeight.w400, MyColor.black),
                  MedicalRadioCard(nestedQuestion:cartController.intakmediclehistoryList[index2].nestedQuestion.toString() ,questionId: cartController.intakmediclehistoryList[index2].questionId.toString(),)

                ],
              ),
            ))),

          ],
        )

      ),
    );

  }


  Widget medicalTestingDetail(IntakeController cartController){
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customView.text("Medical Testing", 20, FontWeight.w600, Colors.black),
              SizedBox(height: 10,),
              ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemCount: cartController.intakmedicaltestingList.length,itemBuilder: (context,index2)=>Card(elevation: 4,surfaceTintColor: MyColor.white,child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    customView.text("${cartController.intakmedicaltestingList[index2].questionText}", 14, FontWeight.w400, MyColor.black),
                    MedicalRadioCard(nestedQuestion:cartController.intakmediclehistoryList[index2].nestedQuestion.toString() ,questionId: cartController.intakmedicaltestingList[index2].questionId.toString(),),

                  ],
                ),
              ))),

            ],
          )

      ),
    );

  }




  Widget imagePickerPage(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customView.text("Please mark the body pain points", 16, FontWeight.w600, Colors.black),
          SizedBox(height: 20,),
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
