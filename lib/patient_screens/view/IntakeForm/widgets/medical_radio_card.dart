import 'dart:developer';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prophysio/helper/CustomView/CustomView.dart';
import 'package:prophysio/language_translator/LanguageTranslate.dart';
import 'package:image_picker/image_picker.dart';
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


  File? file;
  final picker = ImagePicker();

  var imageFileListnew = <XFile>[];


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
                          _textEditingController.text,[],);
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
                          widget.questionId, _selectedOption, '', '',[]);
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
            ? Column(
              children: [
                view.text(
                    "Select product images", 14, FontWeight.w500, MyColor.primary1),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // intakeController.answerList.clear();
                        log("intakeController answer-List${intakeController.answerList.length}");
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => bottomsheetImageSelect());
                        // _choose();
                      },
                      /*   onTap: () {
                      _choose(ImageSource.camera);
                    },*/
                      child: Container(
                        height: 45,
                        width: 50,
                        decoration: BoxDecoration(
                          color: MyColor.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.image, color: MyColor.white),
                      ),
                    ),
                    /*addProductController.imageFileList.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: customView.text("Select Product Images", 14,
                              FontWeight.w500, primaryBlack),
                        )*/
                    showMultipleImageView(),
                  ],
                ),
                Card(
                    elevation: 2,
                    surfaceTintColor: MyColor.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        controller: _textEditingController,
                        maxLines: 2,
                        textInputAction: TextInputAction.newline,
                        // onTapOutside: (val) {
                        //   intakeController.addAnswer(
                        //       widget.questionId,
                        //       _selectedOption,
                        //       widget.nestedQuestion,
                        //       _textEditingController.text,[]);
                        // },
                        decoration: const InputDecoration(
                            hintText: "Answer:-",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      ),
                    ),
                  ),
              ],
            )
            : SizedBox()
      ],
    );
  }
  Widget bottomsheetImageSelect() {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _choose(ImageSource.gallery);
                    Get.back();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.pinkAccent,
                    radius: 30,
                    child: Icon(
                      Icons.photo_library,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                const Text("Gallery")
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _choose(ImageSource.camera);
                    Get.back();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 30,
                    child: Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                const Text("Camera")
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget showMultipleImageView( ) {
    return Expanded(
      child: SizedBox(
        height: 60,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: imageFileListnew.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Stack(
                  children: [
                    Image.file(
                      File(imageFileListnew[index].path),
                      height: 60.0,
                      width: 60.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: MyColor.primary),
                      child: InkWell(
                          onTap: () {
                            setState(() {});
                            intakeController.imageFileList.removeAt(index);
                            intakeController.imagePathList.removeAt(index);
                            log(
                                "image length new${intakeController.imageFileList.length} ");
                            log(
                                "image Path length new${intakeController.imagePathList.length} ");
                          },
                          child: Center(
                              child: const Icon(
                                Icons.close,
                                color: MyColor.white,
                                size: 16,
                              ))),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void _choose(ImageSource source) async {
    if (source == ImageSource.gallery) {
      final List<XFile> selectedImages = await picker.pickMultiImage(
        imageQuality: 90,
      );

      if (selectedImages.isNotEmpty) {
        setState(() {
          // Clear existing image paths and add the newly selected images

          //intakeController.imagePathList.clear();
          imageFileListnew.addAll(selectedImages);

          intakeController.imageFileList.addAll(selectedImages);

          for (int i = 0; i < selectedImages.length; i++) {
            String stringPath = selectedImages[i].path;

            intakeController.imagePathList.add(stringPath);
          }
          log("path length :-- ${intakeController.imagePathList.length}");
        });

        // Call addAnswer to process the selected images
        intakeController.addAnswer(
          widget.questionId,
          _selectedOption,
          widget.nestedQuestion,
          _textEditingController.text,
          intakeController.imageFileList.toList(), // Convert to a regular List<XFile>
        );
    /*    intakeController.imageFileList.clear();
        intakeController.imagePathList.clear();*/
      }
    } else {
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 90,
      );

      if (pickedFile != null) {
        setState(() {
          intakeController.imageFileList.add(XFile(pickedFile.path));
          intakeController.imagePathList.add(pickedFile.path);
        });
      }else{
            intakeController.imageFileList.clear();
        intakeController.imagePathList.clear();
      }
    }
  }

}
