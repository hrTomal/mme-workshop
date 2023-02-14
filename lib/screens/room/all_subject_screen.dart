import 'package:flutter/material.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/constants/variable_names.dart';
import 'package:meetingme/models/room_info.dart';

class AllSubjectScreen extends StatefulWidget {
  AllSubjectScreen(this.rooms);

  static const routeName = '/allscreen';
  final RoomInfo rooms;

  @override
  State<AllSubjectScreen> createState() => _AllSubjectScreenState(rooms);
}

class _AllSubjectScreenState extends State<AllSubjectScreen> {
  final RoomInfo rooms;

  _AllSubjectScreenState(this.rooms);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${VariableNames.organisationName} - Subjects'),
        backgroundColor: ConstantColors.primaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        semanticChildCount: rooms.results!.length,
        children: rooms.results!.map((e) {
          return Card(
            child: Text(e.subject!.title ?? ''),
          );
        }).toList(),
      ),
    );
  }
}
