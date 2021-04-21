import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/screens/search.dart';
import 'package:pharma_line/widgets/rounded_button.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final context;
  MainAppBar({@required this.context});
  @override
  Widget build(BuildContext context) {
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
                Navigator.pushNamed(context, SearchScreen.route);
              }),
          RoundedButton(
              backgroundColor: Palette.midBlue,
              icon: Icon(
                Icons.notifications,
                color: Palette.lightBlue,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(70.0);
}
