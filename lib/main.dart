import 'package:fim_guinee/pages/fmPage.dart';
import 'pages/teamPage.dart';
import 'package:flutter/material.dart';
import 'package:fim_guinee/navy_bar.dart';
import 'package:fim_guinee/pages/videoPlayer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fim Guinée',
      theme: ThemeData(
        primaryColor: Colors.orange[900],
        accentColor: Colors.orange[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VideoApp(),
      // home: TeamPage(),
      // home: NavyBarPage(),
    );
  }
}