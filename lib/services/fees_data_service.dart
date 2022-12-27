import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;

import 'package:meetingme/constants/urls.dart';
import 'package:meetingme/models/fee_info.dart';
import '../models/room_info.dart';

class FeesService {
  Future<FeeInfo> getUserFees() async {
    const apiURL = "${APIurls.devURL}payment/user-fees/";
    var client = http.Client();
    var _fees;
    try {
      var accessToken = await SessionManager().get("token");
      var response = await client.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        _fees = FeeInfo.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return _fees;
  }
}
