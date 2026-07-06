import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  // Take photo from camera
  static Future<File?> takePhoto({
    double? maxWidth = 1024,
    int imageQuality = 80,
  }) async {
    try {
      // Request camera permission
      final cameraPermission = await _requestCameraPermission();
      if (!cameraPermission) {
        throw Exception('Camera permission denied');
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxWidth,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to take photo: $e');
    }
  }

  // Pick image from gallery
  static Future<File?> pickFromGallery({
    double? maxWidth = 1024,
    int imageQuality = 80,
  }) async {
    try {
      // Request storage permission
      final storagePermission = await _requestStoragePermission();
      if (!storagePermission) {
        throw Exception('Storage permission denied');
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxWidth,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
  }

  // Pick multiple images from gallery
  static Future<List<File>> pickMultipleFromGallery() async {
    try {
      final storagePermission = await _requestStoragePermission();
      if (!storagePermission) {
        throw Exception('Storage permission denied');
      }

      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      return images.map((image) => File(image.path)).toList();
    } catch (e) {
      throw Exception('Failed to pick images: $e');
    }
  }

  // Request camera permission
  static Future<bool> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status == PermissionStatus.granted;
  }

  // Request storage permission
  static Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        // Android 13+ uses different permissions
        final photos = await Permission.photos.request();
        return photos == PermissionStatus.granted;
      } else {
        final storage = await Permission.storage.request();
        return storage == PermissionStatus.granted;
      }
    } else {
      // iOS
      final photos = await Permission.photos.request();
      return photos == PermissionStatus.granted;
    }
  }

  // Check if permissions are granted
  static Future<bool> get isCameraPermissionGranted async {
    return await Permission.camera.isGranted;
  }

  static Future<bool> get isStoragePermissionGranted async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        return await Permission.photos.isGranted;
      } else {
        return await Permission.storage.isGranted;
      }
    } else {
      return await Permission.photos.isGranted;
    }
  }
}
