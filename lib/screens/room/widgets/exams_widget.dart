import 'package:flutter/material.dart';
import 'package:meetingme/models/tasks/exam.dart';

class ExamsWidget extends StatelessWidget {
  const ExamsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //late Future<Exam> exams;

    return FittedBox(
      child: Text('Exams'),
    );
  }
}
