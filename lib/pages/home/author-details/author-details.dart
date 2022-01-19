import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/components/navbar/navigation-menu.dart';
import 'package:podfy/data/models/author.dart';
import 'package:podfy/data/models/podcast.dart';


class AuthorDetails extends StatefulWidget {
  final Author author;

  const AuthorDetails({Key? key, required this.author}) : super(key: key);

  @override
  AuthorDetailsState createState() => AuthorDetailsState();
}

class AuthorDetailsState extends State<AuthorDetails> {
  List<Podcast> Podcasts = [
  ];
  late List<Podcast> filteredPodcasts;
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredPodcasts = Podcasts;
  }

  void filterPodcasts(String query) {
    List<Podcast> _listAux = <Podcast>[];
    if (query.isNotEmpty) {
      Podcasts.forEach((Podcast) {
        if (Podcast.titulo.toLowerCase().contains(query) ||
            Podcast.autor.toLowerCase().contains(query)) {
          _listAux.add(Podcast);
        }
      });
      setState(() {
        filteredPodcasts = _listAux;
      });
    } else {
      setState(() {
        filteredPodcasts = Podcasts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          backgroundColor: Colors.deepPurple,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(widget.author.name),
            background: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  image: NetworkImage(
                    "https://picsum.photos/id/${widget.author.id}/400",
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                widget.author.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Episódios',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                onChanged: (value) {
                  filterPodcasts(value);
                },
                controller: editingController,
                decoration: const InputDecoration(
                    hintText: "Pesquisar episódio",
                    fillColor: Colors.deepPurpleAccent,
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
            filteredPodcasts.isNotEmpty
                ? Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior(),
                        child: ListView.builder(
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: filteredPodcasts.length,
                          itemBuilder: (context, index) {
                            return FlatButton(
                              onPressed: () {},
                              child: ListTile(
                                title: Text(
                                  filteredPodcasts[index].titulo,
                                  style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(filteredPodcasts[index].autor),
                                trailing: Text(
                                  filteredPodcasts[index].duracao,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(0),
                  ),
          ]),
        )
      ]),
      bottomNavigationBar: NavigationMenu(),
    );
  }
}
