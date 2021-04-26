import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/course_card.dart';
import 'package:provider/provider.dart';

import 'package:pharma_line/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        drawer: AppDrawer(),
        body: model.loadingCourses
            ? Center(
                child: Container(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              )
            : model.homeCourses.length == 0
                ? Center(
                    child: Text(
                      'there is no courses yet.',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: model.getCourses,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: model.homeCourses.length + 2,
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
                        if (index == model.homeCourses.length + 1) {
                          return SizedBox(
                            height: 100,
                          );
                        }
                        return CourseCard(
                          course: model.homeCourses[index - 1],
                        );
                      },
                    ),
                  ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.ac_unit),
        //   onPressed: () {
        //     model.getUserCoursesAndLessons();
        //   },
        // ),
      );
    });
  }
}
