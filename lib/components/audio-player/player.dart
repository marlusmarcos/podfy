import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Player extends StatefulWidget {
  Player({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayerState();
}

class PlayerState extends State<Player> {
  late Permission permission;
  late PermissionStatus _permissionStatus;

  @override
  void initState() {
    Permission.storage.request().then((val){
      setState(() {
        _permissionStatus = val;
      });
      start();
    });
    super.initState();
  }

  start() => AudioService.start(backgroundTaskEntrypoint: _backgroundTaskEntrypoint);

  stop() => AudioService.stop();

  play() => AudioService.play();

  pause() => AudioService.pause();

  static _backgroundTaskEntrypoint() {
    AudioServiceBackground.run(() => AudioPlayerTask());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          height: 300,
          width: 300,
          color: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: IconButton(
                icon: Icon(Icons.arrow_left),
                color: Colors.deepPurple,
                iconSize: 70,
                onPressed: () {},
              ),
            ),
            InkWell(
              child: IconButton(
                icon: Icon(Icons.play_circle_filled),
                color: Colors.deepPurple,
                iconSize: 70,
                onPressed: () {
                  play();
                },
              ),
            ),
            InkWell(
              child: IconButton(
                icon: Icon(Icons.arrow_right),
                color: Colors.deepPurple,
                iconSize: 70,
                onPressed: () {},
              ),
            ),
          ],
        )
      ],
    );
  }
}

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();
  final _completer = Completer();

//  @override
//  Future<void> onStart() async {
//    await _completer.future;
//  }
//
//  @override
//  void onPlay() async {
//    String localPath = "/storage/emulated/0/Download/music-test.mp3";
//    print("oi");
//    int result = await _audioPlayer.play(localPath, isLocal: true);
//    if (result == 1) {
//      print("Tocou");
//    }
//    AudioServiceBackground.setState(basicState: BasicPlaybackState.playing);
//  }
//
//  @override
//  void onStop() {
//    _audioPlayer.stop();
//    _completer.complete();
//  }
}
