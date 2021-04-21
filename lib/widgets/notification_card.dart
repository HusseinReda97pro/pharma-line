import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/models/notification.dart';

class NotificationCard extends StatefulWidget {
  final NotificationData notification;

  const NotificationCard({@required this.notification});

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    NotificationData notification = widget.notification;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Palette.midBlue,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: TextStyle(color: Palette.lightBlue, fontSize: 16.0),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: Palette.lighterBlue,
                      size: 14.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        notification.date.difference(DateTime.now()).inDays == 0
                            ? 'Today'
                            : notification.date.day.toString() +
                                '/' +
                                notification.date.month.toString() +
                                '/' +
                                notification.date.year.toString(),
                        style: TextStyle(
                            color: Palette.lighterBlue, fontSize: 14.0),
                      ),
                    ),
                    Text(
                      notification.startDuration.minute.toString() +
                          ':' +
                          notification.startDuration.second.toString() +
                          ' - ' +
                          notification.endDuration.hour.toString() +
                          ':' +
                          notification.endDuration.minute.toString(),
                      style:
                          TextStyle(color: Palette.lighterBlue, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    notification.isLive
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: Palette.pink,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                            child: Text(
                              'Live',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        : Container(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Palette.darkBlue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.0),
                        ),
                        border: Border.all(
                          color: Palette.lightBlue,
                        ),
                      ),
                      child: Text(
                        notification.category,
                        style: TextStyle(
                            color: Palette.lightBlue,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
