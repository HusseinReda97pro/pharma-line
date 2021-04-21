import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pharma_line/config/basic_config.dart';
import 'package:pharma_line/models/faculty.dart';
import 'package:pharma_line/models/university.dart';

class UniversityController {
  Future<List<University>> getUniversities() async {
    List<University> universities = [];
    Uri url = Uri.parse(BASIC_URL + '/api/v1/universities');
    http.Response response = await http.get(url);
    var data = json.decode(response.body);
    try {
      for (var uni in data) {
        List<Faculty> faculties = [];
        for (var faculty in uni['faculties']) {
          faculties.add(Faculty(id: faculty['_id'], name: faculty['name']));
        }
        universities.add(University(
            id: uni['_id'], name: uni['name'], faculties: faculties));
      }
    } catch (e) {
      print(e);
    }
    return universities;
  }
}
