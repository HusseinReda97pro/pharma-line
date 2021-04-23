import 'dart:convert';

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
                  course['teacher']['lastName'],
              label: course['label'],
              faculty: '',
              university: '',
              isLive: false),
        );
      } catch (e) {
        print(e);
      }
    }
    return courses;
  }
}
