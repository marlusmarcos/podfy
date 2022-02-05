import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:podfy/data/models/podcast.dart';

class Player extends StatefulWidget {
  final Podcast? podcast;

  Player({Key? key, this.podcast}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlayerState();
}

class PlayerState extends State<Player> {
  late Permission permission;
  late PermissionStatus _permissionStatus;
  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;
  int audioCurrentDuration = 0;
  int audioTotalDuration = 300;
  late StreamSubscription<Duration> audioController;

  @override
  void initState() {
    super.initState();
    
    audioController = audioPlayer.onAudioPositionChanged.listen((Duration  p) {
      setState(() => audioCurrentDuration = p.inSeconds);
    });
  }

  stop() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
      audioCurrentDuration = 0;
    });
  }

  resume() async {
    stop();
    play();
  }

  pause() async {
    int result = await audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  play() async {
    int result = widget.podcast != null ? await audioPlayer.play(widget.podcast!.link) : 0;
    if (result == 1) {
      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    if (isPlaying) stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.podcast == null ? Text('Nenhum podcast tocando no momento') : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(widget.podcast!.titulo, style: TextStyle(fontSize: 24),),
        Container(
          margin: const EdgeInsets.all(20),
          height: 300,
          width: 300,
          color: Colors.grey,
          child: Image.network(widget.podcast!.imagem),
        ),
        Stack(
          children: [
            Container(
              height: 5,
              width: double.parse(audioTotalDuration.toString()),
              color: Colors.grey[300],
            ),
            Container(
              height: 5,
              width: double.parse(audioCurrentDuration.toString()),
              color: Colors.deepPurple
            )
          ],
        ),        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                child: IconButton(
                  icon: const Icon(Icons.refresh, size: 34,),
                  color: Colors.deepPurple,
                  iconSize: 70,
                  onPressed: () {
                    resume();
                  },
                ),
              ),
              InkWell(
                child: IconButton(
                  icon: isPlaying ? const Icon(Icons.pause_circle_filled) : const Icon(Icons.play_circle_filled),
                  color: Colors.deepPurple,
                  iconSize: 70,
                  onPressed: () {
                    isPlaying ? pause() : play();
                  },
                ),
              ),
               InkWell(
                child: IconButton(
                  icon: const Icon(Icons.stop, size: 34,),
                  color: Colors.deepPurple,
                  iconSize: 70,
                  onPressed: () {
                    stop();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
