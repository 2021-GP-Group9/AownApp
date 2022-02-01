import 'package:flutter/cupertino.dart';

class profile_date {
  String _name;
  String _phone_number;
  String _email;
  profile_date(this._email, this._name, this._phone_number);

  String get email => _email;

  String get phone_number => _phone_number;

  String get name => _name;

  factory profile_date.fromJson(dynamic json) {
    return profile_date(json['donorEmail'] as String,
        json['donorName'] as String, json['donorPhone'] as String);
  }
}
