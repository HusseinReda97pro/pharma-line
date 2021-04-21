import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/models/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentData appointment;

  AppointmentCard({@required this.appointment});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO open session
        print('event Taped');
      },
      child: Container(
        constraints: BoxConstraints(minHeight: 90),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: Palette.midBlue,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.title,
                  style: TextStyle(color: Palette.lightBlue, fontSize: 16.0),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color: Palette.lighterBlue,
                        size: 14.0,
                      ),
                      Text(
                        (appointment.startTime.hour % 12).toString() +
                            ':' +
                            appointment.startTime.minute.toString() +
                            ' - ' +
                            (appointment.endTime.hour % 12).toString() +
                            ':' +
                            appointment.endTime.minute.toString(),
                        style: TextStyle(
                            color: Palette.lighterBlue, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      appointment.isLive
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
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
                          appointment.category,
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
      ),
    );
  }
}
