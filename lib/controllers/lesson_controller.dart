import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:pharma_line/config/basic_config.dart';
import 'package:pharma_line/models/lesson.dart';

class LessonController {
  Future<List<Lesson>> getLessons(courseId) async {
    print(courseId);
    var uri =
        Uri.parse(BASIC_URL + "/api/v1/courses/lessons?courseId=$courseId");
    try {
      // final queryParameters = {'courseId': courseId};
      // final uri =
      //     Uri.http(BASIC_URL, "/api/v1/courses/lessons", queryParameters);
      var response = await get(
        uri,
      );
      print(response.body);
      // final request = Request('GET', postUri);
      //
      // request.body = ' {"courseId": courseId}';
      //
      // final response = await request.send();
      // final res = await Response.fromStream(response);
      // print(res.body);
      // print(response);
      var body = json.decode(response.body);

      return await convertToLesson(body);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<dynamic> getLesson(
      {@required String token,
      @required String courseId,
      @required String lessonId}) async {
    try {
      var uri = Uri.parse(BASIC_URL +
          "/api/v1/student/myCourses/lesson?courseId=$courseId&lessonId=$lessonId");
      var response = await get(uri, headers: {'Authorization': token});
      print(response.body);
      if (response.body == 'Unauthorized') {
        return {'error': 'Unauthorized'};
      }
      var body = json.decode(response.body);
      if (body['message'] != null) {
        return {'error': body['message']};
      }
      return {
        'lesson': Lesson(
            id: body['id'],
            description: body['description'],
            title: body['title'],
            price: body['price'],
            imageUrl: body['imageUrl'],
            videoUrl: body['videoUrl'],
            pdfUrl: body['pdfUrl'])
      };
    } catch (_) {
      return {'error': 'somethin went worng'};
    }
  }

  Future<dynamic> enrollInLesson(
      {@required String token,
      @required String courseId,
      @required String lessonId}) async {
    try {
      var uri = Uri.parse(BASIC_URL + "/api/v1/student/myCourses/lesson");
      var response = await post(uri,
          body: {'courseId': courseId, 'lessonId': lessonId},
          headers: {'Authorization': token});
      print(response.body);
      if (response.body == 'Unauthorized') {
        return {'error': 'Unauthorized'};
      }
      var body = json.decode(response.body);
      if (body['message'] != null) {
        return {'error': body['message']};
      }
      return body;
    } catch (_) {
      return {'error': 'somethin went worng'};
    }
  }

  Future<List<Lesson>> convertToLesson(body) async {
    List<Lesson> lessons = [];
    for (var lesson in body) {
      try {
        lessons.add(
          Lesson(
              id: lesson['_id'],
              title: lesson['title'],
              description: lesson['description'],
              imageUrl: lesson['imageUrl'],
              price: lesson['price']),
        );
      } catch (e) {
        print(e);
      }
    }
    print(lessons.length);
    return lessons;
  }
}
