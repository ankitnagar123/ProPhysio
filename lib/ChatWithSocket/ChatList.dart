import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophysio/helper/mycolor/mycolor.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {

  TextEditingController searchCtr = TextEditingController();


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15  ,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 35,
                    width: 40,
                    decoration: BoxDecoration(
                      color: MyColor.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back,
                        color:  MyColor.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Chat",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall
                      ?.merge(TextStyle(color:  MyColor.primary)),
                ),
                SizedBox(width: 50,),
                Flexible(
                  child: Container(
                    height: 40,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color:  MyColor.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        style: TextStyle(
                          color: MyColor.primary,
                          decoration: TextDecoration.none,
                          decorationThickness: 0,
                        ),
                        controller: searchCtr,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Search",
                          suffixIcon: Icon(Icons.search),
                          hintStyle: TextStyle(
                              color: MyColor.secondary, fontSize: 12),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),)
              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                height: Get.height / 1.3,
                width: Get.width,
                decoration: BoxDecoration(
                  color: MyColor.white,
                  borderRadius: BorderRadius.circular(10),),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10),
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                           /* Get.toNamed(RouteHelper.getChatScreen(),
                                arguments: {
                                  "type" : "chat"
                                });*/
                          },
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.asset("assets/images/sp3.jpg", height: 40,
                                width: 40,
                                fit: BoxFit.fill,),
                            ),
                            title:  Text("Name", style: TextStyle(
                                fontSize: 12,
                                color: MyColor.primary
                            ),),
                            subtitle:  Text("Online", style: TextStyle(
                                fontSize: 12,
                                color: MyColor.primary
                            ),),
                          ),
                        );
                      },)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
