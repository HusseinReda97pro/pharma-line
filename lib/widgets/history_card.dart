import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pharma_line/config/Palette.dart';
import 'package:pharma_line/models/history.dart';
import 'package:pharma_line/models/history_status.dart';

class HistoryCard extends StatefulWidget {
  final History history;
  HistoryCard({@required this.history});
  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    History history = widget.history;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        color: Palette.midBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.darkBlue,
                      shape: BoxShape.circle,
                    ),
                    child: history.status == HistoryStatus.SPEND
                        ? Icon(
                            Icons.remove,
                            size: 32.0,
                            color: Palette.pink,
                          )
                        : Icon(
                            Icons.add,
                            size: 32.0,
                            color: Palette.lightBlue,
                          ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        history.amount.toString() +
                            '\$ ' +
                            (history.status == HistoryStatus.SPEND
                                ? 'Spend on:'
                                : history.status == HistoryStatus.COMPLETE
                                    ? 'Added For Completing'
                                    : 'Added to your balance'),
                        style:
                            TextStyle(color: Palette.lightBlue, fontSize: 14.0),
                      ))
                ],
              ),
            ),
            history.status == HistoryStatus.RECHARGE
                ? Container()
                : Container(
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Palette.darkBlue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            history.course.university +
                                ' Uni, ' +
                                history.course.faculty +
                                ' Faculty, DR, ' +
                                history.course.doctorName +
                                '.',
                            style: TextStyle(
                                color: Palette.lightBlue, fontSize: 8.0),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.46,
                              child: Text(
                                history.course.title,
                                style: TextStyle(
                                    color: Palette.lightBlue, fontSize: 16.0),
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
                                history.course.category,
                                style: TextStyle(
                                    color: Palette.lightBlue,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        history.course.progressPercentage != null
                            ? Container(
                                margin: EdgeInsets.only(top: 20.0),
                                child: Row(
                                  children: [
                                    LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      lineHeight: 14.0,
                                      percent:
                                          history.course.progressPercentage /
                                              100,
                                      backgroundColor: Palette.darkBlue,
                                      progressColor:
                                          history.course.progressPercentage ==
                                                  100
                                              ? Palette.turquoise
                                              : Palette.lightBlue,
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text(
                                      history.course.progressPercentage
                                              .toString() +
                                          '%',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color:
                                            history.course.progressPercentage ==
                                                    100
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
          ],
        ),
      ),
    );
  }
}
