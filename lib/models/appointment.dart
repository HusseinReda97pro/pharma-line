import 'package:flutter/material.dart';

class AppointmentData {
  final String title;
  final bool isLive;
  final String category;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final Color color;
  final bool isAllDay;
  final int id;

  AppointmentData({
    @required this.title,
    @required this.isLive,
    @required this.category,
    @required this.date,
    @required this.startTime,
    @required this.endTime,
    @required this.color,
    this.isAllDay = false,
    this.id,
  });
}
