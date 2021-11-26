import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/components/navbar/navigation-menu.dart';
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
  List<Audio> audios = [
    Audio('PodCast #1', 'Flutter', '3:04'),
    Audio('PodCast #2', 'React Native', '3:04'),
    Audio('PodCast #3', 'Front end', '3:04'),
    Audio('PodCast #4', 'C#', '3:04'),
    Audio('PodCast #5', 'Xamarin Forms', '3:04'),
    Audio('PodCast #6', 'Flutter', '3:04'),
    Audio('PodCast #1', 'Flutter', '3:04'),
    Audio('PodCast #2', 'React Native', '3:04'),
    Audio('PodCast #3', 'Front end', '3:04'),
    Audio('PodCast #4', 'C#', '3:04'),
    Audio('PodCast #5', 'Xamarin Forms', '3:04'),
    Audio('PodCast #6', 'Flutter', '3:04'),
    Audio('PodCast #1', 'Flutter', '3:04'),
    Audio('PodCast #2', 'React Native', '3:04'),
    Audio('PodCast #3', 'Front end', '3:04'),
    Audio('PodCast #4', 'C#', '3:04'),
    Audio('PodCast #5', 'Xamarin Forms', '3:04'),
    Audio('PodCast #6', 'Flutter', '3:04'),
  ];
  late List<Audio> filteredAudios;
  TextEditingController editingController = TextEditingController();

  @override
  Future<void> initState() async {
    super.initState();
    filteredAudios = audios;
  }

  void filterAudios(String query) {
    List<Audio> _listAux = [];
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
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: const Text('Pesquisar'),
        ),
        body: SingleChildScrollView(
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
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
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
                            child: ListView.builder(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: filteredAudios.length,
                              itemBuilder: (context, index) {
                                return FlatButton(
                                  onPressed: () {
                                  },
                                  child: ListTile(
                                    title: Text(
                                      filteredAudios[index].title,
                                      style: const TextStyle(
                                          color: Colors.deepPurple, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(filteredAudios[index].author),
                                    trailing: Text(
                                      filteredAudios[index].duration,
                                      style: const TextStyle(color: Colors.deepPurple),
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavigationMenu(),
    );
  }
}
