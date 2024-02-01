import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophysio/doctor_screens/controller/TaskManageCtr/TaskManagementCtr.dart';
import '../../../../../doctor_screens/model/TaskManageModel.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/auth_controllers/PatientSupportController.dart';


class SupportList extends StatefulWidget {
  const SupportList({super.key});

  @override
  State<SupportList> createState() => _DoctorTaskState();
}

class _DoctorTaskState extends State<SupportList> {
  CustomView custom = CustomView();
  TextEditingController searchCtr = TextEditingController();
  PatientSupportCtr patientSupportCtr = Get.put(PatientSupportCtr());
  LocalString text = LocalString();

/*------VARIABLES------*/
  String? cancelId = '';
  String? cancelReason = '';
  String _keyword = '';
  int selectedCard = -1;



  @override
  void initState() {
    super.initState();
    patientSupportCtr.supportList(
      context,
      "User",
    );
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        // padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: showList(),
            ),
          ],
        ),
      ),
    );
  }

  /*------------Booking All List--------------*/
  Widget showList() {
    var listData =patientSupportCtr.supportLists.value;
    return Obx(() {
      if (patientSupportCtr.supportLoading.value) {
        return Center(
          heightFactor: 10,
          child: custom.MyIndicator(),
        );
      }
      return SingleChildScrollView(
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: listData.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var list = listData[index];
              var task = list.message;
              var taskDisc = list.subject;
              var status = list.supportStatus;
              var staffName = list.staffName;

              return InkWell(
                onTap: () {
                  showBottomSheets(status, task, taskDisc,staffName);
                },
                child: Card(
                  elevation: 1.5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Report",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: "Poppins"),
                                  ),
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  custom.text(list.message.toString(), 13.0,
                                      FontWeight.w500, Colors.black),
                                ],
                              ),
                            ),
                            Icon(Icons.more_vert,color: MyColor.primary1,size: 18,),
                          ],
                        ),
                        SizedBox(
                          height: 4,
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

  /*------------Task Details--------------*/
  showBottomSheets(String status, String task, String taskDisc,String staffName,) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))),
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  custom.text(
                      text.details.tr, 17.0, FontWeight.w500, Colors.black),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Subject",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(task,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: "Poppins")),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Message",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(taskDisc,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: "Poppins")),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 30,
                  ),
                  Row(
                    children: [
                      status =="Pending"?SizedBox():  Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Staff",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(staffName,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: "Poppins")),
                          ],
                        ),
                      ),
                     Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Status",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(status,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: "Poppins")),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: MyColor.grey.withOpacity(0.5),
                    height: 30,
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                ],
              ),

          );
        });
  }

/*------------Task Accept PopUp--------------*/
// void acceptPopUp(BuildContext context, String bookingId) {
//   showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel:
//           MaterialLocalizations.of(context).modalBarrierDismissLabel,
//       barrierColor: Colors.black54,
//       pageBuilder: (context, anim1, anim2) {
//         return Center(
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width / 1,
//             child: StatefulBuilder(
//               builder: (context, StateSetter setState) {
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(7.0),
//                   ),
//                   margin: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10.0, vertical: 20.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 10.0,
//                         ),
//                         Padding(
//                           padding:
//                               const EdgeInsets.symmetric(horizontal: 5.0),
//                           child: custom.text(text.accept.tr, 17,
//                               FontWeight.w500, Colors.black),
//                         ),
//                         const SizedBox(
//                           height: 13.0,
//                         ),
//                         Padding(
//                           padding:
//                               const EdgeInsets.symmetric(horizontal: 5.0),
//                           child: custom.text(text.AcceptVisitLine.tr, 12,
//                               FontWeight.w400, Colors.black),
//                         ),
//                         const SizedBox(
//                           height: 13.0,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Expanded(
//                                 flex: 1,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     Get.back();
//                                     Get.back();
//                                   },
//                                   child: custom.text(text.Dismiss.tr, 14.0,
//                                       FontWeight.w400, MyColor.grey),
//                                 )),
//                             Expanded(
//                               child: bookingController.loadingAccept.value
//                                   ? custom.MyIndicator()
//                                   : custom.mysButton(
//                                       context,
//                                       text.Yes_accept.tr,
//                                       () {
//                                         bookingController
//                                             .bookingAppointmentAccept(
//                                                 context, bookingId, () {
//                                           Get.back();
//                                           Get.back();
//                                         });
//
//                                         // Navigator.push(
//                                         //     context,
//                                         //     MaterialPageRoute(
//                                         //         builder: (context) =>
//                                         //         const CancelAppointmentSuccess()));
//                                       },
//                                       MyColor.primary,
//                                       const TextStyle(
//                                         fontSize: 13.0,
//                                         color: MyColor.white,
//                                       ),
//                                     ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       });
// }
}
