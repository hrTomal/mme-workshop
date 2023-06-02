import 'package:flutter/material.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/models/record.dart';
import 'package:meetingme/screens/room/widgets/video_popup.dart';
import 'package:meetingme/screens/video_player/VideoPlayerScreen.dart';
import 'package:meetingme/services/room_data_service.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

class RecordsWidget extends StatefulWidget {
  const RecordsWidget({
    super.key,
    required this.subjectId,
  });

  final String subjectId;

  @override
  State<RecordsWidget> createState() => _RecordsWidgetState();
}

class _RecordsWidgetState extends State<RecordsWidget> {
  late Future<Record> records;

  @override
  void initState() {
    records = MeetingRoomService().getMeetingRecords(widget.subjectId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      child: FutureBuilder(
        future: records,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.count == 0) {
            return const Center(
              child: Text('No Records Found..'),
            );
          } else {
            var allData = snapshot.data!.results;
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: allData!.length,
                itemBuilder: (context, index) {
                  var createDate =
                      DateTime.parse(allData[index].createdAt ?? '').toLocal();
                  var dayString = createDate.day.toString();
                  var monthString = createDate.month.toString();
                  var yearString = createDate.year.toString();
                  var hourString = createDate.hour.toString();
                  var minuteString = createDate.minute.toString();
                  var secondString = createDate.second.toString();
                  var sl = index + 1;
                  return Container(
                    color: ConstantColors.widgetColor,
                    padding: EdgeInsets.symmetric(vertical: height * .01),
                    margin: EdgeInsets.symmetric(
                        vertical: height * .01, horizontal: width * .03),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(sl.toString()),
                          Column(
                            children: [
                              Text(allData[index].meeting?.date ?? ''),
                              WhiteDivider(),
                              Text(allData[index].meeting?.description ?? ''),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return VideoPopup(
                              //         videoUrl: allData[index].file ?? '');
                              //   },
                              // );
                              Navigator.of(context).pushNamed(
                                  VideoPlayerScreen.routeName,
                                  arguments: allData[index].file ?? '');
                            },
                            child: const Text('Watch Now'),
                          )
                        ]),
                  );
                  //
                });
          }
        },
      ),
    );
  }
}
