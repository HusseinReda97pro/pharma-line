import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pharma_line/config/basic_config.dart';
import 'package:pharma_line/models/course.dart';

class CourseController {
  Future<List<Course>> getCourses() async {
    var postUri = Uri.parse(BASIC_URL + "/api/v1/student/courses");
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

  Future<List<Course>> getMyCourses(String token) async {
    var postUri = Uri.parse(BASIC_URL + "/api/v1/student/myCourses");
    try {
      http.Response response =
          await http.get(postUri, headers: {'Authorization': token});
      // print(response.body);
      var body = json.decode(response.body);

      return await convertToCourses(body);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Course>> getCoursesByFacultyId(
      {@required String facultyId}) async {
    var postUri =
        Uri.parse(BASIC_URL + "/api/v1/courses/faculty?facultyId=$facultyId");
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
              teacher: ' Teacher Name',
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
    Uri url = Uri.parse(
        'https://pharmaline.herokuapp.com/api/v1/student/enrollCourse');
    http.Response response = await http
        .post(url, body: {"id": courseId}, headers: {'Authorization': token});
    print(response.body);
  }
}
