import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fim_guinee/src/api_files/provider/views/newsProvider.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'pages/fmPage.dart';
import 'pages/teamPage.dart';
import 'pages/tvPage.dart';
import 'package:flutter/material.dart';
import 'src/youtubePlayer.dart';

class NavyBarPage extends StatefulWidget {
  @override
  _NavyBarPageState createState() => _NavyBarPageState();
}

class _NavyBarPageState extends State<NavyBarPage>
    with AutomaticKeepAliveClientMixin {
  int _selectedPage;
  List<Widget> _pages;
  PageController _pageController;

//  changePages() {
//     switch (_selectedPage) {
//       case 0:
//         // return fmPage();
//         break;
//       case 1:
//         return TvPage();
//         break;
//       case 2:
//         return NewsProvider();
//         break;
//       case 3:
//         return TeamPage();
//     }
//   }

  @override
  void initState() {
    _selectedPage = 0;
    _pages = [
      FmPages(),
      TvPage(),
      NewsProvider(),
      TeamPage(),
    ];
    _pageController = PageController(initialPage: _selectedPage);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text(
              'Tapez une deux fois pour fermer l\'Application',
            ),
          ),
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: _pages,
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: _selectedPage == 0
              ? Colors.orange[900]
              : _selectedPage == 1
                  ? Colors.orange[700]
                  : _selectedPage == 2
                      ? Colors.orange[900]
                      : _selectedPage == 3
                          ? Colors.orange[700]
                          : _selectedPage == 4
                              ? Colors.orange[900]
                              : Colors.orange[700],
          selectedIndex: _selectedPage,
          showElevation: true,
          itemCornerRadius: 8,
          curve: Curves.easeInBack,
          onItemSelected: (index) => setState(() {
            _selectedPage = index;
            _pageController.jumpToPage(_selectedPage);
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
