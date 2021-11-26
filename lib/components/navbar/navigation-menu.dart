import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/models/nav/nav_item.dart';
import 'package:podfy/models/nav/tab_navigator_routes.dart';
import 'package:podfy/screens/home/home.dart';
import 'package:podfy/screens/player/player-browser.dart';
import 'package:podfy/screens/profile/profile-browser.dart';
import 'package:podfy/screens/search/search-browser.dart';
import 'package:provider/provider.dart';

class NavigationMenu extends StatelessWidget {
  NavigationMenu({Key? key}) : super(key: key);

  final List<NavItem> _navItens = [
    NavItem('/home', 0),
    NavItem('/search', 1),
    NavItem('/player', 2),
    NavItem('/profile', 3),
  ];
  int selectedIndex = 0;


  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.home: (context) => Home(),
      TabNavigatorRoutes.search: (context) => SearchBrowser(),
      TabNavigatorRoutes.player: (context) => PlayerBrowser(),
      TabNavigatorRoutes.profile: (context) => ProfileBrowser(),
    };
  }

  @override
  Widget build(BuildContext context) {
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
      currentIndex: selectedIndex,
      onTap: (index) {
      },
      selectedItemColor: Colors.deepPurpleAccent,
    );
  }
}
