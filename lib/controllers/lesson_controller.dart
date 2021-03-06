import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:pharma_line/config/basic_config.dart';
import 'package:pharma_line/main.dart';
import 'package:pharma_line/models/lesson.dart';

class LessonController {
  Future<List<Lesson>> getLessons(courseId) async {
    var uri =
        Uri.parse(BASIC_URL + "/api/v1/courses/lessons?courseId=$courseId");
    try {
      var response = await get(
        uri,
      );

      var body = json.decode(response.body);

      print("Lessons" + body[0].toString());

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
      if (response.body == 'Unauthorized') {
        return {'error': 'Unauthorized'};
      }
      var body = json.decode(response.body);
      if (body['message'] != null) {
        return {'error': body['message']};
      }
      print("LESSON TEST" + body.toString());

      return {
        'lesson': Lesson(
            id: body['_id'],
            description: body['description'],
            title: body['title'],
            price: body['price'],
            imageUrl: body['imageUrl'],
            videoUrl: body['videoUrl'],
            pdfUrl: body['pdfUrl'],
            maxCount: body['maxCount'] != null ? body['maxCount'] : 0,
            count: body['count'] != null ? body['count'] : 0)
      };
    } catch (_) {
      print("LESSON TEST Error" + _.toString());
      return {'error': 'something went worng'};
    }
  }

  Future<List<String>> getUserLessonsByCourseId(
      {@required String token, @required String courseId}) async {
    print('courseId' + courseId.toString());
    Uri url = Uri.parse(
        BASIC_URL + '/api/v1/student/mycourses/lessons?courseId=$courseId');
    Response response = await get(url, headers: {'Authorization': token});
    print(response.body);
    try {
      List<String> lessonsIds = [];
      var body = json.decode(response.body);
      for (var lesson in body) {
        try {
          lessonsIds.add(lesson['_id']);
        } catch (_) {}
      }
      print('user lessonsIds');
      print(lessonsIds);
      return lessonsIds;
    } catch (e) {
      print('get user lessons and lessons ids Error:');
      print(e);
      return [];
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
      if (response.body == 'Unauthorized') {
        return {'error': 'Unauthorized'};
      }
      var body = json.decode(response.body);
      if (body['message'] != null) {
        return {'error': body['message']};
      }
      if (MyApp.mainModel.currentUser != null) {
        MyApp.mainModel.currentUser.lessonsIds.add(lessonId);
      }
      return body;
    } catch (_) {
      return {'error': 'somethin went worng'};
    }
  }

  Future<dynamic> reEnrollInLesson(
      {@required String token,
      @required String courseId,
      @required String lessonId}) async {
    try {
      var uri = Uri.parse(BASIC_URL + "/api/v1/student/reenrollLesson");
      var response = await post(uri,
          body: {'courseId': courseId, 'lessonId': lessonId},
          headers: {'Authorization': token});
      if (response.body == 'Unauthorized') {
        return {'error': 'Unauthorized'};
      }
      var body = json.decode(response.body);
      if (body['message'] != null) {
        return {'error': body['message']};
      }
      if (MyApp.mainModel.currentUser != null) {
        MyApp.mainModel.currentUser.lessonsIds.add(lessonId);
      }
      return body;
    } catch (_) {
      return {'error': 'somethin went worng'};
    }
  }

  Future<int> updateLessonProgress(
      {@required String token,
      @required String courseId,
      @required String lessonId}) async {
    int count = -1;
    try {
      var uri = Uri.parse(BASIC_URL + "/api/v1/student/myProgress");
      var response = await post(uri,
          body: {'courseId': courseId, 'lessonId': lessonId},
          headers: {'Authorization': token});
      if (response.body == 'Unauthorized') {
        return count;
      }
      print(lessonId);
      var body = json.decode(response.body);

      print(body);

      count = ((body as List)
                  .firstWhere((element) => element['id'] == courseId)['lessons']
              as List)
          .firstWhere((element) => element['id'] == lessonId)['count'];
      return count;
    } catch (e) {
      print('Error at update watching video');
      print(e);
    }
    return count;
  }

  Future<List<Lesson>> convertToLesson(body) async {
    List<Lesson> lessons = [];
    for (var lesson in body) {
      try {
        print("lessonBody " + lesson.toString());
        lessons.add(
          Lesson(
              id: lesson['_id'],
              title: lesson['title'],
              description: lesson['description'],
              imageUrl: lesson['imageUrl'],
              price: lesson['price'],
              maxCount: lesson['maxCount'] != null ? body['maxCount'] : 0,
              count: lesson['count'] != null ? body['count'] : 0),
        );
        print("lessonBody end");
      } catch (e) {
        print(e);
      }
    }
    return lessons;
  }

  Future<List<Lesson>> getTeacherLessons(courseId, token) async {
    var uri = Uri.parse(
        BASIC_URL + "/api/v1/teacher/myCourses/lessons?courseId=$courseId");
    try {
      var response = await get(uri, headers: {'Authorization': token});

      var body = json.decode(response.body);

      return await convertToLesson(body);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
