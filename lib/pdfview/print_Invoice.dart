import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({super.key});

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (format) => _generatePdf(format, context),
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, BuildContext contexts) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final profileImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/prologo1.png'))
          .buffer
          .asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(profileImage, width: 130),
                  pw.Container(
                    height: 50,
                    width: 50,
                    child: pw.BarcodeWidget(
                      barcode: pw.Barcode.qrCode(),
                      data: "invoice.info.number",
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Text(
                "Medical Invoice".toUpperCase(),
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 21,
                    color: PdfColor.fromInt(0xff0172B9)),
              ),
              pw.SizedBox(
                height: 15,
              ),
              pw.Container(
                  height: MediaQuery.of(contexts).size.height / 12,
                  decoration: pw.BoxDecoration(
                      // color:  const PdfColor.fromInt(0xffFAFAFA),
                      borderRadius: pw.BorderRadius.circular(10),
                      border: pw.Border.all(
                          color: PdfColor.fromInt(0xff90CAF9), width: 2)),
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                            children: [
                              pw.Text(
                                "Invoice Number",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 15,
                                    color: PdfColor.fromInt(0xffB22724)),
                              ),
                              pw.Text(
                                "Date",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 16,
                                    color: PdfColor.fromInt(0xffB22724)),
                              ),
                              pw.Text(
                                "Amount Due",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 16,
                                    color: PdfColor.fromInt(0xffB22724)),
                              ),
                            ]),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                            children: [
                              pw.Text(
                                "122514",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 15),
                              ),
                              pw.Text(
                                "12-12-2023",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 16),
                              ),
                              pw.Text(
                                "Rs. 5499",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ]),
                      ])),
              pw.SizedBox(
                height: 10,
              ),
              pw.Container(
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                    pw.Text("Patient Information",
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                            color: PdfColor.fromInt(0xffB22724))),
                    pw.SizedBox(height: 5),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Name",
                            style: pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          ),
                          pw.Text(
                            "Brock Nails",
                            style: pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          )
                        ]),
                    pw.SizedBox(height: 3),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Contact Number",
                            style: const pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          ),
                          pw.Text(
                            "(+12)5262621511",
                            style: pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          )
                        ]),
                    pw.SizedBox(height: 3),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Address",
                            style: const pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          ),
                          pw.Text(
                            "Rajiv Gandhi Square Indore (MP)",
                            style: const pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          )
                        ]),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Text("Prescribing Physicians Information",
                        style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(0xffB22724))),
                    pw.SizedBox(
                      height: 3,
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Name",
                            style: pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          ),
                          pw.Text(
                            "Dr.Ram Ahuja",
                            style: pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          )
                        ]),
                    pw.SizedBox(height: 3),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Address",
                            style: pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          ),
                          pw.Text(
                            "America USA United State",
                            style: pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          )
                        ]),
                    pw.SizedBox(height: 3),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Contact Number",
                            style: const pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          ),
                          pw.Text(
                            "2150585252000",
                            style: const pw.TextStyle(
                              color: PdfColors.black,
                            ),
                          )
                        ]),
                    pw.SizedBox(
                      height: 18,
                    ),
                    pw.Align(

                      alignment: pw.Alignment.center,
                      child: pw.Container(
                          // height: MediaQuery.of(contexts).size.height / 5,
                          width: MediaQuery.of(contexts).size.width / 0.8,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.red200),
                            color: PdfColors.white,
                            borderRadius: pw.BorderRadius.circular(3),
                            /* border: pw.Border.all(

                                color: PdfColor.fromInt(0xff90CAF9), width: 2)*/
                          ),
                          child: pw.Column(children: [
                            pw.Row(
                                children: List.generate(
                              300 ~/ 10,
                              (index) => pw.Expanded(
                                  child: pw.Container(
                                margin: pw.EdgeInsets.only(right: 2),
                                color: PdfColor.fromInt(0xffB22724),
                                height: 1,
                                // width: 1,
                                child: pw.Divider(
                                  color: PdfColor.fromInt(0xffB22724),
                                ),
                              )),
                            )),
                            pw.Container(
                              height: MediaQuery.of(contexts).size.height / 22,
                              width: MediaQuery.of(contexts).size.width / 0.8,
                              decoration: pw.BoxDecoration(
                                color: const PdfColor.fromInt(0xffB22724),
                                borderRadius: pw.BorderRadius.circular(3),
                              ),
                              child: pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceAround,
                                  children: [
                                    pw.Text(
                                      "Item",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 15,
                                          color: PdfColor.fromInt(0xffFFFFFF)),
                                    ),
                                    pw.Text(
                                      "Description",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 16,
                                          color: PdfColor.fromInt(0xffFFFFFF)),
                                    ),
                                    pw.Text(
                                      "Price",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 16,
                                          color: PdfColor.fromInt(0xffFFFFFF)),
                                    ),
                                  ]),
                            ),
                            pw.Row(
                                children: List.generate(
                              300 ~/ 10,
                              (index) => pw.Expanded(
                                  child: pw.Container(
                                margin: pw.EdgeInsets.only(right: 2),
                                color: PdfColor.fromInt(0xffB22724),
                                height: 1,
                                // width: 1,
                                child: pw.Divider(
                                  color: PdfColor.fromInt(0xffB22724),
                                ),
                              )),
                            )),
                            pw.SizedBox(height: 5),
                            pw.ListView.separated(
                              separatorBuilder: (context, index) {
                                return pw.Divider(color: PdfColors.red200);
                              },
                              itemBuilder: (context, index) {
                                return pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceAround,
                                    children: [
                                      pw.Text(
                                        "Full Checkup",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 11,
                                            color: PdfColors.black),
                                      ),
                                      pw.VerticalDivider(
                                        thickness: 3,
                                        color: PdfColors.red200,
                                      ),
                                      pw.Text(
                                        "Full Body Checkup",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 11,
                                            color: PdfColors.black),
                                      ),
                                      pw.VerticalDivider(
                                        thickness: 3,
                                        color: PdfColors.red200,
                                      ),
                                      pw.Text(
                                        "Rs.4500",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 11,
                                            color: PdfColors.black),
                                      ),
                                    ]);
                              },
                              itemCount: 3,
                            ),

                            pw.SizedBox(
                              height: 10
                            ),
                          ])),
                    ),
