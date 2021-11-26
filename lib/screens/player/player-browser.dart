import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/components/audio-player/player.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        //FIXME: Exibir titulo do áudio que está tocando
        title: Text('Audio'),
      ),
      body: Center(child: Player()),
      bottomNavigationBar: NavigationMenu(),
    );
  }
}
