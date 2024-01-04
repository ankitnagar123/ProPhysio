import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../doctor_screens/controller/DoctorSignUpController.dart';
import '../../../../../helper/AppConst.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/doctor_list_ctr/DoctorListController.dart';
import '../../../../model/DoctorListModel.dart';
import '../../../doctor_detail_screen/DoctorDetailScreen.dart';
import 'DoctorMapScreen.dart';


class DoctorList extends StatefulWidget {
  String cat, subcat;

  DoctorList({Key? key, required this.cat, required this.subcat})
      : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());

  TextEditingController searchCtr = TextEditingController();

  CustomView customView = CustomView();
  LocalString text = LocalString();
  TabController? tabController;
  String _keyword = '';
  String? selectedBranch;
  String ratings = "";

  List<DoctorListModel> _getFilteredList() {
    if (_keyword.isEmpty) {
      return doctorListCtr.doctorList;
    }
    return doctorListCtr.doctorList
        .where(
            (user) => user.name.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    doctorSignUpCtr.branchListApi();
    doctorListCtr.doctorlistfetch(context, widget.cat.toString(), /*widget.subcat.toString()*/'','','','','');
  }
  @override
  Widget build(BuildContext context) {
    final list = _getFilteredList();
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
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
                cursorColor: Colors.white,
                controller: searchCtr,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  prefixIconColor: MyColor.primary1,
                  suffixIcon: InkWell(
                     onTap: ()=> showModalBottomSheet(
                       backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        color: Colors.white,
                        child:Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),
                              customView.text(
                                  text.Select_Branch.tr, 14, FontWeight.w400, MyColor.black),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: branch(),

                              ),
                              customView.text(
                                  text.selectRatingRange.tr, 14, FontWeight.w400, MyColor.black),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              RatingBar(
                                itemSize: 23,
                                initialRating: 0.0 /*double.parse(
                                            patientRatingCtr.address.value.aveRating.toString())*/,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star, color: MyColor.primary),
                                    half: const Icon(Icons.star_half, color: MyColor.primary),
                                    empty: const Icon(Icons.star_border_purple500_outlined,
                                        color: MyColor.primary)),
                                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                onRatingUpdate: (rating) {
                                  //   log(">>>>> $rating");
                                  // doctorListCtr.location.value = rating.toString();
                                  /*=================*/
                                  setState(() {
                                    ratings = rating.toString();
                                    doctorListCtr.doctorlistfetch(
                                        context,
                                        widget.cat.toString(),
                                        widget.subcat.toString(),
                                        "",
                                        "",
                                        ratings,
                                        selectedBranch.toString());
                                    Get.back();
                                  });


                                  log(" app const = ${AppConst.rating}");
                                },
                              ),
                            ],
                          ),
                        )
                      );
                    },
                  ),
                    /*  onTap: () {

                        var data = {
                          "category": widget.cat,
                          "subCat": widget.subcat,
                          "type": "goFilter",
                        };

                        Get.toNamed(RouteHelper.getFilterScreen(),
                            parameters: data);
                      },*/
                      child: const Icon(Icons.filter_list_alt)),
                  suffixIconColor: MyColor.white,
                  contentPadding: const EdgeInsets.only(top: 3, left: 20),
                  hintText: text.Search_Doctorby_Name.tr,
                  hintStyle:
                  const TextStyle(fontSize: 12, color: MyColor.white),
                  fillColor: MyColor.grey.withOpacity(0.2),
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
            SizedBox(height: height * 0.02),
           /* Align(
                alignment: Alignment.topRight,
                child: branch()
            ),*/
            /*----------------------Doctor List--------------------------*/
            Obx(() {
              if (doctorListCtr.loadingFetch.value) {
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8),
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
                                        id: list[index].doctorId.toString(),
                                        centerId: '', drImg: '', cat: '',
                                      )));
                          // Get.toNamed(RouteHelper.getDoctorDetailScreen(id),);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 6.0),
                          color: MyColor.white,
                          elevation: 1.4,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100.0,
                                height: 100.0,
                                // margin: const EdgeInsets.all(6),
                                child: FadeInImage.assetNetwork(
                                    placeholder:
                                    "assets/images/loading.gif",
                                    // placeholderCacheHeight: 20,
                                    // placeholderCacheWidth: 20,
                                    /*"assets/images/YlWC.gif",*/
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
                                      "${list[index].name.toUpperCase()} ${list[index].surname.toUpperCase()}",
                                      13,
                                      FontWeight.w500,
                                      MyColor.primary1),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  SizedBox(
                                      width: widht * 0.50,
                                      child: customView.text(
                                          list[index].category
                                              .toString(),
                                          12,
                                          FontWeight.w500,
                                          MyColor.black)),
                                  /*   list[index].serviceStatus == "Free"
                                            ? Row(
                                                children: [
                                                  const Icon(
                                                    Icons.local_hospital,
                                                    color: Colors.red,
                                                    size: 19,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: customView.text(
                                                        "FIRST CONSULTANT FREE",
                                                        12,
                                                        FontWeight.normal,
                                                        Colors.green),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  const Icon(
                                                      Icons.monetization_on,
                                                      size: 18),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  customView.text(
                                                      list[index]
                                                          .fees
                                                          .toString(),
                                                      12,
                                                      FontWeight.normal,
                                                      MyColor.grey),
                                                ],
                                              ),*/
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  RatingBar(
                                    ignoreGestures: true,
                                    itemSize: 17,
                                    initialRating: double.parse(
                                        list[index].rating.toString()),
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    ratingWidget: RatingWidget(
                                        full: const Icon(Icons.star,
                                            color: Colors.orange),
                                        half: const Icon(Icons.star_half,
                                            color: Colors.orange),
                                        empty: const Icon(
                                            Icons
                                                .star_border_purple500_outlined,
                                            color: Colors.orange)),
                                    itemPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    onRatingUpdate: (rating) {
                                      log("$rating");
                                    },
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                          Icons.location_on_outlined,
                                          size: 18),
                                      SizedBox(
                                          width:
                                          MediaQuery.sizeOf(context)
                                              .width /
                                              1.9,
                                          child: Text(
                                            list[index].branchAddress.toUpperCase(),
                                            maxLines: 1,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontFamily: "Poppins",
                                              color: MyColor.grey,
                                            ),
                                          )),
                                    ],
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
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }

  /*---------SELECT BRANCH-----*/
  Widget branch() {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return StatefulBuilder(
      builder: (context, StateSetter stateSetter) => Container(
        height: height * 0.05,
        width: widht * 1,
        padding: const EdgeInsets.all(3),
        // margin: const EdgeInsets.fromLTRB(0, 5, 5.0, 0.0),
        decoration: BoxDecoration(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: MyColor.grey)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(

            menuMaxHeight: MediaQuery.of(context).size.height / 3,
            // Initial Value
            value: selectedBranch,
            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down, color: MyColor.primary),
            // Array list of items
            items: doctorSignUpCtr.branchList.map((items) {
              return DropdownMenuItem(
                value: items.branchId,
                child: Text(items.branchName),
              );
            }).toList(),
            hint: Text(text.Select_Branch.tr),
            onChanged: (newValue) {
              stateSetter(() {
                selectedBranch = newValue;
                log('MY selected Branch>>>$selectedBranch');
                doctorListCtr.doctorlistfetch(
                    context,
                    widget.cat.toString(),
                    widget.subcat.toString(),
                    "",
                    "",
                    "",
                    selectedBranch.toString());
              });
              Get.back();
            },
          ),
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

/*
class DoctorListWithCategory extends StatefulWidget {
  String catId, subCatId, rating, startPrice, EndPrice;

  DoctorListWithCategory(
      {Key? key,
      required this.catId,
      required this.subCatId,
      required this.rating,
      required this.startPrice,
      required this.EndPrice})
      : super(key: key);

  @override
  State<DoctorListWithCategory> createState() => _DoctorListWithCategoryState();
}

class _DoctorListWithCategoryState extends State<DoctorListWithCategory>
    with SingleTickerProviderStateMixin {
  CustomView customView = CustomView();
  LocalString text = LocalString();
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  DoctorSignUpCtr doctorSignUpCtr = Get.put(DoctorSignUpCtr());

  TextEditingController searchCtr = TextEditingController();
  TabController? tabController;

  int _selectedIndex = 0;
  bool _isListView = true;
  String? catId;
  String? subCatId;
  String rating = "";
  String startTime = "";
  String endTime = "";

  @override
  void initState() {
    super.initState();
    rating = widget.rating;
    startTime = widget.startPrice;
    endTime = widget.EndPrice;
    tabController = TabController(vsync: this, length: 2);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      doctorSignUpCtr.branchListApi();

      catId = widget.catId;
      subCatId = widget.subCatId;

      print("category$catId");
      print(subCatId);
  */
/*    doctorListCtr.doctorlistfetch(
        context,
        catId.toString(),
        subCatId.toString(),
        startTime.toString(),
        endTime.toString(),
        rating,
        "",
      );*//*

    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // });
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return Obx(() {
      return Scaffold(
        bottomNavigationBar:doctorListCtr.doctorList.isEmpty
            ? const Text("")
            : BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: MyColor.primary1, // Set the color for the selected tab
          unselectedItemColor: Colors.grey, // Set the color for unselected tabs
        ),
       */
/* floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: doctorListCtr.doctorList.isEmpty
            ? const Text("")
            : Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 38.0,
                  width: widht * 0.40,
                  decoration: BoxDecoration(
                      color: MyColor.primary1,
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
                            width: MediaQuery.of(context).size.width * 0.2,
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
              ),*//*

        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  DoctorList(cat: widget.catId, subcat: widget.subCatId),
                  MapViewScreen(
                      catId: widget.catId.toString(),
                      subCatID: widget.subCatId.toString()),
                  */
/* MapView(
                    catId: widget.catId.toString(),
                    subCatID: widget.subCatId.toString()),*//*

                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
*/




/*----------Doctor List Screen--------------------*/

