import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/screens/task_screens/assignment_widgets/description_widget.dart';
import 'package:meetingme/screens/task_screens/assignment_widgets/time_and_mark_widget.dart';
import 'package:meetingme/services/common/file_picker.dart';
import 'package:meetingme/services/common/show_toast.dart';
import 'package:meetingme/services/tasks_data_service.dart';
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
  FilePickerResult? result;
  //List<String>? filePaths;
  List<String> filePaths = [];

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
    final hasSubDoneText = hasSubmitted ?? false;
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
            userType != 'TEACHER'
                ? FloatingActionButton.extended(
                    onPressed: () {
                      hasSubDoneText
                          ? ShowToast.ShowSuccessToast(
                              'You have already submitted this Assignment.')
                          : submitAssignment(context);
                    },
                    backgroundColor: hasSubDoneText
                        ? Colors.grey
                        : ConstantColors.primaryColor,
                    label: Text(
                        hasSubDoneText ? 'Already Submitted' : 'Submit Now'),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Future<dynamic> submitAssignment(BuildContext context) {
    return showDialog(
      context: context,
      builder: ((context) {
        return StatefulBuilder(builder: (context, setStateForDialog) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Select Files To Submit'),
                  ElevatedButton.icon(
                    onPressed: () async {
                      // filePaths = await LocalFilePicker()
                      //     .MultipleFilesPick();
                      // setStateForDialog(() {});
                      result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);
                      if (result == null) {
                        print("No file selected");
                      } else {
                        for (var file in result!.files) {
                          filePaths.add(file.path!);
                        }
                        setStateForDialog(() {});
                      }
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Attach Files'),
                  ),
                  WhiteDivider(),
                  result == null
                      ? Container()
                      : Column(
                          children: [
                            const Text('Selected Files: '),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: result?.files.length ?? 0,
                              itemBuilder: (context, index) {
                                return Text(
                                  textAlign: TextAlign.center,
                                  result?.files[index].name ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ],
                        ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (filePaths != null) {
                        TasksService()
                            .assignmentSubmit(id, filePaths)
                            .then((value) => {
                                  if (value?.updatedAt == null)
                                    {
                                      ShowToast.ShowErrorToast(
                                          'Already Submitted!'),
                                    }
                                  else
                                    {
                                      ShowToast.ShowSuccessToast(
                                          'Upload Succesfull.')
                                    }
                                });
                        Navigator.of(context).pop();
                      } else {
                        ShowToast.ShowErrorToast('Select Files To submit');
                      }
                    },
                    label: const Text('Submit'),
                    icon: const Icon(
                      Icons.save,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ConstantColors.createButtonColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
