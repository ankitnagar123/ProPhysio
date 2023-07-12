import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import "../../controller/auth_controllers/card_controller's/PatientCardController.dart";

class PatientAddNewCardScreen extends StatefulWidget {
  const PatientAddNewCardScreen({Key? key}) : super(key: key);

  @override
  State<PatientAddNewCardScreen> createState() =>
      _PatientAddNewCardScreenState();
}

class _PatientAddNewCardScreenState extends State<PatientAddNewCardScreen> {
  CardCtr cardCtr = CardCtr();
  CustomView customView = CustomView();
  LocalString text = LocalString();
  TextEditingController cardHolderNameCtrl = TextEditingController();
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expireDateCtrl = TextEditingController();
  TextEditingController cvcCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: customView.text(
              text.addNewCard.tr, 15.0, FontWeight.w500, Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: width * 0.05,
              ),
              customView.text(
                  text.addNewCardOrderToPayAppointment.tr,
                  14.0,
                  FontWeight.w500,
                  Colors.black),
              SizedBox(
                height: width * 0.08,
              ),
              customView.text(text.enterCardHolderName.tr, 11.0, FontWeight.w500,
                  MyColor.black),
              SizedBox(
                height: width * 0.01,
              ),
              customView.myField(context, cardHolderNameCtrl,
                  "ex. @john", TextInputType.text),
              SizedBox(
                height: width * 0.05,
              ),
              customView.text(
                  text.enterCardNumber.tr, 11.0, FontWeight.w500, MyColor.black),
              SizedBox(
                height: width * 0.01,
              ),
              customView.myField(context, cardNumberCtrl, "*********4525",
                  TextInputType.number),
              SizedBox(
                height: width * 0.05,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customView.text(text.expireDate.tr, 11.0, FontWeight.w500,
                            MyColor.black),
                        SizedBox(
                          height: width * 0.01,
                        ),
                        customView.myField(context, expireDateCtrl,
                            "ex. 12/1999", TextInputType.text),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customView.text(
                            "CVC/CVV", 11.0, FontWeight.w500, MyColor.black),
                        SizedBox(
                          height: width * 0.01,
                        ),
                        customView.myField(
                            context, cvcCtrl, "ex.1234", TextInputType.number),
                      ],
                    ),
                  ),
                ],
              ),
              // Expanded(child: SizedBox()),
              SizedBox(
                height: width * 0.6,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Obx(() {
                    if (cardCtr.loadingAdd.value) {
                      return customView.MyIndicator();
                    }
                    return customView.MyButton(
                      context,
                      text.saveCard.tr,
                          () {

                        if(isValid() == true){
                          var month = expireDateCtrl.text.split('/').elementAt(0);
                          var year = expireDateCtrl.text.split('/').elementAt(1);
                          cardCtr.cardAdd(context, cardHolderNameCtrl.text,
                              cardNumberCtrl.text, month, year, cvcCtrl.text, () {
                            cardHolderNameCtrl.clear();
                            cardNumberCtrl.clear();
                            expireDateCtrl.clear();
                            cvcCtrl.clear();
                            cardCtr.cardFetch();
                            Get.back();
                           // Get.toNamed(RouteHelper.getPatientPaymentScreen());
                              });
                        }
                      },
                      MyColor.primary,
                      const TextStyle(fontFamily: "Poppins", color: Colors.white),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
        );
  }
  bool isValid() {
     if (cardHolderNameCtrl.text == '') {
    customView.MySnackBar(context,text.pleaseEnterYourName.tr);
    }else if (cardNumberCtrl.text.isEmpty || cardNumberCtrl.text.length < 19) {
      customView.MySnackBar(context, text.enterValidCardDetails.tr);
    } else if (expireDateCtrl.text == '' || expireDateCtrl.text.length < 5) {
      customView.MySnackBar(context, text.pleaseEnterExpiryDate.tr);
    } else if (cvcCtrl.text == '' || cvcCtrl.text.length < 3) {
      customView.MySnackBar(context,text.pleaseEnterValidCVC.tr);
    } else {
      return true;
    }
    return false;
  }
}
