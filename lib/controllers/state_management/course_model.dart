import 'package:flutter/material.dart';
import 'package:pharma_line/controllers/course_controller.dart';
import 'package:pharma_line/models/course.dart';

mixin CourseModel on ChangeNotifier {
  CourseController courseController = CourseController();
  List<Course> currentCourses = [];
  bool loadingCourses = false;
  Future<void> getCourses() async {
    loadingCourses = true;
    notifyListeners();
    currentCourses = await courseController.getCourses();
    loadingCourses = false;
    notifyListeners();
  }

  Future<void> getMyCourses({String token}) async {
    loadingCourses = true;
    notifyListeners();
    currentCourses = await courseController.getMyCourses(token);
    loadingCourses = false;
    notifyListeners();
  }
}
