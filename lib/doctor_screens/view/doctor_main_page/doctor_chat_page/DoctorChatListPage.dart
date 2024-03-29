import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/mycolor/mycolor.dart';

import '../../../../Helper/RoutHelper/RoutHelper.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/Shimmer/ChatShimmer.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../../patient_screens/controller/patinet_chat_controller/PatinetChatController.dart';
import '../../../model/DoctorChatListModel.dart';

class DoctorChatListScreen extends StatefulWidget {
  const DoctorChatListScreen({Key? key}) : super(key: key);

  @override
  State<DoctorChatListScreen> createState() => _DoctorChatListScreenState();
}

class _DoctorChatListScreenState extends State<DoctorChatListScreen> {
  CustomView custom = CustomView();
  TextEditingController searchCtr = TextEditingController();
  ChatController chatController = ChatController();
  LocalString text = LocalString();

  var userIDs = [];
  var selectedItem = [];
  bool isMultiSelectionEnabled = false;

  /*-----SEARCH CHAT LIST-------------*/
  String _keyword = '';
  List<DoctorChatModel> _getFilteredList() {
    if (_keyword.isEmpty) {
      return chatController.doctorMsgList;
    }
    return chatController.doctorMsgList
        .where((user) =>
            user.name.toLowerCase().contains(_keyword.toLowerCase()) ||
            user.surname.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    chatController.doctorMsgListFetch(context);
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    final list = _getFilteredList();
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     /* floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: isMultiSelectionEnabled == true
            ? custom.MyButton(context, "Delete chat", () {
                // deletePopUp(context);
              }, MyColor.primary, const TextStyle(color: MyColor.white))
            : null,
      ),*/
      appBar: AppBar(
        bottom: PreferredSize(child: Divider(color: Colors.grey),preferredSize:  Size.fromHeight(1)),
        leading: isMultiSelectionEnabled
            ? IconButton(
            onPressed: () {
              selectedItem.clear();
              isMultiSelectionEnabled = false;
              setState(() {});
            },
            icon: const Icon(Icons.close,color: Colors.black,))
            : null,
        backgroundColor: Colors.white24,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true == isMultiSelectionEnabled ? false : true,
        title: Text(isMultiSelectionEnabled
            ? getSelectedItemCount()
            : text.chat.tr,style: const TextStyle(color: Colors.black,fontFamily: "Poppins",fontSize: 17,fontWeight: FontWeight.w400),),
        actions: [
          Visibility(
              visible: selectedItem.isNotEmpty,
              child: IconButton(
                icon: const Icon(Icons.delete,color: Colors.black,),
                onPressed: () {
                  deletePopUp(context);
                  setState(() {});
                },
              )),


        ],
      ),
      body: Obx(() {
        if (chatController.loadingFetchListD.value) {
          return loadingShimmer();
        }
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    decoration:  InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: MyColor.white,
                      contentPadding: const EdgeInsets.only(top: 3, left: 20),
                      hintText: text.searchBetweenYourChats.tr,
                      hintStyle:
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
                const SizedBox(
                  height: 10.0,
                ),
              chatController.doctorMsgList.isEmpty?
             Center(heightFactor: 13.0,child:  custom.text(
              text.youDonHaveAnyChat.tr,
                14,
                FontWeight.normal,
                MyColor.black),):Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                          borderOnForeground: false,
                          elevation: 2,
                          margin: const EdgeInsets.only(
                              left: 3, right: 3, top: 3, bottom: 3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 4, right: 4, top: 4, bottom: 4),
                            child: InkWell(
                                onTap: () {
                                  var patientId = {
                                    "ID": list[index].userId,
                                    "name":  list[index].name,
                                    "surname":list[index].surname,
                                    "username":list[index].username,
                                    "pic":list[index].userProfile,
                                    "address":list[index].address,
                                    // "contact":list[index].
                                  };
                                  Get.toNamed(RouteHelper.DChatScreen(),
                                      arguments: patientId);
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
                                          custom.text(list[index].time, 11,
                                              FontWeight.normal, MyColor.grey)
                                        ],
                                      ),
                                      Visibility(
                                        visible: isMultiSelectionEnabled,
                                        child: CheckboxListTile(
                                          checkColor: Colors.white,
                                          activeColor: MyColor.primary1,
                                          dense: true,
                                          value: selectedItem.contains(index),
                                          onChanged: (vale) {
                                            setState(() {
                                              if (selectedItem.contains(index)) {
                                                selectedItem.remove(index);
                                                userIDs.remove(list[index].userId);
                                                // unselect
                                              } else {
                                                selectedItem.add(index);// select
                                                userIDs.add(list[index].userId);
                                              }
                                            });
                                            print(selectedItem);
                                            print(userIDs);
                                          },
                                          controlAffinity: ListTileControlAffinity.trailing,
                                        ),)
                                    ])),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }


  String getSelectedItemCount() {
    return selectedItem.isNotEmpty
        ? text.deleteChat.tr
        :text.noSelected.tr;
  }
  void doMultiSelection(DoctorChatModel nature) {
    if (isMultiSelectionEnabled) {
      if (selectedItem.contains(nature.userId)) {
        selectedItem.remove(nature.userId);
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
                                    chatController.drUserMsgListDelete(context, userIDs.join(","),() {
                                      setState(() {});
                                      isMultiSelectionEnabled = false;
                                      Get.back();
                                      chatController.doctorMsgListFetch(context);
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
