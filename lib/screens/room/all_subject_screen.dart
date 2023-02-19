import 'package:flutter/material.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/constants/variable_names.dart';
import 'package:meetingme/models/room_info.dart';
import 'package:meetingme/screens/room/subject_sreen.dart';

class AllSubjectScreen extends StatefulWidget {
  AllSubjectScreen(this.rooms);

  static const routeName = '/allscreen';
  final Future<RoomInfo> rooms;

  @override
  State<AllSubjectScreen> createState() => _AllSubjectScreenState(rooms);
}

class _AllSubjectScreenState extends State<AllSubjectScreen> {
  final Future<RoomInfo> _rooms;

  _AllSubjectScreenState(this._rooms);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
      body: FutureBuilder(
        future: _rooms,
        //initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var _roomList = snapshot.data!.results;
            return GridView.builder(
              semanticChildCount: 2,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  mainAxisExtent: height * .1),
              itemCount: _roomList.length,
              itemBuilder: (item, index) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    SubjectScreen.routeName,
                    arguments: RoomArguments(
                      _roomList[index].id ?? '',
                      Subject(
                          id: _roomList[index].subject?.id ?? '',
                          title: _roomList[index].subject?.title ?? '',
                          description:
                              _roomList[index].subject?.description ?? ''),
                      _roomList[index].description ?? '',
                      _roomList[index].room ?? '',
                    ),
                  );
                },
                child: Card(
                  color: ConstantColors.widgetColor,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_roomList[index].subject.title),
                      //Text(_roomList[index].subject.)
                    ],
                  )),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
