import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
   String VideoUrl;
  Video( String VideoUrl){

    this.VideoUrl=VideoUrl;
  }


  @override
  State<StatefulWidget> createState() {
    return _VideoState(VideoUrl);
  }
}

class _VideoState extends State<Video> {
  String VideoUrl;
  _VideoState( String VideoUrl){

    this.VideoUrl=VideoUrl;
  }
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(VideoUrl,videoPlayerOptions: VideoPlayerOptions());
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      fullScreenByDefault: false,
      aspectRatio: 3 / 4,
      autoInitialize: true,
     // autoPlay: true,
      looping: false,
      showControls: true,
       showControlsOnInitialize: false,
       materialProgressColors: ChewieProgressColors(
         playedColor: Colors.deepPurple,
       handleColor: Colors.deepPurple.shade100,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.grey,
      ),
      placeholder: Container(
    color: Colors.white,
       ),
      // autoInitialize: true,
    );
  }
  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
         SizedBox(
           width: 1000,
           height: 450,
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
             );
  }
}
