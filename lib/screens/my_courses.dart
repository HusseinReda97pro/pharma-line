import 'package:flutter/material.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/course_card.dart';
import 'package:provider/provider.dart';

import 'package:pharma_line/widgets/app_drawer.dart';

class MyCoursesScreen extends StatefulWidget {
  static const route = '/my_courses';
  @override
  _MyCoursesScreenState createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
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
            : model.currentCourses.length == 0
                ? Center(
                    child: Text(
                      'there is no courses yet.',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: model.getCourses,
                    child: ListView.builder(
                      itemCount: model.currentCourses.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == model.currentCourses.length) {
                          return SizedBox(
                            height: 100,
                          );
                        }
                        return CourseCard(
                          course: model.currentCourses[index],
                        );
                      },
                    ),
                  ),
      );
    });
  }
}
