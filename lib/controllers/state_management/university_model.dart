import 'package:flutter/material.dart';
import 'package:pharma_line/controllers/university_controller.dart';
import 'package:pharma_line/models/university.dart';

mixin UniversitiesModel on ChangeNotifier {
  List<University> universities = [];
  UniversityController _universityController = UniversityController();
  Future<void> getUniversities() async {
    universities = await _universityController.getUniversities();
    notifyListeners();
  }
}
