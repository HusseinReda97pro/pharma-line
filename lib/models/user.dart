import 'package:flutter/material.dart';

class User {
  String id;
  String token;
  String deviceId;
  final String firstName;
  final String lastName;
  final String email;
  final String profileImageUrl;
  final facultyId;
  final String phoneNumber;
  final int points;
  String balance;
  List<String> coursesIds;
  List<String> lessonsIds;
  User(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      this.profileImageUrl,
      this.facultyId,
      @required this.phoneNumber,
      this.points,
      this.id,
      this.deviceId,
      this.balance,
      this.token,
      this.coursesIds,
      this.lessonsIds});
}
