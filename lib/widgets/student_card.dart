import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/models/user.dart';

class StudentCard extends StatefulWidget {
  final User student;
  StudentCard({@required this.student});
  @override
  _StudentCardState createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4.0),
      color: Palette.darkerBlue,
      child: Row(
        children: [
          widget.student.firstName != null && widget.student.lastName != null
              ? Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipOval(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: Palette.lightBlue,
                      child: Text(
                        widget.student.firstName[0] +
                            widget.student.lastName[0],
                        style: TextStyle(
                            color: Palette.darkerBlue, fontSize: 18.0),
                      ),
                    ),
                  ),
                )
              : Container(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: Text(
                  widget.student.firstName + ' ' + widget.student.lastName,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: Text(
                  widget.student.email,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: Text(
                  widget.student.phoneNumber,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
