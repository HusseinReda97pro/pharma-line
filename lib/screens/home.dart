import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/models/course.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/course_card.dart';

import 'file:///D:/MobileDevelopment/pharma_line/lib/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //TODO Edit courses list
  List<Course> courses = [
    Course(
        category: 'Physics',
        doctorName: 'Ahmed Youssef',
        faculty: 'Science',
        isLive: true,
        university: 'Helwan',
        title: 'chemistry fundamentals',
        imageUrl:
            'https://codata.org/wp-content/uploads/2020/10/if_open-science.png'),
    Course(
        category: 'Physics',
        doctorName: 'Ahmed Youssef',
        faculty: 'Science',
        isLive: false,
        university: 'Helwan',
        title: 'chemistry fundamentals',
        imageUrl:
            'https://codata.org/wp-content/uploads/2020/10/if_open-science.png',
        progressPercentage: 20),
    Course(
        category: 'Math',
        doctorName: 'Ahmed Youssef',
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
              margin: EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Hi  ',
                        style:
                            TextStyle(color: Palette.lightBlue, fontSize: 22.0),
                      ),
                      Text(
                        'Abdo!',
                        style: TextStyle(
                            color: Palette.lightBlue,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Text(
                    'Ready to learn?',
                    style: TextStyle(color: Palette.lightBlue, fontSize: 22.0),
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
