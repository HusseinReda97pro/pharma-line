import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pharma_line/controllers/user_controller.dart';
import 'package:pharma_line/models/course.dart';
import 'package:pharma_line/models/history.dart';
import 'package:pharma_line/models/history_status.dart';
import 'package:pharma_line/models/user.dart';

mixin UserModel on ChangeNotifier {
  User currentUser;
  // = User(
  //     firstName: 'Abdo',
  //     lastName: 'ragb',
  //     email: 'test@test.com',
  //     profileImageUrl:
  //         'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg',
  //     points: 150);
  UserController userController = UserController();
  List<History> history = [
    History(
        status: HistoryStatus.SPEND,
        course: Course(
            category: 'Physics',
            doctorName: 'Ahmed Youssef',
            faculty: 'Science',
            isLive: false,
            university: 'Helwan',
            title: 'chemistry fundamentals',
            imageUrl:
                'https://codata.org/wp-content/uploads/2020/10/if_open-science.png',
            progressPercentage: 20),
        amount: 5),
    History(status: HistoryStatus.RECHARGE, amount: 20),
    History(
        status: HistoryStatus.COMPLETE,
        course: Course(
            category: 'Math',
            doctorName: 'Ahmed Youssef',
            faculty: 'Science',
            isLive: false,
            university: 'Helwan',
            title: 'chemistry fundamentals',
            imageUrl:
                'https://codata.org/wp-content/uploads/2020/10/if_open-science.png',
            progressPercentage: 100),
        amount: 5)
  ];

  Future<dynamic> signUp({User user, String password, File image}) async {
    var res = await userController.signUp(user, password, image);
    print(res);
    if (res['errors'] != null) {
      return res;
    }
    var signedUpUser = res['user'];
    currentUser = User(
      id: signedUpUser['_id'],
      token: signedUpUser['token'],
      phoneNumber: signedUpUser['phoneNumber'],
      firstName: signedUpUser['firstName'],
      lastName: signedUpUser['lastName'],
      email: signedUpUser['email'],
      points: signedUpUser['points'],
      balance: signedUpUser['balance'].toString(),
      deviceId: signedUpUser['deviceId'],
      facultyId: signedUpUser['faculty'],
      profileImageUrl: null,
    );
    userController.storeUser(currentUser);
  }

  Future<dynamic> login({String email, String password}) async {
    var res = await userController.login(email, password);
    print(res);
    if (res['errors'] != null) {
      return res;
    }
    var signedUpUser = res['user'];
    currentUser = User(
      id: signedUpUser['_id'],
      token: signedUpUser['token'],
      phoneNumber: signedUpUser['phoneNumber'],
      firstName: signedUpUser['firstName'],
      lastName: signedUpUser['lastName'],
      email: signedUpUser['email'],
      points: signedUpUser['points'],
      balance: signedUpUser['balance'].toString(),
      deviceId: signedUpUser['deviceId'],
      facultyId: signedUpUser['faculty'],
      profileImageUrl: null,
    );
    userController.storeUser(currentUser);
  }

  void logout() {
    userController.removeUser();
    currentUser = null;
  }

  Future<void> autoLogin() async {
    currentUser = await userController.getStoredUser();
  }
}
