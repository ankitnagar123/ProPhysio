import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import 'DoctorListwithCategoy.dart';
import 'DoctorMapScreen.dart';
class DoctorListTab extends StatefulWidget {
  final catId,SubCatId;
  const DoctorListTab({super.key, this.catId, this.SubCatId});

  @override
  State<DoctorListTab> createState() => _DoctorListTabState();
}

class _DoctorListTabState extends State<DoctorListTab>with  SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  TextEditingController searchCtr = TextEditingController();
  CustomView custom = CustomView();
  LocalString text = LocalString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      //     icon: const Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.black,
      //     ),
      //   ),
      //   title: custom.text(text.yourReport.tr, 15.0, FontWeight.w500, Colors.black),
      //   centerTitle: true,
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      // ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.only(left: 3,right: 3,bottom: 5),
              labelPadding: const EdgeInsets.all(7.0),
              indicatorColor: MyColor.red,
              labelColor: Colors.white,
              indicator:  BoxDecoration(color: MyColor.red.withOpacity(0.5),borderRadius: BorderRadius.circular(25),),
              unselectedLabelColor: Colors.black,
              controller: tabController,
              // indicatorWeight: 0,
              tabs:  [
                Tab(
                    child: Text(text.ListView,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins",),)
                ),
                Tab(
                  child: Text(text.MapView.tr,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Poppins"),),
                ),

              ],
            ),
          ),
          Expanded(child:  Padding(
            padding: const EdgeInsets.all(0.0),
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children:  [
                  DoctorList(cat: widget.catId, subcat: widget.SubCatId,),
                  MapViewScreen(catId: widget.catId, subCatID: widget.SubCatId,)
                ]),
          ),),

        ],
      ),
    );
  }
}
