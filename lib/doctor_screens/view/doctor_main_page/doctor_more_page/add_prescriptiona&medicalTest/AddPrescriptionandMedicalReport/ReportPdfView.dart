import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:prophysio/helper/CustomView/CustomView.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../../helper/mycolor/mycolor.dart';

class ReportPdfView extends StatefulWidget {
  final String url,name;

  const ReportPdfView({Key? key, required this.url, required this.name}) : super(key: key);

  @override
  State<ReportPdfView> createState() => _ReportPdfViewState();
}

class _ReportPdfViewState extends State<ReportPdfView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
CustomView view = CustomView();
  bool _downloading = false;

  @override
  void initState() {
    super.initState();
    log("url------${widget.url}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap:() {
            Get.back();
          } ,
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: view.text("View Report", 17, FontWeight.w500, MyColor.black),
        actions: <Widget>[
          _downloading
              ? Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                height: 20,width: 20,child: CircularProgressIndicator()),
              ))
              :  Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                            icon: const Icon(
                Icons.download_for_offline_rounded,
                color: MyColor.primary1,
                            ),
                            onPressed: () {
                downLoadFile(widget.url,"");
                            },
                          ),
              ),
        ],
      ),
      body:  SfPdfViewer.network(
        widget.url,
        key: _pdfViewerKey,
      ),
    );
  }
  void downLoadFile(String fileurl, String patientName) async {
    setState(() {
      _downloading = true; // Show loader when download starts
    });
    FileDownloader.downloadFile(
        url: fileurl,
        name: "$patientName Report.pdf",
        //THE FILE NAME AFTER DOWNLOADING,
        onProgress: (String? fileName, double? progress) {
          log('FILE fileName HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) {
          log('FILE DOWNLOADED TO PATH: $path');
          view.massenger(context, "Report download successfully");
          setState(() {
    _downloading = false; // Hide loader when download completes
    });
    // Handle completion, if needed
        },
        onDownloadError: (String error) {
          log('DOWNLOAD ERROR: $error');
          view.massenger(context, "something went wrong.Please try again.");

          setState(() {
            _downloading = false; // Hide loader when download fails
          });
          // Handle error, if needed
        },
        notificationType: NotificationType.all);
  }

}
