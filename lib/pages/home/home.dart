import 'package:flutter/material.dart';
import 'package:podfy/components/card-button/card-button.dart';
import 'package:podfy/components/navbar/navigation-menu.dart';
import 'package:podfy/data/models/author.dart';
import 'package:podfy/data/models/podcast.dart';
import 'package:podfy/data/services/podcast_service.dart';
import 'package:provider/provider.dart';

import 'author-details/author-details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Podcast> podcasts = [];
  List<Author> autores = [];
  late PodcastService podcastService;

  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {

      });
  }

  Future<List<Podcast>> buscarRecentes(){ 
    return podcastService.listar();
  }

  @override
  Widget build(BuildContext context) {
                podcastService = context.watch<PodcastService>();

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
                  'Olá, Fulano!',
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
                        child: FutureBuilder<List<Podcast>>(
                          future: buscarRecentes(),
                          builder: (ctx, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return ListView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: snapshot.data!.toList().map((podcast) {
                                    return CardButton(
                                      item: podcast,
                                    );
                                  }).toList());
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
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
                        'Autores',
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
                      children: autores.map((author) {
                        return Container(
                            color: Colors.deepPurple,
                            margin: const EdgeInsets.only(right: 5, bottom: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AuthorDetails(author: author)),
                                );
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
