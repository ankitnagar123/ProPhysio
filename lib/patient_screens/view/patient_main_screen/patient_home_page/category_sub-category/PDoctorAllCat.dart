import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../doctor_screens/controller/DoctorSignUpController.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import 'PDoctorSubCat.dart';

class PDrAllCategory extends StatefulWidget {
  const PDrAllCategory({Key? key}) : super(key: key);

  @override
  State<PDrAllCategory> createState() => _PDrAllCategoryState();
}

class _PDrAllCategoryState extends State<PDrAllCategory> {
  LocalString text = LocalString();
  CustomView customView = CustomView();
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());
  int pageIndex = 4;

  @override
  void initState() {
    super.initState();
    doctorSignUpCtr.DoctorCategory();
  }

  String? categoryId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        /*  leading: IconButton(
            onPressed: () {
              print("object");
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),*/
          title: customView.text(
             text.DoctorCategories.tr, 15.0, FontWeight.w500, Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white24,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          child: Obx(() {
            if(doctorSignUpCtr.categoryloding.value){
              return Center(
                heightFactor: 16,
                child: customView.MyIndicator(),
              );
            }else if(doctorSignUpCtr.category.isEmpty){
              return Center(
                heightFactor: 10.0,
                child: customView.text(
                    text.NoCat.tr, 15, FontWeight.w400, MyColor.primary1),
              );
            }else{
              return Column(
                children: [
                  const Divider(),
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 3,
                      children: List.generate(
                          doctorSignUpCtr.category.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            categoryId =
                                doctorSignUpCtr.category[index].categoryId;
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    PDrSubCategory(categoryId: categoryId!,)));
                          },
                          child: Card(
                            margin: const EdgeInsets.only(
                                left: 6, right: 6, bottom: 3, top: 4),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6.0, top: 5),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                        clipBehavior: Clip.antiAlias,
                                        borderRadius: BorderRadius.circular(13.0),
                                        child: FadeInImage.assetNetwork(
                                          imageErrorBuilder: (c, o, s) =>
                                              Image.asset(
                                                  color: MyColor.midgray,
                                                  "assets/images/noimage.png",
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover),
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          placeholder:
                                          "assets/images/loading.gif",
                                          image: doctorSignUpCtr
                                              .category[index].catImg,
                                          placeholderFit: BoxFit.cover,
                                        )),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          doctorSignUpCtr.category[index]
                                              .categoryName,
                                          style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w500),
                                          softWrap: false,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );

            }
          }),
        ),
      ),
    );
  }
}
