import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoAttachment extends StatefulWidget {
  final String url;
  const VideoAttachment({super.key, required this.url});

  @override
  State<VideoAttachment> createState() => _VideoAttachmentState();
}

class _VideoAttachmentState extends State<VideoAttachment> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
      );
      await _videoController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: false,
        looping: false,
        aspectRatio: _videoController.value.aspectRatio,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
      );

      setState(() => _isInitialized = true);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final height = _isInitialized
            ? width / _videoController.value.aspectRatio
            : 250.0;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          width: width,
          height: height.clamp(180.0, 500.0),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.lightGrey.withValues(alpha: .4),
            ),
            color: Colors.black,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _buildContent(),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    if (_error != null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.white54, size: 32),
            SizedBox(height: 8),
            Text(
              'Failed to load video',
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ],
        ),
      );
    }

    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return Chewie(controller: _chewieController!);
  }
}
