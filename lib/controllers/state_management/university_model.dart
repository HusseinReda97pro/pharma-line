import 'package:flutter/material.dart';
import 'package:pharma_line/controllers/university_controller.dart';
import 'package:pharma_line/models/university.dart';

mixin UniversitiesModel on ChangeNotifier {
  List<University> universities = [];
  bool loadingUniversities = false;
  UniversityController _universityController = UniversityController();
  Future<void> getUniversities() async {
    loadingUniversities = true;
    notifyListeners();
    universities = await _universityController.getUniversities();
    loadingUniversities = false;
    notifyListeners();
  }
}
