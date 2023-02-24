import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:meetingme/bloc/payment_history/payment_history_event.dart';
import 'package:meetingme/models/tasks/assignment_submit_response.dart';
import 'package:meetingme/models/tasks/notes.dart';
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
        assignments = Assignment.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return assignments;
  }

  Future<Note> getAllNotes() async {
    const apiURL = "${APIurls.devURL}notes/";
    var client = http.Client();
    var notes;
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
        notes = Note.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return notes;
  }

  Future<AssignmentSubmitResponse?> assignmentSubmit(
      assignmentId, List<String> fileNames) async {
    AssignmentSubmitResponse? res;
    try {
      var apiURL = '${APIurls.devURL}assignment-submissions/';
      var token = await SessionManager().get("token");
      Map<String, String> headers = {"Authorization": 'Bearer $token'};
      var request = http.MultipartRequest('POST', Uri.parse(apiURL));
      request.headers.addAll(headers);
      request.fields['assignment'] = assignmentId;
      for (var fileName in fileNames) {
        request.files.add(await http.MultipartFile.fromPath('files', fileName));
      }
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonString = responseBody;
        var jsonMap = json.decode(jsonString);
        res = AssignmentSubmitResponse.fromJson(jsonMap);
        print(responseBody);
      } else if (response.statusCode == 400) {
        //res?.updatedAt = 'Submitted';
      }
    } catch (ex) {
      print(ex);
    }
    return res;
  }

  Future<int?> assignmentCreate(subjectId, name, mark, descrition, subTime,
      List<String> filePaths) async {
    int? res;
    try {
      var apiURL = '${APIurls.devURL}assignments/';
      var token = await SessionManager().get("token");
      Map<String, String> headers = {"Authorization": 'Bearer $token'};
      var request = http.MultipartRequest('POST', Uri.parse(apiURL));
      request.headers.addAll(headers);

      request.fields['room_subject'] = subjectId;
      request.fields['name'] = name;
      request.fields['description'] = descrition;
      request.fields['mark'] = mark;
      request.fields['submission_date_time'] = subTime;
      for (var filePath in filePaths) {
        request.files
            .add(await http.MultipartFile.fromPath('attachments[]', filePath));
      }
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        res = response.statusCode;
        print(responseBody);
      } else if (response.statusCode == 400) {}
    } catch (ex) {
      print(ex);
    }
    return res;
  }
}
