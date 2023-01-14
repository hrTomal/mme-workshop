import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meetingme/models/room_info.dart';
import 'package:meetingme/screens/room/widgets/assignments_widget.dart';
import 'package:meetingme/screens/room/widgets/exams_widget.dart';
import 'package:meetingme/screens/room/widgets/links_widget.dart';
import 'package:meetingme/screens/room/widgets/notes_widget.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({
    super.key,
    required this.id,
    required this.subject,
    required this.room,
    required this.description,
  });

  static const routeName = '/subject-screen';

  final String id;
  final Subject subject;
  final String room;
  final String description;

  @override
  State<SubjectScreen> createState() =>
      _SubjectScreenState(id, subject, room, description);
}

class _SubjectScreenState extends State<SubjectScreen>
    with SingleTickerProviderStateMixin {
  final String id;
  final Subject subject;
  final String room;
  final String description;

  late TabController _controller;

  _SubjectScreenState(this.id, this.subject, this.room, this.description);

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
        title: Text('Meeting Me- ${subject.title}'),
        backgroundColor: const Color.fromRGBO(26, 55, 77, 1),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
                  child: Text('Notes'),
                ),
                Tab(
                  child: FittedBox(child: Text('Assignments')),
                ),
                Tab(
                  child: Text('Exams'),
                ),
                Tab(
                  child: Text('Links'),
                ),
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
                children: const [
                  Center(
                    child: Text('Notes'),
                  ),
                  AssignmentsWidget(),
                  Center(
                    child: Text('Exams'),
                  ),
                  Center(
                    child: Text('Links'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
