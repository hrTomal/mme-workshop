import 'dart:convert';

import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:meetingme/models/token_model.dart';
import 'package:meetingme/models/user.dart';

import '../constants/urls.dart';

import 'package:http/http.dart' as http;

import '../models/message.dart';
import '../models/token_message.dart';

class DataService {
  getUserInfo() async {
    var accessToken = await SessionManager().get("token");
    const userInfoApiURL = "${APIurls.devURL}users/me/";
    var client = http.Client();
    User? userInfo;
    try {
      var response = await client.get(
        Uri.parse(userInfoApiURL),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        userInfo = User.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return userInfo;
  }

  Future<MessageModel> sendOtp(phone) async {
    const apiURL = "${APIurls.devURL}alert/otp/send-otp/";
    var client = http.Client();
    var msg;
    try {
      var reqBody = {
        "phone": phone,
      };
      var response = await client.post(
        Uri.parse(apiURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(reqBody),
      );
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      msg = MessageModel.fromJson(jsonMap);
    } catch (ex) {}
    return msg;
  }

  Future<TokenAndMessageModel> verifyOtp(phone, otp) async {
    const apiURL = "${APIurls.devURL}alert/otp/verify-otp/";
    var client = http.Client();
    var msg;
    try {
      var reqBody = {
        "phone": phone,
        "otp": otp,
      };
      var response = await client.post(
        Uri.parse(apiURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(reqBody),
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        msg = TokenAndMessageModel.fromJson(jsonMap);
      } else if (response.statusCode == 400) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        msg = TokenAndMessageModel.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return msg;
  }

  Future<MessageModel> changePassword(password, token) async {
    const apiURL = "${APIurls.devURL}users/reset-password/";
    var client = http.Client();
    var msg;
    try {
      var reqBody = {
        "new_password": password,
        "token": token,
      };
      var response = await client.post(
        Uri.parse(apiURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(reqBody),
      );
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      msg = MessageModel.fromJson(jsonMap);
    } catch (ex) {}
    return msg;
  }
}
