import 'package:flutter/material.dart';
import 'package:podfy/components/navbar/navigation-menu.dart';

class ProfileBrowser extends StatelessWidget {
  ProfileBrowser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: const Text('Conta'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 500,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ClipOval(
                            child: Image.network(
                              "https://picsum.photos/200/300",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 24),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: Text(
                            'email@gmail.com',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          width: 300,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  bottomRight: Radius.circular(40.0))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                            child: Text("Torne-se um autor",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.star),
                                title: const Text('Favoritos'),
                                onTap: () {},
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.lock),
                                title: const Text('Alterar senha'),
                                onTap: () {},
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(
                                  Icons.exit_to_app,
                                  color: Colors.deepPurple,
                                ),
                                title: const Text(
                                  'Sair',
                                  style: TextStyle(
                                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                                ),
                                onTap: () async {
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
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
