import 'package:flutter/material.dart';
import 'package:pharma_line/models/lesson.dart';

import '../lesson_controller.dart';

mixin LessonModel on ChangeNotifier {
  LessonController lessonController = LessonController();
  List<Lesson> currentLessons = [];
  bool loadingLessons = false;
  Future<void> getLessons({String courseId}) async {
    loadingLessons = true;
    notifyListeners();
    currentLessons = await lessonController.getLessons(courseId);
    loadingLessons = false;
    notifyListeners();
  }
}
