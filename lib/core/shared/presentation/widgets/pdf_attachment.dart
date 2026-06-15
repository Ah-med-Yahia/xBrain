import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfAttachment extends StatefulWidget {
  final String url;
  const PdfAttachment({super.key, required this.url});

  @override
  State<PdfAttachment> createState() => _PdfAttachmentState();
}

class _PdfAttachmentState extends State<PdfAttachment> {
  late final PdfViewerController _controller = PdfViewerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: .4)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SfPdfViewer.network(
          widget.url,
          controller: _controller,
          canShowScrollHead: true,
          canShowScrollStatus: false,
          enableDoubleTapZooming: true,
        ),
      ),
    );
  }
}
