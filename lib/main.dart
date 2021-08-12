import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:pharma_line/config/theme.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/models/user_type.dart';
import 'package:pharma_line/screens/about_screen.dart';
import 'package:pharma_line/screens/course_students.dart';
import 'package:pharma_line/screens/home.dart';
import 'package:pharma_line/screens/login.dart';
import 'package:pharma_line/screens/my_courses.dart';
import 'package:pharma_line/screens/notifications.dart';
import 'package:pharma_line/screens/profile.dart';
import 'package:pharma_line/screens/schedule.dart';
import 'package:pharma_line/screens/search.dart';
import 'package:pharma_line/screens/secure_scrren.dart';
import 'package:pharma_line/screens/select_faculty.dart';
import 'package:pharma_line/screens/select_university.dart';
import 'package:pharma_line/screens/signup.dart';
import 'package:pharma_line/screens/terms_and_conditions_screen.dart';
import 'package:pharma_line/screens/training_courses.dart';
import 'package:pharma_line/screens/user_info.dart';
import 'package:pharma_line/screens/wallet.dart';
import 'package:provider/provider.dart';
//import 'package:secure_application/secure_application.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  print("firebase Done");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data);
    ScaffoldMessenger.of(MyApp.navigatorKey.currentState.context)
        .showSnackBar(SnackBar(content: Text(event.data['title'])));
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final MainModel mainModel = MainModel();
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    // FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    mainModel.autoLogin();
    mainModel.getUniversities();
    if (mainModel.currentCourses != null &&
        mainModel.currentUserType == UserType.STUDENT) {
      mainModel.getCourses();
    }
    if (mainModel.currentCourses != null &&
        mainModel.currentUserType == UserType.STUDENT) {
      try {
        mainModel.getMyCourses(token: mainModel.currentUser.token);
      } catch (_) {}
    }
    return ChangeNotifierProvider(
      create: (context) => mainModel,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Pharma Line',
        theme: appTheme,
        home: SelectUniversity(),
        routes: {
          LoginScreen.route: (BuildContext context) => LoginScreen(),
          ProfileScreen.route: (BuildContext context) => ProfileScreen(),
          UserInfoScreen.route: (BuildContext context) => UserInfoScreen(),
          WalletScreen.route: (BuildContext context) => WalletScreen(),
          SearchScreen.route: (BuildContext context) => SearchScreen(),
          NotificationsScreen.route: (BuildContext context) =>
              NotificationsScreen(),
          ScheduleScreen.route: (BuildContext context) => ScheduleScreen(),
          MyCoursesScreen.route: (BuildContext context) => MyCoursesScreen(),
          SignUpScreen.route: (BuildContext context) => SignUpScreen(),
          CourseStudents.route: (BuildContext context) => CourseStudents(),
          TermsAndConditionsScreen.route: (BuildContext context) =>
              TermsAndConditionsScreen(),
          AboutScreen.route: (BuildContext context) => AboutScreen(),
          TrainingCourses.route: (BuildContext context) => TrainingCourses(),
          SelectUniversity.route: (BuildContext context) => SelectUniversity(),
          SelectFaculty.route: (BuildContext context) => SelectFaculty(),
        },
      ),
    );
  }
}
