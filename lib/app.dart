import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:podfy/screens/login/login.dart';
import 'package:provider/provider.dart';

import 'screens/home/home.dart';

init() async {
  runApp(PodSheetsApp());
}

class PodSheetsApp extends StatelessWidget {
  @override
  Widget build(BuildContext mainContext) {
    return MaterialApp(
      title: 'Podfy',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) {
          return Home();
        },
      },
    );
  }
}
