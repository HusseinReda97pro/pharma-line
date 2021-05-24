import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/models/user_type.dart';
import 'package:pharma_line/screens/course_students.dart';
import 'package:pharma_line/screens/home.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/course_card.dart';
import 'package:provider/provider.dart';

import 'package:pharma_line/widgets/app_drawer.dart';

class HomeOneScreen extends StatelessWidget {
  void navigateToCourses (ctx , String type){
    Navigator.pushNamed(ctx, HomeScreen.route);

  }

  static const route = '/';
    @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
          return Scaffold(
            appBar: MainAppBar(
              context: context,
            ),
            drawer: AppDrawer(),
            body:  (model.currentUser == null ||
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

                  ElevatedButton(onPressed: (){navigateToCourses(context, "Medical");}, child: Text("Medical")),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){navigateToCourses(context, "General");}, child: Text("General")),




                ],
              ),
            )


          );
        });
  }
}
