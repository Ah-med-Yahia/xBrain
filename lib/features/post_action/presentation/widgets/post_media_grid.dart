import 'package:cached_network_image/cached_network_image.dart';
import 'package:explaino/core/constants/checker_constants.dart';
import 'package:explaino/core/shared/data/models/questions/response/get_list_questions_response_model/attachment_model.dart';
import 'package:explaino/core/shared/presentation/widgets/pdf_attachment.dart';
import 'package:explaino/core/shared/presentation/widgets/video_attachment.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PostMediaGrid extends StatelessWidget {
  final List<AttachmentModel> attachments;

  const PostMediaGrid({super.key, required this.attachments});

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) return const SizedBox.shrink();

    final images = attachments
        .where((a) => a.kind == CheckerConstants.kImage)
        .toList();
    final videos = attachments
        .where((a) => a.kind == CheckerConstants.kVideo)
        .toList();
    final pdfs = attachments
        .where((a) => a.kind == CheckerConstants.kPdf)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (images.isNotEmpty) _buildImagesGrid(context, images),
        if (videos.isNotEmpty) ...[
          if (images.isNotEmpty) const SizedBox(height: 8),
          ...videos.map(
            (v) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: VideoAttachment(url: v.url),
            ),
          ),
        ],
        if (pdfs.isNotEmpty) ...[
          if (images.isNotEmpty || videos.isNotEmpty) const SizedBox(height: 8),
          ...pdfs.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: PdfAttachment(url: p.url),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildImagesGrid(BuildContext context, List<AttachmentModel> images) {
    switch (images.length) {
      case 1:
        return _singleImage(context, images[0]);
      case 2:
        return _twoImages(context, images);
      case 3:
        return _threeImages(context, images);
      default:
        return _fourPlusImages(context, images);
    }
  }

  Widget _singleImage(BuildContext context, AttachmentModel att) {
    return GestureDetector(
      onTap: () => _openFullscreen(context, [att], 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(aspectRatio: 16 / 9, child: _networkImage(att.url)),
      ),
    );
  }

  Widget _twoImages(BuildContext context, List<AttachmentModel> images) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 220,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _openFullscreen(context, images, 0),
                child: _networkImage(images[0].url),
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              child: GestureDetector(
                onTap: () => _openFullscreen(context, images, 1),
                child: _networkImage(images[1].url),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Three Images: big left + two right ───────────────────────
  Widget _threeImages(BuildContext context, List<AttachmentModel> images) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 240,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => _openFullscreen(context, images, 0),
                child: _networkImage(images[0].url),
              ),
            ),
            const SizedBox(width: 2),
            // Right two images stacked
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _openFullscreen(context, images, 1),
                      child: _networkImage(images[1].url),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _openFullscreen(context, images, 2),
                      child: _networkImage(images[2].url),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── 4+ Images: 2×2 grid, last cell shows "+N more" ──────────
  Widget _fourPlusImages(BuildContext context, List<AttachmentModel> images) {
    final displayed = images.take(4).toList();
    final remaining = images.length - 4;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 240,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _openFullscreen(context, images, 0),
                      child: _networkImage(displayed[0].url),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _openFullscreen(context, images, 1),
                      child: _networkImage(displayed[1].url),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _openFullscreen(context, images, 2),
                      child: _networkImage(displayed[2].url),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _openFullscreen(context, images, 3),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          _networkImage(displayed[3].url),
                          if (remaining > 0)
                            Container(
                              color: Colors.black.withValues(alpha: 0.55),
                              child: Center(
                                child: Text(
                                  '+$remaining',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _networkImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      placeholder: (context, url) => Container(
        color: AppColors.offWhite,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.offWhite,
        child: const Icon(
          Icons.broken_image_outlined,
          color: AppColors.grey500,
          size: 32,
        ),
      ),
    );
  }

  void _openFullscreen(
    BuildContext context,
    List<AttachmentModel> images,
    int initialIndex,
  ) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black,
        pageBuilder: (context, animation, secondaryAnimation) =>
            _FullscreenGallery(images: images, initialIndex: initialIndex),
      ),
    );
  }
}

class _FullscreenGallery extends StatefulWidget {
  final List<AttachmentModel> images;
  final int initialIndex;

  const _FullscreenGallery({required this.images, required this.initialIndex});

  @override
  State<_FullscreenGallery> createState() => _FullscreenGalleryState();
}

class _FullscreenGalleryState extends State<_FullscreenGallery> {
  late PageController _controller;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          '${_current + 1} / ${widget.images.length}',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.images.length,
        onPageChanged: (i) => setState(() => _current = i),
        itemBuilder: (context, i) {
          return InteractiveViewer(
            child: Center(
              child: CachedNetworkImage(
                imageUrl: widget.images[i].url,
                fit: BoxFit.contain,
                placeholder: (ctx, url) =>
                    const CircularProgressIndicator(color: Colors.white),
                errorWidget: (ctx, url, error) => const Icon(
                  Icons.broken_image_outlined,
                  color: Colors.white54,
                  size: 48,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
