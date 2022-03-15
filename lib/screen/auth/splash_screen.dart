import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oxoo/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../constants.dart';
import '../../screen/landing_screen.dart';
import '../../service/authentication_service.dart';

late VideoPlayerController controller;

class SplashScreen extends StatefulWidget {
  static final String route = '/SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late bool _isLogged;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printLog("_SplashScreenState");
    final AuthService authService = Provider.of<AuthService>(context);
    _isLogged = authService.getUser() != null ? true : false;

    return _isLogged
        ? LandingScreen()
        : Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  loadVideoPlayer(){
    controller = VideoPlayerController.asset('assets/srishakti_intro.mp4');
    controller.addListener(() {
      setState(() {
        if (!controller.value.isPlaying && controller.value.isInitialized &&
            (controller.value.duration ==controller.value.position)) { //checking the duration and position every time
          //Video Completed//
          setState(() {
            Navigator.pop(context);
            Navigator.pushNamed(context, AuthScreen.route);
          });
        }
      });
    });
    controller.initialize().then((value){
      setState(() {});
    });
    controller.play();
  }

}


