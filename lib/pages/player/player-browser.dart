import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/components/audio-player/player.dart';
import 'package:podfy/components/layout/layout.dart';
import 'package:podfy/components/navbar/navigation-menu.dart';
import 'package:provider/provider.dart';

class PlayerBrowser extends StatefulWidget {
  PlayerBrowser({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayerBrowserState();
}

class _PlayerBrowserState extends State<PlayerBrowser> {
  _PlayerBrowserState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(titulo: "Áudio", child: Player());
  }
}
