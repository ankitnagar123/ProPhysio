import 'dart:io';
import 'package:file_utils/file_utils.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../helper/CustomView/CustomView.dart';
import '../../../../../../../../helper/mycolor/mycolor.dart';
import '../../../../../../../../language_translator/LanguageTranslate.dart';
class PdfViewerPage extends StatefulWidget {
  final File file;
  final String url;

  const PdfViewerPage({
    Key? key,
    required this.file,
    required this.url,
  }) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
CustomView view = CustomView();
LocalString text = LocalString();

  var path = "";
  var _onPressed;
  Directory? externalDir;
  @override
  void initState() {
    super.initState();
  }


  String convertCurrentDateTimeToString() {
    String formattedDateTime =
    DateFormat('yMMMMd').format(DateTime.now()).toString();
    return formattedDateTime;
  }


  Future<void> downloadFile(BuildContext context) async {
    Dio dio = Dio();


    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(
            widget.url, "${dirloc}Medica_${text.reports.tr}_${convertCurrentDateTimeToString()}.pdf",
            onReceiveProgress: (receivedBytes, totalBytes) {
              print('here 1');

              print("praaaa${"${widget.url}Medica _${text.reports.tr}_$dirloc${convertCurrentDateTimeToString()}.pdf"}");
              setState(() {
                print("................seee$dirloc");
              });
              print('here 2');
            });
      } catch (e) {
        print('catch catch catch');
        print(e);
      }
      setState(() {
        path = "${dirloc}Medica_${text.reports.tr}_${convertCurrentDateTimeToString()}.pdf";
      });
      print(path);
      view.MySnackBar(context, text.Download_report_successful.tr);
      print('here give alert-->completed');
    } else {
      setState(() {
        _onPressed = () {
          downloadFile(context);
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white24,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: MyColor.black)),
        title: Text(name,style: TextStyle(color: MyColor.black)),
        actions: [
          IconButton(
            color: MyColor.primary1,
            onPressed: () async {
              downloadFile(context);
            },
            icon: const Icon(Icons.download_rounded),
          ),
        ],
      ),
      body:  Column(
        children: [
           Text(path,overflow: TextOverflow.ellipsis,softWrap: true,maxLines: 2),
          const SizedBox(height: 20,),
          Expanded(
            child: PDFView(
              filePath: widget.file.path,
            ),
          ),
        ],
      )
    );
  }



}
