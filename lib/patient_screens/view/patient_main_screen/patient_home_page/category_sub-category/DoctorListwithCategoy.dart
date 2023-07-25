import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/Helper/RoutHelper/RoutHelper.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/Shimmer/ChatShimmer.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/patient_screens/model/DoctorListModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/doctor_list_ctr/DoctorListController.dart';
import '../../../doctor_detail_screen/DoctorDetailScreen.dart';
import 'DoctorMapScreen.dart';


class DoctorListWithCategory extends StatefulWidget {
  String catId, subCatId;

  DoctorListWithCategory(
      {Key? key, required this.catId, required this.subCatId})
      : super(key: key);

  @override
  State<DoctorListWithCategory> createState() => _DoctorListWithCategoryState();
}

class _DoctorListWithCategoryState extends State<DoctorListWithCategory>
    with SingleTickerProviderStateMixin {
  CustomView customView = CustomView();
  LocalString text = LocalString();
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  TextEditingController searchCtr = TextEditingController();
  TabController? tabController;

  int _selectedIndex = 0;
  bool _isListView = true;
  String? catId;
  String? subCatId;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      catId = widget.catId;
      subCatId = widget.subCatId;
      print("category$catId");
      print(subCatId);
      doctorListCtr.doctorlistfetch(
          context,
          catId.toString(),
          subCatId.toString(),
          '',
          '',
          '',
          '',
          '',
          '');
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // });

  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return Obx(() {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton:  doctorListCtr.doctorList.isEmpty?const Text(""):Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            height: 38.0,
            width: widht * 0.40,
            decoration: BoxDecoration(
                color: MyColor.primary,
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_selectedIndex < 1) {
                      _selectedIndex++;
                      _isListView = true;
                    } else {
                      _isListView = false;
                      _selectedIndex = 0;
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.2,
                      child: customView.text(
                          _isListView
                              ? text.ListView.tr
                              : text.MapView.tr,
                          13,
                          FontWeight.w500,
                          MyColor.white),
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    const Icon(
                      Icons.view_agenda_outlined,
                      color: MyColor.white,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    IndexedStack(
                      index: _selectedIndex,
                      children: [
                        DoctorList(cat: widget.catId, subcat: widget.subCatId),
                        MapViewScreen(
                            catId: widget.catId.toString(),
                            subCatID: widget.subCatId.toString()),
                        /* MapView(
                          catId: widget.catId.toString(),
                          subCatID: widget.subCatId.toString()),*/
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      );
    });
  }
}


/*----------Doctor List Screen--------------------*/
class DoctorList extends StatefulWidget {
  String cat, subcat;

  DoctorList({Key? key,
    required this.cat,
    required this.subcat
  }) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());

  TextEditingController searchCtr = TextEditingController();
  CustomView customView = CustomView();
  LocalString text = LocalString();
  TabController? tabController;
  String _keyword = '';

  List<DoctorListModel> _getFilteredList() {
    if (_keyword.isEmpty) {
      return doctorListCtr.doctorList;
    }
    return doctorListCtr.doctorList
        .where(
            (user) => user.name.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }

  /*@override
  void initState() {
    super.initState();
    doctorListCtr.doctorlistfetch(context, widget.cat.toString(), widget.subcat.toString(),'','','','','','');
    doctorListCtr.catSubCatList();
  }*/
  @override
  Widget build(BuildContext context) {
    final list = _getFilteredList();
    print("Doctor LIST");
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final widht = MediaQuery
        .of(context)
        .size
        .width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(height: height * 0.04),
            SizedBox(
              width: widht,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    _keyword = value;
                  });
                  print(value);
                },
                cursorWidth: 0.0,
                cursorHeight: 0.0,
                onTap: () {},
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                cursorColor: Colors.black,
                controller: searchCtr,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: MyColor.primary1,
                  suffixIcon: InkWell(
                      onTap: () {
                        var data = {
                          "category": widget.cat,
                          "subCat": widget.subcat,
                          "type": "goFilter",
                        };
                        Get.toNamed(
                            RouteHelper.getFilterScreen(), parameters: data);
                      },
                      child: const Icon(Icons.filter_list_alt)),
                  suffixIconColor: MyColor.primary1,
                  contentPadding: const EdgeInsets.only(top: 3, left: 20),
                  hintText: text.Search_Doctorby_Name.tr,
                  hintStyle:
                  const TextStyle(fontSize: 12, color: MyColor.primary1),
                  fillColor: MyColor.lightcolor,
                  filled: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            /*----------------------Doctor List--------------------------*/
            Obx(() {
              if (doctorListCtr.loadingFetch.value) {
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
                  child: Column(
                    children: [
                      categorysubShimmerEffect(context),
                    ],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: doctorListCtr.doctorList.isEmpty
                      ? Center(
                      heightFactor: 10,
                      child: Text(text.Doctor_Not_Available.tr))
                      : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorDetailScreen(
                                        id: list[index]
                                            .doctorId
                                            .toString(),
                                        centerId: '',
                                        drImg: list[index]
                                            .doctorProfile
                                            .toString(),
                                      )));
                          // Get.toNamed(RouteHelper.getDoctorDetailScreen(id),);
                        },
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
                                    placeholder: "assets/images/drsymbol.gif", /*"assets/images/YlWC.gif",*/
                                    alignment: Alignment.center,
                                    image: list[index]
                                        .doctorProfile
                                        .toString(),
                                    fit: BoxFit.fitWidth,
                                    width: double.infinity,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
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
                                  customView.text(
                                      list[index].name.toString(),
                                      13,
                                      FontWeight.w600,
                                      MyColor.black),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                          Icons.location_on_outlined,
                                          size: 18),
                                      SizedBox(
                                        width: 150,
                                        child: customView.text(
                                            list[index]
                                                .location
                                                .toString(),
                                            12,
                                            FontWeight.normal,
                                            MyColor.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.monetization_on,
                                          size: 18),
                                      const SizedBox(width: 3,),
                                      customView.text(
                                          list[index].fees.toString(),
                                          12,
                                          FontWeight.normal,
                                          MyColor.grey),
                                    ],
                                  ),
                                  SizedBox(
                                      width: widht * 0.50,
                                      child: customView.text(
                                          list[index].category.toString(),
                                          12,
                                          FontWeight.w500,
                                          MyColor.black)),

                                  RatingBar(
                                    ignoreGestures: true,
                                    itemSize: 17,
                                    initialRating: double.parse(
                                        list[index].rating.toString()),
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    ratingWidget: RatingWidget(
                                        full:
                                        const Icon(
                                            Icons.star, color: MyColor.primary),
                                        half: const Icon(Icons.star_half,
                                            color: MyColor.primary),
                                        empty: const Icon(
                                            Icons
                                                .star_border_purple500_outlined,
                                            color: MyColor.primary)),
                                    itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Future shortBy() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25.0,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: customView.text(
                      "Sort by:", 19, FontWeight.w600, MyColor.black),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("tap");
                      },
                      child: customView.text(
                          "Relevance", 17, FontWeight.normal, MyColor.black),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child:
                      Icon(Icons.check_outlined, color: MyColor.lightblue),
                    )
                  ],
                ),
                const Divider(thickness: 1.5, height: 34),
                GestureDetector(
                  onTap: () {},
                  child: customView.text(
                      "Rating", 15, FontWeight.normal, MyColor.black),
                ),
                const Divider(thickness: 1.5, height: 34),
                GestureDetector(
                  onTap: () {},
                  child: customView.text(
                      "Distance", 15, FontWeight.normal, MyColor.black),
                ),
                const Divider(thickness: 1.5, height: 34),
                GestureDetector(
                  onTap: () {},
                  child: customView.text(
                      "Name: A-Z", 15, FontWeight.normal, MyColor.black),
                ),
                const Divider(thickness: 1.5, height: 34),
                GestureDetector(
                  onTap: () {},
                  child: customView.text(
                      "Name: Z-A", 15, FontWeight.normal, MyColor.black),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

