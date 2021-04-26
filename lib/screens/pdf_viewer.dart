import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfUrl;
  PDFViewerScreen({@required this.pdfUrl});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  // bool _isLoading = false;
  // PDFDocument pdf;
  // @override
  // void initState() {}
  // Future<void> load() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   pdf = await PDFDocument.fromURL(widget.pdfUrl);
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDF(
        swipeHorizontal: true,
      ).cachedFromUrl(widget.pdfUrl),
    );
  }
}
