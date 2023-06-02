import 'package:flutter/material.dart';
import 'package:meetingme/models/room_info.dart';
import 'package:meetingme/screens/room/widgets/assignments_widget.dart';
import 'package:meetingme/screens/room/widgets/notes_widget.dart';
import 'package:meetingme/screens/room/widgets/records_widget.dart';

import '../../constants/variable_names.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({
    super.key,
    required this.id,
    required this.subject,
    required this.room,
    required this.description,
    required this.classRoomName,
  });

  static const routeName = '/subject-screen';

  final String id;
  final Subject subject;
  final String room;
  final String description;
  final String classRoomName;

  @override
  State<SubjectScreen> createState() =>
      _SubjectScreenState(id, subject, room, description, classRoomName);
}

class _SubjectScreenState extends State<SubjectScreen>
    with SingleTickerProviderStateMixin {
  final String id;
  final Subject subject;
  final String room;
  final String description;
  final String classRoomName;

  late TabController _controller;

  _SubjectScreenState(
      this.id, this.subject, this.room, this.description, this.classRoomName);

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(26, 55, 77, 1),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${VariableNames.organisationName} - ${subject.title}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              classRoomName,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      // AppBar(
      //   title: Text('Meeting Me- ${subject.title}'),
      //   backgroundColor: const Color.fromRGBO(26, 55, 77, 1),
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      // ),
      body: Container(
        height: deviceHeight * .9,
        child: ListView(
          children: [
            TabBar(
              labelColor: Color.fromARGB(255, 71, 88, 95),
              automaticIndicatorColorAdjustment: true,
              controller: _controller,
              tabs: const [
                Tab(
                  child: FittedBox(child: Text('Notes')),
                ),
                Tab(
                  child: FittedBox(child: Text('Assignments')),
                ),
                Tab(
                  child: FittedBox(child: Text('Records')),
                ),
                Tab(
                  child: FittedBox(child: Text('Exams')),
                ),
                // Tab(
                //   child: FittedBox(child: Text('Links')),
                // ),
              ],
            ),
            Container(
              height: deviceHeight * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(deviceWidth * .03),
                ),
              ),
              child: TabBarView(
                controller: _controller,
                children: [
                  NotesWidget(
                    subjectId: id,
                  ),
                  AssignmentsWidget(id),
                  RecordsWidget(
                    subjectId: id,
                  ),
                  Center(
                    child: Text('Exams'),
                  ),
                  // Center(
                  //   child: Text('Links'),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
