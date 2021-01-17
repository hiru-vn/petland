import 'dart:io';
import 'dart:typed_data';
import 'package:imgur/imgur.dart' as imgur;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';

enum FileType { document, image, video, gif }

class FileUtil {
  static FileType getFileType(String path) {
    if (path == null) return null;
    final mimeType = lookupMimeType(path);
    if (mimeType == null) return null;
    if (mimeType.startsWith('image/')) return FileType.image;
    if (mimeType.startsWith('video/')) return FileType.video;
    if (mimeType.startsWith('application/msword')) return FileType.document;
    return null;
  }

  static FileType getFbUrlFileType(String path) {
    if (path == null) return null;

    if (path.contains('.png') ||
        path.contains('.jpg') ||
        path.contains('.img') ||
        path.contains('.jpeg') ||
        path.contains('.webp')) return FileType.image;
    if (path.contains('.mp4') || path.contains('.wmv')) return FileType.video;
    if (path.contains('.doc')) return FileType.document;
    if (path.contains('.gif')) return FileType.gif;
    return null;
  }

  static Future<String> uploadImgur(File file) async {
    try {
      final client =
          imgur.Imgur(imgur.Authentication.fromClientId('d4de8224fa0042f'));

      /// Upload an image from path
      imgur.Image image = await client.image.uploadImage(
          imagePath: file.path, title: 'A title', description: 'A description');
      // print(image.link);
      return image.link;
    } catch (e) {
      throw Exception("Upload ảnh thất bại. Xin kiểm tra lại internet");
    }
  }

  static Future<String> uploadFireStorage(File file, { String path}) async {
    if (file == null) return '';
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('${path ?? 'root'}/${Path.basename(file.path)}');
      UploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.whenComplete(() {});
      print('File Uploaded');
      final fileURL = await storageReference.getDownloadURL();
      return fileURL;
    } catch (e) {
      throw Exception("Upload file thất bại. Xin kiểm tra lại internet");
    }
  }

  static Future<File> createImageFileFromUint8List(Uint8List bytes) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File("$appDocPath/" +
        DateTime.now().millisecondsSinceEpoch.toString() +
        ".png");
    await file.writeAsBytes(bytes);
    return file;
  }
}
