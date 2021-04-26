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

    try {
      var response = await request.send();
      final res = await http.Response.fromStream(response);
      var body = json.decode(res.body);

      if (body['errors'] != null) {
        List<String> errors = [];
        for (var error in body['errors'].values) {
          errors.add(error['message']);
        }
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
    print(deviceId);
    var postUri = Uri.parse(BASIC_URL + "/api/v1/student/login");
    var data = {'email': email, 'password': password, 'deviceId': deviceId};

    try {
      http.Response response = await http.post(postUri, body: data);
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

  Future<dynamic> updateUserInfo(
      User user, String password, io.File image, String token) async {
    var postUri = Uri.parse(BASIC_URL + "/api/v1/student/updateProfile");
    var request = new http.MultipartRequest("POST", postUri);

    // request.fields['email'] = user.email.isNotEmpty ? user.email : null;
    if (user.firstName.isNotEmpty) {
      request.fields['firstName'] = user.firstName;
    }
    if (user.lastName.isNotEmpty) {
      request.fields['lastName'] = user.lastName;
    }
    // request.fields['phoneNumber'] =
    //     user.phoneNumber.isNotEmpty ? user.phoneNumber : null;
    if (password.isNotEmpty) {
      request.fields['password'] = password;
    }
    if (image != null) {
      // request.files.add(new http.MultipartFile.fromBytes(
      //   'profilePicture',
      //   await image.readAsBytes(),
      // ));
      // open a bytestream
      var stream =
          new http.ByteStream(DelegatingStream.typed(image.openRead()));
      // get file length
      var length = await image.length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile(
          'profilePicture', stream, length,
          filename: basename(image.path));

      // add file to multipart
      request.files.add(multipartFile);
    }

    try {
      request.headers['Authorization'] = token;
      var response = await request.send();
      final res = await http.Response.fromStream(response);
      var body = json.decode(res.body);

      if (body['errors'] != null) {
        List<String> errors = [];
        for (var error in body['errors'].values) {
          errors.add(error['message']);
        }
        return {'errors': errors};
      }
      if (body['message'] != null) {
        return {
          'errors': ['something went wrong']
        };
      }
      return {'user': body};
    } catch (e) {
      print(e);
      return {
        'errors': ['something went wrong']
      };
    }
  }

  Future<void> storeUser({String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<User> getStoredUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    if (token == null) {
      return null;
    }

    String deviceId = await DeviceToken.getId();
    var postUri = Uri.parse(BASIC_URL + "/api/v1/student/token-login");
    var data = {'deviceId': deviceId};
    print(data);

    try {
      http.Response response = await http
          .post(postUri, body: data, headers: {'Authorization': token});
      if (response.body == 'Unauthorized') {
        return null;
      }
      print(response.body);
      var body = json.decode(response.body);
      print(body);
      if (body['errors'] != null) {
        return null;
      }
      var id = body['_id'];

      var firstName = body['firstName'];
      var lastName = body['lastName'];
      var email = body['email'];
      var phoneNumber = body['phoneNumber'];
      var deviceId = body['deviceId'];
      var facultyId = body['faculty'];
      var points = body['points'];
      var balance = body['balance'].toString();
      var imageUrl = body["profilePicture"];
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
          id: id,
          coursesIds: [],
          lessonsIds: []);
      return user;
    } catch (e) {
      print('auto login error');
      print(e);
      return null;
    }
  }

  Future<void> removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Future<List<History>> getHistory(token) async {
    List<History> histories = [];
    HistoryStatus userstatus;
    Uri url = Uri.parse(BASIC_URL + '/api/v1/student/myHistory');
    http.Response response = await http
        .get(url, headers: {io.HttpHeaders.authorizationHeader: token});
    var data = json.decode(response.body);

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
        histories.add(
          History(
              amount: hist['transactionAmout'],
              status: userstatus,
              lessonName: hist['title'] ?? hist['transactionType']
              // hist['productId']
              ),
        );
      }
    } catch (e) {
      print(e);
    }
    return histories;
  }

  Future<List<NotificationData>> getNotification(token) async {
    List<NotificationData> Notification = [];
    //String lessontatus;
    Uri url = Uri.parse(BASIC_URL + '/api/v1/student/myNotifications');
    http.Response response = await http
        .get(url, headers: {io.HttpHeaders.authorizationHeader: token});
    var data = json.decode(response.body);

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
