import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pharma_line/config/basic_config.dart';
import 'package:pharma_line/models/course.dart';
import 'package:pharma_line/models/lesson.dart';

class LessonController {
  Future<List<Lesson>> getLessons() async {
    var postUri = Uri.parse(BASIC_URL + "/api/v1/student/courses/lessons");
    try {
      http.Response response = await http.get(
        postUri,
      );
      print(response.body);
      var body = json.decode(response.body);

      return await convertToLesson(body);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Lesson>> convertToLesson(body) async {
    List<Lesson> lessons = [];
    for (var course in body) {
      try {
        lessons.add(
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
