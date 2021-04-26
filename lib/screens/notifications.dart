import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/controllers/state_management/main_model.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:pharma_line/widgets/notification_card.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  static final route = '/notifications';
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
      builder: (BuildContext context, MainModel model, Widget child) {
        return Scaffold(
          appBar: MainAppBar(
            context: context,
          ),
          drawer: AppDrawer(),
          body: model.loadingNotification
              ? Center(
                  child: Container(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ))
              : model.notifications.length == 0
                  ? Center(
                      child: Text(
                      "Theree is no notifications Yet",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ))
                  : ListView.builder(
                      itemCount: model.notifications.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05,
                                vertical: 10.0),
                            child: Text(
                              'Notifications',
                              style: TextStyle(
                                  color: Palette.lightBlue,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        return NotificationCard(
                            notification: model.notifications[index - 1]);
                      }),
        );
      },
    );
  }
}
