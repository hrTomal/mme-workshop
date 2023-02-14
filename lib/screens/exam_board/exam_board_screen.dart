import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:meetingme/models/exam_board.dart';
import 'package:meetingme/services/download_from_url.dart';
import 'package:meetingme/services/exam_board_data_service.dart';

import '../../constants/colors.dart';

class ExamBoardScreen extends StatefulWidget {
  const ExamBoardScreen({super.key});

  static const routeName = '/examboard';
  @override
  State<ExamBoardScreen> createState() => _ExamBoardScreenState();
}

class _ExamBoardScreenState extends State<ExamBoardScreen> {
  final Future<ExamBoard> examboards = ExamBoardService().getAllExamBoardData();
  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState(() {});
    });
    FlutterDownloader.registerCallback(DownloadFromURL.downloadCallback);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Me - ExamBoard'),
        backgroundColor: ConstantColors.primaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder(
        future: examboards,
        builder: (BuildContext context, AsyncSnapshot<ExamBoard> snapshot) {
          if (snapshot.hasData) {
            var allData = snapshot.data!.results;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: allData!.length,
              itemBuilder: ((context, index) {
                var createDate =
                    DateTime.parse(allData[index].createdAt ?? '').toLocal();
                var dayString = createDate.day.toString();
                var monthString = createDate.month.toString();
                var yearString = createDate.year.toString();
                var hourString = createDate.hour.toString();
                var minuteString = createDate.minute.toString();
                var secondString = createDate.second.toString();
                return GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 232, 242, 255),
                            scrollable: true,
                            content: Column(
                              children: [
                                const Text(
                                  'Title',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: width * 1,
                                  margin: EdgeInsets.symmetric(
                                      vertical: height * .01),
                                  color: Colors.white,
                                  child: Text(allData[index].title ?? ''),
                                ),
                                const Text(
                                  'Title',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  height: height * .3,
                                  width: width * .6,
                                  color: Colors.white,
                                  child: GestureDetector(
                                      onTap: () {
                                        DownloadFromURL.downloadFile(
                                            allData[index].file ?? '');
                                      },
                                      child: Image.network(
                                          allData[index].file ?? '')),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: height * .01,
                      horizontal: height * .01,
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: height * .005,
                      horizontal: height * .005,
                    ),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: ConstantColors.primaryColor,
                          margin: EdgeInsets.only(right: width * .02),
                          padding:
                              EdgeInsets.symmetric(horizontal: width * .02),
                          child: Text(
                            '$dayString-$monthString-$yearString',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(allData[index].title ?? ''),
                      ],
                    ),
                  ),
                );
              }),
            );
          } else {
            return const Center(
              child: Text('Currently no notice to show.'),
            );
          }
        },
      ),
    );
  }
}
