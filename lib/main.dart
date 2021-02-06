import 'package:fim_guinee/pages/fmPage.dart';
import 'package:fim_guinee/src/onboarding.dart';
import 'package:fim_guinee/src/wrapper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'pages/teamPage.dart';
import 'package:flutter/material.dart';
import 'package:fim_guinee/navy_bar.dart';
import 'package:fim_guinee/pages/liveStream.dart';
import 'package:fim_guinee/src/youtubePlayer.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fim Guinée',
      theme: ThemeData(
        primaryColor: Colors.orange[900],
        accentColor: Colors.orange[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: TeamPage(),
      // home: NavyBarPage(),
      home: MyWrapper(),
      // home: OnBoardingPage(),
      // home: FmLiveStream(),
      // home: FmPage(),
    );
  }
}
