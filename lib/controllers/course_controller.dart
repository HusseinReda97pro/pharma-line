import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pharma_line/config/basic_config.dart';
import 'package:pharma_line/models/course.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CourseController {
  Future<List<Course>> getCourses({String type, int level}) async {
    var postUri = Uri.parse(
        BASIC_URL + "/api/v1/student/courses?type=$type&level=$level");
    try {
      http.Response response = await http.get(
        postUri,
      );
      print(response.body);
      var body = json.decode(response.body);

      return await convertToCourses(body);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Course>> getMyCourses(String token) async {
    var postUri = Uri.parse(BASIC_URL + "/api/v1/student/myCourses");
    try {
      http.Response response =
          await http.get(postUri, headers: {'Authorization': token});
      print(response.body);
      var body = json.decode(response.body);

      return await convertToCourses(body);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Course>> getCoursesByFacultyId(
      {@required String facultyId, String type, int level}) async {
    var postUri = Uri.parse(BASIC_URL +
        "/api/v1/courses/faculty?facultyId=$facultyId&type=$type&level=$level");
    try {
      http.Response response = await http.get(
        postUri,
      );
      // print(response.body);
      var body = json.decode(response.body);

      return await convertToCourses(body);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Course>> convertToCourses(body) async {
    List<Course> courses = [];
    for (var course in body) {
      try {
        courses.add(
          Course(
              id: course['_id'],
              title: course['title'],
              description: course['description'],
              imageUrl: course['imageUrl'],
              teacher: course['teacher']['firstName'] +
                  " " +
                  course['teacher']['lastName'],
              // course['teacher']['firstName'] +
              //     course['teacher']['lastName'],
              label: course['label'],
              faculty: '',
              university: '',
              isLive: false),
        );
      } catch (e) {
        print('Add Course Error');
        print(e);
      }
    }
    print(courses.length);
    return courses;
  }

  Future<void> enrollCourse(
      {@required String token, @required String courseId}) async {
    FirebaseApp app = await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic(courseId);

    Uri url = Uri.parse(BASIC_URL + '/api/v1/student/enrollCourse');
    http.Response response = await http
        .post(url, body: {"id": courseId}, headers: {'Authorization': token});
    print(response.body);
  }

  Future<List<String>> getUserCourses({@required String token}) async {
    Uri url = Uri.parse(BASIC_URL + '/api/v1/student/mycourses');
    http.Response response =
        await http.get(url, headers: {'Authorization': token});
    print(response.body);
    try {
      List<String> coursesIds = [];

      var body = json.decode(response.body);
      for (var course in body) {
        try {
          coursesIds.add(course['_id']);
        } catch (_) {}
      }

      return coursesIds;
    } catch (e) {
      print('get user courses and lessons ids Error:');
      print(e);
      return [];
    }
  }

// for teacher
  Future<List<Course>> getTeacerCourses({@required String token}) async {
    var postUri = Uri.parse(BASIC_URL + "/api/v1/teacher/myCourses");
    try {
      http.Response response =
          await http.get(postUri, headers: {'Authorization': token});
      print(response.body);
      var body = json.decode(response.body);
      print(body);
      return await convertToCourses(body);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
