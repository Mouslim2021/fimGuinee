import 'dart:async';

import 'package:fim_guinee/src/api_files/provider/services/repository.dart';
import 'package:fim_guinee/src/api_files/provider/views/newsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../navy_bar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    _callApi();
    
  }

  _callApi(){
    repository.fetchFimData(context);
     Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            // return NewsProvider();
            return NavyBarPage();
          },
        ),
      ),
    );
  }
 

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/img_1.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Column(
                  children: [
                    SpinKitWave(
                      type: SpinKitWaveType.center,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
  }
}
