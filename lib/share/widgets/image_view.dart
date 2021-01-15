import 'dart:math';
import 'package:flutter/material.dart';
import 'package:petland/share/widgets/spin_loader.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewNetwork extends StatelessWidget {
  final String url;
  final String tag;
  final int w, h;
  ImageViewNetwork({@required this.url, this.tag, this.w, this.h});
  @override
  Widget build(BuildContext context) {
    String genTag = tag ?? url + Random().nextInt(10000000).toString();
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return DetailImageScreen(
            url,
            tag: genTag,
            scaleW: w,
            scaleH: h,
          );
        }));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => SizedBox.shrink(),
          loadingBuilder: kLoadingBuilder,
        ),
      ),
    );
  }
}

class DetailImageScreen extends StatelessWidget {
  final String url;
  final String tag;
  final int scaleW, scaleH;
  DetailImageScreen(this.url, {this.tag, this.scaleW, this.scaleH});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(fit: StackFit.expand, children: [
          Center(
            child: PhotoView(
              backgroundDecoration: BoxDecoration(color: Colors.black87),
              imageProvider: NetworkImage(
                url,
              ),
              errorBuilder: (_, __, ___) => SizedBox.shrink(),
              loadingBuilder: (context, event) => PhotoView(
                backgroundDecoration: BoxDecoration(color: Colors.black87),
                imageProvider: NetworkImage(
                  url,
                ),
                loadingBuilder: (context, event) => Center(
                  child: kLoadingSpinner,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: InkWell(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20)),
                width: 40,
                height: 40,
                child: Icon(Icons.close),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
