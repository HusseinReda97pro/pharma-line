import 'package:flutter/material.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:pharma_line/widgets/student_card.dart';
import 'package:provider/provider.dart';

class CourseStudents extends StatefulWidget {
  static const route = '\course_students';
  @override
  _CourseStudentsState createState() => _CourseStudentsState();
}

class _CourseStudentsState extends State<CourseStudents> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        drawer: AppDrawer(),
        body: model.isLoadingcourseStudents
            ? Center(
                child: Container(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              )
            : model.currentCourseStudents.length > 0
                ? ListView.builder(
                    itemCount: model.currentCourseStudents.length,
                    itemBuilder: (BuildContext contxtm, int index) {
                      return StudentCard(
                          student: model.currentCourseStudents[index]);
                    },
                  )
                : Center(
                    child: Text('there is no students enrolled in this course'),
                  ),
      );
    });
  }
}
