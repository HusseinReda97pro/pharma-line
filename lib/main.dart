import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:pharma_line/config/theme.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/models/user_type.dart';
import 'package:pharma_line/screens/course_students.dart';
import 'package:pharma_line/screens/home.dart';
import 'package:pharma_line/screens/login.dart';
import 'package:pharma_line/screens/my_courses.dart';
import 'package:pharma_line/screens/notifications.dart';
import 'package:pharma_line/screens/profile.dart';
import 'package:pharma_line/screens/schedule.dart';
import 'package:pharma_line/screens/search.dart';
import 'package:pharma_line/screens/signup.dart';
import 'package:pharma_line/screens/user_info.dart';
import 'package:pharma_line/screens/wallet.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
//  FirebaseApp app = await Firebase.initializeApp();
//  FirebaseMessaging messaging = FirebaseMessaging.instance;
//  messaging.subscribeToTopic("60826d279d5e54001ceb0e1b");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final MainModel mainModel = MainModel();

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      // print(event.data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(event.data['title']) ));
    });

    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    mainModel.autoLogin();
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
        debugShowCheckedModeBanner: false,
        title: 'Pharma Line',
        theme: appTheme,
        home: HomeScreen(),
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
        },
      ),
    );
  }
}
