import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';



class FmPage extends StatefulWidget {
  @override
  _FmPageState createState() => _FmPageState();
}

class _FmPageState extends State<FmPage> {
  final AssetsAudioPlayer _player = AssetsAudioPlayer.newPlayer();

  void _init() async {
    try {
      _player.onErrorDo = (error) {
        error.player.stop();
      };
      await _player.open(
        Audio.liveStream(
          "http://live02.rfi.fr/rfimonde-96k.mp3",
          metas: Metas(
            title: "100.00",
            image: MetasImage.asset("assets/icone.jpg"),
          ),
        ),
        autoStart: true,
        showNotification: true,
        playInBackground: PlayInBackground.enabled,
        notificationSettings: NotificationSettings(
          nextEnabled: false,
          prevEnabled: false,
          stopEnabled: true,
        ),
      );
    } catch (t) {
      print(t);
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
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
              'assets/img_2.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.all(0),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PlayerBuilder.isBuffering(
              player: _player,
              builder: (context, isBuffering) {
                if (isBuffering) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: Colors.black26,
                        strokeWidth: 5,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  );
                } else {
                  return PlayerBuilder.isPlaying(
                    player: _player,
                    builder: (context, isPlaying) {
                      return FloatingActionButton(
                        child: isPlaying
                            ? Icon(Icons.pause, color: Colors.white,)
                            : Icon(Icons.play_arrow,color: Colors.white,),
                        onPressed: () async {
                          try {
                            await _player.playOrPause();
                          } catch (t) {
                            print(t);
                          }
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
