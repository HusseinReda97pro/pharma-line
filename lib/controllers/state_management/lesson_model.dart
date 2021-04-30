import 'package:flutter/material.dart';
import 'package:pharma_line/main.dart';
import 'package:pharma_line/models/lesson.dart';
import 'package:pharma_line/models/user_type.dart';

import '../lesson_controller.dart';

mixin LessonModel on ChangeNotifier {
  LessonController lessonController = LessonController();
  List<Lesson> currentLessons = [];
  bool loadingLessons = false;
  Future<void> getLessons({String courseId}) async {
    loadingLessons = true;
    notifyListeners();
    currentLessons = await lessonController.getLessons(courseId);
    if (MyApp.mainModel.currentUser != null) {
      List<String> lessonIds = await lessonController.getUserLessonsByCourseId(
          token: MyApp.mainModel.currentUser.token, courseId: courseId);
      MyApp.mainModel.currentUser.lessonsIds = lessonIds;
    }
    loadingLessons = false;
    notifyListeners();
  }

  Future<dynamic> enrollInLesson(
      {@required String courseId, @required String lessonId}) async {
    if (MyApp.mainModel.currentUser != null) {
      var res = await lessonController.enrollInLesson(
          token: MyApp.mainModel.currentUser.token,
          courseId: courseId,
          lessonId: lessonId);
      if (res['error'] == null) {
        MyApp.mainModel.currentUser.lessonsIds.add(lessonId);
        notifyListeners();
      }
      return res;
    }
  }

  Future<void> getTeacherLessons({String courseId}) async {
    loadingLessons = true;
    notifyListeners();
    if (MyApp.mainModel.currentUser != null &&
        MyApp.mainModel.currentUserType == UserType.TEACHER) {
      currentLessons = await lessonController.getTeacherLessons(
          courseId, MyApp.mainModel.currentUser.token);
    }
    loadingLessons = false;
    notifyListeners();
  }
}
