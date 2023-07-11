import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/sharedpreference/SharedPrefrenc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../helper/Shimmer/ChatShimmer.dart';
import '../../helper/mycolor/mycolor.dart';
import '../../language_translator/LanguageTranslate.dart';
import '../center_controller/CenterHomeController.dart';
import '../center_models/CenterSelectedDrModel.dart';

class CenterDoctorViewScreen extends StatefulWidget {
  const CenterDoctorViewScreen({Key? key}) : super(key: key);

  @override
  State<CenterDoctorViewScreen> createState() => _CenterDoctorViewScreenState();
}

class _CenterDoctorViewScreenState extends State<CenterDoctorViewScreen> {
  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  LocalString text = LocalString();

  SharedPreferenceProvider sp = SharedPreferenceProvider();
  CenterHomeCtr centerHomeCtr = Get.put(CenterHomeCtr());

  int selectedCard = -1;
String wardId = "";
  String wardName = "";
String keyword = "";
  @override
  void initState() {
    super.initState();
    wardId = Get.parameters["wardId"].toString();
    wardName = Get.parameters["wardName"].toString();
    print("ward id $wardId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerHomeCtr.centerSelectedDrList(context,wardId);
    });
    centerHomeCtr.wardDeleteReason(context);
  }

  List<CenterSelectedDListModel> _getFilteredList() {
    if (keyword.isEmpty) {
      return centerHomeCtr.selectedDoctorList;
    }
    return  centerHomeCtr.selectedDoctorList
        .where(
            (user) => user.name.toLowerCase().contains(keyword.toLowerCase())||user.surname.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }


  @override
  Widget build(BuildContext context) {
  final  drList =  _getFilteredList();
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.06,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_ios_new_outlined,
                              size: 20)),
                      custom.text(wardName, 17,
                          FontWeight.w500, MyColor.black),
                      GestureDetector(
                          onTap: () {
                            var data = {
                              "wardId":wardId,
                              "wardName":wardName,
                            };
                            Get.toNamed(RouteHelper.CEditWard(),parameters: data);
                          },
                          child: const Icon(Icons.more_outlined, size: 20)),
                    ],
                  ),
                ),
                SizedBox(
                  width: widht,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        keyword = value;
                      });
                      log(value);
                    },
                    cursorWidth: 0.0,
                    cursorHeight: 0.0,
                    onTap: () {},
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    controller: searchCtr,
                    decoration:  InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: MyColor.primary1,
                      contentPadding: EdgeInsets.only(top: 3, left: 20),
                      hintText: text.Search_Doctorby_Name.tr,
                      hintStyle: TextStyle(
                          fontSize: 12, color: MyColor.primary1),
                      fillColor: MyColor.lightcolor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                centerHomeCtr.loadingFetchS.value
                    ? categorysubShimmerEffect(context)
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: drList.isEmpty
                            ?  Center(
                                heightFactor: 10,
                                child:
                                    Text(text.Doctor_Not_Available.tr))
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    drList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 6.0),
                                      color: MyColor.midgray,
                                      elevation: 2.2,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 100.0,
                                            height: 100.0,
                                            // margin: const EdgeInsets.all(6),
                                            child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    "assets/images/YlWC.gif",
                                                alignment: Alignment.center,
                                                image: drList[
                                                    index].doctorProfile,
                                                fit: BoxFit.fitWidth,
                                                width: double.infinity,
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return Image.asset(
                                                    'assets/images/noimage.png',
                                                    fit: BoxFit.cover,
                                                  );
                                                }),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              custom.text(
                                                  "${drList[index].name} ${drList[index].surname}",
                                                  13,
                                                  FontWeight.w600,
                                                  MyColor.black),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 18),
                                                  SizedBox(
                                                    width: MediaQuery.sizeOf(context).width/2,
                                                    child: Text(drList[index].location,maxLines: 3,  overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 12,
                                                      fontFamily: "Poppins",color: MyColor.grey,),)),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
