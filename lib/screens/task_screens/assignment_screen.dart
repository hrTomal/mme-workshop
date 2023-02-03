import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/screens/task_screens/assignment_widgets/description_widget.dart';
import 'package:meetingme/screens/task_screens/assignment_widgets/time_and_mark_widget.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

import '../../models/tasks/assignments.dart';
import 'assignment_widgets/files_widget.dart';

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

  var userType;
  @override
  void initState() {
    super.initState();
    SessionManager().get("userType").then((value) => {
          setState(() {
            userType = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    var gapSize = deviceHeight * .007;
    var descriptionWithoutNull = description ?? '';
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
            TitleWidget(
              deviceWidth: deviceWidth,
              deviceHeight: deviceHeight,
              gapSize: gapSize,
              name: name,
            ),
            SizedBox(
              height: gapSize,
            ),
            TimeAndMarkWidget(
              deviceWidth: deviceWidth,
              deviceHeight: deviceHeight,
              createdAt: createdAt,
              submissionDateTime: submissionDateTime,
              mark: mark,
            ),
            SizedBox(
              height: gapSize,
            ),
            files!.isNotEmpty
                ? FilesWidget(
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                    files: files,
                    gapSize: gapSize)
                : Container(),
            SizedBox(
              height: gapSize,
            ),
            descriptionWithoutNull != ''
                ? DescriptionWidget(
                    deviceWidth: deviceWidth,
                    gapSize: gapSize,
                    description: description)
                : Container(),
            SizedBox(
              height: gapSize,
            ),
            // userType != 'TEACHER'
            //     ? FloatingActionButton.extended(
            //         onPressed: () {},
            //         backgroundColor: ConstantColors.primaryColor,
            //         label: const Text('Submit'),
            //       )
            //     : Container()
          ],
        ),
      ),
    );
  }
}
