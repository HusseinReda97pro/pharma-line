import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/models/appointment.dart';
import 'package:pharma_line/widgets/app_bar.dart';
import 'package:pharma_line/widgets/app_drawer.dart';
import 'package:pharma_line/widgets/appointment_card.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleScreen extends StatefulWidget {
  static String route = '/schedule';
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      final AppointmentData appointment = details.appointments[0];
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: new Text(appointment.title)),
              content: Container(
                height: 80,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          appointment.category,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('test',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                new ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text('close'))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        context: context,
      ),
      drawer: AppDrawer(),
      body: SfCalendar(
        onTap: calendarTapped,
        todayTextStyle: TextStyle(color: Palette.lightBlue),
        headerStyle: CalendarHeaderStyle(
          textStyle: TextStyle(color: Palette.lightBlue, fontSize: 16.0),
        ),
        viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: TextStyle(color: Palette.lighterBlue, fontSize: 12.0),
          dateTextStyle: TextStyle(color: Palette.lightBlue, fontSize: 14.0),
        ),
        firstDayOfWeek: 6,
        timeSlotViewSettings: TimeSlotViewSettings(
          dayFormat: 'EEE',
          timeIntervalHeight: 90,
          timeTextStyle: TextStyle(
            fontSize: 14,
            color: Palette.lightBlue,
          ),
        ),
        view: CalendarView.day,
        backgroundColor: Palette.darkBlue,
        cellBorderColor: Colors.transparent,
        todayHighlightColor: Palette.lighterBlue,
        dataSource: MeetingDataSource(getAppointments()),
        appointmentTextStyle: TextStyle(
          fontSize: 32,
        ),
        appointmentBuilder: (BuildContext context,
            CalendarAppointmentDetails calendarAppointmentDetails) {
          final AppointmentData appointment =
              calendarAppointmentDetails.appointments.first;
          return AppointmentCard(
            appointment: appointment,
          );
        },
        // timeSlotViewSettings:
        //     TimeSlotViewSettings(timeInterval: Duration(hours: 2)),
      ),
    );
  }
}

List<AppointmentData> getAppointments() {
  List<AppointmentData> meetings = [];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(Duration(hours: 2));
  final DateTime startTime_2 =
      DateTime(today.year, today.month, today.day, 15, 0, 0);
  final DateTime endTime_2 = startTime_2.add(Duration(hours: 3));
  final DateTime startTime_3 =
      DateTime(today.year, today.month, today.day, 19, 0, 0);
  final DateTime endTime_3 = startTime_3.add(Duration(hours: 1));
  final DateTime startTime_4 =
      DateTime(today.year, today.month, today.day, 21, 0, 0);
  final DateTime endTime_4 = startTime_4.add(Duration(hours: 1));

  meetings.add(
    AppointmentData(
        startTime: startTime,
        endTime: endTime,
        title: 'Live session',
        category: 'Math',
        date: startTime,
        isLive: true,
        color: Palette.midBlue),
  );
  meetings.add(
    AppointmentData(
        startTime: startTime_2,
        endTime: endTime_2,
        title: 'Live session',
        category: 'physics',
        isLive: true,
        date: startTime,
        color: Palette.midBlue),
  );
  meetings.add(
    AppointmentData(
        startTime: startTime_3,
        endTime: endTime_3,
        title: 'Live session',
        category: 'physics',
        date: startTime,
        isLive: false,
        color: Palette.midBlue),
  );
  meetings.add(
    AppointmentData(
        startTime: startTime_4,
        endTime: endTime_4,
        date: startTime,
        title: 'Live session',
        isLive: true,
        category: 'Math 101',
        color: Palette.midBlue),
  );
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<AppointmentData> source) {
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) {
    return appointments[index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments[index].title;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }

  @override
  Color getColor(int index) {
    return appointments[index].color;
  }
}
