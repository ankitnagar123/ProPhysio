import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../../../../helper/mycolor/mycolor.dart';
class QRResult extends StatefulWidget {
  const QRResult({Key? key}) : super(key: key);

  @override
  State<QRResult> createState() => _QRResultState();
}

class _QRResultState extends State<QRResult> {

  CustomView custom = CustomView();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
        centerTitle: true,
        elevation: 0.0,
        title: custom.text("Prescription & Medical reports", 15,
            FontWeight.w500, MyColor.black),
      ),
       body: Padding(
         padding: EdgeInsets.symmetric(horizontal: 10),
         child: Column(
           children: [
             Align(
               alignment: Alignment.topRight,
               child: custom.text(
                   "12/12/22",
                   14,
                   FontWeight.w400,
                   MyColor.black),
             ),
             SizedBox(height: 10,),
             Align(
               alignment: Alignment.topLeft,
               child: custom.text(
                   "Patient Medical Record",
                   20,
                   FontWeight.w500,
                   MyColor.primary1),
             ),
             SizedBox(height: 10,),
             Row(
               children: [
                 Expanded(
                   flex: 1,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const [
                       Text(
                         "Patient Information",
                         style: TextStyle(
                             color: MyColor.primary1,
                             fontSize: 14.0,
                             fontFamily: "Poppins"),
                       ),
                       SizedBox(
                         height: 2.0,
                       ),
                       Text("json sen",
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 15.0,
                               fontFamily: "Poppins")),
                     ],
                   ),
                 ),
                 Expanded(
                   flex: 1,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const [
                       Text(
                         "Birth Date",
                         style: TextStyle(
                             color: MyColor.primary1,
                             fontSize: 14.0,
                             fontFamily: "Poppins"),
                       ),
                       SizedBox(
                         height: 2.0,
                       ),
                       Text(
                         "12-12-22",
                         style: TextStyle(
                             color: Colors.black,
                             fontSize: 15.0,
                             fontFamily: "Poppins"),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
             const Divider(
               thickness: 1.0,
               height: 20.0,
             ),
             Row(
               children: [
                 Expanded(
                   flex: 1,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const [
                       Text(
                         "Contact",
                         style: TextStyle(
                             color: MyColor.primary1,
                             fontSize: 14.0,
                             fontFamily: "Poppins"),
                       ),
                       SizedBox(
                         height: 2.0,
                       ),
                       Text(
                           "${"+61545445488487"}",
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 15.0,
                               fontFamily: "Poppins")),
                     ],
                   ),
                 ),
                 Expanded(
                   flex: 1,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const [
                       Text(
                         "Weight",
                         style: TextStyle(
                             color: MyColor.primary1,
                             fontSize: 15.0,
                             fontFamily: "Poppins"),
                       ),
                       SizedBox(
                         height: 2.0,
                       ),
                       Text(
                           "56kg",
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 15.0,
                               fontFamily: "Poppins")),
                     ],
                   ),
                 ),
               ],
             ),
             const Divider(
               thickness: 1,
               height: 20.0,
             ),
             Row(
               children: [
                 Expanded(
                   flex: 1,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const [
                       Text(
                         "Address",
                         style: TextStyle(
                             color: MyColor.primary1,
                             fontSize: 14.0,
                             fontFamily: "Poppins"),
                       ),
                       SizedBox(
                         height: 2.0,
                       ),
                       Text(
                           "04 Rajiv Gandhi Sq Indore MP",
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 15.0,
                               fontFamily: "Poppins")),
                     ],
                   ),
                 ),
                 Expanded(
                   flex: 1,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: const [
                       Text(
                         "Height",
                         style: TextStyle(
                             color: MyColor.primary1,
                             fontSize: 14.0,
                             fontFamily: "Poppins"),
                       ),
                       SizedBox(
                         height: 2.0,
                       ),
                       Text(
                           "80CM",
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 15.0,
                               fontFamily: "Poppins")),
                     ],
                   ),
                 ),
               ],
             ),
             const Divider(
               thickness: 1,
               height: 40.0,
             ),
             Align(
               alignment: Alignment.topLeft,
               child: custom.text(
                   "General Medical History",
                   18,
                   FontWeight.w500,
                   MyColor.primary1),
             ),
             const Divider(
               color: MyColor.primary1,
               thickness: 1,
               height: 20.0,
             ),
           ],
         ),
       ),
    );
  }
}
