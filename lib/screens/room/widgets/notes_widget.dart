import 'package:flutter/material.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/models/tasks/notes.dart';
import 'package:meetingme/services/tasks_data_service.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  final Future<Note> notes = TasksService().getAllNotes();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var conPadding = height * .01;
    return FutureBuilder(
      future: notes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var allData = snapshot.data!.results;
          return ListView.builder(
            itemCount: allData!.length,
            scrollDirection: Axis.vertical,
            itemBuilder: ((context, index) {
              var createdAtDate =
                  DateTime.parse(allData[index].createdAt ?? '').toLocal();
              var createdDayString = createdAtDate.day.toString();
              var createdMonthString = createdAtDate.month.toString();
              var createdYearString = createdAtDate.year.toString();
              var createdHourString = createdAtDate.hour.toString();
              var createdMinuteString = createdAtDate.minute.toString();
              var createdSecondString = createdAtDate.second.toString();

              return GestureDetector(
                onTap: (() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          content: Column(
                            children: [
                              Text('Title: ${allData[index].name ?? ''}'),
                              const Divider(
                                color: Colors.black,
                              ),
                              Text(
                                  'Description: ${allData[index].description ?? ''}'),
                              allData[index].files!.isNotEmpty
                                  ? SizedBox(
                                      width: width * 1,
                                      height: height * .1,
                                      //color: ConstantColors.widgetColor,
                                      child: Row(
                                        children: [
                                          const Text('Files '),
                                          SizedBox(
                                            width: width * .57,
                                            //color: Colors.white,
                                            child: ListView.builder(
                                                itemCount: allData[index]
                                                    .files!
                                                    .length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (context, fileIndex) {
                                                  return Container(
                                                    margin: EdgeInsets.all(
                                                        conPadding),
                                                    height: conPadding * 6,
                                                    width: conPadding * 6,
                                                    color: Colors.white,
                                                    child: GestureDetector(
                                                      onTap: (() {
                                                        //_downloadFile(widget.files![index].file);
                                                      }),
                                                      child: Image.network(
                                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3-RjXBulP7lPhXjyWTa1jaW6cd5fDzoC240S1hLRH_A6BUZ1b-U2UMYcJS9tg-xdfLYQ&usqp=CAU',
                                                        // allData[index]
                                                        //     .files![
                                                        //         fileIndex]
                                                        //     .file ??
                                                        // '',
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        );
                      });
                }),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: conPadding, vertical: conPadding / 2),
                  padding: EdgeInsets.all(conPadding),
                  decoration: const BoxDecoration(
                    color: ConstantColors.widgetColor,
                  ),
                  child: Column(
                    children: [
                      Text('Title: ${allData[index].name ?? ''}'),
                      const WhiteDivider(),
                      Text(
                          'Upload Date: $createdDayString-$createdMonthString-$createdYearString $createdHourString:$createdMinuteString:$createdSecondString'),
                    ],
                  ),
                ),
              );
            }),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
