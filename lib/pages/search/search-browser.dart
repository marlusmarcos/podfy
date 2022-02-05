import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/components/layout/layout.dart';
import 'package:podfy/components/navbar/navigation-menu.dart';
import 'package:podfy/data/models/podcast.dart';
import 'package:podfy/data/services/podcast_service.dart';
import 'package:provider/provider.dart';

class Audio {
  String title;
  String author;
  String duration;

  Audio(this.title, this.author, this.duration);
}

class SearchBrowser extends StatefulWidget {
  const SearchBrowser({Key? key}) : super(key: key);

  @override
  SearchBrowserState createState() => SearchBrowserState();
}

class SearchBrowserState extends State<SearchBrowser> {
  List<Podcast> podcasts = [];
  List<Podcast> filteredAudios = [];
  TextEditingController editingController = TextEditingController();
  late PodcastService podcastService;

  @override
  void initState() {
    super.initState();
    filteredAudios = podcasts;
  }

  void filterAudios(String query) {
    List<Podcast> _listAux = [];
    if (query.isNotEmpty) {
      podcasts.forEach((audio) {
        if (audio.titulo.toLowerCase().contains(query) ||
            audio.autor.toLowerCase().contains(query)) {
          _listAux.add(audio);
        }
      });
      setState(() {
        filteredAudios = _listAux;
      });
    } else {
      setState(() {
        filteredAudios = podcasts;
      });
    }
  }

  Future<List<Podcast>> listar() async {
    setState(() async {
        podcasts = await podcastService.listarTodos();
    filteredAudios = podcasts;
    });
  
    return filteredAudios;
  }

  @override
  Widget build(BuildContext context) {
    podcastService = context.watch<PodcastService>();

    return Layout(
      titulo: "Pesquisar",
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  onChanged: (value) {
                    filterAudios(value);
                  },
                  controller: editingController,
                  decoration: const InputDecoration(
                      hintText: "Pesquisar episódio",
                      fillColor: Colors.deepPurpleAccent,
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ),
              ),
              filteredAudios.isNotEmpty
                  ? Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.only(top: 20.0),
                        width: MediaQuery.of(context).size.width,
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior(),
                          child: FutureBuilder(
                              future: listar(),
                              builder: (context, sn) {
                                if (sn.hasData && sn.data != null) {
                                  return ListView.builder(
                                    physics: const ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: filteredAudios.length,
                                    itemBuilder: (context, index) {
                                      return FlatButton(
                                        onPressed: () {},
                                        child: ListTile(
                                          title: Text(
                                            filteredAudios[index].titulo,
                                            style: const TextStyle(
                                                color: Colors.deepPurple,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle:
                                              Text(filteredAudios[index].autor),
                                          trailing: Text(
                                            filteredAudios[index]
                                                .duracao
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }

                                return Center(child: CircularProgressIndicator(),);
                              }),
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(0),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
