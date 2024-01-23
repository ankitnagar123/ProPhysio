
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import '../../../../patient_screens/controller/Navigator/RouterCtr.dart';
import '../doctor_booking_page/DoctorBookingScreen.dart';
import '../doctor_chat_page/DoctorChatListPage.dart';
import '../doctor_home_page/DoctorHomeScreen.dart';
import 'DoctorMorePage.dart';

class DoctorMainScreen extends StatefulWidget {
  const DoctorMainScreen({Key? key}) : super(key: key);

  @override
  State<DoctorMainScreen> createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  CustomView custom = CustomView();
  LocalString text = LocalString();
  MyRoute myRoute = Get.put(MyRoute());
  CustomView view = CustomView();

  List screens = [
    const DoctorHomeScreen(),
    const DoctorBookingScreen(),
    const DoctorChatListScreen(),
    const DoctorMorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return WillPopScope(
        onWillPop: () async{
          if(myRoute.pageIndex == 0){
            final value =await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title:   Text(text.Exit_App.tr,style: const TextStyle(fontFamily: 'Poppins',fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.w600),),
                  content:   Text(text.Want_To_Exist.tr,style: const TextStyle(fontFamily: "Poppins",fontSize: 13.0,fontWeight: FontWeight.w500,color: Colors.black),),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pop(false);
                    },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.white)
                      ), child:   Text(text.No.tr,style: const TextStyle(color: Colors.black,fontFamily: 'Poppins'),),
                    ),
                    ElevatedButton(onPressed: (){
                      SystemNavigator.pop();
                    },
                      style:  const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(MyColor.primary1)
                      ), child:   Text(text.Yes.tr,style: const TextStyle(fontFamily: 'Poppins',color: Colors.white),),
                    ),
                  ],
                );
              },);
            if(value!=null){
              return Future.value(value);
            } else{
              return Future.value(false);
            }
          }else {
            if(myRoute.pageIndex.value ==2){
              myRoute.setValue(0);
            }
            else{
              myRoute.setValue(0);
            }
          }
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            bottomNavigationBar: myBottomNavigationBar(),
            backgroundColor: Colors.white,
            body:screens[myRoute.pageIndex.value],
          ),
        ),
      );
    });
  }
  Widget myBottomNavigationBar(){
    return Container(
      height:MediaQuery.of(context).size.width/7.2,
      decoration:  BoxDecoration(
        border:  Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
        color: Colors.white24,
      ),
      child: IconTheme(
        data: const IconThemeData(color: MyColor.primary1, size: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
                onTap: (){
                  setState(() {
                    myRoute.pageIndex.value = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 20,
                        width: 30,
                        child:myRoute.pageIndex.value ==0||myRoute.pageIndex.value ==4?
                        Icon(Icons.home_outlined,color: MyColor.red,size: 27,) :Icon(Icons.home_outlined,color: MyColor.grey,)
                    ),
                    view.text(text.Home.tr, 12, FontWeight.normal,
                      myRoute.pageIndex.value ==0||myRoute.pageIndex.value ==4?
                      MyColor.red:MyColor.grey,)

                  ],
                )),

            InkWell(
                onTap: (){
                  setState(() {
                    myRoute.pageIndex.value = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 20,
                        width: 30,
                        child:myRoute.pageIndex.value ==1?
                        Icon(Icons.book_outlined,color: MyColor.red,size: 27,) :Icon(Icons.book_outlined,color: MyColor.grey,)

                    ),
                    view.text(text.Booking.tr, 12, FontWeight.normal, myRoute.pageIndex.value ==1?MyColor.red:MyColor.grey,)

                  ],
                )),
            InkWell(
                onTap: (){
                  setState(() {
                    myRoute.pageIndex.value = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 20,
                        width: 30,
                        child:myRoute.pageIndex.value ==2?
                        Icon(Icons.chat_rounded,color: MyColor.red,size: 27,) :Icon(Icons.chat_rounded,color: MyColor.grey,)
                    ),
                    view.text(text.chat.tr, 12, FontWeight.normal, myRoute.pageIndex.value ==2? MyColor.red:MyColor.grey,)

                  ],
                )),

            InkWell(
                onTap: (){
                  setState(() {
                    myRoute.pageIndex.value = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 20,
                        width: 30,
                        child:myRoute.pageIndex.value ==3?
                        Icon(Icons.list_outlined,color: MyColor.red,size: 27,) :Icon(Icons.list_outlined,color: MyColor.grey,)
                    ),
                    view.text(text.More.tr, 12, FontWeight.normal, myRoute.pageIndex.value ==3? MyColor.red: MyColor.grey,)

                  ],
                )),
          ],
        ),
      ),
    );
  }
}

/*    return Obx(() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/dhomeIcon.png"),
                      size: 20.0),
                  label: text.Home.tr,
                  tooltip: text.Home.tr),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/dIcon.png"),
                    size: 20.0),
                label: text.Booking.tr,
                tooltip: text.Booking.tr,
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/map.png"),
                      size: 20.0),
                  label: text.chat.tr,
                  tooltip: text.chat.tr),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/moreIcon.png"),
                      size: 20),
                  label: text.More.tr,
                  tooltip: text.More.tr),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: MyColor.iconColor,
            unselectedItemColor: MyColor.black,
            selectedFontSize: 12,
            selectedLabelStyle: const TextStyle(fontSize: 12),
            showUnselectedLabels: true,
            unselectedLabelStyle: const TextStyle(color: Colors.black38),
            iconSize: 25,
            onTap: _onItemTapped,
            elevation: 5),
        body: screens.elementAt(_selectedIndex),
      );
    });
*/