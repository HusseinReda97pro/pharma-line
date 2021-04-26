import 'package:flutter/material.dart';
import 'package:pharma_line/controllers/course_controller.dart';
import 'package:pharma_line/main.dart';
import 'package:pharma_line/models/course.dart';

mixin CourseModel on ChangeNotifier {
  CourseController courseController = CourseController();
  List<Course> currentCourses = [];
  List<Course> homeCourses = [];

  bool loadingCourses = false;
  Future<void> getCourses() async {
    loadingCourses = true;
    notifyListeners();
    homeCourses = await courseController.getCourses();
    if (MyApp.mainModel.currentUser != null) {
      await getMyCourses(token: MyApp.mainModel.currentUser.token);
    }
    await getUserCourses();
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

  Future<void> getCoursesByFacultyId({@required String facultyId}) async {
    loadingCourses = true;
    notifyListeners();
    currentCourses =
        await courseController.getCoursesByFacultyId(facultyId: facultyId);
    loadingCourses = false;
    notifyListeners();
  }

  Future<void> getUserCourses() async {
    if (MyApp.mainModel.currentUser != null) {
      var coursesIds = await courseController.getUserCourses(
          token: MyApp.mainModel.currentUser.token);
      MyApp.mainModel.currentUser.coursesIds = coursesIds;
      notifyListeners();
    }
  }

  Future<void> enrollCourse({token, courseId}) async {
    await courseController.enrollCourse(token: token, courseId: courseId);
    if (MyApp.mainModel.currentUser != null) {
      MyApp.mainModel.currentUser.coursesIds.add(courseId);
      notifyListeners();
    }
  }
}
