// INPUT :
// *********  A LIST OF STRING - IMAGE URL FROM IMGUR

// OUTPUT :
// *********  A FUCNTION THAT HANDLE A LIST OF
// **** CURRENT SELECTED IMAGE URL ****
// WHEN IMAGE URL IS UPLOAD OR REMOVE - IMPLEMENT FROM FATHER WIDGET

import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/image_view.dart';

class ImageRowPicker extends StatefulWidget {
  final List<String> listImg;
  final bool canRemove;
  final Function(List<String>) onUpdateListImg;
  final Function reloadParent;
  final Function(String) onAddImg;
  final Function(String) onRemoveImg;
  ImageRowPicker(this.listImg,
      {this.onUpdateListImg,
      this.canRemove = true,
      this.reloadParent,
      this.onAddImg,
      this.onRemoveImg});
  @override
  _ImageRowPickerState createState() => _ImageRowPickerState();
}

class _ImageRowPickerState extends State<ImageRowPicker>
    with AutomaticKeepAliveClientMixin {
  @override
  get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: (widget.listImg?.length ?? 0) + 1,
      separatorBuilder: (context, index) => SizedBox(width: 10),
      itemBuilder: (context, index) {
        if (index != (widget.listImg?.length ?? 0)) {
          return Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                height: 110,
                width: 110,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ImageViewNetwork(
                          url: widget.listImg[index], w: 100, h: 100),
                    ),
                  ),
                ),
              ),
              if (widget.canRemove)
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      showConfirmDialog(context, 'Xác nhận xóa hình ảnh này?',
                          navigatorKey: navigatorKey, confirmTap: () async {
                        widget.listImg.removeAt(index);
                        setState(() {});
                        //await navigatorKey.currentState.maybePop();
                        if (widget.onRemoveImg != null)
                          widget.onRemoveImg(widget.listImg[index]);
                        if (widget.onUpdateListImg != null)
                          widget.onUpdateListImg(widget.listImg);
                        if (widget.reloadParent != null) widget.reloadParent();
                      });
                    },
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      )),
                    ),
                  ),
                ),
            ],
          );
        }
        if (widget.onUpdateListImg != null)
          return Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () => imagePicker(context, onCameraPick: (str) {
                if (widget.onAddImg != null) widget.onAddImg(str);
              }, onImagePick: (str) {
                if (widget.onAddImg != null) widget.onAddImg(str);
              }, onVideoPick: (str) {
                if (widget.onAddImg != null) widget.onAddImg(str);
              }),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(MdiIcons.plusCircle, size: 75, color: Colors.white),
              ),
            ),
          );
        return Container();
      },
    );
  }

  String loadingImage = 'https://www.bis.org/img/uploading.gif';
}
