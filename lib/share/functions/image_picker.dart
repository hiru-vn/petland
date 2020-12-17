import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

// variable to hold image to be displayed

void imagePicker(BuildContext context, Function(String path) onCameraPick,
    Function(String path) onGalleryPick,
    {String title}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      elevation: 0,
      context: context,
      builder: (_) {
        return Material(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: double.infinity,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? 'Chọn ảnh từ điện thoại',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff696969)),
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(height: 1, color: Colors.grey),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    onCustomPersionRequest(
                        permission: Permission.camera,
                        onGranted: () {
                          // close showModalBottomSheet
                          Navigator.of(context).pop();
                          ImagePicker()
                              .getImage(source: ImageSource.camera)
                              .then((value) {
                            onGalleryPick(value.path);
                          });
                        });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        color: Color(0xff696969),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    onCustomPersionRequest(
                        permission: Permission.photos,
                        onGranted: () {
                          // close showModalBottomSheet
                          Navigator.of(context).pop();

                          ImagePicker()
                              .getImage(source: ImageSource.gallery)
                              .then((value) {
                            onCameraPick(value.path);
                          });
                        });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.apps,
                        color: Color(0xff696969),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Text(
                        'Thư viện',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8), topLeft: Radius.circular(8))),
            padding: EdgeInsets.all(15),
          ),
        );
      });
}

onCustomPersionRequest(
    {@required Permission permission,
    Function onGranted,
    Function onAlreadyDenied,
    Function onJustDeny,
    Function onAndroidPermanentDenied}) {
  permission.status.then((value) {
    if (value.isUndetermined) {
      Permission.camera.request().then((value) {
        if (value.isDenied && onJustDeny != null) {
          onJustDeny();
        } else if (value.isGranted && onGranted != null) {
          onGranted();
        } else if (value.isPermanentlyDenied &&
            onAndroidPermanentDenied != null) {
          onAndroidPermanentDenied();
        }
      });
    } else if (value.isDenied && onAlreadyDenied != null) {
      onAlreadyDenied();
    } else if (value.isGranted && onGranted != null) {
      onGranted();
    }
  });
}
