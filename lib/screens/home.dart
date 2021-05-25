import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/models/user_type.dart';
import 'package:pharma_line/screens/course_students.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/course_card.dart';
import 'package:provider/provider.dart';

import 'package:pharma_line/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedType;
  int selectedLevel;
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
            : model.homeCourses.length == 0
                ? Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Text(
                                      'Level',
                                      style:
                                          TextStyle(color: Palette.lightBlue),
                                    ),
                                    iconSize: 32.0,
                                    iconEnabledColor: Palette.lightBlue,
                                    isExpanded: true,
                                    style: TextStyle(color: Palette.lightBlue),
                                    dropdownColor: Palette.midBlue,
                                    value: selectedLevel,
                                    onChanged: (value) {
                                      selectedLevel = value;
                                      try {
                                        model.getCourses(
                                            level: selectedLevel,
                                            type: selectedType);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("Level 1"),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Level 2"),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Level 3"),
                                        value: 3,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Level 4"),
                                        value: 4,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Level 5"),
                                        value: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Text(
                                      'Type',
                                      style:
                                          TextStyle(color: Palette.lightBlue),
                                    ),
                                    iconSize: 32.0,
                                    iconEnabledColor: Palette.lightBlue,
                                    isExpanded: true,
                                    style: TextStyle(color: Palette.lightBlue),
                                    dropdownColor: Palette.midBlue,
                                    value: selectedType,
                                    onChanged: (value) {
                                      selectedType = value;
                                      try {
                                        model.getCourses(
                                            level: selectedLevel,
                                            type: selectedType);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("Medical"),
                                        value: "medical",
                                      ),
                                      DropdownMenuItem(
                                        child: Text("General"),
                                        value: "general",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (selectedLevel != null || selectedType != null)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedLevel = null;
                                      selectedType = null;
                                      model.getCourses();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    color: Palette.lightBlue,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Text(
                          'there is no courses yet.',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      selectedLevel = null;
                      selectedType = null;
                      await model.getCourses();
                    },
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: model.homeCourses.length + 3,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return (model.currentUser == null ||
                                  model.currentUserType == UserType.TEACHER)
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.all(25.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Hi  ',
                                            style: TextStyle(
                                                color: Palette.lightBlue,
                                                fontSize: 22.0),
                                          ),
                                          Text(
                                            model.currentUser.firstName +
                                                ' ' +
                                                model.currentUser.lastName +
                                                '!',
                                            style: TextStyle(
                                                color: Palette.lightBlue,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Text(
                                        'Ready to learn?',
                                        style: TextStyle(
                                            color: Palette.lightBlue,
                                            fontSize: 22.0),
                                      ),
                                    ],
                                  ),
                                );
                        }
                        if (index == model.homeCourses.length + 2) {
                          return SizedBox(
                            height: 100,
                          );
                        }
                        if (index == 1) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: Text(
                                        'Level',
                                        style:
                                            TextStyle(color: Palette.lightBlue),
                                      ),
                                      iconSize: 32.0,
                                      iconEnabledColor: Palette.lightBlue,
                                      isExpanded: true,
                                      style:
                                          TextStyle(color: Palette.lightBlue),
                                      dropdownColor: Palette.midBlue,
                                      value: selectedLevel,
                                      onChanged: (value) {
                                        selectedLevel = value;
                                        try {
                                          model.getCourses(
                                              level: selectedLevel,
                                              type: selectedType);
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Level 1"),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Level 2"),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Level 3"),
                                          value: 3,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Level 4"),
                                          value: 4,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Level 5"),
                                          value: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      hint: Text(
                                        'Type',
                                        style:
                                            TextStyle(color: Palette.lightBlue),
                                      ),
                                      iconSize: 32.0,
                                      iconEnabledColor: Palette.lightBlue,
                                      isExpanded: true,
                                      style:
                                          TextStyle(color: Palette.lightBlue),
                                      dropdownColor: Palette.midBlue,
                                      value: selectedType,
                                      onChanged: (value) {
                                        selectedType = value;
                                        try {
                                          model.getCourses(
                                              level: selectedLevel,
                                              type: selectedType);
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Medical"),
                                          value: "medical",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("General"),
                                          value: "general",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (selectedLevel != null ||
                                    selectedType != null)
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedLevel = null;
                                        selectedType = null;
                                        model.getCourses();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Palette.lightBlue,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }
                        return CourseCard(
                          course: model.homeCourses[index - 2],
                        );
                      },
                    ),
                  ),
      );
    });
  }
}
