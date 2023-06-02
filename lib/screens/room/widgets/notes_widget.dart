import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:meetingme/bloc/tasks/notes/notes_bloc.dart';
import 'package:meetingme/bloc/tasks/notes/notes_event.dart';
import 'package:meetingme/bloc/tasks/notes/notes_state.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/models/tasks/notes.dart';
import 'package:meetingme/services/download_from_url.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({
    Key? key,
    required this.subjectId,
  }) : super(key: key);

  final String subjectId;

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  final ReceivePort _port = ReceivePort();

  late NotesBloc notesBloc;

  @override
  void initState() {
    notesBloc = BlocProvider.of<NotesBloc>(context);
    notesBloc.add(FetchNotesEvent(roomId: widget.subjectId));
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState(() {});
    });
    FlutterDownloader.registerCallback(DownloadFromURL.downloadCallback);
  }

  final snackBar = SnackBar(
    content: const Text('Something Went Wrong!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var conPadding = height * .01;
    return BlocListener<NotesBloc, NotesStates>(
      listener: (context, state) {
        if (state is FailedFetchingNotesState) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: BlocBuilder<NotesBloc, NotesStates>(
        builder: (context, state) {
          if (state is NotesInitState) {
            notesBloc.add(FetchNotesEvent(roomId: widget.subjectId));
          } else if (state is NotesLoadingState) {
            return _buildLoading();
          } else if (state is SuccessFetchingNotesState) {
            return NotesWidgetView(
              width: width,
              height: height,
              conPadding: conPadding,
              notes: state.notes,
            );
          } else if (state is FailedFetchingNotesState) {
            return _buildErrorUi(state.message);
          }
          return Container();
        },
      ),
    );
    //return NotesWidget(width: width, height: height, conPadding: conPadding);
  }
}

class NotesWidgetView extends StatelessWidget {
  const NotesWidgetView({
    Key? key,
    required this.width,
    required this.height,
    required this.conPadding,
    required this.notes,
  }) : super(key: key);

  final Note notes;
  final double width;
  final double height;
  final double conPadding;

  @override
  Widget build(BuildContext context) {
    if (notes.results!.isEmpty) {
      return const Center(
        child: Text('No Notes Found'),
      );
    } else {
      var allData = notes.results;
      return ListView.builder(
        itemCount: notes.results!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: ((context, index) {
          var createdAtDate =
              DateTime.parse(allData![index].createdAt ?? '').toLocal();
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
                                        width: width * .53,
                                        //color: Colors.white,
                                        child: ListView.builder(
                                            itemCount:
                                                allData[index].files!.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, fileIndex) {
                                              return Container(
                                                margin:
                                                    EdgeInsets.all(conPadding),
                                                height: conPadding * 6,
                                                width: conPadding * 6,
                                                color: Colors.white,
                                                child: GestureDetector(
                                                  onTap: (() {
                                                    DownloadFromURL
                                                        .downloadFile(allData[
                                                                index]
                                                            .files![fileIndex]
                                                            .file);
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
    }
  }
}
