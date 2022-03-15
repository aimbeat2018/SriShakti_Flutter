import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsYoutubePlayer extends StatefulWidget {
  final String? url ;

  MovieDetailsYoutubePlayer({Key? key, this.url}) : super(key: key);
  @override
  _MovieDetailsYoutubePlayerState createState() => _MovieDetailsYoutubePlayerState();
}

class _MovieDetailsYoutubePlayerState extends State<MovieDetailsYoutubePlayer> {
  late YoutubePlayerController controller;
  bool _muted = false;
  bool _isPlayerReady = false;
  String? _url;
  String? youtubeVideoID;


  @override
  void initState() {
    super.initState();
     _url = widget.url;

    print(_url);
    youtubeVideoID = YoutubePlayer.convertUrlToId(_url!);
    if(youtubeVideoID != null){
      controller = YoutubePlayerController(
        initialVideoId: youtubeVideoID!,
        flags:YoutubePlayerFlags(
          autoPlay: true,
        ),
      );
      controller.toggleFullScreenMode();
    }
  }
  
  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
       return _onBackPressed();
      },
      child: Scaffold(
        body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            onReady: () {
              _isPlayerReady = true;
              setState(() {

              });
            },
            controller: controller,
            bottomActions: [
              const SizedBox(width: 14.0),
              IconButton(
                icon: Icon(_muted ? Icons.volume_off : Icons.volume_up,color: Colors.white,),
                onPressed: _isPlayerReady
                    ? () {
                  _muted
                      ? controller.unMute()
                      : controller.mute();
                  setState(() {
                    _muted = !_muted;
                  });
                }
                    : null,
              ),
              CurrentPosition(),
              const SizedBox(width: 8.0),
              ProgressBar(isExpanded: true),
              RemainingDuration(),
              const PlaybackSpeedButton(),
              const SizedBox(width: 8.0),
              InkWell(
                  onTap: (){
                    print("Setting Icon Pressed");
                  },
                  child: Icon(Icons.settings,color:Colors.white,)),
              const SizedBox(width: 14.0),

            ],
            topActions: [
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                          controller.toggleFullScreenMode();
                          Navigator.of(context).pop(true);
                        },
                        child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  ],
                ),
              )
            ],
          ),
          builder: (context,player){
            return player;
          },
        ),
      ),
    );
  }

  _onBackPressed(){
    controller.toggleFullScreenMode();
    Navigator.of(context).pop(true);
  }
}
