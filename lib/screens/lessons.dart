import 'package:flutter/material.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:pharma_line/widgets/lesson_card.dart';
import 'package:provider/provider.dart';

class LessonsScreen extends StatefulWidget {
  static const route = '/lessons';
  final String courseId;

  const LessonsScreen({@required this.courseId});

  @override
  _LessonsScreenState createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
      builder: (BuildContext context, MainModel model, Widget child) {
        return Scaffold(
          appBar: MainAppBar(
            context: context,
          ),
          drawer: AppDrawer(),
          body: model.loadingLessons
              ? Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(),
                  ),
                )
              : model.currentLessons.length == 0
                  ? Center(
                      child: Text(
                        'there is no lessons yet.',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: model.currentLessons.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == model.currentLessons.length) {
                          return SizedBox(
                            height: 100,
                          );
                        }
                        return LessonCard(
                          lesson: model.currentLessons[index],
                          courseId: widget.courseId,
                        );
                      },
                    ),
        );
      },
    );
  }
}
