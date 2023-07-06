/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/CustomView/CustomView.dart';
import '../../../helper/mycolor/mycolor.dart';

class PatinetOfficeAddress extends StatefulWidget {
  final String addressCenter, addressPersonal;

  const PatinetOfficeAddress(
      {Key? key, required this.addressCenter, required this.addressPersonal})
      : super(key: key);

  @override
  State<PatinetOfficeAddress> createState() => _PatinetOfficeAddressState();
}

class _PatinetOfficeAddressState extends State<PatinetOfficeAddress> {
  CustomView custom = CustomView();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: MyColor.black,
            )),
        elevation: 0,
        centerTitle: true,
        title:
            custom.text("Offices address", 17, FontWeight.w500, MyColor.black),
      ),
      body: Column(
        children: [
          const Divider(),
          SizedBox(
            height: height * 0.03,
          ),
          Card(
            elevation: 1.3,
            margin: const EdgeInsets.all(10),
            color: MyColor.midgray,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: custom.text("Personal center address", 15,
                        FontWeight.w500, MyColor.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_outlined),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width/1.2,
                        child: custom.text(widget.addressPersonal, 12,
                            FontWeight.normal, MyColor.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 1.3,
            margin: const EdgeInsets.all(10),
            color: MyColor.midgray,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: custom.text("Medical center address", 15,
                        FontWeight.w500, MyColor.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_outlined),
                      custom.text(widget.addressCenter, 12,
                          FontWeight.normal, MyColor.grey),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
*/
