import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage> {
  VideoPlayerController _videoController;
  int _playbackTime = 0;
  double _volume = 0.5;

  void _initPlayer() async {
    _videoController = VideoPlayerController.network(
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4');
    await _videoController.initialize();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initPlayer();
    _videoController.addListener(() {
      setState(() {
        _playbackTime = _videoController.value.position.inSeconds;
        _volume = _videoController.value.volume;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _videoController.value.initialized ? _playerWidget() : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play();
          setState(() {});
        },
        child: _videoController.value.isPlaying
            ? Icon(Icons.pause)
            : Icon(Icons.play_arrow),
      ),
    );
  }

  Widget _playerWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: VideoPlayer(_videoController),
        ),
        Slider(
          value: _playbackTime.toDouble(),
          max: _videoController.value.duration.inSeconds.toDouble(),
          min: 0,
          onChanged: (v) {
            _videoController.seekTo(Duration(seconds: v.toInt()));
          },
        ),
        Slider(
          value: _volume,
          max: 1,
          min: 0,
          onChanged: (v) {
            _videoController.setVolume(v);
          },
        )
      ],
    );
  }
}
