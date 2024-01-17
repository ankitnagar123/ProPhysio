import 'package:flutter/material.dart';

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
  IntakeController intakeController = IntakeController();
  TextEditingController _textEditingController=TextEditingController();

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
                Text("Yes"),
                Radio<String>(
                  value: 'yes',
                  groupValue: _selectedOption,
                  onChanged: (value) {

                    // Get.find<intakeController>().getMaplist({
                    //  "question_id":widget.questionId
                    // },widget.questionId);

                    setState(() {

                      print(
                          "object for medical history index======${widget.questionId},and nested question${widget.nestedQuestion}");
                      _selectedOption = value!;
                      print(_selectedOption);
                      intakeController.addAnswer(widget.questionId, _selectedOption,widget.nestedQuestion,_textEditingController.text);
                    });
                  },
                ),
              ],
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text("No"),
                Radio<String>(
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
                      intakeController.addAnswer(widget.questionId, _selectedOption,'','');
                    });
                  },
                ),
              ],
            ),
          ],
        ),

          _selectedOption=="yes" && widget.nestedQuestion !=""?Text(
            "${widget.nestedQuestion}?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ):SizedBox(),


        _selectedOption=="yes" && widget.nestedQuestion!="" ? Card(
          elevation: 4,
          surfaceTintColor: MyColor.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextFormField(
              controller: _textEditingController,
              maxLines: 2,
              textInputAction: TextInputAction.newline,
              onTapOutside: (val){
                intakeController.addAnswer(widget.questionId, _selectedOption,widget.nestedQuestion,_textEditingController.text);

              },
              decoration: InputDecoration(
                  hintText: "Answer:-",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
        ):SizedBox()

      ],
    );
  }
}
/*Row(
      children: [
        Expanded(
          flex: 1,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity:
            const VisualDensity(horizontal: -4, vertical: -4),
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
            title: Text("uemshfd"),
          ),
        ),
        Expanded(
          flex: 1,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity:
            const VisualDensity(horizontal: -4, vertical: -4),
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
            title: Text("chouhan"),
          ),
        ),
      ],
    )*/
