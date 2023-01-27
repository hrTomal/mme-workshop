import 'dart:convert';
import 'dart:developer';

import 'package:meetingme/constants/urls.dart';
import 'package:meetingme/models/country.dart';

import 'package:http/http.dart' as http;

import '../models/login_token.dart';

class LoginService {
  Future<CountryInfo> getCountries() async {
    const countriesApiURL = "${APIurls.devURL}locations/countries/";
    var client = http.Client();
    var coutries;
    try {
      var response = await client.get(
        Uri.parse(countriesApiURL),
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        coutries = CountryInfo.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return coutries;
  }

  Future<LoginToken> Login(
      String phone, String password, String country_code) async {
    const loginApiURL = "${APIurls.devURL}users/token/";
    var client = http.Client();
    var responseToken;
    try {
      var reqBody = {
        "phone": phone,
        "password": password,
        "country_code": country_code,
      };
      var jsonReqBody = json.encode(reqBody);
      var response = await http.post(
        Uri.parse(loginApiURL),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonReqBody,
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        responseToken = LoginToken.fromJson(jsonMap);
      } else {
        responseToken = LoginToken('error', 'error');
      }
    } catch (ex) {
      print(ex);
    }
    return responseToken;
  }
}
