import 'dart:io';
import 'dart:typed_data';
import 'package:imgur/imgur.dart' as imgur;
import 'package:path_provider/path_provider.dart';

class ImageUtil {
  static Future<String> upload(File file) async {
    try {
      final client = imgur.Imgur(imgur.Authentication.fromClientId('d4de8224fa0042f'));

      /// Upload an image from path
      imgur.Image image =
          await client.image.uploadImage(imagePath: file.path, title: 'A title', description: 'A description');
      // print(image.link);
      return image.link;
    } catch (e) {
      throw Exception("Upload ảnh thất bại. Xin kiểm tra lại internet");
    }
  }

  static Future<File> createImageFileFromUint8List(Uint8List bytes) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File("$appDocPath/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
    await file.writeAsBytes(bytes);
    return file;
  }
}
