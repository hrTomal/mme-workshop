import 'dart:convert';
import 'dart:developer';

import 'package:meetingme/models/country.dart';

import 'package:http/http.dart' as http;

class LoginService {
  Future<CountryInfo> getCountries() async {
    const countriesApiURL =
        "https://api.meetingme.live/api/locations/countries/";
    var client = http.Client();
    var coutries;
    try {
      var response = await client.get(
        Uri.parse(countriesApiURL),
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        List<dynamic> jsonMap = json.decode(jsonString);
        //coutries = CountryInfo.fromJson(jsonMap);
        coutries = jsonMap;
        //log(jsonMap.toString());
      }
    } catch (ex) {
      print(ex);
    }
    return coutries;
  }
}
