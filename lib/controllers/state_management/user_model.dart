import 'package:flutter/material.dart';
import 'package:pharma_line/models/course.dart';
import 'package:pharma_line/models/history.dart';
import 'package:pharma_line/models/history_status.dart';
import 'package:pharma_line/models/user.dart';

mixin UserModel on ChangeNotifier {
  User currentUser = User(
      userName: 'Abdo Ragab',
      email: 'test@test.com',
      profileImageUrl:
          'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg',
      points: 150);

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
}
