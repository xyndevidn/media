import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:media/data/models/upload_response.dart';

import '../data/api/api_service.dart';

class UploadProvider extends ChangeNotifier {
  final ApiService apiService;
  bool isUploading = false;
  String message = "";
  UploadResponse? uploadResponse;

  UploadProvider(this.apiService);

  Future<void> upload(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    try {
      message = "";
      uploadResponse = null;
      isUploading = true;
      notifyListeners();
      uploadResponse =
          await apiService.uploadDocument(bytes, fileName, description);
      message = uploadResponse?.message ?? "success";
      isUploading = false;
      notifyListeners();
    } catch (e) {
      isUploading = false;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    Uint8List assign = Uint8List.fromList(bytes);

    final img.Image image = img.decodeImage(assign)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      ///
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }
}
