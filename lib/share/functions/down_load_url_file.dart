import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' show get;
import 'dart:io';

Future<File> downLoadUrlFile(String url) async {
    //comment out the next two lines to prevent the device from getting
    // the image from the web in order to prove that the picture is 
    // coming from the device instead of the web.
    var response = await get(url); // <--2
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/images";
    var filePathAndName = documentDirectory.path + '/images/pic.jpg'; 
    //comment out the next three lines to prevent the image from being saved
    //to the device to show that it's coming from the internet
    await Directory(firstPath).create(recursive: true); // <-- 1
    File file = new File(filePathAndName);             // <-- 2
    file.writeAsBytesSync(response.bodyBytes);         // <-- 3
    return file;
  }