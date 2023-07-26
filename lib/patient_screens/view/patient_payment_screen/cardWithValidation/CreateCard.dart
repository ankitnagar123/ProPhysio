import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:medica/patient_screens/view/patient_payment_screen/cardWithValidation/paymet_card.dart';
import 'package:get/get.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import "../../../controller/auth_controllers/card_controller's/PatientCardController.dart";
import 'Strings.dart';
import 'input_formate.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key,}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  CardCtr cardCtr = CardCtr();
  CustomView customView = CustomView();
  LocalString text = LocalString();

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = new GlobalKey<FormState>();
  var numberController = new TextEditingController();
  var _paymentCard = PaymentCard();
  var _autoValidateMode = AutovalidateMode.disabled;

  var _card = new PaymentCard();

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
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
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,),
          child:  Form(
              key: _formKey,
              autovalidateMode: _autoValidateMode,
              child:  ListView(
                children: <Widget>[
                   const SizedBox(
                    height: 20.0,
                  ),
              SizedBox(
                width: widht,
                child: TextFormField(
                  onSaved: (String? value) {
                    _card.name = value;
                    print(value);
                  },
                  keyboardType: TextInputType.text,
                  validator: (String? value) =>
                  value!.isEmpty ? Strings.fieldReq : null,
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.black,
                  decoration:  InputDecoration(
                    hintText: text.enterCardHolderName.tr,
                    // labelText: 'Card Holder Name',
                    icon: Icon(
                      Icons.person,
                      size: 25.0,
                    ),
                    contentPadding: EdgeInsets.only(top: 3, left: 20),
                    hintStyle: TextStyle(fontSize: 12),
                    filled: true,
                    fillColor: MyColor.white,
                    border: OutlineInputBorder(),

                  ),
                ),
              ),
                  SizedBox(
                    height: 30.0,
                  ),
                   TextFormField(

                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(19),
                      new CardNumberInputFormatter()
                    ],
                    controller: numberController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 3, left: 20),
                      hintStyle: const TextStyle(fontSize: 12),
                      filled: true,
                      fillColor: MyColor.white,
                      border: const OutlineInputBorder(),
                      icon: CardUtils.getCardIcon(_paymentCard.type),
                      hintText:text.enterCardNumber.tr,
                      // labelText: 'Number',
                    ),
                    onSaved: (String? value) {
                      print('onSaved = $value');
                      print('Num controller has = ${numberController.text}');
                      _paymentCard.number = CardUtils.getCleanedNumber(value!);
                    },
                    validator: CardUtils.validateCardNum,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(4),
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 3, left: 20),
                      hintStyle: const TextStyle(fontSize: 12),
                      filled: true,
                      fillColor: MyColor.white,
                      border: const OutlineInputBorder(),
                      icon: Image.asset(
                        'assets/images/cvv.png',
                        width: 25.0,
                        color: Colors.grey[600],
                      ),
                      hintText: 'CVV',
                      // labelText: 'CVV',
                    ),
                    validator: CardUtils.validateCVV,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _paymentCard.cvv = int.parse(value!);
                    },
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(4),
                      new CardMonthInputFormatter()
                    ],
                    decoration: const InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 3, left: 20),
                      hintStyle: const TextStyle(fontSize: 12),
                      filled: true,
                      fillColor: MyColor.white,
                      border: const OutlineInputBorder(),
                      icon: Icon(Icons.calendar_month,size: 25),
                      hintText: 'MM/YY',
                      // labelText: 'Expiry Date',
                    ),
                    validator: CardUtils.validateDate,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      List<int> expiryDate = CardUtils.getExpiryDate(value!);
                      _paymentCard.month = expiryDate[0];
                      _paymentCard.year = expiryDate[1];
                    },
                  ),
                  new SizedBox(
                    height: 50.0,
                  ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Container(
                  //     margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                  //     child: Obx(() {
                  //       if (cardCtr.loadingAdd.value) {
                  //         return customView.MyIndicator();
                  //       }
                  //       return customView.MyButton(
                  //         context,
                  //         text.saveCard.tr,
                  //             () {
                  //           if( _validateInputs()){
                  //             cardCtr.cardAdd(context, cardHolderNameCtrl.text,
                  //                 cardNumberCtrl.text, month, year, cvcCtrl.text, () {
                  //                   Get.back();
                  //                   Get.back();
                  //                   cardHolderNameCtrl.clear();
                  //                   cardNumberCtrl.clear();
                  //                   expireDateCtrl.clear();
                  //                   cvcCtrl.clear();
                  //                   cardCtr.cardFetch();
                  //                   // Get.toNamed(RouteHelper.getPatientPaymentScreen());
                  //                 });
                  //           }
                  //         },
                  //         MyColor.primary,
                  //         const TextStyle(fontFamily: "Poppins", color: Colors.white),
                  //       );
                  //     }),
                  //   ),
                  // ),
                  Container(
                    alignment: Alignment.center,
                    child: _getPayButton(),
                  )
                ],
              )),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

   _validateInputs() {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode =
            AutovalidateMode.always; // Start validating on every change.
      });
      _showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      // Encrypt and send send payment details to payment gateway
      _showInSnackBar('Payment card is valid');
    }
  }

  Widget _getPayButton() {
    if (Platform.isIOS) {
      return new CupertinoButton(
        onPressed: _validateInputs,
        color: CupertinoColors.activeBlue,
        child: const Text(
          Strings.pay,
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: _validateInputs,
        child: Text(
          Strings.pay.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
  }

  void _showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
      duration: new Duration(seconds: 3),
    ));
  }
}
