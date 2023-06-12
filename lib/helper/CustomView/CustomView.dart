import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../mycolor/mycolor.dart';



class CustomView {
//************AppBar**********//
  MyAppBar(BuildContext context, String text) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: MyColor.primary.withOpacity(0.60)),
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios)),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              MyColor.primary,
              MyColor.secondary,
            ])),
      ),
      elevation: 0,
      backgroundColor: MyColor.primary,
      title: Text(
        text,
        style: const TextStyle(letterSpacing: 0.5, fontFamily: "Heebo", fontSize: 18),
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
    );
  }

//**********TEXT**********//
  Widget text(String text, double size, FontWeight fontWeight, Color color) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: "Poppins",
          fontWeight: fontWeight),
    );
  }

//********Custom Button********//

  MyButton(BuildContext context, String text, VoidCallback callback,
      Color color, TextStyle style) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: callback,
      child: Container(
        // margin: EdgeInsets.all(5),
        width: widht * 0.83,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0x5b000000),
              offset: Offset(0, 0),
              blurRadius: 2,
              // spreadRadius: 1
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
      ),
    );
  }

//********button for small******//
  mysButton(BuildContext context, String text, VoidCallback callback,
      Color color, TextStyle style) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.all(7),
        width: widht * 0.50,
        height: 40.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0x5b000000),
              offset: Offset(0, 0),
              blurRadius: 2,
              // spreadRadius: 1
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
      ),
    );
  }

  callButton(BuildContext context, String text, VoidCallback callback,
      Color color, TextStyle style,IconData icon) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.all(5),
        width: widht * 0.37,
        height: 37.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0x5b000000),
              offset: Offset(0, 0),
              blurRadius: 2,
              // spreadRadius: 1
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: style,
              ),
              const SizedBox(width: 5,),
              Icon(icon,color: Colors.white,size: 20),
            ],
          ),
        ),
      ),
    );
  }

  acceptRejectButton(BuildContext context, String text, VoidCallback callback,
      Color color, TextStyle style,) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.all(5),
        width: widht * 0.38,
        height: 40.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0x5b000000),
              offset: Offset(0, 0),
              blurRadius: 2,
              // spreadRadius: 1
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
      ),
    );
  }

//=================================*MySnackBar*=======================================//
  MySnackBar(
      context,
      String msg,
      ) {
    final snackBar = SnackBar(
      content: Text(msg,
          style: const TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontFamily: "RobotoMono",
              fontWeight: FontWeight.bold,
              fontSize: 12)),
      padding: const EdgeInsets.all(10),
      backgroundColor: MyColor.primary,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

//*********** main TextField********//

  Widget myField(BuildContext context, TextEditingController controller,
      String hintText, TextInputType inputType) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return
        SizedBox(
          width: widht,
          child: TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: inputType,
            cursorColor: Colors.black,
            controller: controller,
            decoration: InputDecoration(

              contentPadding: const EdgeInsets.only(top: 3, left: 20),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 12),
              filled: true,
              fillColor: MyColor.white,
              border: const OutlineInputBorder(),

              ),
            ),
    );
  }

  Widget PasswordField(BuildContext context, TextEditingController controller,
      String hintText, TextInputType inputType, Widget widget, bool) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widht,
      child: TextFormField(
        obscureText: bool,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.next,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 3, left: 20),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12),
          suffixIcon: widget,
          suffixIconColor: MyColor.primary,
          filled: true,
          fillColor: MyColor.white,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }


  Widget HField(BuildContext context, TextEditingController controller,
      String hintText, TextInputType inputType,) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widht *1,
      child: TextFormField(
        maxLines: 3,
        textInputAction: TextInputAction.next,
        keyboardType: inputType,
        cursorColor: Colors.black,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 12, left: 20),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12),
          filled: true,
          fillColor: MyColor.white,
          border: const OutlineInputBorder(),

        ),
      ),
    );
  }


  Widget searchField(BuildContext context, TextEditingController controller,
      String hintText, TextInputType inputType, Widget icon, Widget icon1,VoidCallback newScreen,VoidCallback search,) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return
        SizedBox(
          width: widht,
          child: TextFormField(
            onChanged: (value) {
            // doctorListCtr.keywords.value=value;
              search();
            },
            cursorWidth: 0.0,
            cursorHeight: 0.0,
            onTap: (){
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              newScreen();
            },
            textInputAction: TextInputAction.next,
            keyboardType: inputType,
            cursorColor: Colors.black,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: icon1,
              prefixIconColor: MyColor.primary1,
              suffixIcon: icon,
                 suffixIconColor: MyColor.primary1,
              contentPadding: const EdgeInsets.only(top: 3, left: 20),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 12,color: MyColor.primary1),
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
    );
  }

  Widget searchFieldnew(BuildContext context, TextEditingController controller,
      String hintText, TextInputType inputType, Widget icon, Widget icon1,VoidCallback newScreen,VoidCallback search,bool) {
    final height = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return
      SizedBox(
        width: widht,
        child: TextFormField(
          readOnly:  bool,
          onChanged: (value) {
            // doctorListCtr.keywords.value=value;
            search();
          },
          cursorWidth: 0.0,
          cursorHeight: 0.0,
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            newScreen();
          },
          textInputAction: TextInputAction.next,
          keyboardType: inputType,
          cursorColor: Colors.black,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: icon1,
            prefixIconColor: MyColor.primary1,
            suffixIcon: icon,
            suffixIconColor: MyColor.primary1,
            contentPadding: const EdgeInsets.only(top: 3, left: 20),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 12,color: MyColor.primary1),
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
      );
  }

  massenger(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: "RobotoMono",
              letterSpacing: 1.0,
              fontSize: 13)),
      backgroundColor: MyColor.primary,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(25),
    ));
  }

  Widget MyIndicator() {
    return CircularProgressIndicator(
      strokeWidth: 2.0,
      backgroundColor: MyColor.primary.withOpacity(0.1),
      color: MyColor.primary,
    );
  }
}
