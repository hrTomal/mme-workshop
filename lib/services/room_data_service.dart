import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:meetingme/constants/urls.dart';
import '../models/room_info.dart';

class RoomService {
  Future<RoomInfo> getRooms() async {
    const countriesApiURL = "${APIurls.liveURL}rooms/";
    var client = http.Client();
    var rooms;
    try {
      var response = await client.get(
        Uri.parse(countriesApiURL),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjY5OTkwNTQwLCJpYXQiOjE2Njg2OTQ1NDAsImp0aSI6IjAxMTNmN2JhOWU3NzQ5ODRiOTdlMDZkYTMyMTdhYWM5IiwidXNlcl9pZCI6IjE2NTRiODM1LTA3MzYtNDA1Yy05YTUxLWJjNWE5OTU1OGUyMSIsInVzZXJuYW1lIjoieWVhbWluMjEifQ.ZWlMIFLXnjikodtzMVKxK_vWmbXN6FY1tJrnGfsUji4',
        },
      );
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
