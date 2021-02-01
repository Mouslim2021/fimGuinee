import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class FmPage extends StatefulWidget {
  @override
  _FmPageState createState() => _FmPageState();
}

class _FmPageState extends State<FmPage> {
  final AssetsAudioPlayer _player = AssetsAudioPlayer.newPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/img_2.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [],
          ),
          
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            label: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          ),
    );
  }
}
