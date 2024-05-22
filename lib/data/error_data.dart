import 'errors.dart';
import 'dart:convert';

ErrorData errorDataFromJson(String str) => ErrorData.fromJson(json.decode(str));
class ErrorData {
  ErrorData({
      num? status, 
      String? errors,}){
    _status = status;
    _errors = errors;
}

  ErrorData.fromJson(dynamic json) {
    _status = json['status'];
    _errors = json['errors'];
  }
  num? _status;
  String? _errors;

  num? get status => _status;
  String? get errors => _errors;

}