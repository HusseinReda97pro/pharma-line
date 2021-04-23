import 'package:flutter/material.dart';
import 'package:pharma_line/models/notification.dart';
import 'package:pharma_line/models/user.dart';

import '../user_controller.dart';

mixin NotificationModel on ChangeNotifier {
  List<NotificationData> notifications = [];
  User currentUser;
  UserController userController = UserController();

  /*List<NotificationData> notifications = [
    NotificationData(
      title: 'chemistry fundamentals',
      isLive: true,
      category: 'Math',
      date: DateTime.utc(2021, 3, 26),
      startDuration: DateTime.utc(0, 0, 0, 10, 30),
      endDuration: DateTime.utc(0, 0, 0, 13, 30),
    ),
    NotificationData(
      title: 'chemistry fundamentals',
      isLive: true,
      category: 'Math',
      date: DateTime.utc(2021, 3, 21),
      startDuration: DateTime.utc(0, 0, 0, 10, 30),
      endDuration: DateTime.utc(0, 0, 0, 13, 30),
    )
  ];*/


  bool loadingNotification = false;
  Future<void> getNotification() async {
    loadingNotification = true;
    notifyListeners();
    notifications = await userController.getNotification(currentUser.token);
    loadingNotification = false;
    notifyListeners();
  }
}
