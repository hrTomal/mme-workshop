import 'package:flutter/material.dart';

class CountryInfo {
  late final int count;
  late String? next;
  late String? previous;
  late final List<Country> results;
  late final int total_pages;
  late final int current_page;

  CountryInfo(
    this.count,
    this.next,
    this.previous,
    this.results,
    this.total_pages,
    this.current_page,
  );

  CountryInfo.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results =
        List.from(json['results']).map((e) => Country.fromJson(e)).toList();
  }
}

class Country {
  late final int id;
  late final String? created_at;
  late final String? updated_at;
  late final bool is_active;
  late final String? name;
  late final String? flag;
  late final String? country_code;
  late final String? phone_code;
  late final int min_digit;
  late final int max_digit;
  late final String? phone_regex;

  Country(
    this.id,
    this.created_at,
    this.updated_at,
    this.is_active,
    this.name,
    this.flag,
    this.country_code,
    this.phone_code,
    this.min_digit,
    this.max_digit,
    this.phone_regex,
  );

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    is_active = json['is_active'];
    name = json['name'];
    flag = json['flag'];
    country_code = json['country_code'];
    phone_code = json['phone_code'];
    min_digit = json['min_digit'];
    max_digit = json['max_digit'];
    phone_regex = json['phone_regex'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = created_at;
    _data['updated_at'] = updated_at;
    _data['is_active'] = is_active;
    _data['created_at'] = name;
    _data['created_at'] = flag;
    _data['country_code'] = country_code;
    _data['phone_code'] = phone_code;
    _data['min_digit'] = min_digit;
    _data['max_digit'] = max_digit;
    _data['phone_regex'] = phone_regex;

    return _data;
  }
}
