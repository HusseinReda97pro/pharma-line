import 'dart:convert';
import 'dart:io' as io;

import 'package:http/http.dart' as http;
import 'package:pharma_line/config/basic_config.dart';
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

    request.files.add(new http.MultipartFile.fromBytes(
      'profilePicture',
      await image.readAsBytes(),
    ));
    try {
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
      return {'user': body};
    } catch (e) {
      return {
        'errors': ['something went wrong']
      };
    }
  }

  Future<dynamic> login(String email, String password) async {
    String deviceId = await DeviceToken.getId();
    var postUri = Uri.parse(BASIC_URL + "/api/v1/student/login");
    var data = {'email': email, 'password': password, 'deviceId': deviceId};

    try {
      http.Response response = await http.post(postUri, body: data);
      print(response.body);
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
    User user = User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        profileImageUrl: null,
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
}
