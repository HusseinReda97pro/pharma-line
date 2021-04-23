import 'package:flutter/cupertino.dart';

class NotificationData {
  final String title;
  final bool isLive;
  final String category;
  final DateTime date;
  final DateTime startDuration;
  final DateTime endDuration;

  NotificationData(
      {@required this.title,
      @required this.isLive,
      @required this.category,
      @required this.date,
      this.startDuration,
       this.endDuration});
}
