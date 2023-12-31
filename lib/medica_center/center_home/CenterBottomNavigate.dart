import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../doctor_screens/controller/RoutCtr.dart';
import '../../helper/CustomView/CustomView.dart';
import '../../helper/mycolor/mycolor.dart';
import '../../language_translator/LanguageTranslate.dart';
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
  LocalString text = LocalString();
  @override
  List screens =  [
     const CenterHomeScreen(),
    const CenterMorePage(),
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
                    view.text(text.Ward.tr, 12, FontWeight.normal,
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
                        child:myRoute.pageIndex.value ==1?  Image.asset("assets/images/moreIcon.png",height: 20,width: 20,color: MyColor.primary,):Image.asset("assets/images/moreIcon.png",height: 20,width: 20,color:MyColor.grey,)),
                    view.text(text.More.tr, 12, FontWeight.normal, myRoute.pageIndex.value ==1?MyColor.primary:MyColor.grey,)

                  ],
                )),
          ],
        ),
      ),
    );
  }
}