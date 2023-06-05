import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica/doctor_screens/view/doctor_main_page/doctor_more_page/add_prescriptiona&medicalTest/QRScannerReports/QRScanOverLay.dart';
import 'package:medica/helper/mycolor/mycolor.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../../helper/CustomView/CustomView.dart';
import 'QRPrescriptionList.dart';

class QRScannerDoctor extends StatefulWidget {
  const QRScannerDoctor({Key? key}) : super(key: key);

  @override
  State<QRScannerDoctor> createState() => _QRScannerDoctorState();
}

MobileScannerController mobileScannerController = MobileScannerController();

class _QRScannerDoctorState extends State<QRScannerDoctor> {
  MobileScannerController controller = MobileScannerController();
  CustomView custom = CustomView();
  String qrId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
        centerTitle: true,
        title: custom.text(
            "Scan and check reports", 16, FontWeight.w500, MyColor.black),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: controller.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey,size: 17,);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: MyColor.primary1,size: 17,);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => controller.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: controller.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            startDelay: true,
              controller: controller,
              onDetect: (qrcode) {
                final List<Barcode> barcodes = qrcode.barcodes;
                for (final barcode in barcodes) {
                  debugPrint('Barcode found! ${barcode.rawValue}');
                  qrId = barcode.rawValue.toString();
                  debugPrint('my string value Barcode found! $qrId');
                }

                if (qrId != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QRPrescriptionList(
                              patientId: qrId,
                            )),
                  );
                } else {
                  Future.delayed(const Duration(seconds: 5), () {
                    Navigator.pop(context);
                  });
                }
              }),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
        ],
      ),
    );
  }
}
