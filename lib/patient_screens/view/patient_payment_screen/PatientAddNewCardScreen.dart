/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medica/helper/CustomView/CustomView.dart';

import '../../../helper/mycolor/mycolor.dart';
import '../../../language_translator/LanguageTranslate.dart';
import "../../controller/auth_controllers/card_controller's/PatientCardController.dart";
import 'cardWithValidation/Strings.dart';
import 'cardWithValidation/input_formate.dart';
import 'cardWithValidation/paymet_card.dart';

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

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = new GlobalKey<FormState>();
  TextEditingController holderNameController = TextEditingController();
  TextEditingController cVVController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final _paymentCard = PaymentCard();
  var _autoValidateMode = AutovalidateMode.disabled;

  final _card = PaymentCard();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: width * 0.05,
              ),
              customView.text(text.addNewCardOrderToPayAppointment.tr, 14.0,
                  FontWeight.w500, Colors.black),
              SizedBox(
                height: width * 0.08,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: customView.text(text.enterCardHolderName.tr, 11.0,
                    FontWeight.w500, MyColor.black),
              ),
              SizedBox(
                height: width * 0.01,
              ),
              SizedBox(
                width: width,
                child: TextFormField(
                  controller: holderNameController,
                  onSaved: (String? value) {
                    _card.name = value;
                    print(value);
                  },
                  keyboardType: TextInputType.text,
                  validator: (String? value) =>
                      value!.isEmpty ? Strings.fieldReq : null,
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
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
                height: width * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: customView.text(text.enterCardNumber.tr, 11.0,
                    FontWeight.w500, MyColor.black),
              ),
              SizedBox(
                height: width * 0.01,
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
                height: width * 0.05,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: customView.text(text.expireDate.tr, 11.0,
                              FontWeight.w500, MyColor.black),
                        ),
                        SizedBox(
                          height: width * 0.01,
                        ),
                        TextFormField(
                          controller: expiryController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new LengthLimitingTextInputFormatter(4),
                            new CardMonthInputFormatter()
                          ],
                          decoration: const InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(top: 3, left: 20),
                            hintStyle: const TextStyle(fontSize: 12),
                            filled: true,
                            fillColor: MyColor.white,
                            border: const OutlineInputBorder(),
                            icon: Icon(Icons.calendar_month, size: 25),
                            hintText: 'MM/YY',
                            // labelText: 'Expiry Date',
                          ),
                          validator: CardUtils.validateDate,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            List<int> expiryDate =
                                CardUtils.getExpiryDate(value!);
                            _paymentCard.month = expiryDate[0];
                            _paymentCard.year = expiryDate[1];
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 14.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: customView.text(
                              "CVC/CVV", 11.0, FontWeight.w500, MyColor.black),
                        ),
                        SizedBox(
                          height: width * 0.01,
                        ),
                        TextFormField(
                          controller: cVVController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new LengthLimitingTextInputFormatter(4),
                          ],
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(top: 3, left: 20),
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
                      ],
                    ),
                  ),
                ],
              ),
              // Expanded(child: SizedBox()),
              SizedBox(
                height: width * 0.4,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                  child: Obx(() {
                    if (cardCtr.loadingAdd.value) {
                      return customView.MyIndicator();
                    }
                    return customView.MyButton(
                      context,
                      text.saveCard.tr,
                      () {
                        if (validateInputs()) {
                          var month =
                              expiryController.text.split('/').elementAt(0);
                          var year =
                              expiryController.text.split('/').elementAt(1);
                          cardCtr.cardAdd(
                              context,
                              holderNameController.text,
                              numberController.text,
                              month,
                              year,
                              cVVController.text, () {
                            Get.back();
                            holderNameController.clear();
                            numberController.clear();
                            expiryController.clear();
                            cVVController.clear();
                            cardCtr.cardFetch();
                            // Get.toNamed(RouteHelper.getPatientPaymentScreen());
                          });
                        }
                      },
                      MyColor.primary,
                      const TextStyle(fontFamily: "Poppins", color: Colors.white),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

*/
/*  bool isValid() {
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
  }*//*

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

  bool validateInputs() {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode =
            AutovalidateMode.always; // Start validating on every change.
      });
    } else {
      form.save();
      return true;
    }
    return false;
  }
}
*/
