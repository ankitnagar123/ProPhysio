import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../helper/CustomView/CustomView.dart';
import '../../../../helper/mycolor/mycolor.dart';
import '../../../../language_translator/LanguageTranslate.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({Key? key}) : super(key: key);

  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
CustomView custom =CustomView();
LocalString text = LocalString();

/*---------TEXT-FIELD CONTROLLER'S----------*/
TextEditingController  invoiceNoCtr = TextEditingController();
TextEditingController amountCtr = TextEditingController();
TextEditingController serviceCtr = TextEditingController();
TextEditingController descriptionCtr = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: custom.text("Billing", 17, FontWeight.w400, Colors.black),
      ),
      body:  SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child:  Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: custom.text("Submit invoice Information", 14, FontWeight.w500, MyColor.primary1)),
                    Align(
                        alignment: Alignment.topLeft,
                        child: custom.text("Fill the correct information reading Therapy\nfor this invoice.", 11, FontWeight.w400, Colors.grey)),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: custom.text(
                          "Invoice No", 13.0, FontWeight.w500, MyColor.primary1),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    custom.myField(context, invoiceNoCtr,"Enter invoice no", TextInputType.text),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: custom.text("Enter Service ", 13.0, FontWeight.w500,
                          MyColor.primary1),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    custom.myField(
                        context, serviceCtr,"Enter service like therapy", TextInputType.text),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: custom.text("Due Amount", 13.0, FontWeight.w500,
                          MyColor.primary1),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    custom.myField(
                        context, amountCtr,"Enter amount", TextInputType.text),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: custom.text("Enter Description ", 13.0, FontWeight.w500,
                          MyColor.primary1),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    custom.myField(
                        context, descriptionCtr,"Enter description", TextInputType.text),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
    )
    ));

  }
}
