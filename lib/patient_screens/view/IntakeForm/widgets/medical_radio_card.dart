import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prophysio/helper/CustomView/CustomView.dart';
import 'package:prophysio/language_translator/LanguageTranslate.dart';

import '../../../../helper/mycolor/mycolor.dart';
import '../answerCtr.dart';

class MedicalRadioCard extends StatefulWidget {
  String questionId;
  String nestedQuestion;

  MedicalRadioCard(
      {super.key, required this.questionId, required this.nestedQuestion});

  @override
  State<MedicalRadioCard> createState() => _MedicalRadioCardState();
}

class _MedicalRadioCardState extends State<MedicalRadioCard> {
  String _selectedOption = '';
  IntakeController intakeController = Get.put(IntakeController());
  TextEditingController _textEditingController = TextEditingController();
  LocalString text = LocalString();
  CustomView view = CustomView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                view.text("Yes", 13, FontWeight.w400, MyColor.black),
                Radio<String>(
                  activeColor: MyColor.primary1,
                  value: 'yes',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    // Get.find<intakeController>().getMaplist({
                    //  "question_id":widget.questionId
                    // },widget.questionId);

                    setState(() {
                      log("object for medical history index======${widget.questionId},and nested question${widget.nestedQuestion}");
                      _selectedOption = value!;
                      print(_selectedOption);
                      intakeController.addAnswer(
                          widget.questionId,
                          _selectedOption,
                          widget.nestedQuestion,
                          _textEditingController.text);
                      log("intakeController.answerList.length${intakeController.answerList.length}");
                    });
                  },
                ),
              ],
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                view.text("No", 13, FontWeight.w400, MyColor.black),
                Radio<String>(
                  activeColor: MyColor.primary1,
                  value: 'no',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    // Get.find<intakeController>().getMaplist({
                    //   "question_id":widget.questionId
                    // },widget.questionId);

                    setState(() {
                      print(
                          "object for medical history index======${widget.questionId}");
                      _selectedOption = value!;
                      print(_selectedOption);
                      intakeController.addAnswer(
                          widget.questionId, _selectedOption, '', '');
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        _selectedOption == "yes" && widget.nestedQuestion != ""
            ? Text(
                "${widget.nestedQuestion}?",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : SizedBox(),
        _selectedOption == "yes" && widget.nestedQuestion != ""
            ? Card(
                elevation: 4,
                surfaceTintColor: MyColor.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    controller: _textEditingController,
                    maxLines: 2,
                    textInputAction: TextInputAction.newline,
                    onTapOutside: (val) {
                      intakeController.addAnswer(
                          widget.questionId,
                          _selectedOption,
                          widget.nestedQuestion,
                          _textEditingController.text);
                    },
                    decoration: InputDecoration(
                        hintText: "Answer:-",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
