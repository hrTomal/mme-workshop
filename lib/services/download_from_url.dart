import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadFromURL {
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  static Future<void> downloadFile(url) async {
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
        openFileFromNotification: true,
        fileName: DateTime.now().millisecond.toString().replaceAll(" ", ""),
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
