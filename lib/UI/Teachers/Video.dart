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
    _videoController = VideoPlayerController.network('https://firebasestorage.googleapis.com/v0/b/hananz-5ffb9.appspot.com/o/0603422b-f493-4c50-875f-8961cf387490272372295182648310.mp4?alt=media&token=5f7b6313-f781-4cc5-9527-64e7ea45ff55');
    await _videoController.initialize();
    setState(() {

    });
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
      body: _videoController.value.initialized ?
      SafeArea(child: _playerWidget()) : Text(
          "لا يوجد"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade200,
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
    return Container(
      width: 500,
      height: 500,
      child: ListView(shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(8),),
              AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              ),
              Row(
                children: [
                  Icon(Icons.play_arrow
                    ,color: Colors.deepPurple,
                  ),
                  Slider(
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.deepPurple.shade50,
                    value: _playbackTime.toDouble(),
                    max: _videoController.value.duration.inSeconds.toDouble(),
                    min: 0,
                    onChanged: (v) {
                      _videoController.seekTo(Duration(seconds: v.toInt()));
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.play_arrow
                    ,color: Colors.deepPurple,
                  ),
                  Slider(
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.deepPurple.shade50,
                    value: _volume,
                    max: 1,
                    min: 0,
                    onChanged: (v) {
                      _videoController.setVolume(v);
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

}

