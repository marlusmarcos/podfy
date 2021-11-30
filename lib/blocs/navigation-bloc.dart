import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:podfy/pages/home/home.dart';
import 'package:podfy/pages/player/player-browser.dart';
import 'package:podfy/pages/profile/profile-browser.dart';
import 'package:podfy/pages/search/search-browser.dart';

class NavigationBloc extends ChangeNotifier {
  int selectedIndex = 0;

  @override
  void aoNavegar(index, context) {
    selectedIndex = index;
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchBrowser()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PlayerBrowser()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileBrowser()),
        );
    }
    notifyListeners();
  }
}