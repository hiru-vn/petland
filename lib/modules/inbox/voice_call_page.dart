import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petland/navigator.dart';

import 'app_id.dart';
import 'import/page_builder.dart';
import 'inbox_model.dart';
import 'video_call_page.dart';

/// MultiChannel Example
class VoiceCallPage extends StatefulWidget {
  final String groupId;
  final List<FbInboxUserModel> users;

  const VoiceCallPage({Key key, this.groupId, this.users}) : super(key: key);
  static Future navigate(String groupId, List<FbInboxUserModel> users) {
    return navigatorKey.currentState
        .push(pageBuilder(VoiceCallPage(groupId: groupId, users: users)));
  }

  @override
  State<StatefulWidget> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  RtcEngine _engine;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false,
      muted = false;
  static final _users = List<int>();
  final _infoStrings = <String>[];

  @override
  void initState() {
    super.initState();
    this.init();
  }

  @override
  void dispose() {
    // clear users
    _users?.clear();
    // destroy sdk
    _engine?.leaveChannel();
    _engine?.destroy();
    super.dispose();
  }

  init() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings
            .add("APP_ID missing, please provide your APP_ID in settings.dart");
        _infoStrings.add("Agora Engine is not starting");
      });
      return;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone].request();
    }

    await _initAgoraRtcEngine();
    this._addListeners();

    _engine?.joinChannel(null, widget.groupId, null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine?.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        print('joinChannelSuccess $channel $uid $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        print('userJoined  $uid $elapsed');
        setState(() {
          _users.add(uid);
        });
      },
      userOffline: (uid, reason) {
        print('userOffline  $uid $reason');
        setState(() {
          _users.removeWhere((element) => element == uid);
        });
      },
      leaveChannel: (stats) {
        print('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
          _users.clear();
        });
      },
    ));
  }

  _switchMicrophone() {
    _engine?.enableLocalAudio(!openMicrophone)?.then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    })?.catchError((err) {
      log('enableLocalAudio $err');
    });
  }

  _switchSpeakerphone() {
    _engine?.setEnableSpeakerphone(!enableSpeakerphone)?.then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    })?.catchError((err) {
      log('setEnableSpeakerphone $err');
    });
  }

  _switchEffect() async {
    if (playEffect) {
      _engine?.stopEffect(1)?.then((value) {
        setState(() {
          playEffect = false;
        });
      })?.catchError((err) {
        log('stopEffect $err');
      });
    } else {
      _engine
          ?.playEffect(
              1,
              await RtcEngineExtension.getAssetAbsolutePath(
                  "assets/Sound_Horizon.mp3"),
              -1,
              1,
              1,
              100,
              true)
          ?.then((value) {
        setState(() {
          playEffect = true;
        });
      })?.catchError((err) {
        log('playEffect $err');
      });
    }
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    List<Widget> list = [
      Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height:MediaQuery.of(context).size.width / 6,
            child: Image.asset(
              'assets/image/avatar.png',
              fit: BoxFit.cover,
            )),
      ),
    ];
    _users.forEach((int uid) => {
          list.add(Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.width / 6,
                child: Image.asset(
                  'assets/image/avatar.png',
                  fit: BoxFit.cover,
                )),
          ))
        });
    return list;
  }

  /// voice view wrapper
  Widget _voiceView(view) {
    return Expanded(child: Container(child: view));
  }

  /// voice view row wrapper
  Widget _expandedVoiceRow(List<Widget> views) {
    List<Widget> wrappedViews =
        views.map((Widget view) => _voiceView(view)).toList();
    return Expanded(
        child: Row(
      children: wrappedViews,
    ));
  }

  /// Voice layout wrapper
  Widget _viewRows() {
    List<Widget> views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_voiceView(views[0])],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVoiceRow([views[0]]),
            _expandedVoiceRow([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVoiceRow(views.sublist(0, 2)),
            _expandedVoiceRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVoiceRow(views.sublist(0, 2)),
            _expandedVoiceRow(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.symmetric(vertical: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () => _onToggleMute(),
                  child: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                    color: muted ? Colors.blueAccent : Colors.white,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: muted ? Colors.white : Colors.blueAccent,
                  padding: const EdgeInsets.all(12.0),
                ),
                SizedBox(
                  height: 10,
                ),
                RawMaterialButton(
                  onPressed: () => _switchSpeakerphone(),
                  child: Icon(
                    enableSpeakerphone
                        ? Icons.volume_up
                        : Icons.volume_down,
                    color:
                        enableSpeakerphone ? Colors.white : Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor:
                      enableSpeakerphone ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
                SizedBox(
                  height: 10,
                ),
                RawMaterialButton(
                  onPressed: () => navigatorKey.currentState.maybePop(),
                  child: Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.red,
                  padding: const EdgeInsets.all(12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Stack(
          //uncomment _panel for debugging
          children: <Widget>[_viewRows(), _toolbar()],
        )));
  }
}
