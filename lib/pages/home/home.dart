import 'package:flutter/material.dart';
import 'package:podfy/components/card-button/card-button.dart';
import 'package:podfy/components/navbar/navigation-menu.dart';
import 'package:podfy/models/user/author.dart';
import 'package:provider/provider.dart';

import 'author-details/author-details.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CardItem> cards = [
      CardItem('Episódio #3', 'DevCast', 'imagePath', () {}),
      CardItem('Episódio #1', '4DevsCast', 'imagePath', () {}),
      CardItem('Episódio #1', 'PyGirls', 'imagePath', () {}),
      CardItem('Episódio #4', 'DevCast', 'imagePath', () {}),
      CardItem('Episódio #5', 'DevCast', 'imagePath', () {}),
      CardItem('Episódio #6', 'DevCast', 'imagePath', () {}),
    ];
    final List<Author> authors = [
      Author('DevCast', 'Um podcast para desenvolvedores', 1),
      Author('4DevsCast', 'Feito por devs para devs', 2),
      Author('Flow Podcast', '', 4),
      Author('Meu Podcast', '', 5),
      Author('Podcast XX', '', 6),
      Author('Podcast XXX', '', 7),
      Author('Podcast IV', '', 8),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Início'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Text(
                  'Olá,!',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
              ),
              Container(
                  height: 215,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          'Episódios recentes',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: cards.map((card) {
                              return CardButton(
                                item: card,
                              );
                            }).toList()),
                      ),
                    ],
                  )),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        'PodCasts',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      children: authors.map((author) {
                        return Container(
                            color: Colors.deepPurple,
                            margin: const EdgeInsets.only(right: 5, bottom: 5),
                            child: InkWell(
                              onTap: () {
                              },
                              splashColor: Colors.white,
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.3),
                                        BlendMode.dstATop),
                                    image: NetworkImage(
                                      "https://picsum.photos/id/${author.id}/400",
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    author.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ));
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationMenu(),
    );
  }
}
