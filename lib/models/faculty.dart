import 'package:flutter/material.dart';
import 'package:pharma_line/models/type.dart';

class Faculty {
  final String id;
  final String name;
  final List<TypeModel> types;
  Faculty({@required this.id, @required this.name, @required this.types});
}
