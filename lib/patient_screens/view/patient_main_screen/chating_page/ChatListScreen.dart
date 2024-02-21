import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../controller/doctor_list_ctr/DoctorListController.dart';
import '../../../controller/patinet_chat_controller/PatinetChatController.dart';
import "../../../model/Chat Model's/PatinetChatListModel.dart";

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  CustomView custom = CustomView();
  LocalString text = LocalString();

  TextEditingController searchCtr = TextEditingController();
  ChatController chatController = Get.put(ChatController());
  DoctorListCtr doctorListCtr = Get.put(DoctorListCtr());

  // bool isMultiSelectionEnabled = false;
  // HashSet<PatinetChatModel> selectedItem = HashSet();
  var DoctorIDs = [];
  var selectedItem = [];

  bool isMultiSelectionEnabled = false;

  /*-----SEARCH CHAT LIST--------z---*/
  String _keyword = '';
  List<PatinetChatModel> _getFilteredList() {
    if (_keyword.isEmpty) {
      return chatController.msgList;
    }
    return  chatController.msgList
        .where(
            (user) => user.name.toLowerCase().contains(_keyword.toLowerCase())||user.surname.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.msgListFetch(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final list = _getFilteredList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        bottom: PreferredSize(child: Divider(color: Colors.grey),preferredSize:  Size.fromHeight(1)),

        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: isMultiSelectionEnabled ? false : true,
        leading: isMultiSelectionEnabled
            ? IconButton(
            onPressed: () {
              selectedItem.clear();
              isMultiSelectionEnabled = false;
              setState(() {});
            },
            icon: const Icon(Icons.close,color: Colors.black,))
            : null,
        title: Text(isMultiSelectionEnabled
            ? getSelectedItemCount()
            : text.chat.tr,style: const TextStyle(color: Colors.black,fontFamily: 'Poppins',fontSize: 17,fontWeight: FontWeight.w400)),
        actions: [
          Visibility(
              visible: selectedItem.isNotEmpty,
              child: IconButton(
                icon: const Icon(Icons.delete,color:MyColor.primary1,),
                onPressed: () {
                 /* selectedItem.forEach((nature) {
                    // list.remove(nature);
                    list.map((e) => (e) {
                      list[e].doctorId;
                      print(list[e].doctorId);
                      chatController.msgListDelete(context,  list[e].doctorId);
                    });
                  });
                  selectedItem.clear();*/
                  deletePopUp(context);
                  setState(() {});
                },
              )),

          /*Visibility(
              visible: isMultiSelectionEnabled,
              child: IconButton(
                icon: Icon(
                  Icons.select_all,
                  color: selectedItem.length == natureList.length
                      ? Colors.black
                      : Colors.white,
                ),
                onPressed: () {
                  if (selectedItem.length == natureList.length) {
                    selectedItem.clear();
                  } else {
                    for (int index = 0; index < natureList.length; index++) {
                      selectedItem.add(natureList[index]);
                    }
                  }
                  setState(() {});
                },
              )),*/
        ],
      ),
      body: Obx(() {
        if (chatController.loadingFetchList.value) {
          return loadingShimmer();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const SizedBox(height: 5.0,),
              SizedBox(
                width: widht,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _keyword = value;
                    });
                    log(value);
                  },
                  cursorWidth: 0.0,
                  cursorHeight: 0.0,
                  onTap: () {},
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  controller: searchCtr,
                  decoration:  InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: MyColor.white,
                    contentPadding: const EdgeInsets.only(top: 3, left: 20),
                    hintText: text.searchBetweenYourChats.tr,
                    hintStyle:
                    TextStyle(fontSize: 12, color: MyColor.white),
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
                height: 10.0,
              ),
           list.isEmpty?  Padding(
             padding: const EdgeInsets.all(8.0),
             child: custom.text(
                 text.youDonHaveAnyChat.tr,
                 14,
                 FontWeight.normal,
                 MyColor.black),
           ):  Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                     /* onTap: () {
                        var doctorId = list[index].doctorId;
                        doctorListCtr.doctorDetialsfetch(doctorId.toString());
                        var data ={
                          "doctorId":doctorId
                        };
                        Get.toNamed(RouteHelper.getChatScreen(),arguments:data);
                      },*/
                      child: Card(
                          borderOnForeground: false,
                          elevation: 2,
                          margin: const EdgeInsets.only(
                              left: 3, right: 3, top: 3, bottom: 3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 4, right: 4, top: 4, bottom: 4),
                            // height: 80.0,
                            child: InkWell(
                                onTap: () {
                                 /* isMultiSelectionEnabled = true;
                                   doMultiSelection(list[index]);*/
                                   var doctorId = list[index].doctorId;
                                   var data ={
                                     "doctorId":doctorId,
                                     "drName":list[index].name,
                                     "drSurname":list[index].surname,
                                     "doctorImg": list[index].userProfile,
                                     "drAddress":list[index].address,
                                   };
                                   log("$data");
                                    Get.toNamed(RouteHelper.getChatScreen(),parameters:data);


                                   // doMultiSelection(chatController);
                                  // // doMultiSelection(list[index]);
                                  // var doctorId = list[index].doctorId;
                                  // var data ={
                                  //   "doctorId":doctorId
                                  // };
                                  // print(data);
                                  // // Get.toNamed(RouteHelper.getChatScreen(),arguments:data);
                                  // // doMultiSelection(chatController);
                                },
                                onLongPress: () {
                                  isMultiSelectionEnabled = true;
                                  doMultiSelection(list[index]);
                                },
                                child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: FadeInImage.assetNetwork(
                                              imageErrorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Image(
                                                      image: AssetImage(
                                                          "assets/images/dummyprofile.png"),
                                                      height: 60.0,
                                                      width: 60.0),
                                              width: 60.0,
                                              height: 60.0,
                                              fit: BoxFit.cover,
                                              placeholder:
                                                  "assets/images/loading.gif",
                                              image: list[index].userProfile,
                                              placeholderFit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                custom.text(
                                                    "${list[index].name} ${list[index].surname}",
                                                    14,
                                                    FontWeight.normal,
                                                    MyColor.black)
                                              ],
                                            ),
                                          ),
                                          custom.text(
                                              list[index].time,
                                              11,
                                              FontWeight.normal,
                                              MyColor.grey)
                                        ],
                                      ),
                                      Visibility(
                                          visible: isMultiSelectionEnabled,
                                          child: CheckboxListTile(
                                            activeColor: MyColor.primary1,
                                            checkColor: Colors.white,
                                            dense: true,
                                            value: selectedItem.contains(index),
                                            onChanged: (vale) {
                                              setState(() {
                                                if (selectedItem.contains(index)) {
                                                  selectedItem.remove(index);
                                                  DoctorIDs.remove(list[index].doctorId);
                                                  // unselect
                                                } else {
                                                  selectedItem.add(index);// select
                                                  DoctorIDs.add(list[index].doctorId);
                                                }
                                              });
                                              print(selectedItem);
                                              print(DoctorIDs);
                                            },
                                            controlAffinity: ListTileControlAffinity.trailing,
                                          ),)
                                    ])),
                          )),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }


  String getSelectedItemCount() {
    return selectedItem.isNotEmpty
        ?text.deleteChat.tr
        : text.noSelected.tr;
  }

  void doMultiSelection(PatinetChatModel nature) {
    if (isMultiSelectionEnabled) {
      if (selectedItem.contains(nature.doctorId)) {
        selectedItem.remove(nature.doctorId);
      } else {
        selectedItem.add(nature);
      }
      setState(() {});
    } else {
      //Other logic
    }
  }
  void deletePopUp(BuildContext context,) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        pageBuilder: (context, anim1, anim2) {
          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: custom.text(text.deleteChat.tr, 17,
                                FontWeight.w500, Colors.black),
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: custom.text(text.areYouSureYouWantDeleteChat.tr, 13,
                                FontWeight.w400, Colors.black),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: custom.text(text.Dismiss.tr, 14.0,
                                        FontWeight.w500, MyColor.grey),
                                  )),
                              Expanded(
                                child: custom.mysButton(
                                  context,
                                  text.deleteChat.tr,
                                  () {
                                   /* for (var nature in selectedItem) {
                                      // natureList.remove(nature);
                                    }
                                    selectedItem.clear();
                                    setState(() {
                                      isMultiSelectionEnabled == false;
                                    });*/
                                    chatController.msgListDelete(context, DoctorIDs.join(","),() {
                                      setState(() {});
                                      isMultiSelectionEnabled = false;
                                      Get.back();
                                      chatController.msgListFetch(context);
                                    },);
                                    isMultiSelectionEnabled = false;
                                  },
                                  Colors.red,
                                  const TextStyle(
                                    color: MyColor.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
