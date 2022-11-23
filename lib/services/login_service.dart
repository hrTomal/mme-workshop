import 'dart:convert';
import 'dart:developer';

import 'package:meetingme/constants/urls.dart';
import 'package:meetingme/models/country.dart';

import 'package:http/http.dart' as http;

import '../models/login_token.dart';

class LoginService {
  Future<CountryInfo> getCountries() async {
    const countriesApiURL = "${APIurls.liveURL}locations/countries/";
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
    const loginApiURL = "${APIurls.liveURL}users/token/";
    var client = http.Client();
    var responseToken;
    try {
      var response =
          await http.post(Uri.parse(loginApiURL), headers: {}, body: {
        "phone": phone,
        "password": password,
        "country_code": country_code,
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        responseToken = LoginToken.fromJson(jsonMap);
      }
    } catch (ex) {
      print(ex);
    }
    return responseToken;
  }
}
