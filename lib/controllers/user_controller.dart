import 'dart:convert';
import 'dart:io' as io;

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:pharma_line/config/basic_config.dart';
import 'package:pharma_line/models/history.dart';
import 'package:pharma_line/models/history_status.dart';
import 'package:pharma_line/models/notification.dart';
import 'package:pharma_line/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'device_token.dart';

class UserController {
  Future<dynamic> signUp(User user, String password, io.File image) async {
    String deviceId = await DeviceToken.getId();
    var postUri = Uri.parse(BASIC_URL + "/api/v1/student/signup");
    var request = new http.MultipartRequest("POST", postUri);

    request.fields['email'] = user.email;
    request.fields['firstName'] = user.firstName;
    request.fields['lastName'] = user.lastName;
    request.fields['phoneNumber'] = user.phoneNumber;
    request.fields['password'] = password;
    request.fields['deviceId'] = deviceId;
    request.fields['faculty'] = user.facultyId;

    // request.files.add(new http.MultipartFile.fromBytes(
    //   'profilePicture',
    //   await image.readAsBytes(),
    // ));
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    // get file length
    var length = await image.length();

    // multipart that takes file
    var multipartFile = new http.MultipartFile('profilePicture', stream, length,
        filename: basename(image.path));

    // add file to multipart
    request.files.add(multipartFile);

    print(request.fields);
    print(request.files);

    try {
      // return {
      //   'errors': ['something went wrong']
      // };
      var response = await request.send();
      final res = await http.Response.fromStream(response);
      print(res.body);
      print(response.statusCode);
      var body = json.decode(res.body);

      if (body['errors'] != null) {
        List<String> errors = [];
        for (var error in body['errors'].values) {
          errors.add(error['message']);
        }
        print(errors);
        return {'errors': errors};
      }
      if (body['message'] != null) {
        return {
          'errors': ['something went wrong']
        };
      }
      return {'user': body};
    } catch (e) {
      return {
        'errors': ['something went wrong']
      };
    }
  }

  Future<dynamic> login(String email, String password) async {
    String deviceId = await DeviceToken.getId();
    print("________________________");
    print(deviceId);
    var postUri = Uri.parse(BASIC_URL + "/api/v1/student/login");
    var data = {'email': email, 'password': password, 'deviceId': deviceId};

    try {
      http.Response response = await http.post(postUri, body: data);
      print(response.body);
      if (response.body == 'Unauthorized') {
        return {
          'errors': ['Unauthorized']
        };
      }
      var body = json.decode(response.body);

      if (body['errors'] != null) {
        List<String> errors = [];
        for (var error in body['errors'].values) {
          errors.add(error['message']);
        }
        print(errors);
        return {'errors': errors};
      }

      return {'user': body};
    } catch (e) {
      print(e);
      return {
        'errors': ['something went wrong']
      };
    }
  }

  Future<void> storeUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.id);
    prefs.setString('token', user.token);
    prefs.setString('firstName', user.firstName);
    prefs.setString('lastName', user.lastName);
    prefs.setString('email', user.email);
    prefs.setString('phoneNumber', user.phoneNumber);
    prefs.setString('deviceId', user.deviceId);
    prefs.setString('facultyId', user.facultyId);
    prefs.setInt('points', user.points);
    prefs.setString('balance', user.balance);
    prefs.setString("profilePicture", user.profileImageUrl);
  }

  Future<User> getStoredUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.get('id');
    if (id == null) {
      return null;
    }
    var token = prefs.get('token');
    var firstName = prefs.get('firstName');
    var lastName = prefs.get('lastName');
    var email = prefs.get('email');
    var phoneNumber = prefs.get('phoneNumber');
    var deviceId = prefs.get('deviceId');
    var facultyId = prefs.get('facultyId');
    var points = prefs.get('points');
    var balance = prefs.get('balance');
    var imageUrl = prefs.get("profilePicture");
    User user = User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        profileImageUrl: imageUrl,
        facultyId: facultyId,
        phoneNumber: phoneNumber,
        points: points,
        deviceId: deviceId,
        token: token,
        balance: balance,
        id: id);
    return user;
  }

  Future<void> removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('token');
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('email');
    prefs.remove('phoneNumber');
    prefs.remove('deviceId');
    prefs.remove('facultyId');
    prefs.remove('points');
    prefs.remove('balance');
  }

  Future<List<History>> getHistory(token) async {
    List<History> Histories = [];
    HistoryStatus userstatus;
    Uri url = Uri.parse(BASIC_URL + '/api/v1/student/myHistory');
    http.Response response = await http
        .get(url, headers: {io.HttpHeaders.authorizationHeader: token});
    var data = json.decode(response.body);
    print(data);

    try {
      for (var hist in data) {
        //enum HistoryStatus { SPEND, COMPLETE, RECHARGE }
        //   transactionType:  String, enum: ["Add", "Course", "Lesson"],
        //course it will be the lesson id of the course then in the page request the details by lesson id
        if (hist['transactionType'] == 'Add') {
          userstatus = HistoryStatus.RECHARGE;
        } else if (hist['transactionType'] == 'Course') {
          userstatus = HistoryStatus.COMPLETE;
        } else {
          userstatus = HistoryStatus.SPEND;
        }
        Histories.add(
          History(
              amount: hist['transactionAmout'],
              status: userstatus,
              lessonName: 'test'
              // hist['productId']
              ),
        );
      }
    } catch (e) {
      print(e);
    }
    return Histories;
  }

  Future<List<NotificationData>> getNotification(token) async {
    List<NotificationData> Notification = [];
    //String lessontatus;
    Uri url = Uri.parse(BASIC_URL + '/api/v1/student/myNotifications');
    http.Response response = await http
        .get(url, headers: {io.HttpHeaders.authorizationHeader: token});
    var data = json.decode(response.body);
    print('______________________________________');
    print(data);
    try {
      for (var notifcation in data) {
        Notification.add(NotificationData(
            title: notifcation['title'],
            isLive: notifcation['isLive'],
            category: notifcation['label'],
            date: DateTime.parse(notifcation['date'])));
      }
    } catch (e) {
      print(e);
    }
    return Notification;
  }
}
