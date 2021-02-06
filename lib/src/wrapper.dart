import 'package:fim_guinee/navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fim_guinee/src/onboarding.dart';

class MyWrapper extends StatefulWidget {
  @override
  _MyWrapperState createState() => _MyWrapperState();
}

class _MyWrapperState extends State<MyWrapper> {
  initWrapper() async {
    bool visitingFlag = await getVisitingFlag();
    setVisitingFlag();
    if (visitingFlag == true) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return NavyBarPage();
      }));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return OnBoardingPage();
      }));
    }
  }

  @override
  void initState() {
    initWrapper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[900],
      child: SpinKitFadingCube(
        color: Colors.white,
      ),
    );
  }
}

setVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  preferences.setBool("alreadyVisited", true);
}

getVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  bool alreadyVisited = preferences.getBool("alreadyVisited") ?? false;
  return alreadyVisited;
}


