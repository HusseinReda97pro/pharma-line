import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/lesson_card.dart';
import 'package:provider/provider.dart';

import 'file:///D:/MobileDevelopment/pharma_line/lib/widgets/app_drawer.dart';

class LessonsScreen extends StatefulWidget {
  static const route = '/lessons';
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
                      itemCount: model.currentLessons.length + 2,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return model.currentUser == null
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.all(25.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Hi  ',
                                            style: TextStyle(
                                                color: Palette.lightBlue,
                                                fontSize: 22.0),
                                          ),
                                          Text(
                                            model.currentUser.firstName +
                                                ' ' +
                                                model.currentUser.lastName +
                                                '!',
                                            style: TextStyle(
                                                color: Palette.lightBlue,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Text(
                                        'Ready to learn?',
                                        style: TextStyle(
                                            color: Palette.lightBlue,
                                            fontSize: 22.0),
                                      ),
                                    ],
                                  ),
                                );
                        }
                        if (index == model.currentLessons.length + 1) {
                          return SizedBox(
                            height: 100,
                          );
                        }
                        return LessonCard(
                          lesson: model.currentLessons[index - 1],
                        );
                      },
                    ),
        );
      },
    );
  }
}
