import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveStream extends StatefulWidget {
  @override
  _LiveStreamState createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {

  YoutubePlayerController _controller; 

  void runLiveStream(){
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=bkXn38__Gy0&ab_channel=FRANCE24"),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        isLive: true,
        enableCaption: true,
        captionLanguage: 'fr',

      )
      );
  }
  @override
  void initState() {
    runLiveStream();
    super.initState();
  }
  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        aspectRatio: 16/9,
        liveUIColor: Colors.orange[900],
        controlsTimeOut: Duration(seconds: 6),
        
        ), 
      builder: (context, player){
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              player,
              Text("FIM 24 Live Streaming")
            ],
          ),
        );
      });
  }
}