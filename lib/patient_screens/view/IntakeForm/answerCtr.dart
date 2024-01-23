import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as Http;
import 'package:prophysio/helper/CustomView/CustomView.dart';
import 'package:prophysio/helper/sharedpreference/SharedPrefrenc.dart';
import 'package:flutter/material.dart';
import 'IntakeFormQuestionDetailModel.dart';
import 'answerModel.dart';




class IntakeController extends GetxController implements GetxService {


  SharedPreferenceProvider sp = SharedPreferenceProvider();
CustomView view = CustomView();
  var loadingList = false.obs;
  var loadingListAdd = false.obs;



  var imageFileList = <XFile>[].obs;
  var imagePathList = <String>[].obs;
  var multipartList = <http.MultipartFile>[].obs;


  // List<Map<String ,String>> _answerlist=[];
  // List<Map<String,String>> get answerlist=>_answerlist;

  var answerList = <AnswerModel>[].obs;




  /*.....................................Prophysio app fetch intake Form details.....................................*/
/*1*/
  List<IntakeFormQuestionDetailModel> _intakeformqueList=[];
  List<IntakeFormQuestionDetailModel>  get intakeformqueList=>_intakeformqueList;
/*2*/
  List<IntakeFormQuestionDetailModel> _intakmediclehistoryList=[];
  List<IntakeFormQuestionDetailModel>  get intakmediclehistoryList=>_intakmediclehistoryList;
/*3*/

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

    loadingList.value = true;
    update();


    final response =await Http.post(
        Uri.parse("https://cisswork.com/Android/emrIntegrateDoctor/api/process.php?action=intake_form_details"),body: {
      "category_type":category_type
    })
        .timeout(Duration(seconds: 30));

    print("this response of login screen===${response.body}");
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      loadingList.value = false;
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
    loadingList.value = false;
    update();
  }


  // void addAnswer(String questionId,String answer,String nestedQuestion,String nestedAnswer,List<File> nestedImages){
  //   for(int i=0;i<answerList.length;i++)
  //   {
  //     if(answerList[i].Question==questionId)
  //     {
  //       answerList.removeAt(i);
  //     }
  //
  //   }
  //
  //   answerList.add(AnswerModel(Question: questionId, answer: answer, nestedQuestion:nestedQuestion, nestedAnswer: nestedAnswer, nestedImgBase64List: nestedImages));
  //   for(int i=0;i<answerList.length;i++)
  //   {
  //     print("answer ----${answerList[i].Question} ${answerList[i].answer}");
  //
  //   }
  //   String json = jsonEncode(answerList.map((i) => i.toJson()).toList()).toString();
  //   print("this is  json response data is here=======$json");
  // }

  /*new*/
    Future<void> addAnswer(
        String questionId,
        String answer,
        String nestedQuestion,
        String nestedAnswer,
        List<XFile> nestedImages,
        ) async {
      // Remove existing answer with the same questionId

      log("umesh question id is here======${questionId}");
      log("umesh nestted image is  here id is here======${nestedImages}");
      answerList.removeWhere((element) => element.Question == questionId);


      // Encode the nested images to base64
      List<String> nestedImgBase64List = [];
      for (XFile nestedImg in nestedImages) {
        List<int> imageBytes = await nestedImg.readAsBytes();
        String nestedImgBase64 = base64Encode(imageBytes);
        nestedImgBase64List.add(nestedImgBase64);
      }
  log("umesh nested box nestddd list image list is here=======${nestedImgBase64List}");
      // Add the new AnswerModel to the answerList
      answerList.add(
        AnswerModel(
          Question: questionId,
          answer: answer,
          nestedQuestion: nestedQuestion,
          nestedAnswer: nestedAnswer,
          nestedImgBase64List: nestedImgBase64List,
        ),
      );

      // Print the updated list of answers
      for (int i = 0; i < answerList.length; i++) {
        print("answer ----${answerList[i].Question} ${answerList[i].answer}");
      }

      // Convert the list of AnswerModel to JSON
      String json = jsonEncode(answerList.map((i) => i.toJson()).toList());

      // Log the JSON data
      debugPrint("this is json response data is here======= $json");
      log("this is json response data is here log======= $json");
    }


  /*..........................................Pro-physio  app send data of form ....................................................*/

  Future<String> intakeFormInsertiondata(file, context,) async {

    loadingListAdd.value = true;
    update();
    String jsondata = jsonEncode(answerList.map((i) => i.toJson()).toList()).toString();
    log("this is image=====$file");
    log("this is data of answerlist=====$json");
    Map<String, String> map = {
      "patient_id": await sp.getStringValue(sp.PATIENT_ID_KEY)??'',
      "answers":jsondata,
    };

    print("this map before response===$map");
    final response = await saveIntakeFormData(map, file);
    final data = jsonDecode(await response.stream.bytesToString());

    print("this response of login screen===${data.toString()}");
    String result = "";
    if (response.statusCode == 200) {
      answerList.clear();
      Navigator.pop(context);
      result = data["result"];
      loadingListAdd.value = false;
   view.MySnackBar(context, result);
    }
    loadingListAdd.value = false;
    update();
    return result;
  }



  Future<Http.StreamedResponse> saveIntakeFormData(Map<String, String> maps,
      File? file,) async {
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
    Http.StreamedResponse response = await request.send();
    return response;
  }

}