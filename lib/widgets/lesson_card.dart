import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/lesson_controller.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/main.dart';
import 'package:pharma_line/models/lesson.dart';
import 'package:pharma_line/models/user_type.dart';
import 'package:pharma_line/screens/lesson.dart';
import 'package:pharma_line/screens/login.dart';
import 'package:provider/provider.dart';

import 'loading_box.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final String courseId;
  LessonCard({@required this.lesson, @required this.courseId});

  _handelOpenLesson({@required BuildContext context}) async {
    if (MyApp.mainModel.currentUser == null) {
      _handelLogin(context: context);
    } else {
      loadingBox(context);
      var res = await LessonController().getLesson(
          token: MyApp.mainModel.currentUser.token,
          courseId: courseId,
          lessonId: lesson.id);
      Navigator.pop(context);
      print(res);
      if (res['error'] != null) {
        _showErrors(context, res['error']);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return LessonScreen(
                lesson: res['lesson'],
                courseId: courseId,
              );
            },
          ),
        );
      }
    }
  }

  Future<void> _showErrors(BuildContext context, String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0.0,
          content: Container(
              width: 100,
              margin: EdgeInsets.symmetric(vertical: 3.0),
              child: Text(error)),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Palette.midBlue;
                    },
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (!(error == 'Not enough balance.' ||
                      error == "You've Reached The Maximum Watching Number" ||
                      error == 'You Should Enroll The Course First')) {
                    _handelEnrollment(context: context);
                  } else {
                    Navigator.pop(context);
                    if (error == 'You Should Enroll The Course First') {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(
                  (error == 'Not enough balance.' ||
                          error ==
                              "You've Reached The Maximum Watching Number" ||
                          error == 'You Should Enroll The Course First')
                      ? 'okay'
                      : 'Enroll Now',
                  textAlign: TextAlign.center,
                ))
          ],
        );
      },
    );
  }

  _handelEnrollment({@required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0.0,
            title: Container(child: new Text('Enrollment')),
            content: Container(
              height: 80,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        "Do you want to sepnd " +
                            lesson.price.toString() +
                            " EGP for Enrollong in lesson: " +
                            lesson.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Palette.darkBlue),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Palette.darkBlue),
                onPressed: () async {
                  loadingBox(context);
                  var res = await MyApp.mainModel
                      .enrollInLesson(courseId: courseId, lessonId: lesson.id);
                  Navigator.pop(context);
                  if (res['error'] != null) {
                    _showErrors(context, res['error']);
                  } else {
                    _enrollmentMessage(context: context);
                  }
                },
                child: Text('Enroll'),
              ),
            ],
          );
        });
  }

  _enrollmentMessage({@required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0.0,
            title: Container(child: new Text('Enrollment')),
            content: Container(
              height: 80,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      'Enroll in lesson:' + lesson.title + ' successfully',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Palette.darkBlue),
                onPressed: () async {
                  loadingBox(context);
                  var res = await LessonController().getLesson(
                      token: MyApp.mainModel.currentUser.token,
                      courseId: courseId,
                      lessonId: lesson.id);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return LessonScreen(
                          lesson: res['lesson'],
                          courseId: courseId,
                        );
                      },
                    ),
                  );
                },
                child: Text('Okay'),
              ),
            ],
          );
        });
  }

  _handelLogin({@required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0.0,
            title: Container(child: new Text('Enrollment')),
            content: Container(
              height: 80,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "you need to login first",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Palette.darkBlue),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Palette.darkBlue),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.route);
                },
                child: Text('Login'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
      return GestureDetector(
        onTap: () {
          print('lesson id" ' + lesson.id);
          print('course id" ' + courseId);
          _handelOpenLesson(context: context);
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Card(
            color: Palette.midBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  lesson.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/placeholder.jpg',
                            image: lesson.imageUrl,
                          ),
                          // Image.network(
                          //   lesson.imageUrl,
                          // ),
                        )
                      : Container(),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          lesson.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        // margin: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          lesson.price.toString() + " EGP",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      lesson.description,
                      softWrap: true,
                      style: TextStyle(
                          color: Color(0xFFCCCCCC),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  model.currentUser != null
                      ? (model.currentUser.lessonsIds.contains(lesson.id) ||
                              model.currentUserType == UserType.TEACHER)
                          ? Container()
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (model.currentUserType !=
                                      UserType.TEACHER) {
                                    _handelOpenLesson(context: context);
                                  }
                                },
                                child: Text(
                                  'Enroll Now',
                                  style: TextStyle(color: Palette.darkBlue),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Palette.lightBlue),
                              ),
                            )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              _handelOpenLesson(context: context);
                            },
                            child: Text(
                              'Enroll Now',
                              style: TextStyle(color: Palette.darkBlue),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Palette.lightBlue),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
