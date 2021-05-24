import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/models/user_type.dart';
import 'package:pharma_line/screens/course_students.dart';
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
                      itemCount: model.homeCourses.length + 3,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return (model.currentUser == null ||
                                  model.currentUserType == UserType.TEACHER)
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
                        if (index == model.homeCourses.length + 2) {
                          return SizedBox(
                            height: 100,
                          );
                        } if (index == 1) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 8,
                              children: [
                                InkWell(

                                  child: Chip(
                                    label: Text("Level 1 "),

                                  ),
                                ),Chip(
                                  label: Text("Level 2 "),
                                ),Chip(
                                  label: Text("Level 3 "),
                                ),Chip(
                                  label: Text("Level 4 "),
                                ),
                                Chip(
                                  label: Text("Level 5 "),
                                ),
                              ],
                            ),
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
        //     var token =
        //         'JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDgyNjdjZjNkZWEwOTAwMWM0OTVmMzciLCJpYXQiOjE2MTk3ODI4MjN9.7Q5bdgXW7QRun8GeJebKDQOdQLWIjNahq5v_gSDZN7g';

        //     model.getCourseStudents(
        //         token: token, courseId: '60826d279d5e54001ceb0e1b');
        //     Navigator.pushNamed(context, CourseStudents.route);
        //   },
        // ),
      );
    });
  }
}
