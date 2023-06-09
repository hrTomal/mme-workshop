import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;

import 'package:meetingme/constants/urls.dart';
import 'package:meetingme/models/fee/fee_info.dart';
import 'package:meetingme/models/fee/payment_history.dart';
import '../models/fee/aamarpay_url.dart';

class FeesService {
  Future<List<FeeInfo>> getUserFees() async {
    const apiURL = "${APIurls.devURL}payments/room-user-fees/payable/";
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
        List jsonMap = json.decode(jsonString);
        _fees = jsonMap.map((e) => FeeInfo.fromJson(e)).toList();
        //FeeInfo.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return _fees;
  }

  Future<AamarPayUrl> getAamarPayUrl(ids) async {
    const apiURL = "${APIurls.devURL}payments/room-user-fees/pay/";
    var client = http.Client();
    var url;
    try {
      var accessToken = await SessionManager().get("token");
      var response = await client.post(
        Uri.parse(apiURL),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(
          {
            'room_user_fee': ids,
          },
        ),
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        url = AamarPayUrl.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return url;
  }

  Future<PaymentHistoryModel> getUserPaymentHistory() async {
    const apiURL = "${APIurls.devURL}payments/";
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
        _fees = PaymentHistoryModel.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return _fees;
  }
}
