import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophysio/doctor_screens/controller/TaskManageCtr/TaskManagementCtr.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../../helper/mycolor/mycolor.dart';
import '../../../../../language_translator/LanguageTranslate.dart';
import '../../../../controller/LeadSheetControler/LeadSheetCtr.dart';
import '../../../../model/LeadSheetListModel.dart';
import '../../../../model/TaskManageModel.dart';
import '../../doctor_more_page/DoctorMainPage.dart';

class LeadSheet extends StatefulWidget {
  const LeadSheet({super.key});

  @override
  State<LeadSheet> createState() => _LeadSheetState();
}

class _LeadSheetState extends State<LeadSheet> {
  CustomView custom = CustomView();
  TextEditingController searchCtr = TextEditingController();
  LeadSheetCtr leadManageCtr = Get.put(LeadSheetCtr());
  LocalString text = LocalString();

/*------VARIABLES------*/
  String? cancelId = '';
  String? cancelReason = '';
  String _keyword = '';
  int selectedCard = -1;

  /*----For SEARCH BOOKING LIST-------*/
  List<LeadSheetModel> _getFilteredList() {
    if (_keyword.isEmpty) {
      return leadManageCtr.leadList;
    }
    return leadManageCtr.leadList
        .where(
            (user) => user.name.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    leadManageCtr.leadManageList(context, "");
  }

  @override
  Widget build(BuildContext context) {
    var listData = _getFilteredList();
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white24,
        title: custom.text("Lead Sheet", 15, FontWeight.w500, Colors.black),
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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: MyColor.white,
                    suffixIconColor: MyColor.white,
                    contentPadding: EdgeInsets.only(top: 3, left: 20),
                    hintText: "Search Lead name",
                    hintStyle: TextStyle(fontSize: 12, color: MyColor.white),
                    labelStyle: TextStyle(fontSize: 12, color: MyColor.white),
                    fillColor: MyColor.lightcolor,
                    filled: true,
                    border: OutlineInputBorder(
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
                    text.pending.tr,
                    () {
                      setState(() {
                        selectedCard = 0;
                      });
                      leadManageCtr.leadManageList(
                        context,
                        "Pending",
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
                    text.confirm.tr,
                    () {
                      setState(() {
                        selectedCard = 1;
                      });
                      leadManageCtr.leadManageList(
                        context,
                        "Confirmed",
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
                      leadManageCtr.leadManageList(
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
                      leadManageCtr.leadManageList(context, "Cancel");
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
    );
  }

  /*------------Booking All List--------------*/
  Widget showList() {
    var listData = _getFilteredList();
    return Obx(() {
      if (leadManageCtr.loadingleadList.value) {
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
              var task = list.task;
              var name = list.task;
              var taskDisc = list.notes;
              var date = list.createdAt;
              var status = list.status;
              var taskId = list.leadId;
              var source = list.source;
              var contact = list.contact;
              var email = list.email;
              var note = list.notes;

              return InkWell(
                onTap: () {
                  showBottomSheets(status,name, task, taskDisc, date, email, taskId,
                      contact, source,note);
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
                                    "Lead Name",
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: "Poppins"),
                                  ),
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  custom.text(list.name.toString(), 13.0,
                                      FontWeight.w500, Colors.black),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),

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
                                  Text(list.createdAt.toString(),
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
                                  const Text(
                                    "Source",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.0,
                                        fontFamily: "Poppins"),
                                  ),
                                  const SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                    list.source.toString(),
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
  showBottomSheets(String status,String name, String task, String taskDisc, String date,
      String email, String taskId, String contact, String source,String note ) {
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
                              "Lead Name",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(name,
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
                              "Source",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(source,
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(email,
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
                              "Contact",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(contact,
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(date,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.0,
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Notes",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.0,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(note,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.0,
                                    fontFamily: "Poppins")),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  status == "Pending"
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              leadManageCtr.loadingstatusReject.value
                                  ? custom.MyIndicator()
                                  : custom.acceptRejectButton(
                                      context, text.cancel.tr, () {
                                      leadManageCtr.leadStatusChange(
                                          context, taskId, "Cancel", () {
                                        setState(() {
                                          selectedCard = 3;
                                        });
                                        leadManageCtr.leadManageList(
                                          context,
                                          "Cancel",
                                        );
                                        Get.back();
                                      });
                                    }, MyColor.midgray,
                                      const TextStyle(color: MyColor.red)),
                              leadManageCtr.loadingstatusAccept.value
                                  ? custom.MyIndicator()
                                  : custom.acceptRejectButton(
                                      context, text.accept.tr, () {
                                      leadManageCtr.leadStatusChange(
                                          context, taskId, "Confirmed", () {
                                        setState(() {
                                          selectedCard = 1;
                                        });
                                        leadManageCtr.leadManageList(
                                          context,
                                          "Confirmed",
                                        );
                                        Get.back();
                                      });
                                    }, MyColor.primary,
                                      const TextStyle(color: MyColor.white))
                            ],
                          ),
                        )
                      : status == "Confirmed"
                          ? leadManageCtr.loadingstatusAccept.value
                              ? custom.MyIndicator()
                              : custom.callButton(context, text.Complete.tr,
                                  () {
                                  leadManageCtr.leadStatusChange(
                                      context, taskId, "Complete", () {
                                    setState(() {
                                      selectedCard = 2;
                                    });
                                    leadManageCtr.leadManageList(
                                      context,
                                      "Complete",
                                    );
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
                          : leadManageCtr.loadingstatusAccept.value
                              ? custom.MyIndicator()
                              : const Text("")
                ],
              ),
            ),
          );
        });
  }
}

