import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/models/tasks/assignments.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FilesWidget extends StatefulWidget {
  const FilesWidget({
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
  State<FilesWidget> createState() => _FilesWidgetState();
}

class _FilesWidgetState extends State<FilesWidget> {
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
