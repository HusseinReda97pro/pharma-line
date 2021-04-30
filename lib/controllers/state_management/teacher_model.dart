import 'package:flutter/material.dart';
import 'package:pharma_line/controllers/teacher_controller.dart';
import 'package:pharma_line/models/user.dart';

mixin TeacherModel on ChangeNotifier {
  List<User> currentCourseStudents = [];
  bool isLoadingcourseStudents = false;
  TeacherController _teacherController = TeacherController();
  Future<void> getCourseStudents(
      {@required String token, @required String courseId}) async {
    isLoadingcourseStudents = true;
    notifyListeners();
    currentCourseStudents = await _teacherController.getCourseStudents(
        token: token, courseId: courseId);
    print(currentCourseStudents.length);
    isLoadingcourseStudents = false;
    notifyListeners();
  }
}
