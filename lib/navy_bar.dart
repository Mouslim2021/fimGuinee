import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fim_guinee/src/api_files/provider/views/newsProvider.dart';
import 'pages/fmPage.dart';
import 'pages/newsPage.dart';
import 'pages/teamPage.dart';
import 'pages/tvPage.dart';
import 'package:flutter/material.dart';

class NavyBarPage extends StatefulWidget {
  @override
  _NavyBarPageState createState() => _NavyBarPageState();
}

class _NavyBarPageState extends State<NavyBarPage> {

  
  
  int _selectedPage = 0;
  // List<Widget> listPage = List<Widget>();

  Widget changePages(){
    switch (_selectedPage) {
      case 0:
        return FmPage();
        break;
        case 1:
        return TvPage();
        break;
        case 2:
        return NewsProvider();
        break;
        case 3:
        return TeamPage();
    };
  }

  // @override
  // void initState() {
  //   super.initState();
  //   listPage.add(FmPage());
  //   listPage.add(TvPage());
  //   listPage.add(NewsPage());
  //   listPage.add(TeamPage());
  // }

        //   IndexedStack(
        //   index: _selectedPage,
        //   children: [
        //     FmPage(),
        //     TvPage(),
        //     NewsPage(),
        //     TeamPage(),
        //   ],
        // )

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: changePages(),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: _selectedPage == 0 ?
          Colors.orange[900] : _selectedPage == 1 ? Colors.orange[700] : _selectedPage == 2 ? Colors.orange[900] : _selectedPage == 3 ? Colors.orange[700] : _selectedPage == 4 ? Colors.orange[900] : Colors.orange[700] ,
          selectedIndex: _selectedPage,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) => setState((){
            _selectedPage = index;
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
