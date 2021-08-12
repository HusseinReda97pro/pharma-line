import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:pharma_line/widgets/course_card.dart';
import 'package:provider/provider.dart';

class TrainingCourses extends StatefulWidget {
  static const route = '/trainingCourses';
  @override
  _TrainingCoursesState createState() => _TrainingCoursesState();
}

class _TrainingCoursesState extends State<TrainingCourses> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<MainModel>(context, listen: false).getTrainingCourses());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        drawer: AppDrawer(),
        body: model.currentUser != null && !model.currentUser.enabled
            ? Center(
                child: Text(
                  "Your Account Was disabled Contact Us For More Details",
                  style: TextStyle(
                    color: Palette.lightBlue,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : model.loadingCourses
                ? Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: model.triaingCourses.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          child: Text("Training Courses",
                              style: TextStyle(
                                  color: Palette.lightBlue,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold)),
                        );
                      }

                      return CourseCard(
                        course: model.triaingCourses[index - 1],
                      );
                    },
                  ),
      );
    });
  }
}
