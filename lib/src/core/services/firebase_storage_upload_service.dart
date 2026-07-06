import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageUploadService {
  FirebaseStorageUploadService._();

  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadImageFile({
    required String filePath,
    required String folder,
    String? ownerId,
  }) async {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('Selected image does not exist');
    }

    final ext = _safeExtension(file.path);
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final owner = (ownerId == null || ownerId.trim().isEmpty)
        ? 'anonymous'
        : ownerId.trim();
    final objectPath = '$folder/$owner/$timestamp$ext';
    final ref = _storage.ref(objectPath);
    await ref.putFile(file, SettableMetadata(contentType: _contentType(ext)));
    return ref.getDownloadURL();
  }

  static String _safeExtension(String path) {
    final dot = path.lastIndexOf('.');
    if (dot < 0 || dot == path.length - 1) return '.jpg';
    final ext = path.substring(dot).toLowerCase();
    const allowed = {'.jpg', '.jpeg', '.png', '.webp', '.gif'};
    return allowed.contains(ext) ? ext : '.jpg';
  }

  static String _contentType(String ext) {
    switch (ext) {
      case '.png':
        return 'image/png';
      case '.webp':
        return 'image/webp';
      case '.gif':
        return 'image/gif';
      case '.jpeg':
      case '.jpg':
      default:
        return 'image/jpeg';
    }
  }
}
