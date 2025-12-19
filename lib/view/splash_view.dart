import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patatoche_v2/constants/assets_resource.dart';
import 'package:video_player/video_player.dart';
import '../routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(AssetsResource.splashVideo)
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(false);
        setState(() {});
      });

    // Add listener to check if the video has completed playing
    _controller.addListener(() {
      if (_controller.value.isInitialized &&
          !_controller.value.isPlaying &&
          _controller.value.duration == _controller.value.position) {
        context.pushReplacement(AppPaths.introduction);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? Stack(
                children: <Widget>[
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: GestureDetector(
                        onTap: () {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                            context.pushReplacement(AppPaths.introduction);
                          }
                        },
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                  ),
                  //FURTHER IMPLEMENTATION
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
