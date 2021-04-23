import 'package:flutter/material.dart';
import 'package:pharma_line/controllers/state_management/notifiction_model.dart';
import 'package:pharma_line/controllers/state_management/university_model.dart';
import 'package:pharma_line/controllers/state_management/user_model.dart';

import 'course_model.dart';

class MainModel extends ChangeNotifier
    with UserModel, NotificationModel, UniversitiesModel, CourseModel {}
