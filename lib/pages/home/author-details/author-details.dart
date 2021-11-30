import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/components/navbar/navigation-menu.dart';
import 'package:podfy/models/user/author.dart';

class Audio {
  String title;
  String author;
  String duration;

  Audio(this.title, this.author, this.duration);
}

class AuthorDetails extends StatefulWidget {
  final Author author;

  const AuthorDetails({Key? key, required this.author}) : super(key: key);

  @override
  AuthorDetailsState createState() => AuthorDetailsState(this.author);
}

class AuthorDetailsState extends State<AuthorDetails> {
  List<Audio> audios = [
    Audio('Episódio #1', 'Flutter', '3:04'),
    Audio('Episódio #2', 'React Native', '3:04'),
    Audio('Episódio #3', 'Front end', '3:04'),
    Audio('Episódio #4', 'C#', '3:04'),
    Audio('Episódio #5', 'Xamarin Forms', '3:04'),
    Audio('Episódio #6', 'Flutter', '3:04'),
  ];
  late List<Audio> filteredAudios;
  TextEditingController editingController = TextEditingController();
  late Author author;

  AuthorDetailsState(Author author);

  @override
  Future<void> initState() async {
    super.initState();
    filteredAudios = audios;
  }

  void filterAudios(String query) {
    List<Audio> _listAux = <Audio>[];
    if (query.isNotEmpty) {
      audios.forEach((audio) {
        if (audio.title.toLowerCase().contains(query) ||
            audio.author.toLowerCase().contains(query)) {
          _listAux.add(audio);
        }
      });
      setState(() {
        filteredAudios = _listAux;
      });
    } else {
      setState(() {
        filteredAudios = audios;
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
            title: Text(author.name),
            background: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  image: NetworkImage(
                    "https://picsum.photos/id/${author.id}/400",
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
                author.description,
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
                  filterAudios(value);
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
            filteredAudios.isNotEmpty
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
                          itemCount: filteredAudios.length,
                          itemBuilder: (context, index) {
                            return FlatButton(
                              onPressed: () {},
                              child: ListTile(
                                title: Text(
                                  filteredAudios[index].title,
                                  style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(filteredAudios[index].author),
                                trailing: Text(
                                  filteredAudios[index].duration,
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
