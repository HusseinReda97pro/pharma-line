import 'package:flutter/material.dart';
import 'package:pharma_line/models/history_status.dart';

class History {
  final HistoryStatus status;
  // final Course course;
  final int amount;
  final lessonName;

  History(
      {@required this.status,
      // this.course,
      this.lessonName,
      @required this.amount});
}
