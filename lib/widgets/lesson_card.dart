import 'package:flutter/material.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/models/lesson.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  LessonCard({@required this.lesson});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        color: Palette.midBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lesson.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        lesson.imageUrl,
                      ),
                    )
                  : Container(),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                      lesson.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                      lesson.price.toString() + " EGP",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  lesson.description,
                  softWrap: true,
                  style: TextStyle(
                      color: Color(0xFFCCCCCC),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
