import 'dart:math';
import 'package:flutter/material.dart';
import 'package:petland/share/import.dart';
import 'package:petland/share/widgets/spin_loader.dart';
import 'package:video_player/video_player.dart';

class VideoViewNetwork extends StatelessWidget {
  final String url;
  final String tag;
  final int w, h;
  VideoViewNetwork({@required this.url, this.tag, this.w, this.h});
  @override
  Widget build(BuildContext context) {
    String genTag = tag ?? url + Random().nextInt(10000000).toString();
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return DetailVideoScreen(
            url,
            tag: genTag,
            scaleW: w,
            scaleH: h,
          );
        }));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/image/video_holder.png',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => SizedBox.shrink(),
        ),
      ),
    );
  }
}

class DetailVideoScreen extends StatefulWidget {
  final String url;
  final String tag;
  final int scaleW, scaleH;
  DetailVideoScreen(this.url, {this.tag, this.scaleW, this.scaleH});

  @override
  _DetailVideoScreenState createState() => _DetailVideoScreenState();
}

class _DetailVideoScreenState extends State<DetailVideoScreen> {
  VideoPlayerController _controller;
  bool videoEnded = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then(
        (_) {
          if (mounted)
            setState(() {
              _controller.play();
            });
        },
      );
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          videoEnded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(fit: StackFit.expand, children: [
          Positioned(
            width: deviceWidth(context),
            top: kToolbarHeight,
            bottom: 0,
            child: Container(
              child: Center(
                child: _controller.value.initialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : kLoadingSpinner,
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight,
            right: 10,
            child: InkWell(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20)),
                width: 40,
                height: 40,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (videoEnded) {
            await _controller.seekTo(Duration.zero);
            _controller.play();
            setState(() {
              videoEnded = false;
            });
            return;
          }
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          videoEnded
              ? Icons.replay
              : (_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
        ),
      ),
    );
  }
}
