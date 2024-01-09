import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophysio/doctor_screens/controller/TaskManageCtr/TaskManagementCtr.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/DocotorBookingController.dart';
import '../../../../model/TaskManageModel.dart';
import '../../../../model/booking_list_model.dart';
import '../../doctor_more_page/DoctorMainPage.dart';

class DoctorTask extends StatefulWidget {
  const DoctorTask({Key? key}) : super(key: key);

  @override
  State<DoctorTask> createState() => _DoctorTaskState();
}

class _DoctorTaskState extends State<DoctorTask> {
  CustomView custom = CustomView();
  TextEditingController searchCtr = TextEditingController();
  TaskManageCtr taskManageCtr = Get.put(TaskManageCtr());
  LocalString text = LocalString();

/*------VARIABLES------*/
  String? cancelId = '';
  String? cancelReason = '';
  String _keyword = '';
  int selectedCard = -1;

  /*----For SEARCH BOOKING LIST-------*/
  List<TaskManageListModel> _getFilteredList() {
    if (_keyword.isEmpty) {
      return taskManageCtr.taskList;
    }
    return taskManageCtr.taskList
        .where((user) =>
            user.taskName.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    taskManageCtr.taskManageList(
      context,
      "",
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listData = _getFilteredList();
    final widht = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DoctorMainScreen()));
        await taskManageCtr.taskManageList(
          context,
          "",
        );
        return true;
        /*Pending*/
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios_new)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white24,
          title: custom.text(text.MYTASK.tr, 15, FontWeight.w500, Colors.black),
        ),
        body: SingleChildScrollView(
          // padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: SizedBox(
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
                      prefixIconColor: MyColor.white,
                      suffixIconColor: MyColor.white,
                      contentPadding: const EdgeInsets.only(top: 3, left: 20),
                      hintText: text.TASKSEARCH.tr,
                      hintStyle:
                          const TextStyle(fontSize: 12, color: MyColor.white),
                      labelStyle:
                          const TextStyle(fontSize: 12, color: MyColor.white),
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
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: custom.mysButton(
                      context,
                      text.upcoming.tr,
                      () {
                        setState(() {
                          selectedCard = 0;
                        });
                        taskManageCtr.taskManageList(
                          context,
                          "Confirmed",
                        );
                      },
                      selectedCard == 0 ? MyColor.primary : MyColor.white,
                      TextStyle(
                          fontSize: 11,
                          fontFamily: "Poppins",
                          color: selectedCard == 0
                              ? MyColor.white
                              : MyColor.primary1),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: custom.mysButton(
                      context,
                      text.pending.tr,
                      () {
                        setState(() {
                          selectedCard = 1;
                        });
                        taskManageCtr.taskManageList(
                          context,
                          "Pending",
                        );
                      },
                      selectedCard == 1 ? MyColor.primary : MyColor.white,
                      TextStyle(
                          fontSize: 11,
                          fontFamily: "Poppins",
                          color: selectedCard == 1
                              ? MyColor.white
                              : MyColor.primary1),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: custom.mysButton(
                      context,
                      text.Complete.tr,
                      () {
                        setState(() {
                          selectedCard = 2;
                        });
                        taskManageCtr.taskManageList(
                          context,
                          "Complete",
                        );
                      },
                      selectedCard == 2 ? MyColor.primary : MyColor.white,
                      TextStyle(
                          fontSize: 11,
                          fontFamily: "Poppins",
                          color: selectedCard == 2
                              ? MyColor.white
                              : MyColor.primary1),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: custom.mysButton(
                      context,
                      text.cancel.tr,
                      () {
                        setState(() {
                          selectedCard = 3;
                        });
                        taskManageCtr.taskManageList(context, "Cancel");
                      },
                      selectedCard == 3 ? MyColor.primary : MyColor.white,
                      TextStyle(
                          fontSize: 11,
                          fontFamily: "Poppins",
                          color: selectedCard == 3
                              ? MyColor.white
                              : MyColor.primary1),
                    ),
                  ),
                ],
              ),
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
      ),
    );
  }

  /*------------Booking All List--------------*/
  Widget showList() {
    var listData = _getFilteredList();
    return Obx(() {
      if (taskManageCtr.loadingTaskList.value) {
        return Center(
          heightFactor: 10,
          child: custom.MyIndicator(),
        );
      } else if (listData.isEmpty) {
        return Center(heightFactor: 5.0, child: Text(text.NoTask.tr));
      }
      return SingleChildScrollView(
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: listData.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var list = listData[index];
              var task = list.taskName;
              var taskDisc = list.taskDescription;
              var date = list.date;
              var time = list.time;
              var status = list.status;
              var taskId = list.allotId;

              return InkWell(
                onTap: () {
                  showBottomSheets(status, task, taskDisc, date, time, taskId);
                },
                child: Card(
                  elevation: 1.5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5.0),
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
                                  Text(
                                    text.MYTASK.tr,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: "Poppins"),
                                  ),
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  custom.text(list.taskName.toString(), 13.0,
                                      FontWeight.w500, Colors.black),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        /* custom.text(
                            taskManageCtr.taskList[index].taskDescription.toString(),
                            10.0,
                            FontWeight.normal,
                            Colors.black87),
                        const SizedBox(
                          height: 10.0,
                        ),*/
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    text.date.tr,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: "Poppins"),
                                  ),
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(list.date.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11.0,
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
                                    text.Time.tr,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: "Poppins"),
                                  ),
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                    list.allotId.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 11.0,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                height: 25.0,
                                width: 75,
                                decoration: BoxDecoration(
                                  color: list.status == "Pending"
                                      ? MyColor.statusYellow
                                      : list.status == "Cancel"
                                          ? Colors.red
                                          : list.status == "Complete"
                                              ? MyColor.primary1
                                              : Colors.green,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: custom.text(
                                      list.status == "Pending"
                                          ? text.Pending.tr
                                          : list.status == "Cancel"
                                              ? text.Cancel.tr
                                              : list.status == "Complete"
                                                  ? text.Complete.tr
                                                  : text.Upcoming.tr,
                                      11.0,
                                      FontWeight.w400,
                                      Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
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
  showBottomSheets(String status, String task, String taskDisc, String date,
      String time, String taskId) {
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
            child: Obx(
              () => Column(
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
                            Text(
                              text.MYTASK.tr,
                              style: const TextStyle(
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
                            Text(
                              text.TaskDisc.tr,
                              style: const TextStyle(
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
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              text.taskInformation.tr,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text("${date}   ${time}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: "Poppins")),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  status == "Pending"
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              taskManageCtr.loadingstatusReject.value
                                  ? custom.MyIndicator()
                                  : custom.acceptRejectButton(
                                      context, text.reject.tr, () {
                                      taskManageCtr.taskStatusChange(
                                          context, taskId, "Cancel", () {
                                        Get.back();
                                      });
                                    }, MyColor.midgray,
                                      const TextStyle(color: MyColor.primary)),
                              taskManageCtr.loadingstatusAccept.value
                                  ? custom.MyIndicator()
                                  : custom.acceptRejectButton(
                                      context, text.accept.tr, () {
                                      taskManageCtr.taskStatusChange(
                                          context, taskId, "Complete", () {
                                        Get.back();
                                      });
                                    }, MyColor.primary,
                                      const TextStyle(color: MyColor.white))
                            ],
                          ),
                        )
                      : status == "Confirmed"
                          ? taskManageCtr.loadingstatusAccept.value
                              ? custom.MyIndicator()
                              : custom.callButton(context, text.Complete.tr,
                                  () {
                                  taskManageCtr.taskStatusChange(
                                      context, taskId, "Confirmed", () {
                                    Get.back();
                                  });
                                },
                                  MyColor.primary,
                                  const TextStyle(
                                    color: MyColor.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  Icons.done)
                          : Text("")
                ],
              ),
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
