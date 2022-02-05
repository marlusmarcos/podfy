import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:podfy/blocs/navigation-bloc.dart';
import 'package:podfy/data/services/auth_service.dart';
import 'package:podfy/pages/home/home.dart';
import 'package:podfy/pages/player/player-browser.dart';
import 'package:podfy/pages/profile/profile-browser.dart';
import 'package:podfy/pages/search/search-browser.dart';
import 'package:podfy/pages/login/login.dart';
import 'package:provider/provider.dart';

import 'core/constants.dart';
import 'data/services/podcast_service.dart';

init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PodSheetsApp());
}

class PodSheetsApp extends StatelessWidget {
  @override
  Widget build(BuildContext mainContext) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationBloc()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => PodcastService(Constants.apiUrl + '/podcasts')),
      ],
      child: MaterialApp(
        title: 'Podfy',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) {
            return Login();
          },
          '/inicio': (context) {
            return Home();
          },
          '/pesquisar': (context) {
            return SearchBrowser();
          },
          '/player': (context) {
            return PlayerBrowser();
          },
          '/perfil': (context) {
            return ProfileBrowser();
          },
        },
      ),
    );
  }
}
