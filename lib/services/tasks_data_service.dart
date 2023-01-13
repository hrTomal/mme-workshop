import 'dart:convert';

import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../constants/urls.dart';
import '../models/tasks/assignments.dart';
import 'package:http/http.dart' as http;

class TasksService {
  Future<Assignment> getAllAssignments() async {
    const apiURL = "${APIurls.devURL}assignments/";
    var client = http.Client();
    var assignments;
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
        //List jsonMap = json.decode(jsonString);
        //assignments = jsonMap.map((e) => Assignment.fromJson(e)).toList();
        assignments = Assignment.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return assignments;
  }
}
