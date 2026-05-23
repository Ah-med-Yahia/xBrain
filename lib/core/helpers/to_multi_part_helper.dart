import 'dart:io';
import 'package:dio/dio.dart';
import 'package:explaino/config/errors/local_exception.dart';
import 'package:explaino/core/constants/errors_constants.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

const _imageMimeMap = {
  'jpg': 'jpeg',
  'jpeg': 'jpeg',
  'png': 'png',
  'gif': 'gif',
  'webp': 'webp',
  'heic': 'heic',
};

const _videoMimeMap = {
  'mp4': 'mp4',
  'mov': 'quicktime',
  'avi': 'x-msvideo',
  'mkv': 'x-matroska',
  'webm': 'webm',
};

const _docMimeMap = {
  'pdf': ('application', 'pdf'),
  'doc': ('application', 'msword'),
  'docx': (
    'application',
    'vnd.openxmlformats-officedocument.wordprocessingml.document',
  ),
  'xls': ('application', 'vnd.ms-excel'),
  'xlsx': (
    'application',
    'vnd.openxmlformats-officedocument.spreadsheetml.sheet',
  ),
  'ppt': ('application', 'vnd.ms-powerpoint'),
  'pptx': (
    'application',
    'vnd.openxmlformats-officedocument.presentationml.presentation',
  ),
  'txt': ('text', 'plain'),
};

Future<MultipartFile> toMultipartFile(File file) async {
  final ext = _extension(file);

  if (_imageMimeMap.containsKey(ext)) return _imageMultipart(file, ext);
  if (_videoMimeMap.containsKey(ext)) return _videoMultipart(file, ext);
  if (_docMimeMap.containsKey(ext)) return _docMultipart(file, ext);

  throw FileException(ErrorsConstant.unsupportedFileType);
}

Future<MultipartFile> _imageMultipart(File file, String ext) async {
  final compressedFile = await _compressImage(file);
  final targetFile = compressedFile ?? file;

  await _assertMaxSize(targetFile, 4 * 1024 * 1024); // 4 MB

  return MultipartFile.fromFile(
    targetFile.path,
    filename: _filename(targetFile),
    contentType: MediaType('image', _imageMimeMap[ext]!),
  );
}

Future<MultipartFile> _videoMultipart(File file, String ext) async {
  await _assertMaxSize(file, 100 * 1024 * 1024); // 100 MB

  return MultipartFile.fromFile(
    file.path,
    filename: _filename(file),
    contentType: MediaType('video', _videoMimeMap[ext]!),
  );
}

Future<MultipartFile> _docMultipart(File file, String ext) async {
  await _assertMaxSize(file, 20 * 1024 * 1024); // 20 MB

  final mime = _docMimeMap[ext]!;

  return MultipartFile.fromFile(
    file.path,
    filename: _filename(file),
    contentType: MediaType(mime.$1, mime.$2),
  );
}

Future<File?> _compressImage(File file) async {
  try {
    final dir = await getTemporaryDirectory();
    final ext = path.extension(file.path).toLowerCase();
    final targetPath = path.join(
      dir.path,
      '${DateTime.now().millisecondsSinceEpoch}$ext',
    );

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 75,
      minWidth: 1024,
      minHeight: 1024,
    );

    return result != null ? File(result.path) : null;
  } catch (_) {
    return null;
  }
}

Future<void> _assertMaxSize(File file, int maxBytes) async {
  if (await file.length() > maxBytes) {
    throw FileException(ErrorsConstant.fileIsTooLarge);
  }
}

String _extension(File file) =>
    path.extension(file.path).replaceFirst('.', '').toLowerCase();

String _filename(File file) => path.basename(file.path);
