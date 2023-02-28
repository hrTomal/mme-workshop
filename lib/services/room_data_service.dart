import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;

import 'package:meetingme/constants/urls.dart';
import 'package:meetingme/models/meeting_room.dart';
import '../models/room_info.dart';

class RoomService {
  Future<RoomInfo> getRooms() async {
    const apiURL = "${APIurls.devURL}rooms/room-subjects/";
    var client = http.Client();
    var rooms;
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
        rooms = RoomInfo.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return rooms;
  }
}

class MeetingRoomService {
  Future<MeetingRoom> getMeetingRooms() async {
    //const meetingRoomsUrl = "${APIurls.devURL}meeting/room-meetings/";
    const meetingRoomsUrl = "${APIurls.devURL}meetings/room-subject-meetings/";
    var client = http.Client();
    var rooms;
    try {
      var token = await SessionManager().get("token");
      var response = await client.get(Uri.parse(meetingRoomsUrl), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        rooms = MeetingRoom.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return rooms;
  }
}
