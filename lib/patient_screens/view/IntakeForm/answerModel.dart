class AnswerModel {

  String Question;
  String answer;
  String nestedQuestion;
  String nestedAnswer;

  AnswerModel({
    required this.Question,
    required this.answer,
    required this.nestedQuestion,
    required this.nestedAnswer
  });

  Map<String,dynamic> toJson(){
    return {
      "question_id": this.Question,
      "answer": this.answer,
      "nestedQuestion":this.nestedQuestion,
      "nestedAnswer":this.nestedAnswer
    };
  }

}