pw.SizedBox(
  height: 20
),

                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            pw.Container(
                                height: MediaQuery.of(contexts).size.height / 12,
                                width: MediaQuery.of(contexts).size.width/1.7,
                                decoration: pw.BoxDecoration(
                                  // color:  const PdfColor.fromInt(0xffFAFAFA),
                                    borderRadius: pw.BorderRadius.circular(10),
                                    border: pw.Border.all(
                                        color: PdfColors.grey400, width: 2)),
                                child: pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    // mainAxisAlignment: pw.MainAxisAlignment.,
                                    children: [
                                      pw.Text(
                                        "NOTES\nPrescriber information: The doctor's name,\n address and phone number\n should be clearly",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.normal,
                                            fontSize: 10),
                                      ),
                                    ])),
                            pw.Column(
                              children: [
                                pw.Row(
                                    mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        "SUBTOTAL",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 12,
                                            color: PdfColors.black),
                                      ),
                                      pw.VerticalDivider(
                                        thickness: 3,
                                        color: PdfColors.red200,
                                      ),
                                      pw.Text(
                                        "Rs.4500",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 13,
                                            color: PdfColors.black),
                                      ),
                                    ]),
                                pw.SizedBox(
                                  height: 4
                                ),
                                pw.Padding(
                                  padding: pw.EdgeInsets.only(left: 20,right: 20),
                                  child: pw.Row(
                                      mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Text(
                                          "DISCOUNT",
                                          style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                              fontSize: 11,
                                              color: PdfColors.black),
                                        ),
                                        pw.VerticalDivider(
                                          thickness: 3,
                                          color: PdfColors.red200,
                                        ),
                                        pw.Text(
                                          "10 %",
                                          style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                              fontSize: 11,
                                              color: PdfColors.black),
                                        ),
                                      ]),
                                ),
                                pw.Text(
                                  "--------------------------",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 11,
                                      color: PdfColors.black),
                                ),
                                pw.Padding(
                                  padding: pw.EdgeInsets.only(left: 20,right: 20),
                                  child: pw.Row(
                                      mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Text(
                                          "TOTAL",
                                          style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                              fontSize: 11,
                                              color: PdfColors.black),
                                        ),
                                        pw.VerticalDivider(
                                          thickness: 3,
                                          color: PdfColors.red200,
                                        ),
                                        pw.Text(
                                          "11500",
                                          style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold,
                                              fontSize: 11,
                                              color: PdfColors.black),
                                        ),
                                      ]),
                                ),
                              ],
                            )

                          ]
                        )

                  ]))
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
