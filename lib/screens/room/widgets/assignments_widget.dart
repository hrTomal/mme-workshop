import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:meetingme/models/tasks/assignments.dart';
import 'package:meetingme/screens/room/widgets/create_assignment.dart';
import 'package:meetingme/screens/task_screens/assignment_screen.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

import '../../../services/tasks_data_service.dart';

class AssignmentsWidget extends StatefulWidget {
  const AssignmentsWidget(
    this.subjectId,
  );

  final String subjectId;

  @override
  State<AssignmentsWidget> createState() => _AssignmentsWidgetState();
}

class _AssignmentsWidgetState extends State<AssignmentsWidget> {
  late Future<Assignment> assignments;

  var titleCtrl = TextEditingController();
  var descriptionCtrl = TextEditingController();
  var marksCtrl = TextEditingController();
  var subTimeCtrl = TextEditingController();

  var userType;

  @override
  void initState() {
    super.initState();
    SessionManager().get("userType").then((value) => {
          setState(() {
            userType = value;
          })
        });
    assignments = TasksService().getRoomAssignments(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        userType == 'TEACHER'
            ? CreateAssignment(
                titleCtrl: titleCtrl,
                descriptionCtrl: descriptionCtrl,
                marksCtrl: marksCtrl,
                subTimeCtrl: subTimeCtrl,
                subjectId: widget.subjectId,
              )
            : Container(),
        SizedBox(
          height: height * .8,
          child: FutureBuilder(
              future: assignments,
              builder:
                  (BuildContext context, AsyncSnapshot<Assignment> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.count != 0) {
                  var allData = snapshot.data!.results;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: allData!.length,
                    itemBuilder: (context, index) {
                      var dueDate = DateTime.parse(
                              allData[index].submissionDateTime ?? '')
                          .toLocal();
                      var dayString = dueDate.day.toString();
                      var monthString = dueDate.month.toString();
                      var yearString = dueDate.year.toString();
                      var hourString = dueDate.hour.toString();
                      var minuteString = dueDate.minute.toString();
                      var secondString = dueDate.second.toString();
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AssignmentScreen.routeName,
                            arguments: AssignmentArguments(
                              allData[index].id,
                              allData[index].files,
                              allData[index].comments,
                              allData[index].createdAt,
                              allData[index].updatedAt,
                              allData[index].isActive,
                              allData[index].name,
                              allData[index].description,
                              allData[index].mark,
                              allData[index].submissionDateTime,
                              allData[index].createdBy,
                              allData[index].updatedBy,
                              allData[index].roomSubject,
                              allData[index].hasSubmitted,
                            ),
                          );
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * .02),
                          child: Card(
                            color: const Color.fromARGB(255, 232, 242, 255),
                            shadowColor:
                                const Color.fromARGB(255, 232, 242, 255),
                            elevation: width * .01,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: width * .02,
                                  horizontal: width * .02,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width * .19,
                                      height: height * .1,
                                      margin:
                                          EdgeInsets.only(right: width * 0.03),
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(26, 55, 77, 1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(width * .03),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Mark',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: width * .012,
                                            ),
                                            child: Text(
                                              allData[index].mark ?? '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * .045),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: width * .67,
                                          child: Text(
                                            allData[index].name ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const WhiteDivider(),
                                        Row(
                                          children: [
                                            const Text('Due Date: '),
                                            Text(
                                              '$hourString:$minuteString:$secondString $dayString-$monthString-$yearString',
                                              style: const TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Great work. Currently no work left.'),
                  );
                }

                /// While is no data show this
                // return const Center(
                //   child: CircularProgressIndicator(),
                // );
              }),
        ),
      ],
    );
  }
}
