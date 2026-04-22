import 'dart:io';
import 'package:dio/dio.dart';
import 'package:explaino/config/errors/local_exception.dart';
import 'package:explaino/core/constants/errors_constants.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

Future<MultipartFile> toMultipartFile(File file) async {
  final compressedFile = await _compressImage(file);
  final targetFile = compressedFile ?? file;

  final bytes = await targetFile.length();
  const maxBytes = 4 * 1024 * 1024;

  if (bytes > maxBytes) {
    throw FileException(ErrorsConstant.fileIsTooLarge);
  }

  final extension = targetFile.path.split('.').last.toLowerCase();
  final mimeSubtype = extension == 'jpg' ? 'jpeg' : extension;

  return await MultipartFile.fromFile(
    targetFile.path,
    filename: targetFile.path.split('/').last,
    contentType: MediaType('image', mimeSubtype),
  );
}

Future<File?> _compressImage(File file) async {
  try {
    final dir = await getTemporaryDirectory();
    final extension = path.extension(file.path).toLowerCase();
    final targetPath = path.join(
      dir.path,
      '${DateTime.now().millisecondsSinceEpoch}$extension',
    );

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 75,
      minWidth: 1024,
      minHeight: 1024,
    );

    return result != null ? File(result.path) : null;
  } catch (e) {
    return null;
  }
}
