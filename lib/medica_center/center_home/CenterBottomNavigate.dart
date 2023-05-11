import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medica/helper/CustomView/CustomView.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:medica/patient_screens/view/patient_main_screen/more_page/MorePage.dart';
import 'package:get/get.dart';
import 'package:medica/patient_screens/view/patient_main_screen/patient_home_page/DoctorListSearch.dart';
import 'package:medica/patient_screens/view/patient_main_screen/patient_home_page/category_sub-category/DoctorListwithCategoy.dart';
import 'package:medica/patient_screens/view/patient_main_screen/patient_home_page/category_sub-category/PDoctorAllCat.dart';
import 'package:medica/patient_screens/view/patient_main_screen/patient_home_page/category_sub-category/PDoctorSubCat.dart';
import 'package:medica/patient_screens/view/patient_main_screen/patient_home_page/HomePage/PatientHomePageTab.dart';
import '../../../doctor_screens/controller/RoutCtr.dart';
import '../center_more/CenterMorePage.dart';
import 'CenterHomePage.dart';

class CenterMainScreen extends StatefulWidget {
  const CenterMainScreen({Key? key}) : super(key: key);

  @override
  State<CenterMainScreen> createState() => _CenterMainScreenState();
}

class _CenterMainScreenState extends State<CenterMainScreen> {

  MyRoute myRoute = Get.put(MyRoute());
  CustomView view = CustomView();
  @override
  int _selectedIndex = 0;
  List screens =  [
     CenterHomeScreen(),
    CenterMorePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                  title:  const Text("Exit App",style: TextStyle(fontFamily: 'Poppins',fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.w600),),
                  content:  const Text("Do you want to exit an app?",style: TextStyle(fontFamily: "Poppins",fontSize: 13.0,fontWeight: FontWeight.w500,color: Colors.black),),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pop(false);
                    },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.white)
                      ), child:  const Text("No",style: TextStyle(color: Colors.black,fontFamily: 'Poppins'),),
                    ),
                    ElevatedButton(onPressed: (){
                      SystemNavigator.pop();
                    },
                      style:  const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(MyColor.primary1)
                      ), child:  const Text("Yes",style: TextStyle(fontFamily: 'Poppins',color: Colors.white),),
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
        child: Scaffold(
          bottomNavigationBar: myBottomNavigationBar(),
          backgroundColor: Colors.white,
          body:screens[myRoute.pageIndex.value],
        ),
      );
    });
  }
  Widget myBottomNavigationBar(){
    return Container(
      height:MediaQuery.of(context).size.width/7.4,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,
                        width: 30,
                        child:myRoute.pageIndex.value ==0||myRoute.pageIndex.value ==4?
                        Image.asset("assets/images/DrIcon.png",height: 20,width: 20,color: MyColor.primary,) :Image.asset("assets/images/DrIcon.png",height: 20,width: 20,color: MyColor.grey,)),
                    view.text("Wards", 12, FontWeight.normal,
                      myRoute.pageIndex.value ==0||myRoute.pageIndex.value ==2?
                      MyColor.primary:MyColor.grey,)

                  ],
                )),

            InkWell(
                onTap: (){
                  setState(() {
                    myRoute.pageIndex.value = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,
                        width: 30,
                        child:myRoute.pageIndex.value ==1?  Image.asset("assets/images/moreIcon.png",height: 20,width: 20,color: MyColor.primary,):Image.asset("assets/images/BookingIcon.png",height: 20,width: 20,color:MyColor.grey,)),
                    view.text("More", 12, FontWeight.normal, myRoute.pageIndex.value ==1?MyColor.primary:MyColor.grey,)

                  ],
                )),
          ],
        ),
      ),
    );
  }
}
/* BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded),
                    label: 'Doctors',
                    tooltip: 'Doctors'),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage("assets/images/dIcon.png"), size: 20.0),
                  label: 'Booking',
                  tooltip: 'Booking',
                ),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage("assets/images/ChatIcon.png"), size: 20.0),
                    label: 'Chat',
                    tooltip: 'Chat'),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage("assets/images/moreIcon.png"), size: 20),
                    label: 'More', tooltip: 'More'),
              ],
              type: BottomNavigationBarType.shifting,
              currentIndex: myRoute.pageIndex.value,
              selectedItemColor: MyColor.iconColor,
              unselectedItemColor: MyColor.black,
              selectedFontSize: 12,
              selectedLabelStyle: const TextStyle(fontSize: 12),
              showUnselectedLabels: true,
              unselectedLabelStyle: const TextStyle(color: Colors.black38),
              iconSize: 25,
              onTap: _onItemTapped,
              elevation: 5),*/