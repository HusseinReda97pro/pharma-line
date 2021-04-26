import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/models/lesson.dart';
import 'package:pharma_line/screens/pdf_viewer.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  LessonScreen({@required this.lesson});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  // YoutubePlayerController _youtubePlayerController;
  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    if (widget.lesson.videoUrl != null) {
      // _youtubePlayerController = YoutubePlayerController(
      //   initialVideoId: YoutubePlayer.convertUrlToId(widget.lesson.videoUrl),
      //   flags: YoutubePlayerFlags(
      //     autoPlay: false,
      //   ),
      // );
      print('Start');
      initializeVideoPalyer();
    }
    super.initState();
  }

  @override
  void dispose() {
    try {
      _videoPlayerController.dispose();
      _chewieController.dispose();
    } catch (_) {}
    super.dispose();
  }

  Future<void> initializeVideoPalyer() async {
    if (widget.lesson.videoUrl.contains('youtube')) {
      // var videoId = YoutubePlayer.convertUrlToId(widget.lesson.videoUrl);
      final extractor = YoutubeExplode();
      final videoId = YoutubePlayer.convertUrlToId(widget.lesson.videoUrl);
      final streamManifest =
          await extractor.videos.streamsClient.getManifest(videoId);
      final streamInfo = streamManifest.muxed.withHighestBitrate();
      extractor.close();
      var videoUrl = streamInfo.url.toString();
      _videoPlayerController = VideoPlayerController.network(videoUrl);
    } else {
      _videoPlayerController =
          VideoPlayerController.network(widget.lesson.videoUrl);
    }
    // _videoPlayerController = VideoPlayerController.network(
    //     'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4');

    print(widget.lesson.videoUrl);

    await Future.wait([_videoPlayerController.initialize()]);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      autoPlay: false,
      looping: false,
      materialProgressColors: ChewieProgressColors(backgroundColor: Colors.red),
      // placeholder: Container(
      //   color: Colors.green,
      // ),
      autoInitialize: true,
    );
    setState(() {});
    print('Done');
  }
  // @override
  // void dispose() {
  //   _youtubePlayerController.dispose();
  //   super.dispose();
  // }

  // Widget youtubeHierarchy() {
  //   return Container(
  //     child: Align(
  //       alignment: Alignment.center,
  //       child: FittedBox(
  //         fit: BoxFit.fill,
  //         child: YoutubePlayer(
  //           controller: _youtubePlayerController,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        context: context,
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              widget.lesson.title,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
          widget.lesson.imageUrl == null
              ? Container()
              : Image.network(widget.lesson.imageUrl),
          widget.lesson.description == null
              ? Container()
              : Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    widget.lesson.description,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
          widget.lesson.videoUrl == null
              ? Container()
              : _chewieController != null &&
                      _chewieController
                          .videoPlayerController.value.isInitialized
                  ? Container(
                      constraints: BoxConstraints(maxHeight: 250),
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    )
                  : Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
          //  YoutubePlayer(
          //     controller: _youtubePlayerController,
          //   ),
          widget.lesson.pdfUrl == null
              ? Container()
              : Container(
                  margin: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Palette.midBlue),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        (MaterialPageRoute(builder: (BuildContext context) {
                          return PDFViewerScreen(
                            pdfUrl: widget.lesson.pdfUrl,
                          );
                        })),
                      );
                      // await canLaunch(widget.lesson.pdfUrl)
                      //     ? await launch(widget.lesson.pdfUrl)
                      //     : throw 'Could not launch';
                    },
                    child: Text(
                      'Open Attachment',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
