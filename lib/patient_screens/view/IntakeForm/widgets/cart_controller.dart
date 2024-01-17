import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart'as Http;

import '../IntakeFormQuestionDetailModel.dart';
import '../answerModel.dart';



class IntakeController extends GetxController implements GetxService
{



  bool _isloading = false;

  bool get isloading => _isloading;

  bool _isloading1 = false;

  bool get isloading1 => _isloading1;



 // List<Map<String ,String>> _answerlist=[];
 // List<Map<String,String>> get answerlist=>_answerlist;

  var answerList = <AnswerModel>[].obs;

  void addAnswer(String questionId,String answer,String nestedQuestion,String nestedAnswer){
    for(int i=0;i<answerList.length;i++)
    {
      if(answerList[i].Question==questionId)
      {
        answerList.removeAt(i);
      }

    }
    answerList.add(AnswerModel(Question: questionId, answer: answer, nestedQuestion:nestedQuestion, nestedAnswer: nestedAnswer));
    for(int i=0;i<answerList.length;i++)
    {
      print("answer ----${answerList[i].Question} ${answerList[i].answer}");

    }
    String json = jsonEncode(answerList.map((i) => i.toJson()).toList()).toString();
    print("this is  json response data is here=======${json}");
  }






 //  void getMaplist(Map<String,String> map,String value)
 // {
 //
 //
 //
 //   _answerlist.add(map);
 // //_answerlist.addIf(_answerlist.map((e) => e.values.contains(value)), map);
 //   //_answerlist.add(map);
 // print("rhdjddj this is here=======${_answerlist.map((e) => e.values.contains(value))}");
 //   print("get ,maplist $_answerlist");
 //   update();
 //
 // }




  /*..........................................Prophysio  app send data of form ....................................................*/

  Future<String> intakeFormInsertiondata(file) async {
    _isloading = true;
    update();
    String jsondata = jsonEncode(answerList.map((i) => i.toJson()).toList()).toString();
    print("this is image=====$file");
    print("this is data of answerlist=====$json");
    Map<String, String> map = {
      "patient_id": '2',
      "answers":jsondata,
    };

    print("this map before response===${map}");
    final response = await saveIntakeFormData(map, file);
    final data = jsonDecode(await response.stream.bytesToString());

    print("this response of login screen===${data.toString()}");
    String result = "";
    if (response.statusCode == 200) {
      result = data["result"];
    }
    _isloading = false;
    update();
    return result;
  }



  Future<Http.StreamedResponse> saveIntakeFormData(Map<String, String> maps,
      File? file) async {
    Http.MultipartRequest request =
    Http.MultipartRequest('POST', Uri.parse(
        "https://cisswork.com/Android/emrIntegrateDoctor/api/process.php?action=insert_intake_form_answer"));
    if (file != null) {
      request.files.add(Http.MultipartFile(
          'image', file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path
              .split('/')
              .last));
    }
    request.fields.addAll(maps);

    print("multipartData request.fields:--- ${maps.toString()}");
    Http.StreamedResponse _response = await request.send();
    return _response;
  }


  /*.....................................Prophysio app fetch intake Form details.....................................*/

  List<IntakeFormQuestionDetailModel> _intakeformqueList=[];
  List<IntakeFormQuestionDetailModel>  get intakeformqueList=>_intakeformqueList;

  List<IntakeFormQuestionDetailModel> _intakmediclehistoryList=[];
  List<IntakeFormQuestionDetailModel>  get intakmediclehistoryList=>_intakmediclehistoryList;

  List<IntakeFormQuestionDetailModel> _intakmedicaltestingList=[];
  List<IntakeFormQuestionDetailModel>  get intakmedicaltestingList=>_intakmedicaltestingList;


  List<IntakeFormQuestionDetailModel> _intakegenralList=[];
  List<IntakeFormQuestionDetailModel>  get intakegenralList=>_intakegenralList;

