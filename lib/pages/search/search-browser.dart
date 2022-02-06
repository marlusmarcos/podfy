import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/blocs/navigation-bloc.dart';
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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      podcastService = Provider.of<PodcastService>(context, listen: false);
      podcastService.listarTodos();
    });
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
                    podcastService.filterAudios(value);
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
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(top: 20.0),
                  width: MediaQuery.of(context).size.width,
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior(),
                    child: Consumer<PodcastService>(
                        builder: (context, value, child) {
                      if (value.podcasts != null) {
                        final pods = value.filteredAudios;
                        return ListView.builder(
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: pods.length,
                          itemBuilder: (context, index) {
                            final podcast = pods[index];
                            return FlatButton(
                              onPressed: () {
                                context.read<PodcastService>().podcastAtual =
                                    podcast;
                                context
                                    .read<NavigationBloc>()
                                    .aoNavegar(2, context);
                              },
                              child: ListTile(
                                title: Text(
                                  podcast.titulo,
                                  style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(podcast.autor),
                                trailing: Text(
                                  '${Duration(seconds: podcast.duracao).inMinutes.toString()}m',
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
