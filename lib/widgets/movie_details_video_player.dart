import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class MovieDetailsVideoPlayerWidget extends StatefulWidget {
  final String? videoUrl;
  final File? localFile;

  const MovieDetailsVideoPlayerWidget({Key? key, this.videoUrl, this.localFile})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MovieDetailsVideoPlayerWidgetState();
  }
}

class _MovieDetailsVideoPlayerWidgetState
    extends State<MovieDetailsVideoPlayerWidget> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    if (widget.localFile != null) {
      _controller = VideoPlayerController.file(widget.localFile!);
    } else {
      _controller = VideoPlayerController.network(widget.videoUrl!);
    }

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      fullScreenByDefault: false,
      allowFullScreen: false,
      autoPlay: true,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var  topbarContainerHeight = size.height * 0.15;

    return WillPopScope(
      onWillPop: () {
        return _onBackPressed();
      },
      child: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                // Use the VideoPlayer widget to display the video.
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
              Container(
                  height: topbarContainerHeight,
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(Icons.arrow_back_ios),
                        onTap: () {
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp]);
                          Navigator.pop(context, true);
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _onBackPressed() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Navigator.pop(context, true);
  }
}
