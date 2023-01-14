import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meetingme/models/notice/notice.dart';

import '../../../services/notice_data_service.dart';

class NoticeWidget extends StatefulWidget {
  const NoticeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NoticeWidget> createState() => _NoticeWidgetState();
}

class _NoticeWidgetState extends State<NoticeWidget> {
  final Future<Notice> notices = NoticesService().getAllNotices();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: notices,
      builder: (BuildContext context, AsyncSnapshot<Notice> snapshot) {
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
                              Card(
                                color: Colors.red,
                                child: Text(
                                  (allData[index].type ?? '').toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                width: width * 1,
                                margin: EdgeInsets.symmetric(
                                    vertical: height * .01),
                                color: Colors.white,
                                child: Text(allData[index].content ?? ''),
                              ),
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
                        color: const Color.fromRGBO(26, 55, 77, 1),
                        margin: EdgeInsets.only(right: width * .02),
                        padding: EdgeInsets.symmetric(horizontal: width * .02),
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
        }

        /// While is no data show this
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
