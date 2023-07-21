import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/medica_center/center_controller/CenterAuthController.dart';

import '../../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../../language_translator/LanguageTranslate.dart';
import '../../../../../../medica_center/center_controller/CenterHomeController.dart';


class PCenterDetailScreen extends StatefulWidget {
  final String id;

  const PCenterDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PCenterDetailScreen> createState() => _PCenterDetailScreenState();
}

class _PCenterDetailScreenState extends State<PCenterDetailScreen> {


  CustomView custom = CustomView();
  LocalString text = LocalString();
  CenterAuthCtr centerAuthCtr = CenterAuthCtr();
  CenterHomeCtr centerHomeCtr = CenterHomeCtr();
  String centerId = '';

  String img = "";
  String address = "";
  String fee = "";
  String cat = "";
  String doc = "";
  String latitude = "";
  String longitude = "";
  String wardId = "";
  String wardName = "";
  @override
  void initState() {
    super.initState();
    centerId = widget.id.toString();
    print("doctor my  id$centerId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      centerHomeCtr.centerWardListPatient(context,centerId);
centerAuthCtr.centerDetails(context, centerId.toString());

    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Obx(() {
      return Scaffold(
        body:  centerAuthCtr.loadingDetails.value?Center(heightFactor: 16, child: custom.MyIndicator()):NestedScrollView(
          floatHeaderSlivers: false,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              leading: InkWell(
                  onTap: () {
                    Get.back();
                  },child: const Icon(Icons.arrow_back_ios,color: MyColor.black)),
              backgroundColor: MyColor.midgray,
              elevation: 0.0,
              expandedHeight: 320.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: custom.text(
                    centerAuthCtr.name.value,
                    15,
                    FontWeight.w500,
                    MyColor.primary1),
                background: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    alignment: Alignment.center,
                    image: centerAuthCtr.image.value,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/noimage.png',
                        fit: BoxFit.cover,
                      );
                    }),
              ),
            )
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.015,
                      ),
                      custom.text(cat, 16, FontWeight.w500, MyColor.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 19, color: MyColor.primary1),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: custom.text(centerAuthCtr.location.value,
                                  13, FontWeight.normal, MyColor.grey)),
                        ],
                      ),

                      const Divider(),
                      Align(
                        alignment: Alignment.topLeft,
                        child: custom.text(text.Centerward.tr, 15,
                            FontWeight.w500, MyColor.primary1),
                      ),
                      centerHomeCtr.loadingFetchW.value?custom.MyIndicator():centerHomeCtr.selectedWardList.isEmpty?
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: custom.text(text.NoWardAddedCenter.tr, 14,
                            FontWeight.w400, MyColor.black),
                      ): ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: centerHomeCtr.selectedWardList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            color: MyColor.midgray,
                            child: ListTile(
                              onTap: () {
                                wardId = centerHomeCtr.selectedWardList[index].wardId;
                                wardName = centerHomeCtr.selectedWardList[index].wardName;

                                var data ={
                                  "wardId":wardId,
                                  "wardName":wardName,
                                  "centerId":centerId,
                                  "address":address,
                                };
                                Get.toNamed(RouteHelper.getCenterWardDrList(),parameters: data);
                              },
                              title: custom.text(
                                  centerHomeCtr.selectedWardList[index].wardName, 14.0,
                                  FontWeight.w500, Colors.black),
                              subtitle: Row(
                                children: [
                                  const Icon(Icons.person_outline_outlined,
                                      size: 17, color: Colors.black),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  custom.text(
                                      "${centerHomeCtr.selectedWardList[index].totalDoctor} doctors", 11.0, FontWeight.normal, Colors.black),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
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
