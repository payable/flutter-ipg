import 'dart:convert';

Errors errorsFromJson(String str) => Errors.fromJson(json.decode(str));
String errorsToJson(Errors data) => json.encode(data.toJson());
class Errors {
  Errors({
      List<String>? logoUrl, 
      List<String>? merchantKey,}){
    _logoUrl = logoUrl;
    _merchantKey = merchantKey;
}

  Errors.fromJson(dynamic json) {
    _logoUrl = json['logoUrl'] != null ? json['logoUrl'].cast<String>() : [];
    _merchantKey = json['merchantKey'] != null ? json['merchantKey'].cast<String>() : [];
  }
  List<String>? _logoUrl;
  List<String>? _merchantKey;

  List<String>? get logoUrl => _logoUrl;
  List<String>? get merchantKey => _merchantKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['logoUrl'] = _logoUrl;
    map['merchantKey'] = _merchantKey;
    return map;
  }

}