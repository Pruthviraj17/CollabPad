import 'dart:convert';
import 'dart:typed_data';

class ImageUtils {
  // Encode image to Base64 string
  static Future<String> encodeImage(Uint8List? imageBytes) async {
    if (imageBytes == null) {
      throw ArgumentError('Image bytes cannot be null');
    }
    return base64Encode(imageBytes);
  }

  // Decode Base64 string to image bytes
  static Uint8List? decodeImage(String base64String) {
    if (base64String.isEmpty) {
      return null;
    }
    return base64Decode(base64String);
  }
}
