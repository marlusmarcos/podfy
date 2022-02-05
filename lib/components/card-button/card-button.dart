
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/blocs/navigation-bloc.dart';
import 'package:podfy/data/models/podcast.dart';
import 'package:podfy/data/services/podcast_service.dart';
import 'package:podfy/pages/player/player-browser.dart';
import 'package:provider/src/provider.dart';

class CardButton extends StatelessWidget {
  Podcast item;

  CardButton({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        child: InkWell(
          splashColor: Colors.deepPurple.withAlpha(30),
          child: Container(
              width: 170,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Image.network(item.imagem)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.titulo,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        Text(
                          item.subtitulo,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.deepPurple),
                        )
                      ],
                    ),
                  )
                ],
              )),
          onTap: () {
              context.read<PodcastService>().podcastAtual = item;
              context.read<NavigationBloc>().aoNavegar(2, context);
          },
        ),
      ),
    );
  }
}
