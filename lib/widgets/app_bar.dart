import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/screens/notifications.dart';
import 'package:pharma_line/screens/search.dart';
import 'package:pharma_line/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final context;
  MainAppBar({@required this.context});
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
      return AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu_sharp, color: Palette.lightBlue),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(),
            ),
            RoundedButton(
                backgroundColor: Palette.midBlue,
                icon: Icon(
                  Icons.search,
                  color: Palette.lightBlue,
                ),
                onPressed: () {
                  model.getUniversities();
                  model.currentCourses.clear();
                  Navigator.pushNamed(context, SearchScreen.route);
                }),
            RoundedButton(
                backgroundColor: Palette.midBlue,
                icon: Icon(
                  Icons.notifications,
                  color: Palette.lightBlue,
                ),
                onPressed: () {
                  if (model.currentUser != null) {
                    model.getNotification();
                  }
                  Navigator.pushNamed(context, NotificationsScreen.route);
                }),
          ],
        ),
      );
    });
  }

  @override
  Size get preferredSize => new Size.fromHeight(70.0);
}
