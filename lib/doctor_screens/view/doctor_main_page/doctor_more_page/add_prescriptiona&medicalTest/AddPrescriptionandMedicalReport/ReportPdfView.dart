import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class ReportPdfView extends StatefulWidget {
  final url;

  const ReportPdfView({super.key, this.url});
  @override
  State<ReportPdfView> createState() => _ReportPdfViewState();
}

class _ReportPdfViewState extends State<ReportPdfView> {

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    log("url------${widget.url}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.url,
        key: _pdfViewerKey,
      ),
    );
  }
}
