import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/screens/home.dart';
import 'package:pharma_line/screens/notifications.dart';
import 'package:pharma_line/screens/schedule.dart';
import 'package:pharma_line/screens/user_info.dart';
import 'package:pharma_line/screens/wallet.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:pharma_line/widgets/profile_image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String route = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image;

  final imageurl = "";
  Widget _card(
      {@required IconData icon,
      @required String title,
      @required Function onPressed}) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Palette.midBlue; // Use the component's default.
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: icon == Icons.person ? 0 : 10.0),
              child: Icon(
                icon,
                color: Palette.darkBlue,
                size: icon == Icons.person ? 65 : 45,
              ),
            ),
            Text(
              title,
              style: TextStyle(color: Palette.lightBlue, fontSize: 18.0),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
//          ImageProvider image = NetworkImage(
//              model.currentUser.profileImageUrl,
//              headers: {"Authorization":  model.currentUser.token});

//import 'package:http/http.dart' as http;
//final response = await http.get(
//    Uri.parse('https://pharmaline.herokuapp.com/api/v1/student/profilePicture'),
//    headers: {HttpHeaders.authorizationHeader: model.currentUser.token},
//  );

      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        drawer: AppDrawer(),
        body: ListView(
          children: [
            ProfileImagePicker(
                image: _image,
                imageUrl: model.currentUser.profileImageUrl,
                model: model),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                model.currentUser.firstName + ' ' + model.currentUser.lastName,
                textAlign: TextAlign.center,
                style: TextStyle(color: Palette.lightBlue, fontSize: 18.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'virtual Points: ' + model.currentUser.points.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Palette.lightBlue, fontSize: 12.0),
              ),
            ),
            Container(
              height: 450,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                childAspectRatio: 3 / 2,
                children: [
                  _card(
                      icon: Icons.person,
                      title: 'info',
                      onPressed: () {
                        Navigator.pushNamed(context, UserInfoScreen.route);
                      }),
                  _card(
                      icon: FontAwesomeIcons.wallet,
                      title: 'wallet',
                      onPressed: () {
                        model.getHistory();
                        Navigator.pushNamed(context, WalletScreen.route);
                      }),
                  _card(
                      icon: FontAwesomeIcons.solidCalendar,
                      title: 'Schedule',
                      onPressed: () {
                        Navigator.pushNamed(context, ScheduleScreen.route);
                      }),
                  _card(
                      icon: Icons.notifications,
                      title: 'notifications',
                      onPressed: () {
                        model.getNotification();
                        Navigator.pushNamed(context, NotificationsScreen.route);
                      }),
                  _card(
                      icon: Icons.cancel,
                      title: 'logout',
                      onPressed: () {
                        model.logout();
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.route);
                      }),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
