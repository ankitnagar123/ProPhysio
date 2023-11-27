import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../../helper/CustomView/CustomView.dart';
import '../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../helper/Shimmer/ChatShimmer.dart';
import '../../../helper/mycolor/mycolor.dart';
import '../../../helper/sharedpreference/SharedPrefrenc.dart';
import '../../../language_translator/LanguageTranslate.dart';
import '../../center_controller/CenterHomeController.dart';

class CenterEditWardScreen extends StatefulWidget {
  const CenterEditWardScreen({Key? key}) : super(key: key);

  @override
  State<CenterEditWardScreen> createState() => _CenterEditWardScreenState();
}

class _CenterEditWardScreenState extends State<CenterEditWardScreen> {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  SharedPreferenceProvider sp = SharedPreferenceProvider();
  LocalString text = LocalString();
  String? cancelReason = '';
  String? cancelReason1 = '';

  String doctorId = "";
  String wardId = "";
  String wardName = "";

  String drCancelId = "";
  String wardCancelId = "";

  var drIdArray = [];
  var drCancelIdArray = [];

  CenterHomeCtr centerHomeCtr = CenterHomeCtr();
  String? id;
  String? userTyp;
  String? deviceId;
  String? deviceTyp;

  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    wardId = Get.parameters["wardId"].toString();
    wardName = Get.parameters["wardName"].toString();

    log("ward Id$wardId");
    log("ward Name$wardName");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerHomeCtr.centerSelectedDrList(context, wardId);
    });
    centerHomeCtr.wardDrRemoveReason(context);
    centerHomeCtr.wardDeleteReason(context);
    nameCtr.text = wardName;
  }

