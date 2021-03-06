import 'package:fim_guinee/pages/fmPage.dart';
import 'package:fim_guinee/pages/splashScreen.dart';
import 'package:fim_guinee/src/api_files/provider/fimProvider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
      create:(_)  => FimProvider(),
          child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(
            color: Color(0xFFF5F5F5),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Fim Guinée',
        theme: ThemeData(
          primaryColor: Colors.orange[900],
          accentColor: Colors.orange[700],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: FmPage(),
        home: SplashScreen(),
      ),
    );
  }
}
