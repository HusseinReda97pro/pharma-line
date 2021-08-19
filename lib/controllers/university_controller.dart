import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pharma_line/config/basic_config.dart';
import 'package:pharma_line/models/faculty.dart';
import 'package:pharma_line/models/university.dart';

class UniversityController {
  Future<List<University>> getUniversities() async {
    List<University> universities = [];
    Uri url = Uri.parse(BASIC_URL + '/api/v1/universities');
    print("getting Universities");
    http.Response response = await http.get(url);
    print("Got Universities");
    var data = json.decode(response.body);
    print(data);
    try {
      for (var uni in data) {
        List<Faculty> faculties = [];

        for (var faculty in uni['faculties']) {
          faculties.add(Faculty(
              id: faculty['_id'],
              name: faculty['name'],
              types: (faculty['types'] as List)
                  ?.map((item) => item as String)
                  ?.toList()));
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
