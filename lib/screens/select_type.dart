import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/models/faculty.dart';
import 'package:pharma_line/screens/couses_list_by_faculty_type.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class SelectType extends StatelessWidget {
  final Faculty faculty;
  SelectType({this.faculty});
  static const route = '/selectType';

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: faculty.types.length + 1,
          itemBuilder: (context, index) {
            if (index == 0)
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Text("Select Type",
                    style: TextStyle(
                        color: Palette.lightBlue,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold)),
              );
            return InkWell(
              onTap: () {
                model.getCoursesByFacultyId(
                    facultyId: faculty.id, type: faculty.types[index - 1]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FacultyAndTypeCourses(
                              faculty: faculty,
                              type: faculty.types[index - 1],
                            )));
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Text(faculty.types[index - 1]),
                decoration: BoxDecoration(
                    color: Palette.lightBlue,
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            );
          },
        ),
      );
    });
  }
}
