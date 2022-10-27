import 'package:flutter/material.dart';

class CountryInfo {
  late final int id;
  late final String createdAt;
  late final String updatedAt;
  late final bool isActive;
  late final String name;
  late final String flag;
  late final String countryCode;
  late final String phoneCode;
  late final int minDigit;
  late final int maxDigit;
  late final String phoneRegex;

  CountryInfo(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.name,
    this.flag,
    this.countryCode,
    this.phoneCode,
    this.minDigit,
    this.maxDigit,
    this.phoneRegex,
  );

  CountryInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isActive = json['isActive'];
    name = json['name'];
    flag = json['flag'];
    countryCode = json['countryCode'];
    phoneCode = json['phoneCode'];
    minDigit = json['minDigit'];
    maxDigit = json['maxDigit'];
    phoneRegex = json['phoneRegex'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['created_at'] = isActive;
    _data['created_at'] = name;
    _data['created_at'] = flag;
    _data['created_at'] = countryCode;
    _data['created_at'] = phoneCode;
    _data['created_at'] = minDigit;
    _data['created_at'] = maxDigit;
    _data['created_at'] = phoneRegex;

    return _data;
  }
}
