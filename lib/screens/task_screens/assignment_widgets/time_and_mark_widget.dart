import 'package:flutter/material.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

class TimeAndMarkWidget extends StatelessWidget {
  const TimeAndMarkWidget({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.createdAt,
    required this.submissionDateTime,
    required this.mark,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final String? createdAt;
  final String? submissionDateTime;
  final String? mark;

  @override
  Widget build(BuildContext context) {
    var createdDate = DateTime.parse(createdAt ?? '').toLocal();
    var createdDayString = createdDate.day.toString();
    var createdMonthString = createdDate.month.toString();
    var createdYearString = createdDate.year.toString();
    var createdHourString = createdDate.hour.toString();
    var createdMinuteString = createdDate.minute.toString();
    var createdSecondString = createdDate.second.toString();

    var submissionDate = DateTime.parse(submissionDateTime ?? '').toLocal();
    var submissionDayString = submissionDate.day.toString();
    var submissionMonthString = submissionDate.month.toString();
    var submissionYearString = submissionDate.year.toString();
    var submissionHourString = submissionDate.hour.toString();
    var submissionMinuteString = submissionDate.minute.toString();
    var submissionSecondString = submissionDate.second.toString();

    var gapSize = deviceHeight * .007;
    return Container(
      width: deviceWidth * 1,
      height: deviceHeight * .1,
      color: ConstantColors.widgetColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Assigned On: '),
              Text(
                  '$createdDayString-$createdMonthString-$createdYearString $createdHourString:$createdMinuteString:$createdSecondString'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Submmission Deadline: '),
              Row(
                children: [
                  Text(
                      '$submissionDayString-$submissionMonthString-$submissionYearString'),
                  Card(
                    color: ConstantColors.primaryColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: gapSize * 2),
                      child: Text(
                        '$submissionHourString:$submissionMinuteString:$submissionSecondString',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Total Mark: '),
              Text(mark ?? ''),
            ],
          )
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.gapSize,
    required this.name,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final double gapSize;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth * 1,
      height: deviceHeight * .1,
      padding: EdgeInsets.all(gapSize * .5),
      color: ConstantColors.widgetColor,
      child: Column(
        children: [
          const Text(
            'Assignment Title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const WhiteDivider(),
          FittedBox(
            alignment: Alignment.center,
            child: Text(
              name ?? '',
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
