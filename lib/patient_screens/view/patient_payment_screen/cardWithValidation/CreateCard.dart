import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prophysio/patient_screens/view/patient_payment_screen/cardWithValidation/paymet_card.dart';
import '../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';
import "../../../controller/auth_controllers/card_controller's/PatientCardController.dart";
import 'Strings.dart';
import 'input_formate.dart';


class PatientAddNewCard extends StatefulWidget {
  const PatientAddNewCard({Key? key,}) : super(key: key);

  @override
  _PatientAddNewCardState createState() =>  _PatientAddNewCardState();
}

class _PatientAddNewCardState extends State<PatientAddNewCard> {

  CardCtr cardCtr = CardCtr();
  CustomView customView = CustomView();
  LocalString text = LocalString();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController holderNameController =  TextEditingController();
  TextEditingController cVVController =  TextEditingController();
  TextEditingController expiryController =  TextEditingController();
  TextEditingController numberController =  TextEditingController();
  final _paymentCard = PaymentCard();
  var _autoValidateMode = AutovalidateMode.disabled;

  final _card = PaymentCard();

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        Get.back(result: true);
      },
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back(result: true);
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
                    decoration:  InputDecoration(
                      hintText: text.enterCardHolderName.tr,
                      // labelText: 'Card Holder Name',
                      icon: const Icon(
                        Icons.person,
                        size: 25.0,
                      ),
                      contentPadding: const EdgeInsets.only(top: 3, left: 20),
                      hintStyle: const TextStyle(fontSize: 12),
                      filled: true,
                      fillColor: MyColor.white,
                      border: const OutlineInputBorder(),

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
                        LengthLimitingTextInputFormatter(19),
                        CardNumberInputFormatter()
                      ],
                      controller: numberController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 3, left: 20),
                        hintStyle: const TextStyle(fontSize: 12),
                        filled: true,
                        fillColor: MyColor.white,
                        border: const OutlineInputBorder(),
                        icon: Icon(Icons.credit_card)/*CardUtils.getCardIcon(_paymentCard.type)*/,
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
                            LengthLimitingTextInputFormatter(4),
                            CardMonthInputFormatter()
                          ],
                          decoration: const InputDecoration(
                            contentPadding:
                            EdgeInsets.only(top: 3, left: 20),
                            hintStyle: TextStyle(fontSize: 12),
                            filled: true,
                            fillColor: MyColor.white,
                            border: OutlineInputBorder(),
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
                            LengthLimitingTextInputFormatter(4),
                          ],
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.only(top: 3, left: 20),
                            hintStyle: const TextStyle(fontSize: 12),
                            filled: true,
                            fillColor: MyColor.white,
                            border: const OutlineInputBorder(),
                            icon: Icon(Icons.pin),
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
                        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                        child: Obx(() {
                          if (cardCtr.loadingAdd.value) {
                            return customView.MyIndicator();
                          }
                          return customView.MyButton(
                            context,
                            text.saveCard.tr,
                                () {
                              if( validateInputs()){
                                var month = expiryController.text.split('/').elementAt(0);
                                var year = expiryController.text.split('/').elementAt(1);
                                cardCtr.cardAdd(context, holderNameController.text,
                                    numberController.text,month, year, cVVController.text, () {
                                      Get.back(result: true);
                                      holderNameController.clear();
                                      numberController.clear();
                                      expiryController.clear();
                                      cVVController.clear();
                                      cardCtr.cardFetch();
                                      // Get.toNamed(RouteHelper.getPatientPaymentScreen());
                                    });
                              }
                            },
                            MyColor.red,
                            const TextStyle(fontFamily: "Poppins", color: Colors.white),
                          );
                        }),
                      ),
                    ),
                  ],
                )),
          )),
    );
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
      _paymentCard.type = cardType;
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