  List<IntakeFormQuestionDetailModel> _intakworkenvironmentList=[];
  List<IntakeFormQuestionDetailModel>  get intakworkenvironmentList=>_intakworkenvironmentList;

  List<IntakeFormQuestionDetailModel> _intakehomeenvironmentList=[];
  List<IntakeFormQuestionDetailModel>  get intakehomeenvironmentList=>_intakehomeenvironmentList;

  // IntakeFormQuestionDetailModel? _intakeFormList;
  // IntakeFormQuestionDetailModel? get intakeFormList=>_intakeFormList;

  Future<void> fetchintakeFormQue(String category_type) async {

    _isloading1 = true;
    update();


    final response =await Http.post(
        Uri.parse("https://cisswork.com/Android/emrIntegrateDoctor/api/process.php?action=intake_form_details"),body: {
      "category_type":category_type
    })
        .timeout(Duration(seconds: 30));

    print("this response of login screen===${response.body}");
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {

      if(category_type=="pain_rating"){
        List<IntakeFormQuestionDetailModel> _intakeformqueListPage=jsonDecode(response.body).map((item)=>IntakeFormQuestionDetailModel.fromJson(item)).toList().cast<IntakeFormQuestionDetailModel>();
        _intakeformqueList.clear();
        _intakeformqueList.addAll(_intakeformqueListPage);
        print("this is the list of bannes ====${_intakeformqueList}");
      }
      else if(category_type=="medical_testing")
      {
        List<IntakeFormQuestionDetailModel> _intakmedicaltestingListPage=jsonDecode(response.body).map((item)=>IntakeFormQuestionDetailModel.fromJson(item)).toList().cast<IntakeFormQuestionDetailModel>();
        _intakmedicaltestingList.clear();
        _intakmedicaltestingList.addAll(_intakmedicaltestingListPage);
        print("this is the list of medical_testing ====${_intakmedicaltestingList}");
      }

      //
      else if(category_type=="general_health")
      {
        List<IntakeFormQuestionDetailModel> _intakegenralListPage=jsonDecode(response.body).map((item)=>IntakeFormQuestionDetailModel.fromJson(item)).toList().cast<IntakeFormQuestionDetailModel>();
        _intakegenralList.clear();
        _intakegenralList.addAll(_intakegenralListPage);
        print("this is the list of medical_testing ====${_intakegenralList}");
      }
      //
      else if(category_type=="work_environment")
      {
        List<IntakeFormQuestionDetailModel> _intakworkenvironmentListPage=jsonDecode(response.body).map((item)=>IntakeFormQuestionDetailModel.fromJson(item)).toList().cast<IntakeFormQuestionDetailModel>();
        _intakworkenvironmentList.clear();
        _intakworkenvironmentList.addAll(_intakworkenvironmentListPage);
        print("this is the list of medical_testing ====${_intakworkenvironmentList}");
      }
      //
      else if(category_type=="home_environment")
      {
        List<IntakeFormQuestionDetailModel> _intakehomeenvironmentListPage=jsonDecode(response.body).map((item)=>IntakeFormQuestionDetailModel.fromJson(item)).toList().cast<IntakeFormQuestionDetailModel>();
        _intakehomeenvironmentList.clear();
        _intakehomeenvironmentList.addAll(_intakehomeenvironmentListPage);
        print("this is the list of medical_testing ====${_intakehomeenvironmentList}");
      }
      //
      else {
        List<IntakeFormQuestionDetailModel> _intakmediclehistoryListPage=jsonDecode(response.body).map((item)=>IntakeFormQuestionDetailModel.fromJson(item)).toList().cast<IntakeFormQuestionDetailModel>();
        _intakmediclehistoryList.clear();
        _intakmediclehistoryList.addAll(_intakmediclehistoryListPage);
        print("this is the list of bannes ====${_intakmediclehistoryList}");
      }

      //_intakeFormList=IntakeFormQuestionDetailModel.fromJson(jsonDecode(response.body));


    }
    _isloading1 = false;
    update();

  }




  }