import 'package:flutter/material.dart';

class Course {
  final String imageUrl;
  final String title;
  final String label;
  final String teacher;
  final String university;
  final String faculty;
  final bool isLive;
  final int progressPercentage;

  final String description;
  final String id;

  Course(
      {@required this.id,
      @required this.description,
      @required this.imageUrl,
      @required this.title,
      @required this.label,
      @required this.teacher,
      @required this.university,
      @required this.faculty,
      @required this.isLive,
      this.progressPercentage});
}
