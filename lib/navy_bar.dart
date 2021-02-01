import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fim_guinee/pages/fmPage.dart';
import 'package:fim_guinee/pages/newsPage.dart';
import 'package:fim_guinee/pages/podCastPage.dart';
import 'package:fim_guinee/pages/teamPage.dart';
import 'package:fim_guinee/pages/tvPage.dart';
import 'package:flutter/material.dart';

class NavyBarPage extends StatefulWidget {
  @override
  _NavyBarPageState createState() => _NavyBarPageState();
}

class _NavyBarPageState extends State<NavyBarPage> {
  int currentIndex = 0;

  Widget changePages(){
    switch (currentIndex) {
      case 0:
        return FmPage();
        break;
        case 1:
        return TvPage();
        break;
        case 2:
        return NewsPage();
        break;
        case 3:
        return PodCastPage();
        break;
        case 4:
        return TeamPage();
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: changePages(),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: currentIndex == 0 ?
          Colors.orange[900] : currentIndex == 1 ? Colors.orange[700] : currentIndex == 2 ? Colors.orange[900] : currentIndex == 3 ? Colors.orange[700] : currentIndex == 4 ? Colors.orange[900] : Colors.orange[700] ,
          selectedIndex: currentIndex,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) => setState(() {
            currentIndex = index;
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.radio),
              title: Text(
                'FIM FM',
              ),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.tv),
              title: Text(
                'FIM 24',
              ),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.event_note),
              title: Text(
                'Les actus',
              ),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.speaker),
              title: Text(
                'Podcast',
              ),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text(
                'La team',
              ),
              activeColor: Colors.white,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
