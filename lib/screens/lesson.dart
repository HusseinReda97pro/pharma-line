import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/models/lesson.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  LessonScreen({@required this.lesson});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  YoutubePlayerController _youtubePlayerController;
  @override
  void initState() {
    if (widget.lesson.videoUrl != null) {
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.lesson.videoUrl),
        flags: YoutubePlayerFlags(
          autoPlay: false,
        ),
      );
    }
    super.initState();
  }

  // @override
  // void dispose() {
  //   _youtubePlayerController.dispose();
  //   super.dispose();
  // }

  Widget youtubeHierarchy() {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fill,
          child: YoutubePlayer(
            controller: _youtubePlayerController,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape) {
        return Scaffold(
          body: youtubeHierarchy(),
        );
      } else {
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
                  : YoutubePlayer(
                      controller: _youtubePlayerController,
                    ),
              widget.lesson.pdfUrl == null
                  ? Container()
                  : Container(
                      margin: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Palette.midBlue),
                        onPressed: () async {
                          await canLaunch(widget.lesson.pdfUrl)
                              ? await launch(widget.lesson.pdfUrl)
                              : throw 'Could not launch';
                        },
                        child: Text(
                          'Download Attachment',
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
    });
  }
}
