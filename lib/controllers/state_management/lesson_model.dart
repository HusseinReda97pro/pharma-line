import 'package:flutter/material.dart';
import 'package:pharma_line/controllers/course_controller.dart';
import 'package:pharma_line/models/lesson.dart';

mixin LessonModel on ChangeNotifier {
  CourseController courseController = CourseController();
  List<Lesson> currentLessons = [];
  bool loadingLessons = false;
  Future<void> getCourses() async {
    loadingLessons = true;
    notifyListeners();
    // currentLessons = await courseController.getCourses();
    loadingLessons = false;
    notifyListeners();
  }
}
