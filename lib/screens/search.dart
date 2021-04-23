import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/models/course.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/course_card.dart';

import 'package:pharma_line/widgets/app_drawer.dart';

class SearchScreen extends StatefulWidget {
  static final String route = '/search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //TODO Edit courses list
  List<Course> courses = [
    Course(
        label: 'Physics',
        teacher: 'Ahmed Youssef',
        faculty: 'Science',
        isLive: false,
        university: 'Helwan',
        title: 'chemistry fundamentals',
        imageUrl:
            'https://codata.org/wp-content/uploads/2020/10/if_open-science.png',
        progressPercentage: 20),
    Course(
        label: 'Math',
        teacher: 'Ahmed Youssef',
        faculty: 'Science',
        isLive: false,
        university: 'Helwan',
        title: 'chemistry fundamentals',
        imageUrl:
            'https://codata.org/wp-content/uploads/2020/10/if_open-science.png',
        progressPercentage: 100),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        context: context,
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: courses.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    color: Palette.midBlue,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          //value: 'Helwan University',
                          hint: Text(
                            'University',
                            style: TextStyle(color: Palette.lightBlue),
                          ),
                          iconSize: 32.0,
                          iconEnabledColor: Palette.lightBlue,
                          isExpanded: true,
                          style: TextStyle(color: Palette.lightBlue),
                          dropdownColor: Palette.midBlue,
                          items: <String>[
                            'Helwan University',
                            'Cairo University',
                            'Alex University'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    color: Palette.midBlue,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          //value: 'Helwan University',
                          hint: Text(
                            'Faculty',
                            style: TextStyle(color: Palette.lightBlue),
                          ),
                          iconSize: 32.0,
                          iconEnabledColor: Palette.lightBlue,
                          isExpanded: true,
                          style: TextStyle(color: Palette.lightBlue),
                          dropdownColor: Palette.midBlue,
                          items: <String>[
                            'Faculty of computer science',
                            'Faculty of computer science',
                            'Faculty of computer science'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (index == courses.length + 1) {
            return SizedBox(
              height: 100,
            );
          }

          return CourseCard(
            course: courses[index - 1],
          );
        },
      ),
    );
  }
}
