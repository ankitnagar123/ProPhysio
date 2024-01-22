import 'dart:convert';
import 'dart:io';

class AnswerModel {
  String Question;
  String answer;
  String nestedQuestion;
  String nestedAnswer;
  List<String>? nestedImgBase64List; // Change the type to List<String>

  AnswerModel({
    required this.Question,
    required this.answer,
    required this.nestedQuestion,
    required this.nestedAnswer,
    this.nestedImgBase64List, // Update the field name
  });

  Map<String, dynamic> toJson() {
    return {
      "question_id": this.Question,
      "answer": this.answer,
      "nestedQuestion": this.nestedQuestion,
      "nestedAnswer": this.nestedAnswer,
      "nestedImgBase64List": this.nestedImgBase64List, // Update the field name
    };
  }
}