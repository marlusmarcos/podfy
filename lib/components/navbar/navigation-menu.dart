import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/blocs/navigation-bloc.dart';
import 'package:podfy/pages/home/home.dart';
import 'package:podfy/pages/player/player-browser.dart';
import 'package:podfy/pages/profile/profile-browser.dart';
import 'package:podfy/pages/search/search-browser.dart';
import 'package:provider/provider.dart';

class NavigationMenu extends StatefulWidget {
  NavigationMenu({Key? key}) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _index = context.watch<NavigationBloc>().selectedIndex;

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Pesquisar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note),
          label: 'Audio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _index,
      onTap: (index) {
        context.read<NavigationBloc>().aoNavegar(index, context);
      },
      selectedItemColor: Colors.deepPurpleAccent,
    );
  }
}
