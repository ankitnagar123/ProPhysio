import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../controller/doctor_list_ctr/DoctorListController.dart';
import '../../../model/DoctorListModel.dart';
import '../../doctor_detail_screen/DoctorDetailScreen.dart';

class DoctorSearchList extends StatefulWidget {
  const DoctorSearchList({Key? key}) : super(key: key);

  @override
  State<DoctorSearchList> createState() => _DoctorSearchListState();
}

class _DoctorSearchListState extends State<DoctorSearchList>
    with SingleTickerProviderStateMixin {
  CustomView customView = CustomView();
  TextEditingController searchCtr = TextEditingController();
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());
  String _keyword = '';
  TabController? tabController;

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

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
    tabController = TabController(vsync: this, length: 2);
    print("doctor length${doctorListCtr.doctorList.length}");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    final list = _getFilteredList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: customView.text("Search", 17, FontWeight.bold, MyColor.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios, color: MyColor.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
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
                          Get.toNamed(RouteHelper.getFilterScreen());
                        },
                        child: const Icon(Icons.filter_list_alt)),
                    suffixIconColor: MyColor.primary1,
                    contentPadding: const EdgeInsets.only(top: 3, left: 20),
                    hintText: "search doctor",
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
              const SizedBox(
                height: 25,
              ),
              /*----------------------Doctor List--------------------------*/
              Obx(() {
                if (doctorListCtr.loadingFetch.value) {
                  return Center(child: customView.MyIndicator());
                }
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: _keyword.isEmpty
                      ? const Text("Search someone to see results here.")
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                /*var id = {
                            "data": doctorListCtr.doctorList[index].doctorId
                          };*/
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorDetailScreen(
                                              id: list[index]
                                                  .doctorId
                                                  .toString(), centerId: '',
                                            )));
                                // Get.toNamed(RouteHelper.getDoctorDetailScreen(id),);
                              },
                              child: Card(
                                color: MyColor.midgray,
                                elevation: 2,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      // margin: const EdgeInsets.all(6),
                                      child: Image.network(
                                        list[index].doctorProfile.toString(),
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.amber,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Whoops!',
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          );
                                        },
                                      ),
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
                                            customView.text(
                                                list[index].code.toString(),
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
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
}
