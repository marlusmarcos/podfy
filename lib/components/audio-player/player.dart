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
  bool isLoading = false;
  Duration audioCurrentDuration = Duration(seconds: 0);
  late StreamSubscription<Duration> audioController;
  late double fatorLargura;

  @override
  void initState() {
    super.initState();
    fatorLargura = widget.podcast != null ? 300 / widget.podcast!.duracao : 1;
    audioController = audioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        audioCurrentDuration = p;
        isLoading = false;
      });
    });
  }

  stop() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
      audioCurrentDuration = Duration(seconds: 0);
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
    setState(() {
      isLoading = true;
    });
    int result = widget.podcast != null
        ? await audioPlayer.play(widget.podcast!.link)
        : 0;
    if (result == 1) {
      setState(() {
        isPlaying = true;
      });
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    if (isPlaying) stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.podcast == null
        ? const Text('Nenhum podcast tocando no momento')
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.podcast!.titulo,
                style: const TextStyle(fontSize: 24),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                height: 300,
                width: 300,
                color: Colors.grey,
                child: Image.network(widget.podcast!.imagem),
              ),
              Container(
                width: 300,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 5,
                          width: 300,
                          color: Colors.grey[300],
                        ),
                        Container(
                            height: 5,
                            width: audioCurrentDuration.inMilliseconds > 0
                                ? (double.parse(audioCurrentDuration.inSeconds
                                        .toString()) *
                                    fatorLargura)
                                : 0,
                            color: Colors.deepPurple),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_printDuration(audioCurrentDuration),
                            style: const TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold)),
                        Text(
                            '${Duration(seconds: widget.podcast?.duracao ?? 0).inMinutes.toString()}m',
                            style: const TextStyle(color: Colors.deepPurple))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: IconButton(
                        icon: const Icon(
                          Icons.refresh,
                          size: 34,
                        ),
                        color: Colors.deepPurple,
                        iconSize: 70,
                        onPressed: () {
                          resume();
                        },
                      ),
                    ),
                    InkWell(
                      child: !isLoading
                          ? IconButton(
                              icon: isPlaying
                                  ? const Icon(Icons.pause_circle_filled)
                                  : const Icon(Icons.play_circle_filled),
                              color: Colors.deepPurple,
                              iconSize: 70,
                              onPressed: () {
                                isPlaying ? pause() : play();
                              },
                            )
                          : const CircularProgressIndicator(
                              color: Colors.deepPurple,
                            ),
                    ),
                    InkWell(
                      child: IconButton(
                        icon: const Icon(
                          Icons.info_outline,
                          size: 34,
                        ),
                        color: Colors.deepPurple,
                        iconSize: 60,
                        onPressed: () {}
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
