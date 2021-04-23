import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  CourseCard({@required this.course});
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
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  course.imageUrl,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  course.university +
                      (course.university.isEmpty ? '' : ' Uni, ') +
                      course.faculty +
                      (course.faculty.isEmpty ? '' : ' Faculty,') +
                      ' DR, ' +
                      course.teacher +
                      '.',
                  style: TextStyle(color: Palette.lightBlue, fontSize: 12.0),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: Text(
                      course.title,
                      style:
                          TextStyle(color: Palette.lightBlue, fontSize: 17.0),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    padding: EdgeInsets.all(5.0),
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
                      course.label,
                      style: TextStyle(
                          color: Palette.lightBlue,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  course.isLive
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
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
                                fontSize: 8.0,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      : Container()
                ],
              ),
              course.progressPercentage != null
                  ? Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.7,
                            lineHeight: 14.0,
                            percent: course.progressPercentage / 100,
                            backgroundColor: Palette.darkBlue,
                            progressColor: course.progressPercentage == 100
                                ? Palette.turquoise
                                : Palette.lightBlue,
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            course.progressPercentage.toString() + '%',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: course.progressPercentage == 100
                                  ? Palette.turquoise
                                  : Palette.lightBlue,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
