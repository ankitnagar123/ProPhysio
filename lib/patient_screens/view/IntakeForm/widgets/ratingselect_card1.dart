import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophysio/helper/CustomView/CustomView.dart';
import 'package:prophysio/language_translator/LanguageTranslate.dart';
import 'package:prophysio/patient_screens/view/IntakeForm/answerCtr.dart';

import '../../../../helper/mycolor/mycolor.dart';
import '../IntakeFormQuestionDetailModel.dart';

class RatingSelectCard1 extends StatefulWidget {
  final IntakeFormQuestionDetailModel intakeFormQuestionDetailModel;
  final int indexrating;
  final IntakeController cartController;

  RatingSelectCard1(
      {super.key,
      required this.intakeFormQuestionDetailModel,
      required this.indexrating,
      required this.cartController});

  @override
  State<RatingSelectCard1> createState() => _RatingSelectCard1State();
}

class _RatingSelectCard1State extends State<RatingSelectCard1> {
  int selectIndex = -1;

  LocalString text = LocalString();
  CustomView view = CustomView();

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        surfaceTintColor: MyColor.white,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              view.text("${widget.intakeFormQuestionDetailModel.questionText}",
                  12, FontWeight.w400, MyColor.black),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                  height: 30,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget
                          .intakeFormQuestionDetailModel.answerOptions!.length,
                      itemBuilder: (context, index3) => SizedBox(
                          height: 30,
                          width: 30,
                          child: InkWell(
                              onTap: () {
                                print(
                                    "${widget.intakeFormQuestionDetailModel.answerOptions![index3]},,,,index details,${widget.indexrating},,,,${widget.intakeFormQuestionDetailModel.questionId}");
                                selectIndex = widget.indexrating;

                                selectIndex = int.parse(widget
                                    .intakeFormQuestionDetailModel
                                    .answerOptions![index3]);
                                print("selce index===${selectIndex}");

                                setState(() {
                                  Get.find<IntakeController>().addAnswer(
                                      widget.intakeFormQuestionDetailModel
                                          .questionId
                                          .toString(),
                                      selectIndex.toString(),
                                      '',
                                      '');
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selectIndex ==
                                              int.parse(widget
                                                  .intakeFormQuestionDetailModel
                                                  .answerOptions![index3])
                                          ? MyColor.primary1
                                          : MyColor.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: MyColor.primary1
                                              .withOpacity(0.4))),
                                  child: Center(
                                    child: Text(
                                      widget.intakeFormQuestionDetailModel
                                          .answerOptions![index3],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: selectIndex ==
                                                int.parse(widget
                                                    .intakeFormQuestionDetailModel
                                                    .answerOptions![index3])
                                            ? MyColor.white
                                            : MyColor.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ))))
                  // customView.text("${cartController.intakeformqueList[index2].questionText}", 14, FontWeight.w400, MyColor.black),
                  // SizedBox(height: 30,child: ListView.builder(shrinkWrap: true,scrollDirection: Axis.horizontal,itemCount: cartController.intakeformqueList[index2].answerOptions!.length,itemBuilder: (context,index3)=>RatingSelectCard(intakeFormQuestionDetailModel:cartController.intakeformqueList[index2],indexrating:index3)))

                  )
            ],
          ),
        ));
  }
}
