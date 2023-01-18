// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

import '../../../models/tasks/assignments.dart';

class AssignmentScreen extends StatefulWidget {
  AssignmentScreen({
    super.key,
    this.id,
    this.files,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.name,
    this.description,
    this.mark,
    this.submissionDateTime,
    this.createdBy,
    this.updatedBy,
    this.roomSubject,
    this.hasSubmitted,
  });

  final String? id;
  final List<Files>? files;
  final List<Comments>? comments;
  final String? createdAt;
  final String? updatedAt;
  final bool? isActive;
  final String? name;
  final String? description;
  final String? mark;
  final String? submissionDateTime;
  final String? createdBy;
  final String? updatedBy;
  final String? roomSubject;
  final bool? hasSubmitted;

  static const routeName = '/assignment-screen';

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState(
        id,
        files,
        comments,
        createdAt,
        updatedAt,
        isActive,
        name,
        description,
        mark,
        submissionDateTime,
        createdBy,
        updatedBy,
        roomSubject,
        hasSubmitted,
      );
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  final String? id;
  final List<Files>? files;
  final List<Comments>? comments;
  final String? createdAt;
  final String? updatedAt;
  final bool? isActive;
  final String? name;
  final String? description;
  final String? mark;
  final String? submissionDateTime;
  final String? createdBy;
  final String? updatedBy;
  final String? roomSubject;
  final bool? hasSubmitted;

  _AssignmentScreenState(
      this.id,
      this.files,
      this.comments,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.name,
      this.description,
      this.mark,
      this.submissionDateTime,
      this.createdBy,
      this.updatedBy,
      this.roomSubject,
      this.hasSubmitted);

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    var gapSize = deviceHeight * .007;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Me'),
        backgroundColor: const Color.fromRGBO(26, 55, 77, 1),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.all(gapSize),
        child: Column(
          children: [
            Container(
              width: deviceWidth * 1,
              height: deviceHeight * .1,
              padding: EdgeInsets.all(gapSize * .5),
              color: ConstantColors.widgetColor,
              child: Column(
                children: [
                  const Text('Assignment Title'),
                  const WhiteDivider(),
                  FittedBox(
                    alignment: Alignment.center,
                    child: Text(name ?? ''),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: gapSize,
            ),
            Container(
              width: deviceWidth * 1,
              height: deviceHeight * .1,
              color: ConstantColors.widgetColor,
            ),
            SizedBox(
              height: gapSize,
            ),
            Container(
              width: deviceWidth * 1,
              height: deviceHeight * .1,
              color: ConstantColors.widgetColor,
            ),
          ],
        ),
      ),
    );
  }
}
