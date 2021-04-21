import 'package:flutter/material.dart';

class Course {
  final String imageUrl;
  final String title;
  final String category;
  final String doctorName;
  final String university;
  final String faculty;
  final bool isLive;
  final int progressPercentage;

  Course(
      {@required this.imageUrl,
      @required this.title,
      @required this.category,
      @required this.doctorName,
      @required this.university,
      @required this.faculty,
      @required this.isLive,
      this.progressPercentage});
}
