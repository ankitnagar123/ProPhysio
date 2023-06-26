import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../patient_screens/controller/doctor_list_ctr/PDoctorSpecializationCtr.dart';

class DoctorViewSpecialization extends StatefulWidget {
  const DoctorViewSpecialization({Key? key}) : super(key: key);

  @override
  State<DoctorViewSpecialization> createState() =>
      _DoctorViewSpecializationState();
}

class _DoctorViewSpecializationState extends State<DoctorViewSpecialization> {
  DoctorSpecializationCtr doctorSpecializationCtr =
      Get.put(DoctorSpecializationCtr());
  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: height * 0.01,
      ),
      doctorSpecializationCtr.category.isEmpty
          ? const SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "No  Specialization Added by Doctor",
                style: TextStyle(color: MyColor.primary1, fontSize: 12),
              )))
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: doctorSpecializationCtr.category.length,
              itemBuilder: (context, index) {
                var list = doctorSpecializationCtr.category[index];
                return GestureDetector(
                  onTap: () {
                    var categoryId = list.categoryId;
                    var data = {
                      // "doctorId": doctorId,
                      "catId": categoryId,
                    };
                    Get.toNamed(RouteHelper.getSpecializationDetailsScreen(),
                        arguments: data);
                  },
                  child: Container(
                      height: 50.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: MyColor.lightcolor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            custom.text(list.categoryName, 14.0,
                                FontWeight.w500, MyColor.primary1),
                            const Icon(
                              Icons.arrow_forward,
                              size: 20.0,
                              color: MyColor.primary1,
                            ),
                          ],
                        ),
                      )),
                );
              },
            ),
      SizedBox(
        height: height * 0.01,
      ),
    ]));
  }
}
