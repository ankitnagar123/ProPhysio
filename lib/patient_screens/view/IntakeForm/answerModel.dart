class AnswerModel {

  String Question;
  String answer;
  String nestedQuestion;
  String nestedAnswer;
  String nestedImgq;

  String nestedImg;

  AnswerModel({
    required this.Question,
    required this.answer,
    required this.nestedQuestion,
    required this.nestedAnswer,
    required this.nestedImgq,
    required this.nestedImg,
  });

  Map<String,dynamic> toJson(){
    return {
      "question_id": this.Question,
      "answer": this.answer,
      "nestedQuestion":this.nestedQuestion,
      "nestedAnswer":this.nestedAnswer,
      "nestedImgq":this.nestedImgq,
      "nestedImg":this.nestedImg
    };
  }

}