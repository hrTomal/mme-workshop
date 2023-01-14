import 'dart:convert';

import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:meetingme/models/notice/notice.dart';
import '../constants/urls.dart';
import 'package:http/http.dart' as http;

class NoticesService {
  Future<Notice> getAllNotices() async {
    const apiURL = "${APIurls.devURL}notice/";
    var client = http.Client();
    var notces;
    try {
      var token = await SessionManager().get("token");
      var response = await client.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        notces = Notice.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return notces;
  }
}