/*

  List<CenterDoctorListModel> _getFilteredList() {
    if (_keyword.isEmpty) {
      return centerHomeCtr.doctorList;
    }
    return centerHomeCtr.doctorList
        .where(
            (user) => user.name.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }*/

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          leading: InkWell(
              onTap: () {
                centerHomeCtr.centerSelectedDrList(context, wardId);
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
          elevation: 0,
          centerTitle: true,
          title: custom.text(text.Edit_Ward.tr, 17, FontWeight.w500, MyColor.black),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: custom.text(text.Edit_Ward.tr, 13.0, FontWeight.w600,
                    MyColor.primary1),
              ),
              const SizedBox(
                height: 4.0,
              ),

              custom.myField(context, nameCtr, text.Edit_Ward.tr, TextInputType.text),
              SizedBox(
                height: height * 0.03,
              ),
              const Divider(thickness: 1.5, color: MyColor.midgray),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: custom.text(
                        text.Edit_Doctor.tr, 16.0, FontWeight.w500, MyColor.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      var data = {
                        "wardId": wardId,
                        "wardName": wardName,
                      };
                      Get.offNamed(RouteHelper.cAddMoreDrs(), parameters: data);
                    },
                    child: Card(
                      elevation: 2,
                      color: MyColor.midgray,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: custom.text(
                            text.Add_More_Doctor.tr, 14.0, FontWeight.w400,
                            MyColor.black),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02,),
              centerHomeCtr.loadingFetchS.value
                  ? categoryShimmerEffect(context)
                  : Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 4,
                  children: List.generate(
                      centerHomeCtr.selectedDoctorList.length, (index) {
                    return Stack(
                      children: [
                        Card(
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
                                      borderRadius: BorderRadius.circular(
                                          13.0),
                                      child: FadeInImage.assetNetwork(
                                        imageErrorBuilder: (c, o, s) =>
                                            Image.asset(
                                                color: MyColor.midgray,
                                                "assets/images/noimage.png",
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover),
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        placeholder:
                                        "assets/images/loading.gif",
                                        image: centerHomeCtr
                                            .selectedDoctorList[index]
                                            .doctorProfile,
                                        placeholderFit: BoxFit.cover,
                                      )),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        centerHomeCtr
                                            .selectedDoctorList[index].name,
                                        style: const TextStyle(fontSize: 11),
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
                        Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                                onTap: () {
                                  doctorId = centerHomeCtr.selectedDoctorList[index]
                                          .doctorId;
                                  removeDoctor(context, doctorId, index);
                                },
                                child: const Icon(
                                  Icons.close_outlined, size: 18,
                                  color: MyColor.primary1,))),
                      ],
                    );
                  }),
                ),
              ),
              Align(alignment: Alignment.topLeft, child: GestureDetector(
                  onTap: () {
                    deleteWardPopUp(context);
                  },
                  child: custom.text(
                     text.Delete_Ward.tr, 13, FontWeight.w500, Colors.red))),
              const SizedBox(height: 65,)
            ],
          ),
        ),
      );
    });
  }

  void getValuee() async {
    id = await sp.getStringValue(sp.DOCTOR_ID_KEY);
    deviceTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);
    deviceId = await sp.getStringValue(sp.FIREBASE_TOKEN_KEY);
    // userTyp = await sp.getStringValue(sp.CURRENT_DEVICE_KEY);

    // loginCtr.updateToken(context, id!, "Doctor", deviceId!, deviceTyp!);
  }

  void removeDoctor(BuildContext context, String id, indexs) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
              child: StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 5.0),
                            child: custom.text(text.Remove_Doctor.tr, 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 5.0),
                            child: custom.text(
                                text.Sure_Want_Remove_Doctor.tr,
                                12,
                                FontWeight.w400,
                                Colors.black),
                          ),

                          SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: centerHomeCtr.doctorRemoveReason
                                  .length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -2),
                                  leading: Text(
                                      centerHomeCtr.doctorRemoveReason[index]
                                          .reason.toString()),
                                  trailing: Radio<String>(
                                    value: index.toString(),
                                    groupValue: cancelReason,
                                    onChanged: (value) {
                                      setState(() {
                                        cancelReason = value!;
                                        print("....$cancelReason");
                                        drCancelId = centerHomeCtr
                                            .doctorRemoveReason[index].id;
                                        print('Doctor Cancel id$drCancelId');
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: custom.text(text.Dismiss.tr, 14.0,
                                        FontWeight.w400, MyColor.grey),
                                  )),
                              centerHomeCtr.loadingEdit.value
                                  ? custom.MyIndicator()
                                  : Expanded(
                                child: custom.mysButton(
                                  context,
                                  text.Remove_Doctor.tr,
                                      () {
                                    if(cancelReason == ""){
                                      print("select");
                                    }else{
                                      centerHomeCtr.editWard(
                                          context, wardName, doctorId, drCancelId,
                                          wardId, () {
                                        centerHomeCtr.centerSelectedDrList(
                                            context, wardId);
                                        Get.back();
                                      });
                                    }

                                    /* bookingController
                                        .bookingAppointmentCancel(
                                        context, id,cancelId!, () {
                                      Get.offNamed(RouteHelper
                                          .DCancelAppointSucces());*/
                                    // });
                                  },
                                  Colors.red,
                                  const TextStyle(
                                    fontSize: 13.0,
                                    color: MyColor.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }

  void deleteWardPopUp(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1,
              child: StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Obx(() {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0),
                              child: custom.text(text.Delete_Ward.tr, 17,
                                  FontWeight.w500, Colors.black),
                            ),
                            const SizedBox(
                              height: 13.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0),
                              child: custom.text(
                                  text.Sure_Want_Remove_Ward.tr,
                                  12,
                                  FontWeight.w400,
                                  Colors.black),
                            ),
                            const SizedBox(
                              height: 13.0,
                            ),
                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: centerHomeCtr.wardRemoveReason
                                    .length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -2),
                                    leading: Text(
                                        centerHomeCtr.wardRemoveReason[index]
                                            .reason.toString()),
                                    trailing: Radio<String>(
                                      value: index.toString(),
                                      groupValue: cancelReason1,
                                      onChanged: (value) {
                                        setState(() {
                                          cancelReason1 = value!;
                                          print("....$cancelReason1");
                                          wardCancelId = centerHomeCtr
                                              .doctorRemoveReason[index].id;
                                          print('Ward Cancel id$wardCancelId');
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: custom.text(
                                      text.Dismiss.tr, 14.0, FontWeight.w500,
                                      MyColor.grey),
                                ),
                                centerHomeCtr.loadingDelete.value
                                    ? custom.MyIndicator()
                                    : custom.mysButton(
                                  context,
                                  text.Delete_Ward.tr,
                                      () {
                                    if(cancelReason1 == ""){
                                      log("empty");
                                    }else{
                                      centerHomeCtr.deleteWard(
                                          context, wardCancelId, wardId, () {
                                        Get.toNamed(
                                            RouteHelper.CBottomNavigation());
                                      });
                                    }

                                  },
                                  Colors.red,
                                  const TextStyle(
                                    color: MyColor.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          );
        });
  }

}
