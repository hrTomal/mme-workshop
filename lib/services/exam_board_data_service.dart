import 'dart:convert';

import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../constants/urls.dart';
import 'package:http/http.dart' as http;

import '../models/exam_board.dart';

class ExamBoardService {
  Future<ExamBoard> getAllExamBoardData() async {
    const apiURL = "${APIurls.devURL}examboard/";
    var client = http.Client();
    var exams;
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
        exams = ExamBoard.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return exams;
  }
}
