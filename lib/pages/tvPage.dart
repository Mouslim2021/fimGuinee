import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class TvPage extends StatefulWidget {
  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  availbleTV(){
    return showToast(
        'Bientôt disponible',
        context: context,
        animation: StyledToastAnimation.slideFromBottomFade,
        reverseAnimation: StyledToastAnimation.slideToBottomFade,
        position:
            StyledToastPosition(align: Alignment.bottomCenter, offset: 0.0),
        startOffset: Offset(0.0, -3.0),
        reverseEndOffset: Offset(0.0, -3.0),
        duration: Duration(seconds: 5),
        animDuration: Duration(seconds: 1),
        curve: Curves.elasticInOut,
        reverseCurve: Curves.elasticOut,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/img_2-min.PNG',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 8,
        backgroundColor: Colors.white,
        onPressed: () {
          availbleTV();
        },
        icon: Icon(
          Icons.live_tv,
          color: Colors.orange[600],
        ),
        label: Text(
          'Régardez FIM 24 en live!',
          style: TextStyle(
            color: Colors.orange[600],
          ),
        ),
      ),
    );
  }
}
