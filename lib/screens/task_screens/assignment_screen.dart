// ignore_for_file: no_logic_in_create_state

import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/widgets/constant_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/tasks/assignments.dart';

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

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    var gapSize = deviceHeight * .007;

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
                ? FilesContainer(
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                    files: files,
                    gapSize: gapSize)
                : Container(),
            // FloatingActionButton.extended(
            //   onPressed: () {},
            //   label: const Text('Submit'),
            // )
          ],
        ),
      ),
    );
  }
}

class FilesContainer extends StatefulWidget {
  const FilesContainer({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.files,
    required this.gapSize,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final List<Files>? files;
  final double gapSize;

  @override
  State<FilesContainer> createState() => _FilesContainerState();
}

class _FilesContainerState extends State<FilesContainer> {
  ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.deviceWidth * 1,
      height: widget.deviceHeight * .1,
      color: ConstantColors.widgetColor,
      child: Row(
        children: [
          const Text('Documents '),
          SizedBox(
            width: widget.deviceWidth * .77,
            //color: Colors.white,
            child: ListView.builder(
                itemCount: widget.files!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(widget.gapSize),
                    height: widget.gapSize * 10,
                    width: widget.gapSize * 10,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: (() {
                        _downloadFile(widget.files![index].file);
                      }),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3-RjXBulP7lPhXjyWTa1jaW6cd5fDzoC240S1hLRH_A6BUZ1b-U2UMYcJS9tg-xdfLYQ&usqp=CAU',
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadFile(url) async {
    final permission = await Permission.storage.request();
    //final permission = await Permission.storage.status;

    if (permission.isGranted) {
      final externalDir = await getExternalStorageDirectory();

      await FlutterDownloader.enqueue(
        url: url,
        headers: {}, // optional: header send with url (auth token etc)
        savedDir: externalDir!.path,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    } else {
      Fluttertoast.showToast(
          msg: "Storage Permission required to download assignment.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

class TimeAndMarkWidget extends StatelessWidget {
  const TimeAndMarkWidget({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.createdAt,
    required this.submissionDateTime,
    required this.mark,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final String? createdAt;
  final String? submissionDateTime;
  final String? mark;

  @override
  Widget build(BuildContext context) {
    var createdDate = DateTime.parse(createdAt ?? '').toLocal();
    var createdDayString = createdDate.day.toString();
    var createdMonthString = createdDate.month.toString();
    var createdYearString = createdDate.year.toString();
    var createdHourString = createdDate.hour.toString();
    var createdMinuteString = createdDate.minute.toString();
    var createdSecondString = createdDate.second.toString();

    var submissionDate = DateTime.parse(submissionDateTime ?? '').toLocal();
    var submissionDayString = submissionDate.day.toString();
    var submissionMonthString = submissionDate.month.toString();
    var submissionYearString = submissionDate.year.toString();
    var submissionHourString = submissionDate.hour.toString();
    var submissionMinuteString = submissionDate.minute.toString();
    var submissionSecondString = submissionDate.second.toString();

    var gapSize = deviceHeight * .007;
    return Container(
      width: deviceWidth * 1,
      height: deviceHeight * .1,
      color: ConstantColors.widgetColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Assigned On: '),
              Text(
                  '$createdDayString-$createdMonthString-$createdYearString $createdHourString:$createdMinuteString:$createdSecondString'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Submmission Deadline: '),
              Row(
                children: [
                  Text(
                      '$submissionDayString-$submissionMonthString-$submissionYearString'),
                  Card(
                    color: ConstantColors.primaryColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: gapSize * 2),
                      child: Text(
                        '$submissionHourString:$submissionMinuteString:$submissionSecondString',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Total Mark: '),
              Text(mark ?? ''),
            ],
          )
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.gapSize,
    required this.name,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final double gapSize;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth * 1,
      height: deviceHeight * .1,
      padding: EdgeInsets.all(gapSize * .5),
      color: ConstantColors.widgetColor,
      child: Column(
        children: [
          const Text('Assignment Title'),
          const WhiteDivider(),
          FittedBox(
            alignment: Alignment.center,
            child: Text(
              name ?? '',
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
