import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/models/user_type.dart';
import 'package:pharma_line/screens/about_screen.dart';
import 'package:pharma_line/screens/home.dart';
import 'package:pharma_line/screens/login.dart';
import 'package:pharma_line/screens/my_courses.dart';
import 'package:pharma_line/screens/profile.dart';
import 'package:pharma_line/screens/signup.dart';
import 'package:pharma_line/screens/terms_and_conditions_screen.dart';
import 'package:pharma_line/screens/training_courses.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  Widget _listTile(
      {@required BuildContext context,
      @required title,
      @required IconData icon,
      @required Function onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        leading: Icon(
          icon,
          size: 24.0,
          color: Palette.lightBlue,
        ),
        title: Text(
          title,
          style: TextStyle(color: Palette.lightBlue, fontSize: 16.0),
        ),
      ),
    );
  }

  void _navigeteToPage(BuildContext context, String routeName) {
    String name = ModalRoute.of(context).settings.name;
    if (routeName == name) {
      Navigator.of(context).pop();
    } else if (routeName == HomeScreen.route) {
      Navigator.of(context).popUntil(ModalRoute.withName(HomeScreen.route));
    } else {
      Navigator.of(context).popUntil(ModalRoute.withName(HomeScreen.route));
      Navigator.of(context).pushNamed(routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
      builder: (BuildContext context, MainModel model, Widget child) {
        return Drawer(
          elevation: 0,
          child: Container(
            color: Palette.darkBlue,
            child: ListView(
              children: [
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                _listTile(
                  context: context,
                  title: 'Home',
                  icon: Icons.home,
                  onPressed: () {
                    _navigeteToPage(context, HomeScreen.route);
                  },
                ),
                (model.currentUser == null ||
                        model.currentUserType == UserType.TEACHER ||
                        !model.currentUser.enabled)
                    ? Container()
                    : _listTile(
                        context: context,
                        title: 'My Courses',
                        icon: Icons.book,
                        onPressed: () {
                          print(model.currentUser.token);
                          model.getMyCourses(token: model.currentUser.token);
                          _navigeteToPage(context, MyCoursesScreen.route);
                        },
                      ),
                (model.currentUser == null ||
                        model.currentUserType == UserType.TEACHER ||
                        !model.currentUser.enabled)
                    ? Container()
                    : _listTile(
                        context: context,
                        title: 'Profile',
                        icon: Icons.person,
                        onPressed: () {
                          _navigeteToPage(context, ProfileScreen.route);
                        },
                      ),
                model.currentUser == null
                    ? _listTile(
                        context: context,
                        title: 'Login',
                        icon: Icons.person,
                        onPressed: () {
                          _navigeteToPage(context, LoginScreen.route);
                        },
                      )
                    : _listTile(
                        context: context,
                        title: 'Logout',
                        icon: Icons.logout,
                        onPressed: () {
                          model.logout();
                          model.getCourses();
                          Navigator.popUntil(
                              context, ModalRoute.withName(HomeScreen.route));
                        },
                      ),
                model.currentUser == null
                    ? _listTile(
                        context: context,
                        title: 'Signup',
                        icon: Icons.person_add,
                        onPressed: () {
                          model.getUniversities();
                          _navigeteToPage(context, SignUpScreen.route);
                        },
                      )
                    : Container(),
                _listTile(
                  context: context,
                  title: 'Training Courses',
                  icon: Icons.model_training,
                  onPressed: () {
                    _navigeteToPage(context, TrainingCourses.route);
                  },
                ),
                _listTile(
                  context: context,
                  title: 'About',
                  icon: Icons.not_listed_location_sharp,
                  onPressed: () {
                    _navigeteToPage(context, AboutScreen.route);
                  },
                ),
                _listTile(
                  context: context,
                  title: 'Terms & Conditions',
                  icon: Icons.info_outline_rounded,
                  onPressed: () {
                    _navigeteToPage(context, TermsAndConditionsScreen.route);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
