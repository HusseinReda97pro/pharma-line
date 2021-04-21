import 'package:flutter/material.dart';

class User {
  final String userName;
  final String email;
  final String profileImageUrl;
  final facultyId;
  final int points;

  User(
      {@required this.userName,
      @required this.email,
      @required this.profileImageUrl,
      @required this.facultyId,
      @required this.points});
}
