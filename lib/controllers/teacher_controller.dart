import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pharma_line/config/basic_config.dart';
import 'package:pharma_line/models/user.dart';
import 'package:http/http.dart' as http;

class TeacherController {
  Future<List<User>> getCourseStudents(
      {@required String token, @required String courseId}) async {
    List<User> users = [];
    try {
      Uri url = Uri.parse(
          BASIC_URL + '/api/v1/teacher/myCourses/students?courseId=$courseId');
      http.Response response =
          await http.get(url, headers: {'Authorization': token});
      var body = json.decode(response.body);
      for (var user in body) {
        try {
          users.add(
            User(
                email: user['email'],
                firstName: user['firstName'],
                lastName: user['lastName'],
                phoneNumber: user['phoneNumber']),
          );
        } catch (_) {}
      }
    } catch (_) {}
    return users;
  }
}
