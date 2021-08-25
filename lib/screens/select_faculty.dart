import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/models/faculty.dart';
import 'package:pharma_line/models/university.dart';
import 'package:pharma_line/screens/couses_list_by_faculty_type.dart';
import 'package:pharma_line/screens/select_type.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class SelectFaculty extends StatelessWidget {
  final University university;
  SelectFaculty({this.university});
  static const route = '/selectFaculty';
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: MainAppBar(
            context: context,
          ),
          drawer: AppDrawer(),
          body: university.faculties.length == 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Text("This University does not contain any Faculty.",
                      style: TextStyle(
                          color: Palette.lightBlue,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold)),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: university.faculties.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16.0),
                        child: Text("Select Faculty",
                            style: TextStyle(
                                color: Palette.lightBlue,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold)),
                      );
                    }

                    return InkWell(
                      onTap: () {
                        if (university.faculties[index - 1].types.length <= 1) {
                          model.getCoursesByFacultyId(
                              facultyId: university.faculties[index - 1].id,
                              type:
                                  university.faculties[index - 1].types.isEmpty
                                      ? null
                                      : university.faculties[index - 1].types
                                          .first.name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FacultyAndTypeCourses(
                                        faculty:
                                            university.faculties[index - 1],
                                        type: university.faculties[index - 1]
                                                .types.isEmpty
                                            ? null
                                            : university.faculties[index - 1]
                                                .types.first,
                                      )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectType(
                                        faculty:
                                            university.faculties[index - 1],
                                      )));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        child: Text(university.faculties[index - 1].name),
                        decoration: BoxDecoration(
                            color: Palette.lightBlue,
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
