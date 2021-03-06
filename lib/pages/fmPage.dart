import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:fim_guinee/src/api_files/mesConst.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FmPages extends StatefulWidget {
  @override
  _FmPagesState createState() => _FmPagesState();
}

class _FmPagesState extends State<FmPages> with AutomaticKeepAliveClientMixin {
  final AssetsAudioPlayer _player = AssetsAudioPlayer.newPlayer();

//   String streamUrl;

//  Future<String> getStreamUrl() async{

//   }

  checkConn() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print('Connected with mobile data');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print('Connected with wifi data');
    } else if (connectivityResult == ConnectivityResult.none) {
      showToast(
        'Votre téléphone n\'a pas de connexion internet',
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
  }

  void _init() async {
    try {
      _player.onErrorDo = (error) {
        error.player.stop();
      };
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final response = await http.get(url);
      preferences.setString('streamUrl', response.body);
      final stream = preferences.getString("streamUrl");
      final result = json.decode(stream);
      String streamUrl = result['app']['radio_streaming'].toString();
      await _player.open(
        Audio.liveStream(
          streamUrl,
          metas: Metas(
            title: "95.3",
            album: "",
            artist: "",
            image: MetasImage.network("https://fimguinee.com/frontend/logo_nav.png"),
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final liveStream = getStreamUrl();
    checkConn();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
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
                        elevation: 8,
                        backgroundColor: Colors.white,
                        child: isPlaying
                            ? Icon(
                                Icons.pause_circle_outline,
                                color: Colors.orange[600],
                                size: 35,
                              )
                            : Icon(
                                Icons.play_circle_outline,
                                color: Colors.orange[600],
                                size: 35,
                              ),
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
