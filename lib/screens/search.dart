import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/models/faculty.dart';
import 'package:pharma_line/models/university.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/course_card.dart';

import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static final String route = '/search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  University selectedUniversity;
  Faculty selectedFaculty;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        drawer: AppDrawer(),
        body: model.loadingCourses
            ? Center(
                child: Container(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                itemCount: model.currentCourses.length + 2,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05),
                            color: Palette.midBlue,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<University>(
                                  //value: 'Helwan University',
                                  hint: Text(
                                    selectedUniversity == null
                                        ? 'University'
                                        : selectedUniversity.name,
                                    style: TextStyle(color: Palette.lightBlue),
                                  ),
                                  iconSize: 32.0,
                                  iconEnabledColor: Palette.lightBlue,
                                  isExpanded: true,
                                  style: TextStyle(color: Palette.lightBlue),
                                  dropdownColor: Palette.midBlue,
                                  items: model.universities
                                      .map((University university) {
                                    return new DropdownMenuItem<University>(
                                      value: university,
                                      child: new Text(university.name),
                                    );
                                  }).toList(),
                                  onChanged: (university) {
                                    print(university);
                                    setState(() {
                                      selectedUniversity = university;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          !(selectedUniversity?.faculties != null)
                              ? SizedBox.shrink()
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5.0,
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  color: Palette.midBlue,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<Faculty>(
                                        //value: 'Helwan University',
                                        hint: Text(
                                          selectedFaculty == null
                                              ? 'Faculty'
                                              : selectedFaculty.name,
                                          style: TextStyle(
                                              color: Palette.lightBlue),
                                        ),
                                        iconSize: 32.0,
                                        iconEnabledColor: Palette.lightBlue,
                                        isExpanded: true,
                                        style:
                                            TextStyle(color: Palette.lightBlue),
                                        dropdownColor: Palette.midBlue,
                                        items: selectedUniversity.faculties
                                            .map((Faculty faculty) {
                                          return new DropdownMenuItem<Faculty>(
                                            value: faculty,
                                            child: new Text(faculty.name),
                                          );
                                        }).toList(),
                                        onChanged: (faculty) {
                                          setState(() {
                                            print("faculty id: " + faculty.id);
                                            try {
                                              model.getCoursesByFacultyId(
                                                  facultyId: faculty.id);
                                            } catch (e) {
                                              print(e);
                                            }

                                            selectedFaculty = faculty;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
                  }
                  if (index == model.currentCourses.length + 1) {
                    return SizedBox(
                      height: 100,
                    );
                  }

                  return CourseCard(
                    course: model.currentCourses[index - 1],
                  );
                },
              ),
      );
    });
  }
}
