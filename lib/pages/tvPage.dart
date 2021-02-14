import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flushbar/flushbar.dart';
import '../src/youtubePlayer.dart';

class TvPage extends StatefulWidget {
  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {

  Future<bool> checkConn() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Connection mobile");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connection wifi");
    } else if (connectivityResult == ConnectivityResult.none) {
      showToast(
        'Aucune connexion détectée, Vérifiez votre internet et réessayez plus tard',
        context: context,
        animation: StyledToastAnimation.slideFromTopFade,
        reverseAnimation: StyledToastAnimation.slideToTopFade,
        position: StyledToastPosition(align: Alignment.topCenter, offset: 0.0),
        startOffset: Offset(0.0, -3.0),
        reverseEndOffset: Offset(0.0, -3.0),
        duration: Duration(seconds: 5),
        animDuration: Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn,
      );
    }
  }

  loader() {
    return Flushbar(
      duration: Duration(seconds: 6),
      titleText: Text(
        "Patientez",
        style: TextStyle(color: Color(0xffc43c24)),
      ),
      messageText: Text(
        "En cours de traitement...",
        style: TextStyle(color: Color(0xffc43c24)),
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Color(0xff2a4b8d),
      backgroundGradient:
          LinearGradient(colors: [Colors.white, Colors.grey[400]]),
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
          color: Colors.blue[800],
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
    )..show(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/img_3.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FmLiveStream();
          }));
        },
        icon: Icon(
          Icons.live_tv,
          color: Colors.white,
        ),
        label: Text(
          'Régardez FIM 24 en live!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
