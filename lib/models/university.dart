import 'package:flutter/material.dart';
import 'package:pharma_line/models/faculty.dart';

class University {
  final String id;
  final String name;
  final List<Faculty> faculties;
  University(
      {@required this.id, @required this.name, @required this.faculties});
}
