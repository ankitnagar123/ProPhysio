import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/Shimmer/ChatShimmer.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/patient_screens/controller/patinet_center_controller/PCenterController.dart';
import '../../../../../../../language_translator/LanguageTranslate.dart';
import '../PCenterDetailsPage.dart';

class PCenterListView extends StatefulWidget {
  const PCenterListView({Key? key}) : super(key: key);

  @override
  State<PCenterListView> createState() => _PCenterListViewState();
}

class _PCenterListViewState extends State<PCenterListView> {
  CustomView customView = CustomView();
  LocalString text = LocalString();
  PCenterCtr pCenterCtr = PCenterCtr();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pCenterCtr.centerListApi();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Column(
          children: [
            showList(),
          ],
        ),
      ),
    );
  }

  Widget showList() {
    return Obx(() {
      if (pCenterCtr.loadingFetch.value) {
        return Padding(
          padding: EdgeInsets.only(top: 17),
          child: categorysubShimmerEffect(context),
        );
      }
      return pCenterCtr.centerList.isEmpty
          ? Center(
          heightFactor: 10,
          child: customView.text(text.Center_not_available_moment.tr, 14,
              FontWeight.w400, MyColor.primary1))
          : SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: pCenterCtr.centerList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var centerList = pCenterCtr.centerList[index];
              var id = pCenterCtr.centerList[index].centerId;
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PCenterDetailScreen(
                            id: id,
                          )));

                },
                child: Card(
                  color: MyColor.midgray,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7.0, vertical: 10.0),
                    child: Row(
                      children: [
                        ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(5.0),
                            child: FadeInImage.assetNetwork(
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                  color: MyColor.midgray,
                                  "assets/images/noimage.png",
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover),
                              width: 90,
                              height: 95,
                              fit: BoxFit.cover,
                              placeholder: "assets/images/loading.gif",
                              image: centerList.image,
                              placeholderFit: BoxFit.cover,
                            )),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customView.text(
                                pCenterCtr.centerList[index].name
                                    .toString(),
                                14.0,
                                FontWeight.w500,
                                Colors.black),
                            const SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width / 1.8,
                              child: customView.text(
                                  pCenterCtr.centerList[index].biography
                                      .toString(),
                                  12.0,
                                  FontWeight.w400,
                                  Colors.black),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    size: 18),
                                SizedBox(
                                  width: 150,
                                  child: customView.text(
                                      pCenterCtr
                                          .centerList[index].address,
                                      12,
                                      FontWeight.normal,
                                      MyColor.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }
}
