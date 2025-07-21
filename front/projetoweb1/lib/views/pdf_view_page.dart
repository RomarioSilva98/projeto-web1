import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visualizador de PDF"),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: HtmlWidget(
          '<iframe src="$pdfUrl" width="100%" height="100%" style="border: none;"></iframe>',
        ),
      ),
    );
  }
}
