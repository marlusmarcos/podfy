import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/components/audio-player/player.dart';
import 'package:podfy/components/layout/layout.dart';
import 'package:podfy/components/navbar/navigation-menu.dart';
import 'package:podfy/data/services/podcast_service.dart';
import 'package:provider/provider.dart';

class PlayerBrowser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Layout(titulo: "Áudio", child: Player(podcast: context.watch<PodcastService>().podcastAtual));
  }
}
