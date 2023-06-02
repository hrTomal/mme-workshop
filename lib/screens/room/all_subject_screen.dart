import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
            var roomList = snapshot.data!.results;
            return GridView.builder(
              semanticChildCount: 2,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  mainAxisExtent: height * .1),
              itemCount: roomList.length,
              itemBuilder: (item, index) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    SubjectScreen.routeName,
                    arguments: RoomArguments(
                      roomList[index].id ?? '',
                      Subject(
                          id: roomList[index].subject?.id ?? '',
                          title: roomList[index].subject?.title ?? '',
                          description:
                              roomList[index].subject?.description ?? ''),
                      roomList[index].description ?? '',
                      roomList[index].room ?? '',
                      roomList[index].roomDetails.name,
                    ),
                  );
                },
                child: Card(
                  color: ConstantColors.widgetColor,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(roomList[index].subject.title),
                      Card(
                          color: ConstantColors.primaryColor,
                          child: Text(
                            roomList[index].roomDetails.name,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ))
                    ],
                  )),
                ),
              ),
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: ConstantColors.primaryColor, size: 100),
            );
          }
        },
      ),
    );
  }
}
