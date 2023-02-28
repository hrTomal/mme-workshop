import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:meetingme/components/components.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/services/common/show_toast.dart';
import 'package:meetingme/services/tasks_data_service.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

class CreateAssignment extends StatefulWidget {
  CreateAssignment({
    Key? key,
    required this.titleCtrl,
    required this.descriptionCtrl,
    required this.marksCtrl,
    required this.subTimeCtrl,
    required this.subjectId,
  }) : super(key: key);

  final TextEditingController titleCtrl;
  final TextEditingController descriptionCtrl;
  final TextEditingController marksCtrl;
  final TextEditingController subTimeCtrl;
  final String subjectId;

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  FilePickerResult? result;
  List<String> filePaths = [];

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setStateForDialog) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: widget.titleCtrl,
                          minLines: 1,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          decoration: normalTextInput.copyWith(
                              labelText: 'Assignment Title'),
                        ),
                        TextField(
                          controller: widget.descriptionCtrl,
                          keyboardType: TextInputType.multiline,
                          minLines: 2,
                          maxLines: 5,
                          decoration: normalTextInput.copyWith(
                              labelText: 'Description'),
                        ),
                        TextField(
                          controller: widget.marksCtrl,
                          minLines: 1,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration:
                              normalTextInput.copyWith(labelText: 'Marks'),
                        ),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDateTimePicker(
                              context,
                              showTitleActions: true,
                              onChanged: (time) => {
                                widget.subTimeCtrl.text =
                                    time.toLocal().toString(),
                              },
                            );
                          },
                          child: AbsorbPointer(
                              child: TextField(
                            controller: widget.subTimeCtrl,
                            decoration: normalTextInput.copyWith(
                                labelText: 'Submissition Time'),
                          )),
                        ),
                        WhiteDivider(),
                        ElevatedButton.icon(
                          onPressed: () async {
                            // result = await FilePicker.platform
                            //     .pickFiles(allowMultiple: true);
                            // if (result == null) {
                            //   print("No file selected");
                            // } else {
                            //   setStateForDialog(() {});
                            // }
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
                        const WhiteDivider(),
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
                                                fontWeight: FontWeight.bold));
                                      }),
                                ],
                              ),
                        const WhiteDivider(),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (widget.titleCtrl.text.isEmpty) {
                              ShowToast.ShowErrorToast(
                                  'Please Enter Assignment Name');
                            } else if (widget.descriptionCtrl.text.isEmpty) {
                              ShowToast.ShowErrorToast(
                                  'Please Enter Assignment Description');
                            } else if (widget.marksCtrl.text.isEmpty) {
                              ShowToast.ShowErrorToast(
                                  'Please Enter Assignment Marks');
                            } else if (widget.subTimeCtrl.text.isEmpty) {
                              ShowToast.ShowErrorToast(
                                  'Please Enter Assignment Submission Time');
                            } else {
                              TasksService()
                                  .assignmentCreate(
                                      widget.subjectId,
                                      widget.titleCtrl.text,
                                      widget.marksCtrl.text,
                                      widget.descriptionCtrl.text,
                                      widget.subTimeCtrl.text,
                                      filePaths)
                                  .then((value) => {
                                        if (value == 200 || value == 201)
                                          {
                                            ShowToast.ShowSuccessToast(
                                                'Assignment Created Succesfully!'),
                                          }
                                        else
                                          {
                                            ShowToast.ShowErrorToast(
                                                'Failed to Create.')
                                          }
                                      });
                              Navigator.of(context).pop();
                            }
                          },
                          label: const Text('Save'),
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
            });
      },
      icon: const Icon(
        Icons.add,
      ),
      label: const Text('Create New'),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(ConstantColors.createButtonColor),
      ),
    );
  }
}
