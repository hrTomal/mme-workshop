import 'dart:convert';

import 'package:meetingme/models/workshop/workshop_list_model.dart';
import 'package:http/http.dart' as http;

import '../../constants/urls.dart';

class WorkshopDataService {
  Future<WorkshopListModel> getAllWorkshops() async {
    const apiURL = "${APIurls.workshopUrl}workshops/";
    var client = http.Client();
    var workshops;
    try {
      //var token = await SessionManager().get("token");
      var response = await client.get(Uri.parse(apiURL), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
        //'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        // var jsonString = response.body;
        var jsonMap = json.decode(source);
        workshops = WorkshopListModel.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return workshops;
  }

  Future<String?> CreateTempUser(
      first_name, last_name, email, phone, batch_room) async {
    String? res;
    const String apiUrl = '${APIurls.workshopUrl}workshops/temp-user/';
    // try {

    //   print(apiUrl);

    //   Map<String, String> headers = {
    //     "Content-type": "application/json",
    //     "Accept": "application/json",
    //   };

    //   Map<String, dynamic> data = {
    //     "first_name": first_name,
    //     "last_name": last_name,
    //     "email": email,
    //     "phone": phone,
    //     "batch_room": batch_room,
    //   };

    //   String jsonData = json.encode(data);

    //   http
    //       .post(Uri.parse(apiUrl), headers: headers, body: jsonData)
    //       .then((response) {
    //     if (response.statusCode == 200 || response.statusCode == 201) {
    //       String jsonMap = json.decode(response.body);
    //       res = jsonMap;
    //     }
    //   });
    // } catch (ex) {
    //   print(ex);
    // }

    try {
      var reqBody = {
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
        "phone": phone,
        "batch_room": batch_room,
      };
      var jsonReqBody = json.encode(reqBody);
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonReqBody,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        String jsonMap = json.decode(response.body);
        res = jsonMap;
      }
    } catch (ex) {
      print(ex);
    }
    return res;
  }
}
