import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

// variable to hold image to be displayed

void imagePicker(BuildContext context,
    {Function(String path) onCameraPick,
    Function(String path) onImagePick,
    Function(String path) onVideoPick,
    String title}) {
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ??
                      'Chọn ảnh ${onVideoPick != null ? 'và video ' : ''}từ điện thoại',
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
                if (onCameraPick != null) ...[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      onCustomPersionRequest(
                          permission: Permission.camera,
                          onGranted: () {
                            // close showModalBottomSheet
                            Navigator.of(context).pop();
                            ImagePicker.pickImage(source: ImageSource.camera)
                                .then((value) {
                              if (value == null) return;
                              onCameraPick(value.path);
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
                ],
                if (onImagePick != null) ...[
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

                            ImagePicker.pickImage(source: ImageSource.gallery)
                                .then((value) {
                              if (value == null) return;
                              onImagePick(value.path);
                            });
                          });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.image,
                          color: Color(0xff696969),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        Text(
                          'Images',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
                if (onVideoPick != null) ...[
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

                            ImagePicker.pickVideo(source: ImageSource.gallery)
                                .then((value) {
                              if (value == null) return;
                              onVideoPick(value.path);
                            });
                          });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.video_collection,
                          color: Color(0xff696969),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        Text(
                          'Videos',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
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
