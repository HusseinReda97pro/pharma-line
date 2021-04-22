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
  User(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.profileImageUrl,
      @required this.facultyId,
      @required this.phoneNumber,
      @required this.points,
      this.id,
      this.deviceId,
      this.balance,
      this.token});
}
