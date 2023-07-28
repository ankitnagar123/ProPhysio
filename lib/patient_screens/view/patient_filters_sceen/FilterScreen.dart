import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/AppConst.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';

import '../../../language_translator/LanguageTranslate.dart';
import '../../controller/doctor_list_ctr/DoctorListController.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  CustomView custom = CustomView();
  LocalString text = LocalString();
// DoctorListCtr doctorListCtr = DoctorListCtr();

  var cat = "" ;
  var subCat = "";
  @override
  void initState() {
    cat = Get.parameters['category'].toString();
    subCat = Get.parameters['subCat'].toString();
print("cat$cat");
     cat = AppConst.cat;
    print("store${AppConst.cat}");
     if(Get.parameters["type"] == "goFilter"){
       cat = Get.parameters["category"].toString();
       subCat = Get.parameters["subCat"].toString();

       AppConst.FILTER_CAT = cat;
       AppConst.FILTER_SUBCAT = subCat;

       print("cat ===${AppConst.FILTER_CAT}");
       print("sub-cat===${AppConst.FILTER_SUBCAT}");
     }else{
       print("object");
     }
/*AppConst.FILTER_CAT = cat;
    AppConst.FILTER_SUBCAT = subCat;*/

 /*   WidgetsBinding.instance.addPostFrameCallback((_) {
      print("rating===${AppConst.rating}");
      print("location===${AppConst.FILTER_LOCATION}");

      print("priceRangeStart===${AppConst.priceRangeStart}");
      print("priceRangeEnd===${AppConst.priceRangeEnd}");

    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return   Scaffold(
      /*  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: doctorListCtr.loadingFetchF.value?custom.MyIndicator():custom.MyButton(context, "Show All 0 results", () {
             doctorListCtr.doctorlistfetch(context, AppConst.FILTER_CAT, AppConst.FILTER_SUBCAT, AppConst.priceRangeStart,
                AppConst.priceRangeEnd, AppConst.rating, AppConst.FILTER_LATITUDE,  AppConst.FILTER_LONGITUDE,  AppConst.FILTER_DISTANCE);
            Get.back();
          }, MyColor.primary,
              const TextStyle(color: MyColor.white, fontFamily: "Poppins")),
        ),*/
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: custom.text(text.Filters.tr, 17, FontWeight.bold, MyColor.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close_outlined, color: MyColor.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            SizedBox(
              height: height * 0.03,
            ),
            ListTile(
              onTap: () {
                Get.offNamed(RouteHelper.getLocationDistanceFilter());
              },
              title: custom.text(
                  text.Location_and_distance.tr, 15, FontWeight.w500,
                  MyColor.black),
              subtitle: Text("${AppConst.FILTER_LOCATION} , ${AppConst
                  .FILTER_DISTANCE}${text.km.tr}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20),
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () async {
                var data = {
                  "cat":cat,
                  "subCat":subCat,
                };
                Get.offAndToNamed(RouteHelper.getRatingFilterScreen(),
                  parameters: data,
                );
              },
              title: custom.text(
                  text.Rating.tr, 15, FontWeight.w500, MyColor.black),
              subtitle: Text(AppConst.rating),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20),
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                var data = {
                  "cat":cat,
                  "subCat":subCat,
                };
                Get.offNamed(RouteHelper.getPriceRange(),
                    parameters: data);
                // Get.toNamed(RouteHelper.getSpecializationScreen());
              },
              title: custom.text(
                  text.price_Range.tr, 15, FontWeight.w500, MyColor.black),
              subtitle: Row(
                children: [
                  Text("${AppConst.priceRangeStart}-"),
                  Text(AppConst.priceRangeEnd),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
