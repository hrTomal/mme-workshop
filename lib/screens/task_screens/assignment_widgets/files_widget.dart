import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/models/tasks/assignments.dart';
import 'package:meetingme/services/download_from_url.dart';
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
  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // String id = data[0];
      // DownloadTaskStatus status = data[1];
      // int progress = data[2];
      setState(() {});
    });
    FlutterDownloader.registerCallback(DownloadFromURL.downloadCallback);
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
                        DownloadFromURL.downloadFile(widget.files![index].file);
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
}
