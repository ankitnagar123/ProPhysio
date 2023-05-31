import 'package:flutter/material.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/add_prescriptiona&medicalTest/QRScanOverLay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerDoctor extends StatefulWidget {
  const QRScannerDoctor({Key? key}) : super(key: key);

  @override
  State<QRScannerDoctor> createState() => _QRScannerDoctorState();
}

MobileScannerController mobileScannerController = MobileScannerController();

class _QRScannerDoctorState extends State<QRScannerDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("QR"),
        actions: [
          IconButton(onPressed: (){
            mobileScannerController.switchCamera();
          }, icon: const Icon(Icons.qr_code_scanner_sharp))
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (barcodes) {
              debugPrint("Barcode Fount!" + barcodes.raw);
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
        ],
      ),
    );
  }
}
