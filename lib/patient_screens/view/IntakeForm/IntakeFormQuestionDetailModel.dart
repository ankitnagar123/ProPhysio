class IntakeFormQuestionDetailModel {
  String? questionId;
  String? questionText;
  String? questionType;
  List<String>? answerOptions;
  String? nestedQuestion;
  String? questionCategory;

  IntakeFormQuestionDetailModel(
      {this.questionId,
        this.questionText,
        this.questionType,
        this.answerOptions,
        this.nestedQuestion,
        this.questionCategory});

  IntakeFormQuestionDetailModel.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    questionText = json['question_text'];
    questionType = json['question_type'];
    answerOptions = json['answer_options'].cast<String>();
    nestedQuestion = json['nestedQuestion'];
    questionCategory = json['question_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question_text'] = this.questionText;
    data['question_type'] = this.questionType;
    data['answer_options'] = this.answerOptions;
    data['nestedQuestion'] = this.nestedQuestion;
    data['question_category'] = this.questionCategory;
    return data;
  }
}
