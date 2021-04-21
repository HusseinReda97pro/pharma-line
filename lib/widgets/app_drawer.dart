import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/screens/login.dart';
import 'package:pharma_line/screens/profile.dart';

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

  @override
  Widget build(BuildContext context) {
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
              title: 'Login',
              icon: Icons.person,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.route);
              },
            ),
            _listTile(
              context: context,
              title: 'Profile',
              icon: Icons.person,
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
