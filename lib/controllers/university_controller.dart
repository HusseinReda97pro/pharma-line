import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pharma_line/config/basic_config.dart';
import 'package:pharma_line/models/faculty.dart';
import 'package:pharma_line/models/type.dart';
import 'package:pharma_line/models/university.dart';

class UniversityController {
  Future<List<University>> getUniversities() async {
    List<University> universities = [];
    Uri url = Uri.parse(BASIC_URL + '/api/v1/universities');
    http.Response response = await http.get(url);
    var data = json.decode(response.body);
    log(data.toString());
    try {
      for (var uni in data) {
        List<Faculty> faculties = [];

        for (var faculty in uni['faculties']) {
          faculties.add(Faculty(
              id: faculty['_id'],
              name: faculty['name'],
              types: (faculty['types'] as List)
                  ?.map(
                      (item) => TypeModel(id: item['_id'], name: item['name']))
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
