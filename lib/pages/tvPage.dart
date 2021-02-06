import 'package:flutter/material.dart';
import 'package:fim_guinee/src/youtubePlayer.dart';

class TvPage extends StatefulWidget {
  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {

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
          Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return FmLiveStream();
            }
          ));
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
