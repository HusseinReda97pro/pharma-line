import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/lesson_controller.dart';
import 'package:pharma_line/main.dart';
import 'package:pharma_line/models/lesson.dart';
import 'package:pharma_line/screens/pdf_viewer.dart';
import 'package:pharma_line/screens/secure_scrren.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  final String courseId;
  LessonScreen({@required this.lesson, @required this.courseId});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController;
  List<int> watchedSeconds = [];
  bool isWatched = false;

  @override
  void initState() {
    if (widget.lesson.videoUrl != null) {
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
    _videoPlayerController.addListener(videoViewership);
    setState(() {});
    print('Done');
  }

  Future<void> videoViewership() async {
    if (!watchedSeconds
        .contains(_videoPlayerController.value.position.inSeconds)) {
      watchedSeconds.add(_videoPlayerController.value.position.inSeconds);
    }
    if (watchedSeconds.length >=
        _videoPlayerController.value.duration.inSeconds * 0.25) {
      if (!isWatched) {
        print('Watched');
        isWatched = true;
        int count = await LessonController().updateLessonProgress(
            token: MyApp.mainModel.currentUser.token,
            courseId: widget.courseId,
            lessonId: widget.lesson.id);
        showCountMessage(count: count);
      }
    }
    print(watchedSeconds.length);
  }

  void showCountMessage({@required int count}) {
    if (count != null && count != -1) {
      Fluttertoast.showToast(
          msg: 'You consumed ' +
              count.toString() +
              (count == 1 ? ' view' : ' views') +
              ' out of 5',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color(0xFFCCCCCC),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SecureScrren(screen: Scaffold(
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
      // floatingActionButton: FloatingActionButton(
      //   child: Text('+'),
      //   onPressed: () async {
      //     int count = await LessonController().updateLessonProgress(
      //         token: MyApp.mainModel.currentUser.token,
      //         courseId: widget.courseId,
      //         lessonId: widget.lesson.id);
      //     print("count is" + count.toString());
      //   },
      // ),
    ));
  }
}
